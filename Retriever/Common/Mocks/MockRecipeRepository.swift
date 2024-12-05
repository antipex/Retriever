//
//  MockRecipeRepository.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

class MockRecipeRepository: RecipeRepositoryProtocol {
    let kind: Kind

    init(kind: Kind = .normal) {
        self.kind = kind
    }

    func getRecipes() async throws -> [Recipe] {
        let fileName: String

        switch kind {
        case .normal:
            fileName = "recipes"
        case .malformed:
            fileName = "recipes_malformed"
        case .empty:
            fileName = "recipes_empty"
        }

        if let response = DebugLoader().load(GetRecipesResponse.self, fromFileNamed: fileName) {
            return response.recipes
        } else {
            throw APIError.decodingError
        }
    }
}

extension MockRecipeRepository {
    enum Kind {
        case normal
        case malformed
        case empty
    }
}
