//
//  BaseHostingController.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

class BaseHostingController<T: View>: UIHostingController<T> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.isNavigationBarHidden = true
    }
}
