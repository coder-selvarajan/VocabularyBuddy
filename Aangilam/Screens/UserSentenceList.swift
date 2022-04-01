//
//  WordList.swift
//  Aangilam
//
//  Created by Selvarajan on 28/03/22.
//

import SwiftUI

struct UserSentenceList: View {
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    @State private var searchText = ""
    
    func delete(at indexes: IndexSet) {
        indexes.forEach { index in
            let userSentence = userSentenceListVM.userSentenceAllEntries[index]
            userSentenceListVM.deleteSentence(sentence: userSentence)
        }
    }

    var body: some View {
        List {
            ForEach(searchResults, id:\.id) {usersentence in
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(usersentence.sentence)")
                        .font(.headline)
                    Text("\(usersentence.tag)").font(.subheadline).foregroundColor(.secondary)
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .navigationTitle(Text("Your Sentence List"))
        .searchable(text: $searchText)
        .onAppear {
            userSentenceListVM.getAllUserSentenceEntries()
        }
    }
    
    var searchResults: [UserSentenceViewModel] {
        if searchText.isEmpty {
            return userSentenceListVM.userSentenceAllEntries
        } else {
            return userSentenceListVM.userSentenceAllEntries.filter { $0.sentence.contains(searchText) }
        }
    }
}

struct UserSentenceList_Previews: PreviewProvider {
    static var previews: some View {
        UserSentenceList()
    }
}
