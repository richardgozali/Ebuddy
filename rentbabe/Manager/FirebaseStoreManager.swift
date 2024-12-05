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
                            email: data["email"] as? String ?? "",
                            gender: Gender(rawValue: data["ge"] as? String ?? "")
                            ?? .UNSPECIFIED,
                            phoneNumber: data["phoneNumber"] as? String ?? "",
                            image: data["image"] as? String ?? ""
                        )
                    }
                    promise(.success(users))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func updateUserData(
        userID: String,
        email: String,
        phoneNumber: String,
        gender: String,
        image: String,
        completion: @escaping (Bool, Error?
    ) -> Void) {
        let userRef = db.collection("USERS").document(userID)
        userRef.updateData([
            "email": email,
            "phoneNumber": phoneNumber,
            "gender": gender,
            "image": image
        ]) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
