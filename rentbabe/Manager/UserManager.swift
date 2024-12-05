//
//  UserManager.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import Foundation

class UserManager: ObservableObject {
    @Published private var user = User()

    func setupUser(_ user: User = User()) {
        self.user = user
    }
}
