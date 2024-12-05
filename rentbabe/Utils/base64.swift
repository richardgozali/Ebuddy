//
//  base64.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import UIKit

struct Base64 {
    static let instance = Base64()

    func convertImageToBase64(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        return imageData.base64EncodedString()
    }
    
    func decodeBase64ToImage(base64String: String) -> UIImage? {
        if let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let aspectRatio = image.size.width / image.size.height
        var newWidth = targetSize.width
        var newHeight = targetSize.height
        
        // Adjust the target size to maintain the aspect ratio
        if targetSize.width / aspectRatio <= targetSize.height {
            newHeight = targetSize.width / aspectRatio
        } else {
            newWidth = targetSize.height * aspectRatio
        }
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
