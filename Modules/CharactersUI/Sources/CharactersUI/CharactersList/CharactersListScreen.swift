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
            switch viewModel.dataState {
            case .loading:
                ProgressView()
            case let .loaded(characters):
                CharactersListView(
                    characters: characters,
                    didSelectCharacter: self.didSelectCharacter
                )
            case .error:
                Button("Retry") {
                    viewModel.getCharacters()
                }
            }
            
        }
        .searchable(text: $viewModel.searchText)
        .onAppear {
            viewModel.getCharacters()
        }
        .onChange(of: viewModel.searchText) { searchText in
            self.viewModel.getCharacters()
        }
    }
}


private struct CharactersListView: View {
    
    let characters: [Character]
    private let didSelectCharacter: ((Character) -> Void)?
    
    init(characters: [Character], didSelectCharacter: ((Character) -> Void)? = nil) {
        self.characters = characters
        self.didSelectCharacter = didSelectCharacter
    }
    
    var body: some View {
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
