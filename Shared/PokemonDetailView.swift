//
//  PokemonDetailView.swift
//  PokedexAsync
//
//  Created by Amethyst Raven Sky Wyld on 25/09/2022.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonViewModel = .init()

    let pokemon: PokemonResult

    init(pokemon: PokemonResult) {
        self.pokemon = pokemon
    }

    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .bold()
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

            Spacer()
        }
        .onAppear {
            Task {
                try await self.viewModel.fetchPokemon(pokemon)
            }
        }
    }
}
