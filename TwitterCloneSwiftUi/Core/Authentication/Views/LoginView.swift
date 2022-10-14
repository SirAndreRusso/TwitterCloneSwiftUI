//
//  LoginView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 13.10.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            // Header view
            
            VStack(alignment: .leading) {
                HStack {Spacer()}
                Text("Hello.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Welcome back")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: .bottomRight))
            
            VStack(spacing: 40) {
                CustomInputFields(imageName: "envelope", placeholderText: "Email", text: $email)
                CustomInputFields(imageName: "lock", placeholderText: "Password", text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 44)
            
            HStack {
                Spacer()
                NavigationLink {
                    Text("Reset password")
                } label: {
                    Text("Forgot password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                }

            }
            Button {
                print("Sign in")
            } label: {
               Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5),  radius: 10, x: 0, y: 0)

            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                        .foregroundColor(Color(.systemBlue))
                    
                    Text(" Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                    
                }
            }
            .padding(.bottom, 32)

        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
