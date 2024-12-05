//
//  FirebaseStoreManager.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

import FirebaseFirestore
import Combine

class FirebaseStoreManager {
    static let instance = FirebaseStoreManager() // Singleton instance
    private var db = Firestore.firestore()

    private init() {}

    func fetchUsers() -> AnyPublisher<[User], Error> {
        return Future { promise in
            self.db.collection("USERS").getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    let users = snapshot.documents.compactMap { doc -> User? in
                        let data = doc.data()
                        return User(
                            uuid: doc.documentID,
                            gender: Gender(rawValue: data["ge"] as? String ?? "")
                            ?? .UNSPECIFIED
                        )
                    }
                    promise(.success(users))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
