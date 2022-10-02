//
//  Pokemon.swift
//  PokedexAsync
//
//  Created by Amethyst Raven Sky Wyld on 25/09/2022.
//

import Foundation

// MARK: - Pokemon

struct Pokemon: Codable {
	let id: Int
	let name: String
	let baseExperience, height: Int
	let isDefault: Bool
	let order, weight: Int
	let abilities: [Ability]
	let forms: [Species]
	let gameIndices: [GameIndex]
	let heldItems: [HeldItem]
	let locationAreaEncounters: String
	let moves: [Move]
	let species: Species
	let sprites: Sprites
	let stats: [Stat]
	let types: [TypeElement]
	let pastTypes: [PastType]

	enum CodingKeys: String, CodingKey {
		case id, name
		case baseExperience = "base_experience"
		case height
		case isDefault = "is_default"
		case order, weight, abilities, forms
		case gameIndices = "game_indices"
		case heldItems = "held_items"
		case locationAreaEncounters = "location_area_encounters"
		case moves, species, sprites, stats, types
		case pastTypes = "past_types"
	}
}

// MARK: - Ability

struct Ability: Codable {
	let isHidden: Bool
	let slot: Int
	let ability: Species

	enum CodingKeys: String, CodingKey {
		case isHidden = "is_hidden"
		case slot, ability
	}
}

// MARK: - Species

struct Species: Codable {
	let name: String
	let url: String
}

// MARK: - GameIndex

struct GameIndex: Codable {
	let gameIndex: Int
	let version: Species

	enum CodingKeys: String, CodingKey {
		case gameIndex = "game_index"
		case version
	}
}

// MARK: - HeldItem

struct HeldItem: Codable {
	let item: Species
	let versionDetails: [VersionDetail]

	enum CodingKeys: String, CodingKey {
		case item
		case versionDetails = "version_details"
	}
}

// MARK: - VersionDetail

struct VersionDetail: Codable {
	let rarity: Int
	let version: Species
}

// MARK: - Move

struct Move: Codable {
	let move: Species
	let versionGroupDetails: [VersionGroupDetail]

	enum CodingKeys: String, CodingKey {
		case move
		case versionGroupDetails = "version_group_details"
	}
}

// MARK: - VersionGroupDetail

struct VersionGroupDetail: Codable {
	let levelLearnedAt: Int
	let versionGroup, moveLearnMethod: Species

	enum CodingKeys: String, CodingKey {
		case levelLearnedAt = "level_learned_at"
		case versionGroup = "version_group"
		case moveLearnMethod = "move_learn_method"
	}
}

// MARK: - PastType

struct PastType: Codable {
	let generation: Species
	let types: [TypeElement]
}

// MARK: - TypeElement

struct TypeElement: Codable {
	let slot: Int
	let type: Species
}

// MARK: - GenerationV

struct GenerationV: Codable {
	let blackWhite: Sprites

	enum CodingKeys: String, CodingKey {
		case blackWhite = "black-white"
	}
}

// MARK: - GenerationIv

struct GenerationIv: Codable {
	let diamondPearl, heartgoldSoulsilver, platinum: Sprites

	enum CodingKeys: String, CodingKey {
		case diamondPearl = "diamond-pearl"
		case heartgoldSoulsilver = "heartgold-soulsilver"
		case platinum
	}
}

// MARK: - Versions

struct Versions: Codable {
	let generationI: GenerationI
	let generationIi: GenerationIi
	let generationIii: GenerationIii
	let generationIv: GenerationIv
	let generationV: GenerationV
	let generationVi: [String: Home]
	let generationVii: GenerationVii
	let generationViii: GenerationViii

	enum CodingKeys: String, CodingKey {
		case generationI = "generation-i"
		case generationIi = "generation-ii"
		case generationIii = "generation-iii"
		case generationIv = "generation-iv"
		case generationV = "generation-v"
		case generationVi = "generation-vi"
		case generationVii = "generation-vii"
		case generationViii = "generation-viii"
	}
}

// MARK: - Sprites

