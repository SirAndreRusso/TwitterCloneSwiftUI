//
//  FeedViewModel.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 30.10.2022.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    let tweetService = TweetService()
    let userService = UserService()
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        tweetService.fetchTweets { tweets in
            self.tweets = tweets
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
