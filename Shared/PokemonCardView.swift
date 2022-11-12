import SwiftUI

struct PokemonCardView: View {
	@StateObject var viewModel: PokemonViewModel = .init()

	let pokemon: PokemonResult

	init(pokemon: PokemonResult) {
		self.pokemon = pokemon
	}

	var body: some View {
		NavigationLink {
			PokemonDetailView(pokemon: pokemon)
		} label: {
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
				if viewModel.selectedPokemon == nil {
					Task {
						try await self.viewModel.fetchPokemon(pokemon)
					}
				}
			}
			.tint(.black)
		}
	}
}

#if DEBUG
	struct PokemonCardView_Previews: PreviewProvider {
		static var previews: some View {
			PokemonCardView(pokemon: .init(name: "Pikachu", url: ""))
		}
	}
#endif
