//
//  SideViewVM.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 12.10.2022.
//

import Foundation
enum SideMenuVM: Int, CaseIterable {
    case profile
    case lists
    case bookMarks
    case logout
    
    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .lists:
            return "Lists"
        case .bookMarks:
            return "Bookmarks"
        case .logout:
            return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile:
            return "person"
        case .lists:
            return "list.bullet"
        case .bookMarks:
            return "bookmark"
        case .logout:
            return "arrow.left.square"
        }
    }
}
