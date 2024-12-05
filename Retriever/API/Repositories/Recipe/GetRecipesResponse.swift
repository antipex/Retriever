//
//  GetRecipesResponse.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import Foundation

struct GetRecipesResponse: Decodable {
    let recipes: [Recipe]
}
