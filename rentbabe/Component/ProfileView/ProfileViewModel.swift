//
//  ProfileViewModel..swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var uid: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var gender: Gender = .UNSPECIFIED
    @Published var image: UIImage = UIImage()
    @Published var selectedImageData: Data = Data()
    @Published var isLoading: Bool = false
    var action: () -> Void = {}

    func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
}

