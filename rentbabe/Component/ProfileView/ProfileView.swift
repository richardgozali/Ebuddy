//
//  ProfileView.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    @State private var showImagePicker = false
    @State private var selectedImageData: Data?

    private func iconProfile() -> some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(maxHeight: 200)
            .onTapGesture {
                self.showImagePicker.toggle()
            }
    }

    private func formView() -> some View {
        VStack {
            TextField("UID", text: $viewModel.uid).disabled(!viewModel.uid.isEmpty)
            TextField("Email",text: $viewModel.email)
            TextField("Phone Number",text: $viewModel.phoneNumber)
        }
        .padding(.bottom, 20)
    }

    private func primaryButton() -> some View  {
        Button(action: viewModel.action) {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                Text("Upload Data")
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
        .disabled(viewModel.isLoading)
    }

    var body: some View {
        VStack(spacing: 0) {
            iconProfile()
            Button("Change Image") {
                self.showImagePicker.toggle()
            }
            .padding(.bottom, 20)
            formView()
            primaryButton()
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePickerView(selectedImageData: $selectedImageData, selectedImage: $viewModel.image)
        })
    }
}
