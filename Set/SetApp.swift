//
//  SetApp.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

@main
struct SetApp: App {
    var viewModel = SetViewModel()
    var body: some Scene {
        WindowGroup {
            SetView(viewModel: viewModel)
        }
    }
}
