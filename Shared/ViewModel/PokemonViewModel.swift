import Combine
import Foundation

@MainActor
final class PokemonViewModel: ObservableObject {
	@Published var pokemons: [PokemonResult] = []
	@Published var filteredPokemons: [PokemonResult] = []
	@Published var currentResponse: String?
	@Published var searchPokemonEntry: String = ""
	@Published var isLoading: Bool = false
	@Published var selectedPokemon: Pokemon?

	private(set) var subscriptions: Set<AnyCancellable> = []

	let service: PokemonService
	let generationService: GenerationServiceProvider

	init(service: PokemonService = .init(),
	     generationService: GenerationServiceProvider = GenerationService())
	{
		self.service = service
		self.generationService = generationService

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

	func fetchGeneration(number: Int) async throws {
		isLoading = true
		let json = try await generationService.fetchGeneration(number: number)
		isLoading = false

		pokemons = json.pokemonSpecies
	}

	func fetchNext() async throws {
		guard let currentResponse = currentResponse else {
			return
		}
		isLoading = true
		let json = try await service.fetchNextPokemons(url: currentResponse)
		isLoading = false

		pokemons.append(contentsOf: json.results)
		self.currentResponse = json.next
	}

	func fetchPokemon() async throws {
		isLoading = true
		let json = try await service.fetchPokemons()
		isLoading = false
		pokemons = json.results
		currentResponse = json.next
	}

	func fetchPokemon(_ pokemon: PokemonResult) async throws {
		isLoading = true
		let pokemon = try await service.fetchPokemon(pokemon)
		isLoading = false

		selectedPokemon = pokemon
	}
}
