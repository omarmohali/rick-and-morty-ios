import XCTest
import Combine
@testable import CharactersUI

final class CharactersUITests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testInitialStateIsLoading() async throws {
        
        let charactersLoader = CharactersLoaderMock()
        let sut = CharactersListViewModel(charactersLoader: charactersLoader)
        
        XCTAssertEqual(sut.state, .loading)
        
    }
    
    func testGetCharactersFailure() async throws {
        
        let charactersLoader = CharactersLoaderMock()
        let sut = CharactersListViewModel(charactersLoader: charactersLoader)
        let expectedError = "Failed to Get Characters"
        charactersLoader.getCharactersResult = .failure(expectedError)
        
        let exp = XCTestExpectation(description: "Wait for charactersLoader")
        sut.$state.sink { _ in
            exp.fulfill()
        }
        .store(in: &cancellables)
        
        sut.getCharacters()
        
        await fulfillment(of: [exp])
        XCTAssertEqual(sut.state, .error)
        
    }
    
    func testGetCharactersSuccess() async throws {
        
        let charactersLoader = CharactersLoaderMock()
        let sut = CharactersListViewModel(charactersLoader: charactersLoader)
        let expectedCharacters = [Character.mockCharacter()]
        charactersLoader.getCharactersResult = .success(expectedCharacters)
        
        let exp = XCTestExpectation(description: "Wait for charactersLoader")
        sut.$state.sink { _ in
            exp.fulfill()
        }
        .store(in: &cancellables)
        
        sut.getCharacters()
        
        await fulfillment(of: [exp])
        XCTAssertEqual(sut.state, .loaded(expectedCharacters))
        
    }
}

class CharactersLoaderMock: CharactersLoader {
    
    var getCharactersResult: Result<[Character], Error>?
    func getCharacters() async throws -> [Character] {
        guard let result = self.getCharactersResult else {
            XCTFail("Did not set getCharactersResult")
            return []
        }
        
        switch result {
        case let .success(characters):
            return characters
        case let .failure(error):
            throw error
        }
        
    }
}

extension String: Error { }

extension Character {
    static func mockCharacter(
        id: Int = 0,
        name: String = "Rick Sanchez",
        species: String = "Human",
        image: URL = .init(string: "www.image.com")!
    ) -> Character {
        .init(
            id: id,
            name: name,
            species: species,
            image: image
        )
    }
}
