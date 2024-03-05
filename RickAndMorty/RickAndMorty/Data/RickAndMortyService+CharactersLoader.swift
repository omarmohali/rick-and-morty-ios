import RickAndMortyService
import CharactersUI

extension RickAndMortyService.Service: CharactersLoader {
    public func getCharacters() async throws -> [CharactersUI.Character] {
        return try await self.getCharacters().map(Character.init)
    }
}

private extension CharactersUI.Character {
    init(_ dto: RickAndMortyService.Character) {
        self.init(
            id: dto.id, 
            name: dto.name, 
            species: dto.species, 
            image: dto.image
        )
    }
}
