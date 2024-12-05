//
//  MainScreenCoordinator.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import Foundation
import SwiftUI

struct MainScreenCoordinator: View {
    static var name: String {
        String(describing: self)
    }
    @State private var destinationCoordinatorName: String?
    @State private var viewModel = MainScreenViewModel()
    @State private(set)var useCase: MainScreenUseCase = MainScreenUseCase()
    @Binding var userManager: UserManager
    @Binding var selectedCoordinatorName: String?

    var body: some View {
        NavigationLink(
             destination: MainScreenView(
                viewModel: self.createViewModel()
            ),
            tag: MainScreenCoordinator.name,
            selection: $selectedCoordinatorName
        ){ EmptyView() }
    }

    private func createViewModel() -> MainScreenViewModel {
        if selectedCoordinatorName != MainScreenCoordinator.name {
            return viewModel
        }
        viewModel.setUseCase(createUseCase())
        viewModel.onCreateNavigationLinks = createNavigationLinks
        return viewModel
    }

    private func createUseCase() -> MainScreenUseCase {
        useCase.callback.onSubmissionSuccess = startDestinationCoordinator
        return useCase
    }

    private func startDestinationCoordinator() {
        destinationCoordinatorName = PreviewScreenCoordinator.name
        userManager.setupUser(useCase.output.user)
    }

    private func createNavigationLinks() -> AnyView {
        AnyView(
            PreviewScreenCoordinator(
                user: $useCase.output.user,
                selectedCoordinatorName: $destinationCoordinatorName
            )
        )
    }
}
