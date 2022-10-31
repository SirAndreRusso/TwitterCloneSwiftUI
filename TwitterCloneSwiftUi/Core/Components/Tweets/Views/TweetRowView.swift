//
//  TweetRowView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 11.10.2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var tweetRowViewModel: TweetRowViewModel
    init(tweet: Tweet) {
        self.tweetRowViewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = tweetRowViewModel.tweet.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                        .foregroundColor(Color(.systemBlue))
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(user.fullname)
                                .font(.subheadline)
                                .bold()
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Text("2w")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Text(tweetRowViewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    tweetRowViewModel.tweet.isLiked ?? false ?
                    tweetRowViewModel.unlikeTweet() :
                    tweetRowViewModel.likeTweet()
                } label: {
                    Image(systemName: tweetRowViewModel.tweet.isLiked ?? false ? "heart.fill" : "heart")
                        .foregroundColor(tweetRowViewModel.tweet.isLiked ?? false ? .red : .gray)
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(.gray)
            Divider()
        }
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView()
//    }
//}
