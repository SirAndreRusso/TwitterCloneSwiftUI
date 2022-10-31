//
//  TweetService.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 29.10.2022.
//

import Foundation
import Firebase

struct TweetService {
    func uploadTweet(caption: String, completion: @escaping (Bool) -> Void) {
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
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
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
    
    func fetchTweets(forUid uid: String, completion: @escaping ([Tweet]) -> Void) {
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

//MARK: - Likes

extension TweetService {
    func likeTweet(tweet: Tweet, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userLikesRef = Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes" : tweet.likes + 1]) { error in
                guard error == nil else { return }
                userLikesRef.document(tweetId).setData([:]) { error in
                    completion()
                }
            }
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        let userLikesRef = Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes" : tweet.likes - 1]) { error in
                guard error == nil else { return }
                userLikesRef.document(tweetId).delete { error in
                    guard error == nil else { return }
                    completion()
                }
            }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
            .document(tweetId).getDocument { snapshot, error in
                guard error == nil, let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        Firestore.firestore().collection("users")
            .document(uid).collection("user-likes")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else { return }
                documents.forEach { doc in
                    let tweetId = doc.documentID
                    Firestore.firestore().collection("tweets")
                        .document(tweetId)
                        .getDocument { snapshot, error in
                            guard error == nil else { return }
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }
        
    }
}



