//
//  ContentView.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

struct SetView: View {
    var viewModel = SetViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Hello, world!") {
                print("hi")
                
            }
        }
        .padding()
    }
}

#Preview {
    SetView()
}
