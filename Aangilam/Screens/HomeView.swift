//
//  ContentView.swift
//  Aangilam
//
//  Created by Selvarajan on 13/03/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    @StateObject var userPhraseListVM = UserPhraseListViewModel()
    @State var selection: Int? = nil
    @State var showList: Int? = nil
    
    func delete(at indexes: IndexSet) {
        //        if let first = indexes.first {
        //            //
        //        }
    }
    
    var WordListFooter: some View {
        NavigationLink(destination: UserWordList(), tag: 1, selection: $showList) {
            Button(action: {
                // Show word list
                self.showList = 1
            }, label: {
                Text("Show All")
                    .foregroundColor(.blue)
                    .padding(.bottom, 7)
            })
        }
    }
    
    var SentenceListFooter: some View {
        NavigationLink(destination: UserSentenceList(), tag: 2, selection: $showList) {
            Button(action: {
                // Show sentence list
                self.showList = 2
            }, label: {
                Text("Show All")
                    .foregroundColor(.blue)
                    .padding(.bottom, 7)
            })
        }
    }
    
    var PhraseListFooter: some View {
        NavigationLink(destination: UserPhraseList(), tag: 3, selection: $showList) {
            Button(action: {
                // Show phrase list
                self.showList = 3
            }, label: {
                Text("Show All")
                    .foregroundColor(.blue)
                    .padding(.bottom, 7)
            })
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                ZStack {
                    List {
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                NavigationLink(destination: FlipCardGame(), tag: 11, selection: $selection) {
                                    Button(action: {
                                        self.selection = 11
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.mint)
                                                .frame(width: 140, height: 80, alignment: .leading)
                                                .cornerRadius(10)
                                            
                                            Text("Word Flip")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .frame(width: 100, height: 120, alignment: .center)
                                        }
                                    }
                                }
                                NavigationLink(destination: RandomSentenceView(), tag: 12, selection: $selection) {
                                    Button(action: {
                                        self.selection = 12
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.cyan)
                                                .frame(width: 140, height: 80, alignment: .leading)
                                                .cornerRadius(10)
                                                .padding(10)
                                            
                                            Text("Random Sentences")
                                                .font(.title3)
                                                .foregroundColor(.white)
                                                .frame(width: 100, height: 120, alignment: .center)
                                        }
                                    }
                                }
                                
                            }
                            .padding(0)
                        }
                        .padding(0)
                        .listRowBackground(Color.clear)
                        
                        
                        Section(header: Text("Words"), footer: WordListFooter) {
                            ForEach(userWordListVM.userWordRecentEntries, id:\.id) {userword in
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("\(userword.word)")
                                            .font(.headline)
                                            .bold()
                                        Text(" (\(userword.type))  \(userword.meaning)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .onDelete(perform: delete)
                        }
                        .listSectionSeparatorTint(.red)
                        
                        Section(header: Text("Sentences"),  footer: SentenceListFooter) {
                            ForEach(userSentenceListVM.userSentenceRecentEntries, id:\.id) {sentence in
                                Text("\(sentence.sentence)").font(.subheadline)
                            }
                        }
                        
                        Section(header: Text("Phrases / Idioms"),  footer: PhraseListFooter) {
                            ForEach(userPhraseListVM.userPhraseRecentEntries, id:\.id) {phrase in
                                Text("\(phrase.phrase)").font(.subheadline)
                            }
                        }
                    }
                    .padding(0)
                    .listStyle(.insetGrouped)
                    //                .ignoresSafeArea(edges: .top)
                    .onAppear {
                        userWordListVM.getRecentWordEntries()
                        userSentenceListVM.getRecentSentenceEntries()
                        userPhraseListVM.getRecentPhraseEntries()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: AddUserWordView(), tag: 1, selection: $selection) {
                                Button(action: {
                                    // Add new word
                                    self.selection = 1
                                }) {
                                    Text("+W")
                                        .font(.headline)
                                    //                                    Image(systemName: "plus")
                                    //                                        .font(.title)
                                }
                                .padding(15)
                                .foregroundColor(Color.white)
                                .background(Color.indigo)
                                .cornerRadius(8)
                            }
                            .padding(.trailing, 5)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                            
                            NavigationLink(destination: AddUserSentenceView(), tag: 2, selection: $selection) {
                                Button(action: {
                                    // Add new word
                                    self.selection = 2
                                }) {
                                    Text("+S")
                                        .font(.headline)
                                    //                                    Image(systemName: "plus")
                                    //                                        .font(.title)
                                }
                                .padding(15)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
                            .padding(.trailing, 5)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                            
                            NavigationLink(destination: AddUserPhraseView(), tag: 3, selection: $selection) {
                                Button(action: {
                                    // Add new word
                                    self.selection = 3
                                }) {
                                    Text("+P")
                                        .font(.headline)
                                    //                                    Image(systemName: "plus")
                                    //                                        .font(.title)
                                }
                                .padding(15)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(8)
                            }
                            .padding(.trailing, 20)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                            
                        }
                    }
                }
            }
            .navigationTitle("Aangilam")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            //looListVM.getLooEntriesFor(date: listDate)
                        }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(destination: Test()) {
                        Image(systemName: "plus")
                        //                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
