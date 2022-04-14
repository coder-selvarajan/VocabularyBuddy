//
//  UserSentenceListViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 31/03/22.
//

import Foundation
import CoreData

class UserSentenceListViewModel: ObservableObject {
    @Published var userSentenceAllEntries = [UserSentenceViewModel]()
    @Published var userSentenceRecentEntries = [UserSentenceViewModel]()
    
    func getAllUserSentenceEntries() {
        let userSentenceEntries : [UserSentence] = UserSentence.all()

        DispatchQueue.main.async {
            self.userSentenceAllEntries = userSentenceEntries.map(UserSentenceViewModel.init)
        }
    }
    
    func getRecentSentenceEntries() {
        let SentenceEntries : [UserSentence] = UserSentence.getRecentFiveRecords()

        DispatchQueue.main.async {
            self.userSentenceRecentEntries = SentenceEntries.map(UserSentenceViewModel.init)
        }
    }
    
    func pickRandomSentence() -> UserSentenceViewModel {
        let randomNumber: Int = Int.random(in: 1..<userSentenceAllEntries.count)
        let sentence = userSentenceAllEntries[randomNumber]
        return sentence
    }
    
    func saveSentence(sentence: String, tag: String){
        let newSentenceVM = AddUserSentenceViewModel()
        newSentenceVM.tag = tag
        newSentenceVM.sentence = sentence
        
        newSentenceVM.save()
    }
    
    func deleteSentence(sentence: UserSentenceViewModel) {
        let userSentence: UserSentence? = UserSentence.byId(id: sentence.id)
        
        if let userSentence = userSentence {
            userSentence.delete()
            getAllUserSentenceEntries()
            getRecentSentenceEntries()
        }
    }
}

struct UserSentenceViewModel: Identifiable {
    let userSentence: UserSentence
    
    var id: NSManagedObjectID {
        return userSentence.objectID
    }
    
    var creationDate: Date {
        return userSentence.creationDate ?? Date()
    }
    
    var sentence: String {
        return userSentence.sentence ?? ""
    }
 
    var tag: String {
        return userSentence.tag ?? ""
    }
}
