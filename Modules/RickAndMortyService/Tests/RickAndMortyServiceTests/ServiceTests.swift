import XCTest
import Foundation
import RickAndMortyService

class ServiceTests: XCTestCase {
 
    lazy var session: URLSession = {
        let  configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()
    
    override func tearDown() {
        super.tearDown()
        MockURLProtocol.requestHandler = nil
    }
    
    func testGetCharacters() async throws {
        let sut =  Service(session: session, baseURL: anyURL)
        
        var capturedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            capturedRequest = request
            let response = HTTPURLResponse()
            let data = """
                {
                  "info": {
                    "count": 826,
                    "pages": 42,
                    "next": "https://rickandmortyapi.com/api/character/?page=20",
                    "prev": "https://rickandmortyapi.com/api/character/?page=18"
                  },
                  "results": [
                    {
                      "id": 361,
                      "name": "Toxic Rick",
                      "status": "Dead",
                      "species": "Humanoid",
                      "type": "Rick's Toxic Side",
                      "gender": "Male",
                      "origin": {
                        "name": "Alien Spa",
                        "url": "https://rickandmortyapi.com/api/location/64"
                      },
                      "location": {
                        "name": "Earth",
                        "url": "https://rickandmortyapi.com/api/location/20"
                      },
                      "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                      "episode": [
                        "https://rickandmortyapi.com/api/episode/27"
                      ],
                      "url": "https://rickandmortyapi.com/api/character/361",
                      "created": "2018-01-10T18:20:41.703Z"
                    }
                  ]
                }
            """.data(using: .utf8)!
            return (response, data)
        }
        
        
        let characters = try await sut.getCharacters()
        
        let request = try XCTUnwrap(capturedRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "\(anyURL)/character/"
        )
        
        XCTAssertEqual(characters, [
            .init(
                id: 361,
                name: "Toxic Rick",
                status: "Dead",
                species: "Humanoid",
                type: "Rick's Toxic Side",
                gender: "Male",
                origin: .init(
                    name: "Alien Spa",
                    urlString: "https://rickandmortyapi.com/api/location/64"
                ),
                location: .init(
                    name: "Earth",
                    urlString: "https://rickandmortyapi.com/api/location/20"
                ),
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg")!,
                episode: [
                    URL(string: "https://rickandmortyapi.com/api/episode/27")!
                  ],
                url: URL(string: "https://rickandmortyapi.com/api/character/361")!
            )
        ])
    }
    
    private let anyURL = URL(string: "www.any-url.com")!
    
    
    
}


class MockURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("No request handler provided")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            XCTFail("Error handling the request: \(error)")
        }
    }
    
    override func stopLoading() {
        
    }
    
}

