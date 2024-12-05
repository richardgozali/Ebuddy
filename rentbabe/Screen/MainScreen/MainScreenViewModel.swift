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
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUsers()
    }

    private func fetchUsers() {
        FirebaseStoreManager.instance.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching users: \(error)")
                }
            }, receiveValue: { [weak self] users in
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
}
