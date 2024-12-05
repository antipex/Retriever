//
//  RecipeRemoteSource.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import Foundation

protocol RecipeRemoteSourceProtocol {
    func getRecipes() async throws -> [Recipe]
}

class RecipeRemoteSource: RecipeRemoteSourceProtocol {
    func getRecipes() async throws -> [Recipe] {
        let response = try await GetRecipesRequest().execute()
        return response.recipes
    }
}
