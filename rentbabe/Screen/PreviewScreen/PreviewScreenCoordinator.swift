//
//  PreviewScreenCoordinator.swift
//  rentbabe
//
//  Created by Richard Gozali on 06/12/24.
//

import SwiftUI

struct PreviewScreenCoordinator: View {
    static var name: String {
        String(describing: self)
    }
    @State private var viewModel = PreviewScreenViewModel()
    @Binding var user: User
    @Binding var selectedCoordinatorName: String?
    private(set)var useCase = PreviewScreenUseCase()

    var body: some View {
        NavigationLink(
            destination: PreviewScreenView(
                viewModel: self.createViewModel()
            ),
            tag: PreviewScreenCoordinator.name,
            selection: $selectedCoordinatorName
        ) { EmptyView() }
    }

    private func createViewModel() -> PreviewScreenViewModel {
        if selectedCoordinatorName != PreviewScreenCoordinator.name {
            return viewModel
        }
        viewModel.image = Base64.instance.decodeBase64ToImage(
            base64String: user.image
        ) ?? UIImage(systemName: "person.fill") ?? UIImage()
        viewModel.setUseCase(createUseCase())
        return viewModel
    }
    
    private func createUseCase() -> PreviewScreenUseCase {
        return useCase
    }
}
