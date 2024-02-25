import SwiftUI
import RickAndMortyService
import CharactersUI

@main
struct RickAndMortyApp: App {
    
    private let charactersClient = CharactersUIClient(charactersLoader: RickAndMortyService.Service())
    
    var body: some Scene {
        WindowGroup {
            self.charactersClient.charactersList()
        }
    }
}