class Sprites: Codable {
	let backDefault: String
	let backFemale: String?
	let backShiny: String
	let backShinyFemale: String?
	let frontDefault: String
	let frontFemale: String?
	let frontShiny: String
	let frontShinyFemale: String?
	let other: Other?
	let versions: Versions?
	let animated: Sprites?

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backFemale = "back_female"
		case backShiny = "back_shiny"
		case backShinyFemale = "back_shiny_female"
		case frontDefault = "front_default"
		case frontFemale = "front_female"
		case frontShiny = "front_shiny"
		case frontShinyFemale = "front_shiny_female"
		case other, versions, animated
	}

	init(backDefault: String, backFemale: String?, backShiny: String, backShinyFemale: String?, frontDefault: String, frontFemale: String?, frontShiny: String, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: Sprites?) {
		self.backDefault = backDefault
		self.backFemale = backFemale
		self.backShiny = backShiny
		self.backShinyFemale = backShinyFemale
		self.frontDefault = frontDefault
		self.frontFemale = frontFemale
		self.frontShiny = frontShiny
		self.frontShinyFemale = frontShinyFemale
		self.other = other
		self.versions = versions
		self.animated = animated
	}
}

// MARK: - GenerationI

struct GenerationI: Codable {
	let redBlue, yellow: RedBlue

	enum CodingKeys: String, CodingKey {
		case redBlue = "red-blue"
		case yellow
	}
}

// MARK: - RedBlue

struct RedBlue: Codable {
	let backDefault, backGray, frontDefault, frontGray: String

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backGray = "back_gray"
		case frontDefault = "front_default"
		case frontGray = "front_gray"
	}
}

// MARK: - GenerationIi

struct GenerationIi: Codable {
	let crystal, gold, silver: Crystal
}

// MARK: - Crystal

struct Crystal: Codable {
	let backDefault, backShiny, frontDefault, frontShiny: String

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backShiny = "back_shiny"
		case frontDefault = "front_default"
		case frontShiny = "front_shiny"
	}
}

// MARK: - GenerationIii

struct GenerationIii: Codable {
	let emerald: Emerald
	let fireredLeafgreen, rubySapphire: Crystal

	enum CodingKeys: String, CodingKey {
		case emerald
		case fireredLeafgreen = "firered-leafgreen"
		case rubySapphire = "ruby-sapphire"
	}
}

// MARK: - Emerald

struct Emerald: Codable {
	let frontDefault, frontShiny: String

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
		case frontShiny = "front_shiny"
	}
}

// MARK: - Home

struct Home: Codable {
	let frontDefault: String
	let frontFemale: String?
	let frontShiny: String
	let frontShinyFemale: String?

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
		case frontFemale = "front_female"
		case frontShiny = "front_shiny"
		case frontShinyFemale = "front_shiny_female"
	}
}

// MARK: - GenerationVii

struct GenerationVii: Codable {
	let icons: DreamWorld
	let ultraSunUltraMoon: Home

	enum CodingKeys: String, CodingKey {
		case icons
		case ultraSunUltraMoon = "ultra-sun-ultra-moon"
	}
}

// MARK: - DreamWorld

struct DreamWorld: Codable {
	let frontDefault: String
	let frontFemale: String?

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
		case frontFemale = "front_female"
	}
}

// MARK: - GenerationViii

struct GenerationViii: Codable {
	let icons: DreamWorld
}

// MARK: - Other

struct Other: Codable {
	let dreamWorld: DreamWorld
	let home: Home
	let officialArtwork: OfficialArtwork

	enum CodingKeys: String, CodingKey {
		case dreamWorld = "dream_world"
		case home
		case officialArtwork = "official-artwork"
	}
}

// MARK: - OfficialArtwork

struct OfficialArtwork: Codable {
	let frontDefault: String

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
	}
}

// MARK: - Stat

struct Stat: Codable {
	let baseStat, effort: Int
	let stat: Species

	enum CodingKeys: String, CodingKey {
		case baseStat = "base_stat"
		case effort, stat
	}
}
