//
//  AuthViewModel.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 17.10.2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    init() {
        self.userSession = Auth.auth().currentUser
        print("Debug: usersession is: \(self.userSession?.uid)")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("Debug: failed to sign in with error: \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            print("Debug: did log user in")
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                print("Debug: failed to register with error: \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid]
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { error in
                    if error == nil {
                        print("Debug: data uploaded")
                    } else {
                        return
                    }
                }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
