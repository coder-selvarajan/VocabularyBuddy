//
//  MyWordListViewModel.swift
//  Mozhi
//
//  Created by Selvarajan on 13/03/22.
//

import Foundation
import CoreData

class MyWordListViewModel: ObservableObject {
    @Published var myWordAllEntries = [MyWordViewModel]()
    
    func getAllMyWordEntries() {
        let myWordEntries : [MyWord] = MyWord.all()

        DispatchQueue.main.async {
            self.myWordAllEntries = myWordEntries.map(MyWordViewModel.init)
        }
    }
    
    func saveWord(word: String, tag: String, meaning: String, sampleSentence: String){
        let newWordVM = AddMyWordViewModel()
        newWordVM.word = word
        newWordVM.tag = tag
        newWordVM.meaning = meaning
        newWordVM.sampleSentence = sampleSentence
        
        newWordVM.save()
    }
}

struct MyWordViewModel: Identifiable {
    let myWord: MyWord
    
    var id: NSManagedObjectID {
        return myWord.objectID
    }
    
    var creationDate: Date {
        return myWord.creationDate ?? Date()
    }
    
    var word: String {
        return myWord.word ?? ""
    }
 
    var tag: String {
        return myWord.tag ?? ""
    }
    
    var sampleSentence: String {
        return myWord.sampleSentence ?? ""
    }
    
    var meaning: String {
        return myWord.meaning ?? ""
    }
    
}
