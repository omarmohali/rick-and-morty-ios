import Combine
import Foundation

public struct BeerBuddyInfo {
    public let character: Character
    public let buddy: Character
    public let numberOfCommonEpisodes: Int
    public let location: String
    public let firstMetDate: Date
    public let lastMetDate: Date
    
    public init(
        character: Character,
        buddy: Character,
        numberOfCommonEpisodes: Int,
        location: String,
        firstMetDate: Date,
        lastMetDate: Date
    ) {
        self.character = character
        self.buddy = buddy
        self.numberOfCommonEpisodes = numberOfCommonEpisodes
        self.location = location
        self.firstMetDate = firstMetDate
        self.lastMetDate = lastMetDate
    }
}

public protocol BeerBuddyFinder {
    func getPerfectBuddy(for character: Character) async -> BeerBuddyInfo
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
                let info = await self.buddyFinder.getPerfectBuddy(for: self.character)
                let screenInfo = ScreenInfo(
                    firstCharacterImage: info.character.image,
                    secondCharacterImage: info.buddy.image,
                    firstCharacterName: info.character.name,
                    secondCharacterName: info.buddy.name,
                    extraInfo: [
                        "They can meet in \(info.location)",
                        "They have been together in \(info.numberOfCommonEpisodes) episode",
                        "They met on \(info.firstMetDate)",
                        "The last time they worked together was on \(info.lastMetDate)"
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
