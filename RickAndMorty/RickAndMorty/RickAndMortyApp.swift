import SwiftUI
import RickAndMortyService
import CharactersUI
import BeerBuddyUI

public typealias CharactersUICharacter = CharactersUI.Character
public typealias BeerBuddyUICharacter = BeerBuddyUI.Character
public typealias CharacterDTO = RickAndMortyService.Character

@main
struct RickAndMortyApp: App {
    
    private let service: Service
    
    private let charactersClient: CharactersUIClient
    private let beerBuddyClient: BeerBuddyUIClient
    
    init() {
        let service = Service(baseURL: URL(string: "https://rickandmortyapi.com/api")!)
        self.service = service
        self.charactersClient = CharactersUIClient(
            charactersLoader: service
        )
        self.beerBuddyClient = BeerBuddyUIClient(
            beerBuddyFinder: AppBeerBuddyFinder(service: service)
        )
    }
    
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


class AppBeerBuddyFinder: BeerBuddyFinder {
    
    private let service:  Service
    
    init(service: Service) {
        self.service = service
    }
    
    func getPerfectBuddy(for character: BeerBuddyUICharacter) async -> BeerBuddyInfo {
        return .init(
            character: .init(
                id: 1,
                name: "Rick",
                species: "Human",
                image: URL(string: "www.any-url.com")!
            ),
            buddy: .init(
                id: 2,
                name: "Morty",
                species: "Human",
                image: URL(string: "www.any-url.com")!
            ),
            numberOfCommonEpisodes: 1,
            location: "Earth",
            firstMetDate: Date(),
            lastMetDate: Date()
        )
    }
}
