//
//  DetailView.swift
//  NoteApp
//
//  Created by Kerem on 5.08.2024.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var noteManager: NoteManager
    @State var note: Note
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                TextField("Title", text: $note.title)
                    .font(.largeTitle)
                
                Picker("Category", selection: $note.category) {
                               ForEach(noteManager.categories, id: \.self) { category in
                                   Text(category)
                                       .tag(category)
                               }
                           }
//                Text(note.category)
//                    .font(.headline)
//                    .foregroundStyle(.secondary)
            }
            TextEditor(text: $note.content)
                .font(.title3)
                .padding()
            Button(action: {
                noteManager.updateNoteContent(note: note, newContent: note.content)
                dismiss()
            }, label: {
                Text("Save")
            })
            .padding()
        }
        .padding()
        .navigationTitle("Note Detail")
    }
    
}


#Preview {
    DetailView( note: Note(title: "asd", content: "asf", category: "personal"))
        .environmentObject(NoteManager())
}
