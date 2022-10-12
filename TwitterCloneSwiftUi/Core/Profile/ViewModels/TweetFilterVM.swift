//
//  TweetFilterVM.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 12.10.2022.
//

import Foundation
enum TweetFilterVM: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
            
        case .tweets:
            return "Tweets"
        case .replies:
            return "Replies"
        case .likes:
            return "Likes"
        }
    }
}
