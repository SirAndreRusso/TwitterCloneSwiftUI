//
//  SideMenuView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 12.10.2022.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
               Circle()
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bruce Wayne")
                        .font(.headline)
                    Text("@Batman")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
           UserStatsView()
                    .padding(.vertical)
            }
            
            ForEach(SideMenuVM.allCases, id: \.rawValue) { viewModel in
                if viewModel == .profile {
                    NavigationLink {
                        ProfileView()
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
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

