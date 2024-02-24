import XCTest
import Combine
@testable import CharactersUI

final class CharactersUITests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testtGetCharacters() async throws {
        
        let charactersLoader = CharactersLoaderMock()
        let sut = CharactersListViewModel(charactersLoader: charactersLoader)
        let expectedCharacters = [Character(id: 1, name: "Rick")]
        charactersLoader.getCharactersResult = expectedCharacters
        
        let exp = XCTestExpectation(description: "Wait for charactersLoader")
        sut.$charcters.sink { _ in
            exp.fulfill()
        }
        .store(in: &cancellables)
        
        sut.getCharacters()
        
        await fulfillment(of: [exp])
        XCTAssertEqual(sut.charcters, expectedCharacters)
        
    }
}

class CharactersLoaderMock: CharactersLoader {
    
    var getCharactersResult: [Character]?
    func getCharacters() async throws -> [Character] {
        guard let result = self.getCharactersResult else {
            XCTFail("Did not set characters")
            return []
        }
        
        return result
    }
}
