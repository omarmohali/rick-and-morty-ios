import SwiftUI
import RickAndMortyService
import CharactersUI

@main
struct RickAndMortyApp: App {
    
    private let charactersClient = CharactersUIClient()
    
    var body: some Scene {
        WindowGroup {
            self.charactersClient.charactersList()
        }
    }
}
