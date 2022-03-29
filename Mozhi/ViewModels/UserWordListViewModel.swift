//
//  UserWordListViewModel.swift
//  Mozhi
//
//  Created by Selvarajan on 13/03/22.
//

import Foundation
import CoreData

class UserWordListViewModel: ObservableObject {
    @Published var userWordAllEntries = [WordViewModel]()
    @Published var userWordRecentEntries = [WordViewModel]()
    
    func getAllUserWordEntries() {
        let userWordEntries : [UserWord] = UserWord.all()

        DispatchQueue.main.async {
            self.userWordAllEntries = userWordEntries.map(WordViewModel.init)
        }
    }
    
    func getRecentWordEntries() {
        let wordEntries : [UserWord] = UserWord.getRecentFiveRecords()

        DispatchQueue.main.async {
            self.userWordRecentEntries = wordEntries.map(WordViewModel.init)
        }
    }
    
    func saveWord(word: String, tag: String, meaning: String, sampleSentence: String, type: String){
        let newWordVM = AddUserWordViewModel()
        newWordVM.word = word
        newWordVM.tag = tag
        newWordVM.meaning = meaning
        newWordVM.sampleSentence = sampleSentence
        newWordVM.type = type
        
        newWordVM.save()
    }
}

struct WordViewModel: Identifiable {
    let userWord: UserWord
    
    var id: NSManagedObjectID {
        return userWord.objectID
    }
    
    var creationDate: Date {
        return userWord.creationDate ?? Date()
    }
    
    var word: String {
        return userWord.word ?? ""
    }
 
    var tag: String {
        return userWord.tag ?? ""
    }
    
    var sampleSentence: String {
        return userWord.sampleSentence ?? ""
    }
    
    var meaning: String {
        return userWord.meaning ?? ""
    }
    
    var type: String {
        return userWord.type ?? ""
    }
    
}
