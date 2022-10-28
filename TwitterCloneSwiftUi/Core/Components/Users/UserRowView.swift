//
//  UserRowView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 12.10.2022.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageURL))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 48, height: 48)
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
