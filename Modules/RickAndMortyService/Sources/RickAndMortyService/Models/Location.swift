import Foundation

public struct LocationsResponse: Decodable {
    public let results: [Location]
}

public struct Location: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [URL]
    public let url: URL
    
    
    public init(id: Int, name: String, type: String, dimension: String, residents: [URL], url: URL) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
    }
}
