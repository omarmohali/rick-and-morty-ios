import Foundation

public struct Character: Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let species: String
    public let image: URL
    
    
    
    public init(id: Int, name: String, species: String, image: URL) {
        self.id = id
        self.name = name
        self.species = species
        self.image = image
    }
}
