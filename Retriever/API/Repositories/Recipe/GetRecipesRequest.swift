//
//  GetRecipesRequest.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

struct GetRecipesRequest: APIRequestProtocol {
    typealias BodyType = EmptyBody
    typealias ResponseType = GetRecipesResponse

    let endpoint: String = "recipes.json"
    let method: URLRequest.HTTPMethod = .get
    let body: BodyType? = nil
}
