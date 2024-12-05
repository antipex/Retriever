//
//  APIDispatcherProtocol.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation

protocol APIDispatcherProtocol {
    func dispatch(requestData: APIRequestDataProtocol) async throws -> Data
}
