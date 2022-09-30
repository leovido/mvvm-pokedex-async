//
//  PokemonDetailView.swift
//  PokedexAsync
//
//  Created by Amethyst Raven Sky Wyld on 25/09/2022.
//

import SwiftUI

struct PokemonDetailView: View {
	@ObservedObject var viewModel: PokemonViewModel
	
	let pokemon: PokemonResult
	
	init(viewModel: PokemonViewModel, pokemon: PokemonResult) {
		self.viewModel = viewModel
		self.pokemon = pokemon
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Height")
					.font(.headline)
				Text(viewModel.selectedPokemon?.height.description ?? "")
					.font(.body)
			}
			
			HStack {
				Text("Weight")
					.font(.headline)
				Text(viewModel.selectedPokemon?.weight.description ?? "")
					.font(.body)
			}
			
//			if let versions = viewModel.selectedPokemon!.sprites.versions {
//				List(versions.generationI, id: \.id) { version in
//					Text(version)
//				}
//			}
			
			
			HStack {
				VStack {
					Text("Front")
						.font(.title2)
					AsyncImage(url: URL(string: viewModel.selectedPokemon?.sprites.frontDefault ?? ""))
						.aspectRatio(contentMode: .fit)
						.frame(width: 120, height: 120)
				}
				
				VStack {
					Text("Back")
						.font(.title2)
					AsyncImage(url: URL(string: viewModel.selectedPokemon?.sprites.backDefault ?? ""))
						.aspectRatio(contentMode: .fit)
						.frame(width: 120, height: 120)
				}
			}
			.padding()
			
			HStack {
				VStack {
					Text("Front shiny")
						.font(.title2)
					
					AsyncImage(url: URL(string: viewModel.selectedPokemon?.sprites.frontShinyFemale ?? ""))
						.aspectRatio(contentMode: .fit)
						.frame(width: 120, height: 120)
				}
				
				VStack {
					Text("Back shiny")
						.font(.title2)
					
					AsyncImage(url: URL(string: viewModel.selectedPokemon?.sprites.backShinyFemale ?? ""))
						.aspectRatio(contentMode: .fit)
						.frame(width: 120, height: 120)
				}
			}
			.padding()

			Spacer()
		}
		.navigationTitle(viewModel.selectedPokemon?.name.capitalized ?? "")
		.onAppear() {
			Task {
				try await self.viewModel.fetchPokemon(pokemon)
			}
		}
		.onDisappear() {
			//			self.viewModel.selectedPokemon = nil
		}
	}
}

//struct PokemonDetailView_Previews: PreviewProvider {
//		static var previews: some View {
//			PokemonDetailView(pokemon: .init(name: "Pikachu", url: ""))
//		}
//}
