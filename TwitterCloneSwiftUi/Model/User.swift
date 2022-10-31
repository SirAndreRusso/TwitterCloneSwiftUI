//
//  User.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 28.10.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageURL: String
    let uid: String
    let email: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
}
