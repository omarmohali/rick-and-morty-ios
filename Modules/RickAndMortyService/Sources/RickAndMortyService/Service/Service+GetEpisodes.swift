import Foundation

public extension Service {
    
    struct NoIdsProvidedError: Error {
        
    }
    
    func getEpisodes(ids: [Int]) async throws -> [Episode] {
        
        guard !ids.isEmpty else {  throw NoIdsProvidedError() }
        
        var idsPath = ids.reduce("", {"\($0)\($1),"})
        idsPath.removeLast()
        
        let url = URL(string: "\(self.baseURL.absoluteString)/episode/\(idsPath)")!
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(for: request)
        if ids.count == 1 {
            let location = try JSONDecoder().decode(Episode.self, from: data)
            return [location]
        } else {
            let locations = try JSONDecoder().decode([Episode].self, from: data)
            return locations
        }
    }
}

