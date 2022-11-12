import Foundation

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
