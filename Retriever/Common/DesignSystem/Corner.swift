//
//  Corner.swift
//  WeatherGeek
//
//  Created by Kyle Rohr on 4/12/24.
//

import Foundation

public extension CGFloat {
    enum Corner {
        /// 4px
        public static let one: CGFloat = 4
        /// 8px
        public static let two: CGFloat = 8
        /// 16px
        public static let three: CGFloat = 16
        /// Infinity
        public static let infinity: CGFloat = .greatestFiniteMagnitude
    }
}
