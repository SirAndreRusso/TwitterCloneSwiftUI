//
//  ExploreViewModel.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 28.10.2022.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    private let service = UserService()
    init() {
       fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
}
