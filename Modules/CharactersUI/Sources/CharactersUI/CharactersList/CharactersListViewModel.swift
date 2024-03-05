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
                let characters = try await self.charactersLoader.getCharacters()
                DispatchQueue.main.async { [weak self] in
                    self?.state = .loaded(characters)
                }
            } catch {
                print(error)
                DispatchQueue.main.async { [weak self] in
                    self?.state = .error
                }
            }
        }
    }
}

#if DEBUG
class CharactersLoaderMock: CharactersLoader {
    func getCharacters() async throws -> [Character] {
        return [
            .init(id: 0, name: "Rick Sanchez", species: "Human", image: .init(string: "www.image.com")!)
        ]
    }
}

extension CharactersListViewModel {
    static let mock = CharactersListViewModel(charactersLoader: CharactersLoaderMock())
}
#endif
