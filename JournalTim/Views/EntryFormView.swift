//
//  EntryFormView.swift
//  JournalTim
//
//  Created by Timothy Terrance on 4/27/26.
//

import SwiftUI
import SwiftData

struct EntryFormView:View{
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    
    let entry:JournalEntry?
    
    @State private var title:String = ""
    @State private var entryBody:String = ""
    @State private var isFavorite:Bool = false
    
    var body: some View {
        
        Form{
            Section("Title"){
                TextField("Title", text: $title)
            }
            Section("Body / Content"){
                TextEditor(text:$entryBody)
                    .frame(minHeight:200)
            }
            Section("Favorite"){
                Toggle("Is it Favorite", isOn: $isFavorite)
            }
        }
        .navigationTitle(entry == nil ? "New Entry" : "Edit Entry")
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button("Cancel"){dismiss()}
                
            }
            
            ToolbarItem(placement: .topBarLeading){
                Button("Save"){
                    //save()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
            }
        }
        .onAppear {
            guard let entry else {return}
            title = entry.title
            entryBody = entry.body
            isFavorite = entry.isFav
        }
    }
    
    private func save () {
        let t = title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
#Preview {
        NavigationStack{
            EntryFormView(entry: JournalEntry(title: "First", body: "Content"))
        }
        
    }

