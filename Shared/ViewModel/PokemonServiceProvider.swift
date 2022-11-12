import Foundation

protocol PokemonServiceProvider {
	func fetchNextPokemons(url: String) async throws -> PokemonResponse
	func fetchPokemons() async throws -> PokemonResponse
	func fetchPokemon(_ pokemon: PokemonResult) async throws -> Pokemon
}

final class PokemonService: PokemonServiceProvider {
	func fetchNextPokemons(url: String) async throws -> PokemonResponse {
		let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)

		guard try validateResponse(urlResponse: response) else {
			throw NSError(domain: "Invalid response", code: 0001)
		}

		let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)

		return pokemonResponse
	}

	func fetchPokemons() async throws -> PokemonResponse {
		let (data, response) = try await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon")!)

		guard try validateResponse(urlResponse: response) else {
			throw NSError(domain: "Invalid response", code: 0001)
		}

		let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)

		return pokemonResponse
	}

	func fetchPokemon(_ pokemon: PokemonResult) async throws -> Pokemon {
		let (data, response) = try await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)")!)

		guard try validateResponse(urlResponse: response) else {
			throw NSError(domain: "Invalid response", code: 0001)
		}

		let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

		return pokemon
	}
}
