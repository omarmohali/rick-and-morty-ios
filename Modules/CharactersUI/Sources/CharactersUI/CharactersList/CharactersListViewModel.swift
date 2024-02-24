import Combine
import Foundation


public protocol CharactersLoader {
    func getCharacters() async throws  -> [Character]
}

public class CharactersListViewModel: ObservableObject {
    
    @Published private(set) var charcters = [Character]()
    private let charactersLoader: CharactersLoader
    
    init(charactersLoader: CharactersLoader) {
        self.charactersLoader = charactersLoader
    }
    
    func getCharacters() {
        Task {
            do {
                let charachters = try await self.charactersLoader.getCharacters().map { Character(id: $0.id, name: $0.name) }
                DispatchQueue.main.async { [weak self] in
                    self?.charcters = charachters
                }
            } catch {
                print(error)
            }
        }
    }
}

