import Combine
import Foundation

public protocol BeerBuddyFinder {
    func getPerfectBuddy(for character: Character) async -> Character
}


class BeerBuddyViewModel: ObservableObject {
    
    struct ScreenInfo {
        var firstCharacterImage: URL
        var secondCharacterImage: URL
        
        var firstCharacterName: String
        var secondCharacterName: String
        
        var extraInfo: [String]
    }
    
    enum State {
        case loading
        case loaded(ScreenInfo)
        case error
    }
    
    private let buddyFinder: BeerBuddyFinder
    
    private let character: Character
    
    @Published var state: State = .loading
    
    init(character: Character, buddyFinder: BeerBuddyFinder) {
        self.buddyFinder = buddyFinder
        self.character =  character
    }
    
    func getBeerBuddy() {
        self.state = .loading
        Task {
            do {
                let buddy = await self.buddyFinder.getPerfectBuddy(for: self.character)
                let screenInfo = ScreenInfo(
                    firstCharacterImage: self.character.image,
                    secondCharacterImage: buddy.image,
                    firstCharacterName: self.character.name,
                    secondCharacterName: buddy.name,
                    extraInfo: [
                        "They can meet in Interdimentional Cable",
                        "They have been together in 1 episode",
                        "They met on Mar 17, 2014",
                        "The last time they worked together was on Mar 17, 2014"
                    ]
                )
                DispatchQueue.main.async {
                    self.state = .loaded(screenInfo)
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .error
                }
            }
            
        }
        
    }
    
}
