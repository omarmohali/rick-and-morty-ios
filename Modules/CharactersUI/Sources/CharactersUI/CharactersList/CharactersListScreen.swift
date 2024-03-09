//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Omar Ali on 23/2/24.
//

import SwiftUI

struct CharactersListScreen: View {
    
    @ObservedObject private var viewModel: CharactersListViewModel
    private let viewForCharacter: (Character) -> AnyView
    
    init(
        viewModel: CharactersListViewModel,
        viewForCharacter: @escaping (Character) -> AnyView
    ) {
        self.viewModel = viewModel
        self.viewForCharacter = viewForCharacter
    }
    
    var body: some View {
        ZStack {
            switch viewModel.dataState {
            case .loading:
                ProgressView()
            case let .loaded(characters):
                CharactersListView(
                    characters: characters,
                    viewForCharacter: self.viewForCharacter
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
    private let viewForCharacter: (Character) -> AnyView
    
    init(characters: [Character], viewForCharacter: @escaping (Character) -> AnyView) {
        self.characters = characters
        self.viewForCharacter = viewForCharacter
    }
    
    var body: some View {
        
        List {
            ForEach(characters, id: \.self) { character in
                NavigationLink(destination: viewForCharacter(character)) {
                    CharacterView(character: character)
                }
            }
        }
    }
}
