//
//  Tweet.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 30.10.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var user: User?
}
