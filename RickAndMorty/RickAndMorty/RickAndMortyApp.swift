import SwiftUI
import RickAndMortyService
import CharactersUI

@main
struct RickAndMortyApp: App {
    
    private let charactersClient = CharactersUIClient(
        charactersLoader: RickAndMortyService.Service()
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(charactersUIClient: self.charactersClient)
        }
    }
}


struct ContentView: View {
    
    private let charactersUIClient: CharactersUIClient
    
    init(charactersUIClient: CharactersUIClient) {
        self.charactersUIClient = charactersUIClient
    }
    
    var body: some View {
        NavigationView {
            self.charactersUIClient.charactersList { character  in
                AnyView(
                    Text(character.name)
                )
                
            }
        }
        
    }
}
