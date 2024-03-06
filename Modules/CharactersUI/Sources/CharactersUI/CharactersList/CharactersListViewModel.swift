import Combine
import Foundation


public protocol CharactersLoader {
    func getCharacters(nameFilter: String?) async throws  -> [Character]
}

class CharactersListViewModel: ObservableObject {
    
    enum DataState {
        case loading
        case loaded([Character])
        case error
    }
    
    @Published private(set) var dataState: DataState = .loading
    @Published var searchText = ""
    
    private let charactersLoader: CharactersLoader
    
    init(charactersLoader: CharactersLoader) {
        self.charactersLoader = charactersLoader
    }
    
    func getCharacters() {
        self.dataState = .loading
        Task {
            do {
                let characters = try await self.charactersLoader.getCharacters(nameFilter: searchText)
                DispatchQueue.main.async { [weak self] in
                    self?.dataState = .loaded(characters)
                }
            } catch {
                print(error)
                DispatchQueue.main.async { [weak self] in
                    self?.dataState = .error
                }
            }
        }
    }
}

#if DEBUG
class CharactersLoaderMock: CharactersLoader {
    func getCharacters(nameFilter: String?) async throws -> [Character] {
        return [
            .init(id: 0, name: "Rick Sanchez", species: "Human", image: .init(string: "www.image.com")!)
        ]
    }
}

extension CharactersListViewModel {
    static let mock = CharactersListViewModel(charactersLoader: CharactersLoaderMock())
}
#endif
