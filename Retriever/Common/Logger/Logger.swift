//
//  Logger.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/24.
//

import Foundation
import Combine

protocol LogProvider {
    func log(level: Logger.Level, categoryString: String?, message: String)
}

final class Logger: @unchecked Sendable {
    static let shared = Logger()

    private static let categories: Categories = Categories()

    private var providers: [LogProvider] = []
    private let appendQueue = DispatchQueue(label: "com.traeger.loggerQueue")

    @Published public private(set) var lines: [String] = []

    private let maxLogLines = 5000

    private init() {
        register(SystemLogProvider())
    }

    static func register(_ provider: LogProvider) {
        self.shared.providers.append(provider)
    }

    private func register(_ provider: LogProvider) {
        providers.append(provider)
    }

    static func log(level: Level, message: String) {
        Self.log(level: level, category: \.general, message: message)
    }

    static func log(level: Level, category: KeyPath<Categories, String>, message: String) {
        self.shared.log(level: level, categoryString: categories[keyPath: category], message: message)
    }

    private func log(level: Level, categoryString: String?, message: String) {
        appendQueue.async { [weak self] in
            guard let self else { return }

            var formattedMessage = message

            if let categoryString {
                formattedMessage = "[\(categoryString)] \(formattedMessage)"
            }

            lines.append(formattedMessage)

            if lines.count >= maxLogLines {
                lines.removeFirst()
            }

            for provider in providers {
                provider.log(level: level, categoryString: categoryString, message: "## \(formattedMessage)")
            }
        }
    }

}

extension Logger {
    enum Level: String, Sendable {
        case notice
        case info
        case debug
        case error
    }

    struct Categories: Sendable {
        public var general: String { "General" }
    }
}
