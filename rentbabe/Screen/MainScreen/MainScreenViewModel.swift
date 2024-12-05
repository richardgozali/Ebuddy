//
//  MainScreenViewModel.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import Combine
import Foundation
import FirebaseFirestore

class MainScreenViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String? = nil
    @Published var profileViewModel = ProfileViewModel()
    @Published var userManager: UserManager
    private var cancellables = Set<AnyCancellable>()

    init(userManager: UserManager) {
        self.userManager = userManager
        self.profileViewModel.action = uploadTask
        fetchUsers()
    }

    private func fetchUsers() {
        profileViewModel.setLoading(true)
        FirebaseStoreManager.instance.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching users: \(error)")
                }
            }, receiveValue: { [weak self] users in
                self?.profileViewModel.setLoading(false)
                self?.users = users
                self?.profileViewModel.email = users.first?.email ?? ""
                self?.profileViewModel.phoneNumber = users.first?.phoneNumber ?? ""
                self?.profileViewModel.gender = users.first?.gender ?? Gender.UNSPECIFIED
                self?.profileViewModel.uid = users.first?.uuid ?? ""
                self?.profileViewModel.image = Base64.instance.decodeBase64ToImage(
                    base64String: users.first?.image ?? ""
                ) ?? UIImage(systemName: "person.fill") ?? UIImage()
            })
            .store(in: &cancellables)
    }

    func uploadTask() {
        profileViewModel.setLoading(true)
        let resizeImage = Base64.instance.resizeImage(image: profileViewModel.image, targetSize: CGSize(width: 1000, height: 1000))
        let imageBase64 = Base64.instance.convertImageToBase64(image: resizeImage ?? UIImage())
        FirebaseStoreManager.instance.updateUserData(
            userID: profileViewModel.uid,
            email: profileViewModel.email,
            phoneNumber: profileViewModel.phoneNumber,
            gender: profileViewModel.gender.rawValue,
            image: imageBase64 ?? ""
        ) { success, error in
            if success {
                self.userManager.setupUser(
                    User(
                        uuid: self.profileViewModel.uid,
                        email: self.profileViewModel.email,
                        gender: self.profileViewModel.gender,
                        phoneNumber: self.profileViewModel.phoneNumber,
                        image: imageBase64 ?? ""
                    )
                )
            } else {
                print( "Error: \(error?.localizedDescription ?? "Unknown error")")
            }
            self.profileViewModel.setLoading(false)
        }
    }
}
