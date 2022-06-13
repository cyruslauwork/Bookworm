//
//  ContentView.swift
//  Bookworm
//
//  Created by Cyrus on 10/6/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc // Retreive shared context container via @Environment
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book> // Retreive stored data in Core Data
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            // Booklist
//            Text("Count: \(books.count)")
            List {
                ForEach(books) { book in // Sequentially retrieve stored data in Core Data through ForEach
                    NavigationLink {
//                        Text(book.title ?? "Unknown Title")
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm") // Navigation Bar
            .toolbar { // Tool Bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
