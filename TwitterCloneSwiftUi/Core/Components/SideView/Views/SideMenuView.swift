//
//  SideMenuView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 12.10.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    UserStatsView()
                        .padding(.vertical)
                }
                
                ForEach(SideMenuVM.allCases, id: \.rawValue) { viewModel in
                    if viewModel == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                        
                    }
                    else if viewModel == .logout {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                        
                    }
                    else {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        else {
            Text("No user")
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

