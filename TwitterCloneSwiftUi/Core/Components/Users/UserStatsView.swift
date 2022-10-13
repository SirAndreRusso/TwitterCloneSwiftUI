//
//  UserStatsView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 12.10.2022.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 24) {
            HStack(spacing: 4) {
                Text("807")
                    .bold()
                Text("Following")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 4) {
                Text("10.1M")
                    .bold()
                Text("Followers")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
