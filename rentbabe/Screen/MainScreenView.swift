//
//  MainScreenView.swift
//  rentbabe
//
//  Created by Richard Gozali on 03/12/24.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var viewModel = MainScreenViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
    }
}
