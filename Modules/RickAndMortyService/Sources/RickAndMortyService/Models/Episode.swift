import Foundation

public struct Episode: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let airDate: String
    public let code:  String
    public let characters: [URL]
    public let url: URL
    public let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case code = "episode"
        case characters
        case url
        case created
    }
    
    public init(
        id: Int,
        name: String,
        airDate: String,
        code: String,
        characters: [URL],
        url: URL,
        created: String
    ) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.code = code
        self.characters = characters
        self.url = url
        self.created = created
    }
}
