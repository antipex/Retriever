//
//  APIError.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

enum APIError: Error {
    case generic(title: String?, message: String?)
    case badConfiguration
    case requestFailed(statusCode: Int)
    case decodingError
}
