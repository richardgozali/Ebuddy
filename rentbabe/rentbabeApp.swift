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
    @State private var userManager = UserManager()
    @State var destinationCoordinator: String? = MainScreenCoordinator.name

    var body: some Scene {
        WindowGroup {
            NavigationView{
                MainScreenCoordinator(
                    userManager: $userManager,
                    selectedCoordinatorName: $destinationCoordinator
                )
            }
        }
    }
}
