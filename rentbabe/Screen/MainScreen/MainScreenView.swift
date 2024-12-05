//
//  MainScreenView.swift
//  rentbabe
//
//  Created by Richard Gozali on 03/12/24.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        VStack {
            viewModel.onCreateNavigationLinks()
            ProfileView(viewModel: viewModel.profileViewModel)
                .padding(.horizontal, 16)
        }.navigationBarHidden(true)
    }
}
