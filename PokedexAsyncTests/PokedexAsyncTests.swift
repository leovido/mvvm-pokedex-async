//
//  PokemonTests.swift
//  Tests iOS
//
//  Created by Amethyst Raven Sky Wyld on 25/09/2022.
//

import Foundation
@testable import PokedexAsync
import XCTest

class Tests_iOS: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testViewModelFetch() async throws {
        let viewModel = await PokemonViewModel()

        try await viewModel.fetchPokemon()

        XCTAssertEqual(viewModel.pokemons.count, 20)
    }

    func testFetchPokemon() async throws {
        let (data, response) = try await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!)

        guard let response = response as? HTTPURLResponse,
              (200 ... 399) ~= response.statusCode
        else {
            XCTFail()
            return
        }
        let json = try! JSONSerialization.jsonObject(with: data)

        dump(json)
        let pokemons = try! JSONDecoder().decode(Pokemon.self, from: data)

        XCTAssertEqual(pokemons.name, "bulbasaur")
    }
}
