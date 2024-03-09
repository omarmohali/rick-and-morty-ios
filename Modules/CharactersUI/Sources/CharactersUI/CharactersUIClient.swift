import SwiftUI

public class CharactersUIClient {
    
    private let charactersLoader: CharactersLoader
    
    public init(charactersLoader: CharactersLoader) {
        self.charactersLoader = charactersLoader
    }
    
    public func charactersList(viewForCharacter: @escaping (Character) -> AnyView) -> some View {
        CharactersListScreen(
            viewModel: .init(
                charactersLoader: self.charactersLoader
            ),
            viewForCharacter: viewForCharacter
        )
        .navigationTitle("Characters")
    }
    
}
