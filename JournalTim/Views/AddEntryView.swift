//
//  AddEntryView.swift
//  JournalTim
//
//  Created by Timothy Terrance on 4/27/26.
//

import SwiftUI
import SwiftData

struct AddEntryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var entryBody: String = ""
    @State private var isFavorite: Bool = false
    @State private var category: JournalCategory = .personal

    var body: some View {

        Form {
            Section("Title") {
                TextField("Title", text: $title)
            }

            Section("Body / Content") {
                TextEditor(text: $entryBody)
                    .frame(minHeight: 200)
            }

            Section("Category") {
                Picker("Category", selection: $category) {
                    ForEach(JournalCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
            }

            Section("Favorite") {
                Toggle("Favorite", isOn: $isFavorite)
            }
        }
        .navigationTitle("New Entry")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }

            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    save()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }

    private func save() {
        let t = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let b = entryBody.trimmingCharacters(in: .whitespacesAndNewlines)
        let entry = JournalEntry(title: t, body: b, isFavorite: isFavorite, category: category.rawValue)

        context.insert(entry)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddEntryView()
    }
    .modelContainer(for: JournalEntry.self, inMemory: true)
}
