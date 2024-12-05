//
//  RetrieverTests.swift
//  RetrieverTests
//
//  Created by Kyle Rohr on 3/12/2024.
//

import Testing
@testable import Retriever

struct RecipeListTests {
    @Test func testNormalRecipes() async throws {
        let recipeListViewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository(kind: .normal)
        )

        await recipeListViewModel.reload()

        #expect(recipeListViewModel.recipes.count == 63)
        #expect(recipeListViewModel.state == .loaded)
    }

    @Test func testMalformedRecipes() async throws {
        let recipeListViewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository(kind: .malformed)
        )

        await recipeListViewModel.reload()

        #expect(recipeListViewModel.recipes.isEmpty)
        #expect(recipeListViewModel.state == .error)
    }

    @Test func testEmptyRecipes() async throws {
        let recipeListViewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository(kind: .empty)
        )

        await recipeListViewModel.reload()

        #expect(recipeListViewModel.recipes.isEmpty)
        #expect(recipeListViewModel.state == .loaded)
    }
}
