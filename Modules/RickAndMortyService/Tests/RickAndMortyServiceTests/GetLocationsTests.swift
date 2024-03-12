import XCTest
import Foundation
import RickAndMortyService

class GetLocationsTests: BaseTestCase {
    
    func testGetLocations() async throws {
        let sut =  self.makeSUT()
        
        var capturedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            capturedRequest = request
            return (.init(), Self.responseData)
        }
        
        
        let locations = try await sut.getLocations()
        
        let request = try XCTUnwrap(capturedRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "\(anyURL)/location/"
        )
        
        XCTAssertEqual(locations, [
            .init(
                id: 1,
                name: "Earth",
                type: "Planet",
                dimension: "Dimension C-137",
                residents: [
                    URL(string: "https://rickandmortyapi.com/api/character/1")!,
                    URL(string: "https://rickandmortyapi.com/api/character/2")!
                ],
                url: URL(string: "https://rickandmortyapi.com/api/location/1")!
            )
        ])
    }
    
    
    func testURLConstructionWithFilters() async throws {
        let sut =  self.makeSUT()
        
        var capturedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            capturedRequest = request
            return (.init(), Self.responseData)
        }
        
        let _ = try await sut.getLocations(filters: .init(
            name: "anyname",
            type: "anytype",
            dimension: "anydimension"
        ))
        
        let request = try XCTUnwrap(capturedRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "\(anyURL)/location/?name=anyname&type=anytype&dimension=anydimension"
        )
    }
    
    private let anyURL = URL(string: "www.any-url.com")!
    
    private static let responseData = """
            {
                "info": {
                    "count": 126,
                    "pages": 7,
                    "next": "https://rickandmortyapi.com/api/location?page=2",
                    "prev": null
                  },
                  "results": [
                    {
                      "id": 1,
                      "name": "Earth",
                      "type": "Planet",
                      "dimension": "Dimension C-137",
                      "residents": [
                        "https://rickandmortyapi.com/api/character/1",
                        "https://rickandmortyapi.com/api/character/2"
                      ],
                      "url": "https://rickandmortyapi.com/api/location/1",
                      "created": "2017-11-10T12:42:04.162Z"
                    }
                  ]
                }
            """.data(using: .utf8)!
    
    
    
    
}
