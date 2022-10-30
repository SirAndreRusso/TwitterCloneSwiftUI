//
//  TweetService.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 29.10.2022.
//

import Foundation
import Firebase

struct TweetService {
    func uploadTweet(caption: String, completion: @escaping (Bool) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        Firestore.firestore().collection("tweets")
            .document().setData(data) { error in
                if let error = error {
                    completion(false)
                    print(error.localizedDescription)
                    return
                }
                completion(true)
                print("Did upload tweet")
            }
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> ()) {
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                guard error == nil, let documents = snapshot?.documents else {return}
                documents.forEach { doc in
                    let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                    completion(tweets)
                }
            }
    }
    
    func fetchTweets(forUid uid: String, completion: @escaping ([Tweet]) -> ()) {
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, error in
                guard error == nil, let documents = snapshot?.documents else {return}
                documents.forEach { doc in
                    let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                    completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
                }
            }
    }
}
