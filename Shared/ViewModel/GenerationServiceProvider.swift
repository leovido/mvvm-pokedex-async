import Foundation

protocol GenerationServiceProvider {
	func fetchGeneration(number: Int) async throws -> Generation
}

final class GenerationService: GenerationServiceProvider {
	func fetchGeneration(number: Int) async throws -> Generation {
		let (data, response) = try await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/generation/\(number)/")!)

		guard try validateResponse(urlResponse: response) else {
			throw NSError(domain: "Invalid response", code: 0001)
		}

		let generationResponse = try JSONDecoder().decode(Generation.self, from: data)

		return generationResponse
	}
}
