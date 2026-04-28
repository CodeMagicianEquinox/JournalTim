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

@Model
class JournalEntry {
    
    var title: String
    var body: String
    var dateCreated: Date
    var isFav: Bool
    
    init(title:String, body:String, dateCreated:Date = .now,isFav:Bool = false){
        
        self.title = title
        self.body = body
        self.dateCreated = dateCreated
        self.isFav = isFav
        
    }
    
}

let newEntry = JournalEntry(title: "New", body: "Content")

