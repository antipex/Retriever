//
//  SystemLogProvider.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/24.
//

import Foundation
import OSLog

final class SystemLogProvider: LogProvider {
    private var subsystem = Bundle.main.bundleIdentifier

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    private var dateString: String {
        dateFormatter.string(from: Date())
    }

    func log(level: Logger.Level, categoryString: String?, message: String) {
        os_log("%{public}@", type: level.osLogType, "\(dateString) \(message)")
    }
}

private extension Logger.Level {
    var osLogType: OSLogType {
        switch self {
        case .notice:
            return .default
        case .info:
            return .info
        case .debug:
            return .debug
        case .error:
            return .error
        }
    }
}
