//
//  SearchBar.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 28.10.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("search", text: $text)
                .padding(9)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                        .padding(.leading, 8)
                }
        }
        .padding(.horizontal, 4)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
