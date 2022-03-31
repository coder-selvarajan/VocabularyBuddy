//
//  WordList.swift
//  Aangilam
//
//  Created by Selvarajan on 28/03/22.
//

import SwiftUI

struct UserSentenceList: View {
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    
    func delete(at indexes: IndexSet) {
        indexes.forEach { index in
            let userSentence = userSentenceListVM.userSentenceAllEntries[index]
            userSentenceListVM.deleteSentence(sentence: userSentence)
        }
    }

    var body: some View {
        List {
            ForEach(userSentenceListVM.userSentenceAllEntries, id:\.id) {usersentence in
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
        .onAppear {
            userSentenceListVM.getAllUserSentenceEntries()
        }
    }
}

struct UserSentenceList_Previews: PreviewProvider {
    static var previews: some View {
        UserSentenceList()
    }
}
