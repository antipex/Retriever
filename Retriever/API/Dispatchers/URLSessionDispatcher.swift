//
//  APIError.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

final class URLSessionDispatcher: APIDispatcherProtocol {
    init() {}

    func dispatch(requestData: APIRequestDataProtocol) async throws -> Data {
        guard
            let url = requestData.url
        else {
            throw APIError.badConfiguration
        }

        var request = URLRequest(
            url: url,
            method: requestData.method,
            contentType: requestData.contentType,
            body: requestData.body
        )
        request.allHTTPHeaderFields = requestData.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if statusCode != 200 {
                throw APIError.requestFailed(statusCode: statusCode)
            }
        }

        return data
    }
}
