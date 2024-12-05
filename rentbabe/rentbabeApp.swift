//
//  rentbabeApp.swift
//  rentbabe
//
//  Created by Richard Gozali on 03/12/24.
//

import SwiftUI

@main
struct rentbabeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userManager = UserManager() 

    var body: some Scene {
        WindowGroup {
            MainScreenView(userManager: self.userManager)
                .environmentObject(userManager)
        }
    }
}
