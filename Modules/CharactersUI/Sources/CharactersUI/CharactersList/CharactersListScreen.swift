//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Omar Ali on 23/2/24.
//

import SwiftUI

struct CharactersListScreen: View {
    
    @ObservedObject private var viewModel: CharactersListViewModel
    private let didSelectCharacter: ((Character) -> Void)?
    
    init(
        viewModel: CharactersListViewModel,
        didSelectCharacter: ((Character) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.didSelectCharacter = didSelectCharacter
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case let .loaded(characters):
                self.charactersList(characters)
            case .loading:
                Text("Loading")
                
            case .error:
                Text("Error")
                
            }
        }
        .onAppear {
            viewModel.getCharacters()
        }
    }
    
    func charactersList(_ characters: [Character]) -> some View {
        List {
            ForEach(characters, id: \.self) { character in
                CharacterView(character: character)
                    .onTapGesture {
                        self.didSelectCharacter?(character)
                    }
            }
        }
    }
}

#Preview {
    CharactersListScreen(viewModel: .mock)
}
