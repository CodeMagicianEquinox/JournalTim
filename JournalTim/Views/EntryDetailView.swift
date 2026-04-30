//
//  EntryDetailView.swift
//  JournalTim
//
//  Created by Timothy Terrance on 4/29/26.
//

import SwiftUI
import SwiftData

struct EntryDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var entry: JournalEntry

    var body: some View {
        Form {
            Section("Title") {
                TextField("Title", text: $entry.title)
            }

            Section("Body / Content") {
                TextEditor(text: $entry.body)
                    .frame(minHeight: 220)
            }

            Section("Category") {
                Picker("Category", selection: $entry.category) {
                    ForEach(JournalCategory.allCases) { category in
                        Text(category.rawValue).tag(category.rawValue)
                    }
                }
            }

            Section {
                Toggle("Favorite", isOn: $entry.isFavorite)
                Toggle("Archived", isOn: $entry.isArchived)
            }
        }
        .navigationTitle("Edit Entry")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    context.delete(entry)
                    dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EntryDetailView(entry: JournalEntry(title: "First", body: "Content"))
    }
    .modelContainer(for: JournalEntry.self, inMemory: true)
}
