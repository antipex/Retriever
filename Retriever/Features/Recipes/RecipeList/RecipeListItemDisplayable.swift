//
//  RecipeListItemDisplayable.swift
//  Retriever
//
//  Created by Kyle Rohr on 5/12/2024.
//

import Foundation

struct RecipeListItemDisplayable: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageUrl: URL
}

extension RecipeListItemDisplayable {
    init(recipe: Recipe) {
        self.id = recipe.id
        self.title = recipe.name
        self.subtitle = recipe.cuisine
        self.imageUrl = recipe.photoUrlSmall
    }
}
