//
//  ContentView.swift
//  Shared
//
//  Created by Amethyst Raven Sky Wyld on 25/09/2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject var viewModel: PokemonViewModel = PokemonViewModel()
	
    var body: some View {
			NavigationView {
				List(viewModel.searchPokemonEntry.isEmpty ? viewModel.pokemons : viewModel.filteredPokemons, id: \.name) { pokemon in
					NavigationLink(pokemon.name.capitalized) {
						PokemonDetailView(viewModel: viewModel, pokemon: pokemon)
					}
				}
				.searchable(text: $viewModel.searchPokemonEntry)
				.navigationTitle("Pokedex")
			}
			.onAppear() {
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
