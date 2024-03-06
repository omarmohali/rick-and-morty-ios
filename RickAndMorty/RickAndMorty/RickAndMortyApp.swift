import SwiftUI
import RickAndMortyService
import CharactersUI

@main
struct RickAndMortyApp: App {
    
    private let charactersClient = CharactersUIClient(charactersLoader: RickAndMortyService.Service())
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                self.charactersClient.charactersList()
            }
            .navigationTitle("Characters")
            
        }
    }
}

struct OfflineCharactersLoader: CharactersLoader {
    
    private let characters: [CharactersUI.Character] = [
        .init(id: 1, name: "Rick Sanchez", species: "Human", image: .init(string: "www.hello.com")!),
        .init(id: 1, name: "Omar Mohamed", species: "Human", image: .init(string: "www.hello.com")!),
        .init(id: 1, name: "Aly Mohamed", species: "Human", image: .init(string: "www.hello.com")!),
        .init(id: 1, name: "Nermine Zaki", species: "Human", image: .init(string: "www.hello.com")!),
        .init(id: 1, name: "Mohamed Ali", species: "Human", image: .init(string: "www.hello.com")!)
    ]
    
    func getCharacters(nameFilter: String?) async throws -> [CharactersUI.Character] {
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        return self.characters
    }
}
