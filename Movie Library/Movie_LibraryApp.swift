//
//  Movie_LibraryApp.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

@main
struct Movie_LibraryApp: App {
    let persistenceController = PersistenceController.shared
    var settingStore = SettingStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settingStore)
        }
    }
}
