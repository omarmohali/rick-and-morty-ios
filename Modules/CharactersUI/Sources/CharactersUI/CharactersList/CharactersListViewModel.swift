import Combine
import Foundation


public protocol CharactersLoader {
    func getCharacters() async throws  -> [Character]
}

class CharactersListViewModel: ObservableObject {
    
    public enum State: Equatable {
        case loading
        case loaded([Character])
        case error
    }
    
    @Published private(set) var state: State = .loading
    private let charactersLoader: CharactersLoader
    
    init(charactersLoader: CharactersLoader) {
        self.charactersLoader = charactersLoader
    }
    
    func getCharacters() {
        self.state = .loading
        Task {
            do {
                let charachters = try await self.charactersLoader.getCharacters().map { Character(id: $0.id, name: $0.name) }
                DispatchQueue.main.async { [weak self] in
                    self?.state = .loaded(charachters)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.state = .error
                }
            }
        }
    }
}

