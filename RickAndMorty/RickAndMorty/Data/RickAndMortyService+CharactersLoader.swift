import RickAndMortyService
import CharactersUI

extension RickAndMortyService.Service: CharactersLoader {
    public func getCharacters(nameFilter: String?) async throws -> [CharactersUI.Character] {
        return try await self.getCharacters(nameFilter: nameFilter).map(Character.init)
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
