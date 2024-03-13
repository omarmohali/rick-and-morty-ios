import XCTest
import Foundation
import RickAndMortyService

class GetEpisodesTests: BaseTestCase {
    
    func testGetOneEpisode() async throws {
        let sut =  self.makeSUT()
        
        var capturedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            capturedRequest = request
            return (.init(), Self.oneEpisodeData)
        }
        
        
        let episodes = try await sut.getEpisodes(ids: [1])
        
        let request = try XCTUnwrap(capturedRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "\(anyURL)/episode/1"
        )
        
        XCTAssertEqual(episodes, [
            .init(
                id: 28,
                name: "The Ricklantis Mixup",
                airDate: "September 10, 2017",
                code: "S03E07",
                characters: [
                    URL(string: "https://rickandmortyapi.com/api/character/1")!,
                    URL(string: "https://rickandmortyapi.com/api/character/2")!
                ],
                url: URL(string: "https://rickandmortyapi.com/api/episode/28")!,
                created: "2017-11-10T12:56:36.618Z"
            )
        ])
    }
    
    func testGetMultipleEpisodes() async throws {
        let sut =  self.makeSUT()
        
        var capturedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            capturedRequest = request
            return (.init(), Self.multipleEpisodesData)
        }
        
        
        let episodes = try await sut.getEpisodes(ids: [1, 2, 3])
        
        let request = try XCTUnwrap(capturedRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "\(anyURL)/episode/1,2,3"
        )
        
        XCTAssertEqual(episodes, [
            .init(
                id: 10,
                name: "Close Rick-counters of the Rick Kind",
                airDate: "April 7, 2014",
                code: "S01E10",
                characters: [
                    URL(string: "https://rickandmortyapi.com/api/character/1")!,
                    URL(string: "https://rickandmortyapi.com/api/character/2")!
                ],
                url: URL(string: "https://rickandmortyapi.com/api/episode/10")!,
                created: "2017-11-10T12:56:34.747Z"
            ),
            .init(
                id: 28,
                name: "The Ricklantis Mixup",
                airDate: "September 10, 2017",
                code: "S03E07",
                characters: [
                    URL(string: "https://rickandmortyapi.com/api/character/1")!,
                    URL(string: "https://rickandmortyapi.com/api/character/2")!
                ],
                url: URL(string: "https://rickandmortyapi.com/api/episode/28")!,
                created: "2017-11-10T12:56:36.618Z"
            )

        ])
    }
    
    func testThrowsErrorWhenEmptyArrayIsPassed() async throws {
        let sut =  self.makeSUT()
        
        do {
            let _ =  try await sut.getEpisodes(ids: [])
            XCTFail("Should throw error id  empty array is passed")

        } catch {
            XCTAssertTrue(error is Service.NoIdsProvidedError)
        }
        
    }
    
    private let anyURL = URL(string: "www.any-url.com")!
    
    private static let oneEpisodeData = """
            {
              "id": 28,
              "name": "The Ricklantis Mixup",
              "air_date": "September 10, 2017",
              "episode": "S03E07",
              "characters": [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2"
              ],
              "url": "https://rickandmortyapi.com/api/episode/28",
              "created": "2017-11-10T12:56:36.618Z"
            }
            """.data(using: .utf8)!
    
    private static let multipleEpisodesData = """
            [
              {
                "id": 10,
                "name": "Close Rick-counters of the Rick Kind",
                "air_date": "April 7, 2014",
                "episode": "S01E10",
                "characters": [
                  "https://rickandmortyapi.com/api/character/1",
                  "https://rickandmortyapi.com/api/character/2"
                ],
                "url": "https://rickandmortyapi.com/api/episode/10",
                "created": "2017-11-10T12:56:34.747Z"
              },
              {
                "id": 28,
                "name": "The Ricklantis Mixup",
                "air_date": "September 10, 2017",
                "episode": "S03E07",
                "characters": [
                  "https://rickandmortyapi.com/api/character/1",
                  "https://rickandmortyapi.com/api/character/2"
                ],
                "url": "https://rickandmortyapi.com/api/episode/28",
                "created": "2017-11-10T12:56:36.618Z"
              }
            ]
            """.data(using: .utf8)!
    
    
    
    
}
