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

struct BeerBuddyView: View {
    
    private let character: CharactersUI.Character
    
    init(character: CharactersUI.Character) {
        self.character = character
    }
    
    var body: some View {
        Text(character.name)
    }
}
