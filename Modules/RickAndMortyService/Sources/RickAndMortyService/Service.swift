import Foundation

public class Service {
    
    public init() { }
    
    public func getCharacters(nameFilter: String?) async throws -> [Character] {
        
        let nameFilterSuffix: String
        if let nameFilter = nameFilter, !nameFilter.isEmpty {
            nameFilterSuffix = "/?name=\(nameFilter)"
        } else {
            nameFilterSuffix = ""
        }
        
        let (data, _) = try await URLSession.shared.data(from: .init(string: "https://rickandmortyapi.com/api/character\(nameFilterSuffix)")!)
        let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
        return response.results
        
    }
    
}
