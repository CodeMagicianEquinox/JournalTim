//
//  JournalTimApp.swift
//  JournalTim
//
//  Created by Timothy Terrance on 4/27/26.
//

import SwiftUI
import SwiftData

@main
struct JournalTimApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                EntryListView()
            }
        }
        .modelContainer(for:[JournalEntry.self])
    }
}
