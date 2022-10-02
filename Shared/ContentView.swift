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
		TabView {
			NavigationView {
				ScrollView {
					LazyVGrid(columns: [.init(), .init(), .init()]) {
						ForEach(viewModel.searchPokemonEntry.isEmpty ? viewModel.pokemons : viewModel.filteredPokemons, id: \.name) { pokemon in
							NavigationLink("", destination: PokemonCardView(pokemon: pokemon))
						}
					}
					.padding()
				}
				.searchable(text: $viewModel.searchPokemonEntry)
				.navigationTitle("Pokedex")
			}
			.tabItem {
				Text("Pokemon")
			}
			.onAppear {
				Task {
					try await viewModel.fetchPokemon()
				}
			}
			NavigationView {
				Text("airsent")
			}
			.tabItem {
				Text("Pokemon")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
