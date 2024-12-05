//
//  URLRequest+HTTPMethod.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

extension URLRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    var method: HTTPMethod? {
        get {
            guard let httpMethod else { return nil }
            return HTTPMethod(rawValue: httpMethod)
        }
        set {
            httpMethod = newValue?.rawValue
        }
    }

    init(
        url: URL,
        method: HTTPMethod,
        contentType: String?,
        body: Data?
    ) {
        self.init(url: url)

        self.method = method
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.httpBody = body
    }
}
