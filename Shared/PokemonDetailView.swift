import SwiftUI

struct PokemonDetailView: View {
	@StateObject var viewModel: PokemonViewModel = .init()

	let pokemon: PokemonResult

	init(pokemon: PokemonResult) {
		self.pokemon = pokemon
	}

	var body: some View {
		VStack(alignment: .leading) {
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

			if viewModel.selectedPokemon?.sprites.frontShinyFemale != nil, viewModel.selectedPokemon?.sprites.backShinyFemale != nil {
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
			}

			List {
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
			}
			Spacer()
		}
		.navigationTitle(Text(pokemon.name.capitalized))
		.onAppear {
			Task {
				try await self.viewModel.fetchPokemon(pokemon)
			}
		}
	}
}

#if DEBUG
	struct PokemonDetailView_Previews: PreviewProvider {
		static var previews: some View {
			PokemonDetailView(pokemon: .init(name: "Pikachu", url: ""))
		}
	}
#endif
