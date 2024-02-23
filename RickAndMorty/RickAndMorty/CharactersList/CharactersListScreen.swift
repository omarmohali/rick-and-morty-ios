//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Omar Ali on 23/2/24.
//

import SwiftUI
import RickAndMortyService

struct ContentView: View {
    
    @ObservedObject private var viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        List {
            ForEach(viewModel.charcters, id: \.self) { character in
                Text(character.name)
            }
        }
        .onAppear {
            viewModel.getCharacters()
        }
    }
}

//#Preview {
//    ContentView()
//}
