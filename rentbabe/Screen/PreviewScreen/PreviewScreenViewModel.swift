//
//  PreviewScreenViewModel.swift
//  rentbabe
//
//  Created by Richard Gozali on 06/12/24.
//

import SwiftUI

class PreviewScreenViewModel: ObservableObject {
    @Published var image: UIImage = UIImage()
    @Published var mode: ApperanceMode = .Light
    private(set)var useCase: PreviewScreenUseCase = PreviewScreenUseCase()
    
    func setUseCase(_ useCase: PreviewScreenUseCase) {
        self.useCase = useCase
    }
}
