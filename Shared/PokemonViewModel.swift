import Combine
import Foundation

final class PokemonService {
	func fetchPokemons() async throws -> PokemonResponse {
		let (data, response) = try await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon")!)

		guard let response = response as? HTTPURLResponse,
		      (200 ... 399) ~= response.statusCode
		else {
			throw NSError(domain: "invalid", code: 0001)
		}

		let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)

		return pokemonResponse
	}

	func fetchPokemon(_ pokemon: PokemonResult) async throws -> Pokemon {
		let (data, response) = try await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)")!)

		guard let response = response as? HTTPURLResponse,
		      (200 ... 399) ~= response.statusCode
		else {
			throw NSError(domain: "invalid", code: 0001)
		}

		let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

		return pokemon
	}
}

struct PokemonResponse: Codable, Hashable {
	let next: String?
	let previous: String?
	let count: Int
	let results: [PokemonResult]
}

struct PokemonResult: Codable, Hashable {
	let name: String
	let url: String
}

@MainActor
final class PokemonViewModel: ObservableObject {
	@Published nonisolated var pokemons: [PokemonResult] = []
	@Published nonisolated var filteredPokemons: [PokemonResult] = []
	@Published nonisolated var searchPokemonEntry: String = ""
	@Published nonisolated var isLoading: Bool = false
	@Published nonisolated var selectedPokemon: Pokemon?

	private(set) var subscriptions: Set<AnyCancellable> = []

	let service: PokemonService

	init(service: PokemonService = .init()) {
		self.service = service

		$searchPokemonEntry
			.print()
			.debounce(for: 0.25, scheduler: DispatchQueue.main)
			.map { newEntry in
				self.pokemons.filter { result in
					result.name.contains(newEntry.lowercased())
				}
			}
			.assign(to: \.filteredPokemons, on: self)
			.store(in: &subscriptions)
	}

	func fetchPokemon() async throws {
		isLoading = true
		let json = try await service.fetchPokemons()
		isLoading = false
		pokemons = json.results
	}

	func fetchPokemon(_ pokemon: PokemonResult) async throws {
		isLoading = true
		let pokemon = try await service.fetchPokemon(pokemon)
		isLoading = false

		selectedPokemon = pokemon
	}
}
