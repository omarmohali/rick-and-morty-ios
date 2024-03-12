import Foundation

public extension Service {
    
    struct LocationFilters {
        
        public enum Status: String, Decodable {
            case alive
            case dead
            case unknown
        }
        
        public enum Gender: String, Decodable {
            case male
            case female
            case genderless
            case unknown
        }
        
        public let name: String?
        public let status: Status?
        public let species: String?
        public let type: String?
        public let gender: Gender?
        
        public static let noFilters = CharacterFilters(
            name: nil,
            status: nil,
            species: nil,
            type: nil,
            gender: nil
        )
    }
    
    func getLocations(filters: CharacterFilters = .noFilters) async throws -> [Character] {
        
        let queryItems: [URLQueryItem] = [
            filters.name == nil ? nil : .init(name: "name", value: filters.name),
            filters.status == nil ? nil : .init(name: "status", value: filters.status?.rawValue),
            filters.species == nil ? nil : .init(name: "species", value: filters.species),
            filters.type == nil ? nil : .init(name: "type", value: filters.type),
            filters.gender == nil ? nil : .init(name: "gender", value: filters.gender?.rawValue)
        ].compactMap { $0 }
        
        var urlComponents = URLComponents(string: "\(self.baseURL.absoluteString)/character/")
        if !queryItems.isEmpty {
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else { throw NSError() }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(for: request)
        let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
        return response.results
    }
}
