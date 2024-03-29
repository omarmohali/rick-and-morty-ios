import Foundation

public struct CharactersResponse: Decodable {
    public let results: [Character]
}

public struct Character: Decodable {
    public let id: Int
    public let name: String
    public let image: URL
    public let species: String
}

