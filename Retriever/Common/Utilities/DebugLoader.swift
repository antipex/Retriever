//
//  DebugLoader.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import Foundation

public final class DebugLoader {
    public func load<T: Decodable>(
        _ type: T.Type,
        fromFileNamed fileName: String,
        withExtension fileExtension: String = "json"
    ) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let object = try JSONDecoder().decode(type, from: data)

                return object
            } catch {
                    print("DebugLoader failed to load file: \(error)")

                return nil
            }
        } else {
            print("DebugLoader failed to load file.")

            return nil
        }
    }
}
