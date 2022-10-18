//
//  CustomInputFields.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 14.10.2022.
//

import SwiftUI

struct CustomInputFields: View {
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool?
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.gray))
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputFields_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputFields(imageName: "envelope",
                          placeholderText: "Email",
                          isSecureField: false,
                          text: .constant(""))
    }
}
