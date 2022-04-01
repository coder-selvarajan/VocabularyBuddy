//
//  WordList.swift
//  Aangilam
//
//  Created by Selvarajan on 28/03/22.
//

import SwiftUI

struct UserWordList: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @State private var searchText = ""
    
    func delete(at indexes: IndexSet) {
        indexes.forEach { index in
            let userWord = userWordListVM.userWordAllEntries[index]
            userWordListVM.deleteWord(word: userWord)
        }
    }
    
    var body: some View {
        List {
            ForEach(searchResults, id:\.id) {userword in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("\(userword.word)")
                            .font(.headline)
                            .bold()
                        Text(" (\(userword.type))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text("\(userword.meaning)").font(.subheadline).foregroundColor(.secondary)
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.grouped)
        .navigationTitle(Text("Your Word List"))
        .searchable(text: $searchText)
        .onAppear {
            userWordListVM.getAllUserWordEntries()
        }
    }
    
    var searchResults: [UserWordViewModel] {
        if searchText.isEmpty {
            return userWordListVM.userWordAllEntries
        } else {
            return userWordListVM.userWordAllEntries.filter { $0.word.contains(searchText) }
        }
    }
}


struct UserWordList_Previews: PreviewProvider {
    static var previews: some View {
        UserWordList()
    }
}
