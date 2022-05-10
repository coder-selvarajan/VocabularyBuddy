//
//  EditUserSentence.swift
//  Aangilam
//
//  Created by Selvarajan on 10/05/22.
//

import SwiftUI

struct EditUserSentence: View {
    @Binding var userSentence: UserSentence
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            Form {
                Section {
                    
                    VStack(alignment: .leading) {
                        Text("Sentence: ")
                        TextEditor(text: $userSentence.sentence.toUnwrapped(defaultValue: ""))
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                    }.padding(.vertical, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Tag: ")
                        TextEditor(text: $userSentence.tag.toUnwrapped(defaultValue: ""))
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                    }.padding(.vertical, 5)
                    
                    
                    Button(action: {
                        userSentence.save()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Update Sentence")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame (height: 55)
                            .frame (maxWidth: .infinity)
                            .background (Color.indigo)
                            .cornerRadius(10)
                    })
                }
            }
        } //VStack
    }
}

//struct EditUserSentence_Previews: PreviewProvider {
//    static var previews: some View {
//        EditUserSentence()
//    }
//}
