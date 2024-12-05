//
//  MainScreenView.swift
//  rentbabe
//
//  Created by Richard Gozali on 03/12/24.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel: MainScreenViewModel

    init(userManager: UserManager) {
        _viewModel = StateObject(wrappedValue: MainScreenViewModel(userManager: userManager))
    }
    
    var body: some View {
        VStack {
            ProfileView(viewModel: viewModel.profileViewModel)
                .padding(.horizontal, 16)
        }
    }
}
