//
//  ExploreView.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 11.10.2022.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0...19, id: \.self) { _ in
                            NavigationLink {
//                                ProfileView(user: <#T##User#>)
                            } label: {
                                UserRowView()
                            }

                          
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
