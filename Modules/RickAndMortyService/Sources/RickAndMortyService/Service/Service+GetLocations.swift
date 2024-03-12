import Foundation

public extension Service {
    
    struct LocationFilters {
        
        public let name: String?
        public let type: String?
        public let dimension: String?
        
        public init(name: String?, type: String?, dimension: String?) {
            self.name = name
            self.type = type
            self.dimension = dimension
        }
        
        public static let noFilters = LocationFilters(
            name: nil,
            type: nil,
            dimension: nil
        )
    }
    
    func getLocations(filters: LocationFilters = .noFilters) async throws -> [Location] {
        
        let queryItems: [URLQueryItem] = [
            filters.name == nil ? nil : .init(name: "name", value: filters.name),
            filters.type == nil ? nil : .init(name: "type", value: filters.type),
            filters.dimension == nil ? nil : .init(name: "dimension", value: filters.dimension)
        ].compactMap { $0 }
        
        var urlComponents = URLComponents(string: "\(self.baseURL.absoluteString)/location/")
        if !queryItems.isEmpty {
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else { throw NSError() }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(for: request)
        let response = try JSONDecoder().decode(LocationsResponse.self, from: data)
        return response.results
    }
}
