//
//  TwitterCloneSwiftUiApp.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 11.10.2022.
//

import SwiftUI
import Firebase
@main
struct TwitterCloneSwiftUiApp: App {
    @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                  
//                SideMenuView()
              
            }
            .environmentObject(viewModel)
        }
    }
}
