//
//  TweetRowViewModel.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 31.10.2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    private let service = TweetService()
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    func likeTweet() {
        service.likeTweet(tweet: tweet) {
            self.tweet.isLiked = true
        }
    }
    
    func unlikeTweet() {
        service.unlikeTweet(tweet) {
            self.tweet.isLiked = false
        }
    }
    
    func checkIfUserLikedTweet() {
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike {
                self.tweet.isLiked = true
            }
        }
    }
}
