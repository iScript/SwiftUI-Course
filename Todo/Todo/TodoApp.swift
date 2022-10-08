//
//  TodoApp.swift
//  Todo
//
//  Created by ykq on 2022/3/20.
//

import SwiftUI

@main
struct TodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            IndexView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
