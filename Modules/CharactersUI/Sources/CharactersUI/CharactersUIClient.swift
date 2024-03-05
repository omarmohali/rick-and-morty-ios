import SwiftUI

public class CharactersUIClient {
    
    private let charactersLoader: CharactersLoader
    
    public init(charactersLoader: CharactersLoader) {
        self.charactersLoader = charactersLoader
    }
    
    public func charactersList(didSelectCharacter: ((Character) -> Void)? = nil) -> some View {
        CharactersListScreen(
            viewModel: .init(
                charactersLoader: self.charactersLoader
            ),
            didSelectCharacter: didSelectCharacter
        )
    }
    
}
