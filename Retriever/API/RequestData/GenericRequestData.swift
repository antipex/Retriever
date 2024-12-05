//
//  GenericRequestData.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

struct GenericRequestData: APIRequestDataProtocol {
    let url: URL?
    let method: URLRequest.HTTPMethod

    var headers: [String: String] = [:]
    let contentType = "application/json"

    var body: Data?
}

extension GenericRequestData {
    init(
        url: URL?,
        method: URLRequest.HTTPMethod,
        body: Encodable?
    ) {
        self.url = url
        self.method = method

        if let body = body {
            self.body = try? JSONEncoder().encode(body)
        }
    }
}
