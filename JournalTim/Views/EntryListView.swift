//
//  EntryListView.swift
//  JournalTim
//
//  Created by Timothy Terrance on 4/27/26.
//

import SwiftUI
import SwiftData

struct EntryListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]

    @State private var searchText = ""
    @State private var showAddEntry = false
    @State private var filter: EntryFilter = .all

    var body: some View {
        TabView {
            NavigationStack {
                entryList(entries: activeEntries, title: "Journal")
            }
            .tabItem {
                Label("Entries", systemImage: "book")
            }

            NavigationStack {
                entryList(entries: archivedEntries, title: "Archived Entries")
            }
            .tabItem {
                Label("Archived", systemImage: "archivebox")
            }
        }
        .sheet(isPresented: $showAddEntry) {
            NavigationStack {
                AddEntryView()
            }
        }
    }

    private var activeEntries: [JournalEntry] {
        filteredEntries(isArchived: false)
    }

    private var archivedEntries: [JournalEntry] {
        filteredEntries(isArchived: true)
    }

    private func filteredEntries(isArchived: Bool) -> [JournalEntry] {
        entries.filter { entry in
            entry.isArchived == isArchived &&
            matchesSearch(entry) &&
            matchesFilter(entry)
        }
    }

    private func matchesSearch(_ entry: JournalEntry) -> Bool {
        let term = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !term.isEmpty else { return true }

        return entry.title.localizedCaseInsensitiveContains(term) ||
        entry.body.localizedCaseInsensitiveContains(term)
    }

    private func matchesFilter(_ entry: JournalEntry) -> Bool {
        filter == .all || entry.category == filter.rawValue
    }

    private func entryList(entries: [JournalEntry], title: String) -> some View {
        List {
            ForEach(entries) { entry in
                NavigationLink {
                    EntryDetailView(entry: entry)
                } label: {
                    EntryRowView(entry: entry)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        entry.isFavorite.toggle()
                    } label: {
                        Label(entry.isFavorite ? "Unfavorite" : "Favorite", systemImage: entry.isFavorite ? "star.slash" : "star")
                    }
                    .tint(.yellow)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        context.delete(entry)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                    Button {
                        entry.isArchived.toggle()
                    } label: {
                        Label(entry.isArchived ? "Restore" : "Archive", systemImage: entry.isArchived ? "tray.and.arrow.up" : "archivebox")
                    }
                    .tint(.blue)
                }
            }
        }
        .overlay {
            if entries.isEmpty {
                ContentUnavailableView(title, systemImage: "book.closed")
            }
        }
        .navigationTitle(title)
        .searchable(text: $searchText, prompt: "Search entries")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Picker("Category", selection: $filter) {
                        ForEach(EntryFilter.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddEntry = true
                } label: {
                    Label("Add Entry", systemImage: "plus")
                }
            }
        }
    }
}

private struct EntryRowView: View {
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(entry.title)
                    .font(.headline)

                if entry.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }

            HStack {
                Text(entry.date, style: .date)
                Text(entry.category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    EntryListView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
