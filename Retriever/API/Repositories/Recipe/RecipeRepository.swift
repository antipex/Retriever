//
//  RecipeRepository.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func getRecipes() async throws -> [Recipe]
}

class RecipeRepository: RecipeRepositoryProtocol {
    let remoteSource: RecipeRemoteSourceProtocol

    init(remoteSource: RecipeRemoteSourceProtocol = RecipeRemoteSource()) {
        self.remoteSource = remoteSource
    }

    func getRecipes() async throws -> [Recipe] {
        try await remoteSource.getRecipes()
    }
}
