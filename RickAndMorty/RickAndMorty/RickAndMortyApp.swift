import SwiftUI
import RickAndMortyService
import CharactersUI
import BeerBuddyUI

public typealias CharactersUICharacter = CharactersUI.Character
public typealias BeerBuddyUICharacter = BeerBuddyUI.Character
public typealias CharacterDTO = RickAndMortyService.Character

@main
struct RickAndMortyApp: App {
    
    private let charactersClient = CharactersUIClient(
        charactersLoader: RickAndMortyService.Service(
            baseURL: URL(string: "https://rickandmortyapi.com/api/character")!
        )
    )
    
    private let beerBuddyClient = BeerBuddyUIClient(beerBuddyFinder: MockFinder())
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                charactersUIClient: self.charactersClient,
                beerBuddyClient: self.beerBuddyClient
            )
        }
    }
}


struct ContentView: View {
    
    private let charactersUIClient: CharactersUIClient
    private let beerBuddyClient: BeerBuddyUIClient
    
    init(
        charactersUIClient: CharactersUIClient,
        beerBuddyClient: BeerBuddyUIClient
    ) {
        self.charactersUIClient = charactersUIClient
        self.beerBuddyClient = beerBuddyClient
    }
    
    var body: some View {
        NavigationView {
            self.charactersUIClient.charactersList { character  in
                AnyView(
                    self.beerBuddyClient.beerBuddyScreen(character: .init(character))
                )
                
            }
        }
        
    }
}

extension BeerBuddyUICharacter {
    init(_ character: CharactersUICharacter) {
        self.init(
            id: character.id,
            name: character.name,
            species: character.species,
            image: character.image
        )
    }
}


struct MockFinder: BeerBuddyFinder {
    func getPerfectBuddy(for character: BeerBuddyUI.Character) async -> BeerBuddyUI.Character {
        .init(
            id: 2,
            name: "Morty Smith",
            species: "Human",
            image: .init(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
        )
    }
}
