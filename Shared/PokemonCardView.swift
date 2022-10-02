//
//  PokemonCardView.swift
//  PokedexAsync
//
//  Created by Amethyst Raven Sky Wyld on 30/09/2022.
//

import SwiftUI

struct PokemonCardView: View {
	@StateObject var viewModel: PokemonViewModel = .init()

	let pokemon: PokemonResult

	init(pokemon: PokemonResult) {
		self.pokemon = pokemon
	}

	var body: some View {
		VStack {
			AsyncImage(url: URL(string: viewModel.selectedPokemon?.sprites.frontDefault ?? ""))
				.aspectRatio(contentMode: .fit)
				.frame(width: 120, height: 120)

			Text(pokemon.name.capitalized)
				.font(.body)
				.bold()
		}
		.padding()
		.onAppear {
			Task {
				try await self.viewModel.fetchPokemon(pokemon)
			}
		}
	}
}
