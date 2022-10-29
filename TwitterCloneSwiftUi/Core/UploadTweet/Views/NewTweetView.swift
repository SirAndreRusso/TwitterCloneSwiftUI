//
//  NewTweetView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 13.10.2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var uploadTweetViewModel = UploadTweetViewModel()
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    uploadTweetViewModel.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                    
                TextArea("Whats happening?", text: $caption)
            }
            .padding()
        }
        .onReceive(uploadTweetViewModel.$didUploadTweet) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//struct NewTweetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTweetView()
//    }
//}
