//
//  ProfilePhotoSelectionView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 18.10.2022.
//

import SwiftUI

struct ProfilePhotoSelectionView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Setup your account",
                           title2: "Add a profile photo")
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        
                        
                } else {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .padding(.top, 44)
            
            if  let selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5),  radius: 10, x: 0, y: 0)
            }

            Spacer()
        }
        .ignoresSafeArea()
    }
    func loadImage() {
        guard let selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
    }
}


struct ProfilePhotoSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectionView()
    }
}
