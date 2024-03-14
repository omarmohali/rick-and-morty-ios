import RickAndMortyService
import CharactersUI

extension RickAndMortyService.Service: CharactersLoader {
    public func getCharacters(nameFilter: String?) async throws -> [CharactersUICharacter] {
        return try await self.getCharacters(
            filters: .init(name: nameFilter)
        ).map(CharactersUICharacter.init)
    }
}

private extension CharactersUICharacter {
    init(_ dto: CharacterDTO) {
        self.init(
            id: dto.id,
            name: dto.name,
            species: dto.species,
            image: dto.image
        )
    }
}
