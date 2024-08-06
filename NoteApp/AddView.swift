//
//  AddView.swift
//  NoteApp
//
//  Created by Kerem on 5.08.2024.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var noteManager: NoteManager
    @State private var title = ""
    @State private var content = ""
    @State private var selectedCategory = "Personal"
    @Environment(\.dismiss) var dismiss
    @State var showAlert: Bool = false
    
    var body: some View {
        Form {
            
            
            TextField("Title", text: $title)
            TextEditor( text: $content)
            Picker("Category", selection: $selectedCategory) {
                ForEach(noteManager.categories, id: \.self) { category in
                    Text(category)
                        .tag(category)
                }
            }
            
            Button("Add Note") {
                if title.isEmpty || content.isEmpty {
                    showAlert = true
                }else {
                    
                    let newNote = Note(title: title, content: content, category: selectedCategory)
                    noteManager.addNote(newNote)
                    dismiss()
                }
                
            }
            .padding() // Button'a biraz boşluk ekleyin
            .frame(maxWidth: .infinity) // Button'un genişliğini artırmak için
            .background(Color.blue) // Butonun arka plan rengi
            .foregroundColor(.white) // Buton metin rengi
            .cornerRadius(8) 
            .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("Title and Content cannot be empty"), dismissButton: .default(Text("OK")))
                        }

        }
        .navigationTitle("Add Note")
    }
}

#Preview {
    AddView()
        .environmentObject(NoteManager())
}
