import Foundation

// MARK: - Generation

struct Generation: Codable {
	let id: Int
	let mainRegion: MainRegion
	let moves: [MainRegion]
	let name: String
	let names: [Name]
	let pokemonSpecies: [PokemonResult]

	let types, versionGroups: [MainRegion]

	enum CodingKeys: String, CodingKey {
		case id
		case mainRegion = "main_region"
		case moves, name, names
		case pokemonSpecies = "pokemon_species"
		case types
		case versionGroups = "version_groups"
	}
}

// MARK: - MainRegion

struct MainRegion: Codable {
	let name: String
	let url: String
}

// MARK: - Name

struct Name: Codable {
	let language: MainRegion
	let name: String
}
