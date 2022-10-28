//
//  UserService.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 28.10.2022.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    func fetchUser(withUid uid: String, completion: @escaping (User) -> ()) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                guard let snapshot, error == nil else { return }
                guard let user = try? snapshot.data(as: User.self) else {
                    print("can't parse the user")
                    return
                }
                DispatchQueue.main.async {
                    completion(user)
                }
            }
    }
    
    func fetchUsers(completion: @escaping ([User]) -> ()) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else { return }
                let users = documents.compactMap({try? $0.data(as: User.self)})
                
                DispatchQueue.main.async {
                    completion(users)
                }
            }
    }
}
