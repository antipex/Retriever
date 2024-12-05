//
//  APIRequestProtocol.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

protocol APIRequestProtocol {
    associatedtype BodyType: Encodable
    associatedtype ResponseType: Decodable

    var endpoint: String { get }
    var method: URLRequest.HTTPMethod { get }
    var body: BodyType? { get }
    var data: GenericRequestData { get }
}

extension APIRequestProtocol {
    var data: GenericRequestData {
        var requestUrl: URL?

        if let baseUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/") {
            requestUrl = baseUrl.appendingPathComponent(endpoint)
        }

        return GenericRequestData(
            url: requestUrl,
            method: method,
            body: body
        )
    }

    @discardableResult func execute(
        dispatcher: APIDispatcherProtocol = URLSessionDispatcher()
    ) async throws -> ResponseType {
        let responseData = try await dispatcher.dispatch(requestData: data)

        do {
            let decoded = try JSONDecoder().decode(ResponseType.self, from: responseData)
            return decoded
        } catch {
            Logger.log(level: .error, category: \.network, message: "Decoding failed: \(error)")
            throw APIError.decodingError
        }
    }
}
