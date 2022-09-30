//
//  ContentView.swift
//  Shared
//
//  Created by Amethyst Raven Sky Wyld on 25/09/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: PokemonViewModel = .init()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [.init(), .init(), .init()]) {
                    ForEach(viewModel.searchPokemonEntry.isEmpty ? viewModel.pokemons : viewModel.filteredPokemons, id: \.name) { pokemon in
                        PokemonCardView(pokemon: pokemon)
//                        PokemonDetailView(pokemon: pokemon)
                    }
                }
            }
            .padding()
            .searchable(text: $viewModel.searchPokemonEntry)
            .navigationTitle("Pokedex")
        }
        .onAppear {
            Task {
                try await viewModel.fetchPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
