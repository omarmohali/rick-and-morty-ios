import Foundation

public class Service {
    
    public init() { }
    
    public func getCharacters() async throws -> [Character] {
        
        let (data, _) = try await URLSession.shared.data(from: .init(string: "https://rickandmortyapi.com/api/character")!)
        let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
        return response.results
        
    }
    
}
