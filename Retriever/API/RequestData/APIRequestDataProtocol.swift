//
//  APIRequestDataProtocol.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

protocol APIRequestDataProtocol {
    var url: URL? { get }
    var method: URLRequest.HTTPMethod { get }

    var headers: [String: String] { get set }
    var contentType: String { get }

    var body: Data? { get }
}
