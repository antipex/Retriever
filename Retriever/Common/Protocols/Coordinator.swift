//
//  Coordinator.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/24.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        coordinator.removeAllChildren()
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func removeAllChildren() {
        childCoordinators.forEach { $0.removeAllChildren() }
        childCoordinators.removeAll()
    }
}
