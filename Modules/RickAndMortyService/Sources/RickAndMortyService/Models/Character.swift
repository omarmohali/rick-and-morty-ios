import Foundation

public struct CharactersResponse: Decodable {
    public let results: [Character]
}

public struct Character: Decodable, Equatable {
    
    public struct Origin: Decodable, Equatable {
        public let name: String
        private let urlString: String
        
        public var url: URL? {
            .init(string: self.urlString)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case urlString = "url"
        }
        
        public init(name: String, urlString: String) {
            self.name = name
            self.urlString = urlString
        }
    }
    
    public struct Location: Decodable, Equatable {
        public let name: String
        private let urlString: String
        
        public var url: URL? {
            .init(string: self.urlString)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case urlString = "url"
        }
        
        public init(name: String, urlString: String) {
            self.name = name
            self.urlString = urlString
        }
    }
    
    
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: Origin
    public let location: Location
    public let image: URL
    public let episode: [URL]
    public let url: URL
    
    
    public init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Origin, location: Location, image: URL, episode: [URL], url: URL) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
    }
    
}

