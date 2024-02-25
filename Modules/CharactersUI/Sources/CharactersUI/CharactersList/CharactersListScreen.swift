//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Omar Ali on 23/2/24.
//

import SwiftUI

struct CharactersListScreen: View {
    
    @ObservedObject private var viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
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
                Text(character.name)
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
