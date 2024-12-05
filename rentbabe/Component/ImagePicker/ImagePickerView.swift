//
//  ImagePickerView.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import SwiftUI
import UIKit

struct ImagePickerView: View {
    @Binding var selectedImageData: Data?
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ImagePickerController(selectedImageData: $selectedImageData, selectedImage: $selectedImage, presentationMode: presentationMode)
    }
}

struct ImagePickerController: UIViewControllerRepresentable {
    @Binding var selectedImageData: Data?
    @Binding var selectedImage: UIImage
    var presentationMode: Binding<PresentationMode>
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImageData: Data?
        @Binding var selectedImage: UIImage
        var presentationMode: Binding<PresentationMode>
        
        init(selectedImageData: Binding<Data?>, selectedImage: Binding<UIImage>, presentationMode: Binding<PresentationMode>) {
            _selectedImageData = selectedImageData
            _selectedImage = selectedImage
            self.presentationMode = presentationMode
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    self.selectedImageData = imageData
                    self.selectedImage = image
                }
            }
            presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImageData: $selectedImageData, selectedImage: $selectedImage, presentationMode: presentationMode)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
