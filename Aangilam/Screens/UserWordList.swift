//
//  WordList.swift
//  Aangilam
//
//  Created by Selvarajan on 28/03/22.
//

import SwiftUI

struct UserWordList: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    
    func delete(at indexes: IndexSet) {
        indexes.forEach { index in
            let userWord = userWordListVM.userWordAllEntries[index]
            userWordListVM.deleteWord(word: userWord)
        }
    }

    var body: some View {
        List {
            ForEach(userWordListVM.userWordAllEntries, id:\.id) {userword in
                
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
        .listStyle(.plain)
        .navigationTitle(Text("Your Word List"))
        .onAppear {
            userWordListVM.getAllUserWordEntries()
        }
    }
}

struct UserWordList_Previews: PreviewProvider {
    static var previews: some View {
        UserWordList()
    }
}
