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

    func uploadTask() {
        let resizeImage = Base64.instance.resizeImage(image: image, targetSize: CGSize(width: 100, height: 100))
        let imageBase64 = Base64.instance.convertImageToBase64(image: resizeImage ?? UIImage())
        FirebaseStoreManager.instance.updateUserData(
            userID: uid,
            email: email,
            phoneNumber: phoneNumber,
            gender: gender.rawValue,
            image: imageBase64 ?? ""
        ) { success, error in
            if success {
                print( "Document successfully updated!")
            } else {
                print( "Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        
    }
}

