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
            EntryListView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
