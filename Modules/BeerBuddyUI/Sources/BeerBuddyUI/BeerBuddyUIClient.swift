import SwiftUI

public class BeerBuddyUIClient {
    
    private let beerBuddyFinder: BeerBuddyFinder
    
    public init(beerBuddyFinder: BeerBuddyFinder) {
        self.beerBuddyFinder = beerBuddyFinder
    }
    
    public func beerBuddyScreen(character: Character) -> some View {
        BeerBuddyScreen(
            viewModel: .init(
                character: character,
                buddyFinder: self.beerBuddyFinder
            )
        )
        .navigationTitle("Beer Buddy")
    }
    
}
