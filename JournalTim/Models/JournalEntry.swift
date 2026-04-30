//
//  JournalEntry.swift
//  JournalTim
//
//  Created by Timothy Terrance on 4/27/26.
//

import Foundation // Basic Types, functions
//Int, Double, Strings, Char, Date
import SwiftData // Handles persistance
// a Class = a template

enum JournalCategory: String, CaseIterable, Identifiable {
    case work = "Work"
    case personal = "Personal"
    case school = "School"

    var id: String { rawValue }
}

enum EntryFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case work = "Work"
    case personal = "Personal"
    case school = "School"

    var id: String { rawValue }
}

@Model
class JournalEntry {

    var title: String
    var body: String
    var date: Date
    var isFavorite: Bool
    var category: String
    var isArchived: Bool

    init(
        title: String,
        body: String,
        date: Date = .now,
        isFavorite: Bool = false,
        category: String = JournalCategory.personal.rawValue,
        isArchived: Bool = false
    ) {
        self.title = title
        self.body = body
        self.date = date
        self.isFavorite = isFavorite
        self.category = category
        self.isArchived = isArchived
    }
}
