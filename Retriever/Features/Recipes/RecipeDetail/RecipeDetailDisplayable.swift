//
//  RecipeDetailDisplayable.swift
//  Retriever
//
//  Created by Kyle Rohr on 5/12/2024.
//

import Foundation

struct RecipeDetailDisplayable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageUrl: URL
    let learnMoreUrl: URL?
    let youtubeUrl: URL?
}

extension RecipeDetailDisplayable {
    init(recipe: Recipe) {
        self.id = recipe.id
        self.title = recipe.name
        self.subtitle = recipe.cuisine
        self.imageUrl = recipe.photoUrlLarge
        self.learnMoreUrl = recipe.sourceUrl
        self.youtubeUrl = recipe.youtubeUrl
    }
}
