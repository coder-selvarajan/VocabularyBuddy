//
//  UserSentenceListViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 31/03/22.
//

import Foundation
import CoreData

class UserSentenceListViewModel: ObservableObject {
    @Published var userSentenceAllEntries = [UserSentence]()
    @Published var userSentenceRecentEntries = [UserSentence]()
    
    func getAllUserSentenceEntries() {
        let userSentenceEntries : [UserSentence] = UserSentence.all()

        DispatchQueue.main.async {
            self.userSentenceAllEntries = userSentenceEntries //.map(UserSentenceViewModel.init)
        }
    }
    
    func getRecentSentenceEntries() {
        let SentenceEntries : [UserSentence] = UserSentence.getRecentFiveRecords()

        DispatchQueue.main.async {
            self.userSentenceRecentEntries = SentenceEntries //.map(UserSentenceViewModel.init)
        }
    }
    
    func pickRandomSentence() -> UserSentence {
        let randomNumber: Int = Int.random(in: 1..<userSentenceAllEntries.count)
        let sentence = userSentenceAllEntries[randomNumber]
        return sentence
    }
    
    func saveSentence(sentence: String, tag: String){
        let userSentence = UserSentence(context: UserSentence.viewContext)
        userSentence.creationDate = Date()
        userSentence.tag = tag
        userSentence.sentence = sentence
        
        userSentence.save()
    }
    
    func deleteSentence(sentence: UserSentence) {
        let userSentence: UserSentence? = UserSentence.byId(id: sentence.objectID)
        
        if let userSentence = userSentence {
            userSentence.delete()
            getAllUserSentenceEntries()
            getRecentSentenceEntries()
        }
    }
}
