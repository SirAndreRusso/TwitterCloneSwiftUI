//
//  ProfileView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 11.10.2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationsMode
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterVM = .tweets
    @Namespace var animation
    init(user: User) {
        self.profileViewModel = ProfileViewModel(user: user)
        
    }
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            actionButtons
            userInfoDetails
            tweetFilterBar
            tweetsView
            
            Spacer()
        }
//        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(username: "Name", fullname: "Full Name", profileImageURL: "", uid: "123123123", email: "qq@qq.ru"))
    }
}
extension ProfileView {
    
    //MARK: - Header view
    
    var headerView: some View {
        ZStack(alignment: .bottomLeading){
            Color(.systemBlue)
                .ignoresSafeArea()
            VStack{
                Button {
                    presentationsMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -4)
                }

                KFImage(URL(string: profileViewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
            }
        }
        .frame(height: 96)
    }
    
    //MARK: - Action buttons
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            Button {
                
            } label: {
                Text(profileViewModel.actionButtonTitle)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color.black)
                    .frame(width: 120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            }

        }
        .padding(.trailing)
    }
    
    //MARK: - User info details
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(profileViewModel.user.fullname)
                    .font(.title2
                    .bold())
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            Text("@\(profileViewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Your moms favourite villain")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Gotham, NY")
                }
                
                HStack {
                    Image(systemName: "link")
                    Text("www.joker.com")
                }
            }
            .font(.caption)
            .foregroundColor(Color(.gray))
            
            UserStatsView()
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    //MARK: - Tweet filter bar
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterVM.allCases, id: \.rawValue) { item in
                VStack() {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                
                if selectedFilter == item {
                    Capsule()
                        .foregroundColor(Color(.systemBlue))
                        .frame(height: 3)
                        .matchedGeometryEffect(id: "filter", in:   animation)
                } else {
                    Capsule()
                        .foregroundColor(Color(.clear))
                        .frame(height: 3)
                }
            }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(y: 16))
    }
    
    //MARK: - Tweets view
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(profileViewModel.tweets(forFilter: self.selectedFilter)) { tweet in
                    TweetRowView(tweet: tweet)
                        .padding()
                }
            }
        }
    }
}
