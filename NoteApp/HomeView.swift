//
//  HomeView.swift
//  NoteApp
//
//  Created by Kerem on 5.08.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var noteManager = NoteManager()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(noteManager.notes) { note in
                    NavigationLink(destination: DetailView( note: note).environmentObject(noteManager)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(note.title)
                                    .font(.headline)
                                Spacer()
                                Text(note.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Text(note.content)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform:deleteNote)
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing: NavigationLink("Add Note", destination: AddView().environmentObject(noteManager)))
            
        }
    }
    private func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            let note = noteManager.notes[index]
            noteManager.delete(note: note)
        }
    }
}

#Preview {
    HomeView()
}
