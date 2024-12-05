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
            })
            .store(in: &cancellables)
    }
}
