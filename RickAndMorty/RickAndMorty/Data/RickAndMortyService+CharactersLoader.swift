import RickAndMortyService

extension RickAndMortyService.Service: CharactersLoader {
    func getCharacters() async throws -> [Character] {
        return try await self.getCharacters().map(Character.init)
    }
}

private extension Character {
    init(_ dto: RickAndMortyService.Character) {
        self.init(id: dto.id, name: dto.name)
    }
}
