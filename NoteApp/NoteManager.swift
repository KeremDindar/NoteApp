//
//  Data.swift
//  NoteApp
//
//  Created by Kerem on 5.08.2024.
//

import Foundation


struct Note: Identifiable, Codable {
    let id = UUID()
    var title: String
    var content: String
    var category: String
}


class NoteManager: ObservableObject {
    
     
    
    @Published var notes: [Note] = []
    @Published var categories: [String] = ["Personal","Work", "Study"]
    
    init() {
        loadNotes()
        loadCategories()
    }
    
    func addNote(_ note: Note) {
            notes.append(note)
            saveNotes()
        }
        
        func delete(note: Note) {
            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes.remove(at: index)
                saveNotes()
            }
        }
        
        func updateNoteContent(note: Note, newContent: String) {
            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes[index].content = newContent
                notes[index].title = note.title
                notes[index].category = note.category
                saveNotes()
            }
        }
    
    private func saveNotes() {
            if let encoded = try? JSONEncoder().encode(notes) {
                UserDefaults.standard.set(encoded, forKey: "notes")
            }
        }
        
        private func loadNotes() {
            if let data = UserDefaults.standard.data(forKey: "notes"),
               let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                notes = decoded
            }
        }
        
        private func saveCategories() {
            if let encoded = try? JSONEncoder().encode(categories) {
                UserDefaults.standard.set(encoded, forKey: "categories")
            }
        }
        
        private func loadCategories() {
            if let data = UserDefaults.standard.data(forKey: "categories"),
               let decoded = try? JSONDecoder().decode([String].self, from: data) {
                categories = decoded
            }
        }
    
}
