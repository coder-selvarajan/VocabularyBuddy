//
//  WordList.swift
//  Mozhi
//
//  Created by Selvarajan on 28/03/22.
//

import SwiftUI

struct WordList: View {
    @StateObject var myWordListVM = MyWordListViewModel()
    
    var body: some View {
        List {
            ForEach(myWordListVM.myWordAllEntries, id:\.id) {myword in
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(myword.word)").font(.subheadline).bold()
                    Text("\(myword.meaning)").font(.subheadline)
                }
            }
            .onDelete(perform: nil)
        }
        .onAppear {
            myWordListVM.getAllMyWordEntries()
        }
    }
}

struct WordList_Previews: PreviewProvider {
    static var previews: some View {
        WordList()
    }
}
