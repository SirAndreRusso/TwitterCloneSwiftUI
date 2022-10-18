//
//  RegistrationView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 13.10.2022.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    
    
    var body: some View {
        if viewModel.didAuthenticateUser {
            ProfilePhotoSelectionView()
        } else {
            VStack {
//                NavigationLink(destination: ProfilePhotoSelectionView(),
//                               isActive: $viewModel.didAuthenticateUser,
//                               label: {})
                
                
                AuthHeaderView(title1: "Get started", title2: "Create your account")
                VStack(spacing: 40) {
                    CustomInputFields(imageName: "envelope",
                                      placeholderText: "Email",
                                      text: $email)
                    CustomInputFields(imageName: "person",
                                      placeholderText: "Username",
                                      text: $username)
                    CustomInputFields(imageName: "person.circle",
                                      placeholderText: "Fullname",
                                      text: $fullname)
                    CustomInputFields(imageName: "lock",
                                      placeholderText: "Password",
                                      isSecureField: true,
                                      text: $password)
                }
                .padding(32)
                
                Button {
                    viewModel.register(withEmail: email,
                                       password:password,
                                       fullname: fullname,
                                       username: username)
                } label: {
                    Text("Sign up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5),  radius: 10, x: 0, y: 0)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.footnote)
                        Text("Sign in")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom)
                }
            }
            .ignoresSafeArea()
        }
    }
}
