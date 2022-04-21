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
    @State private var searchText = ""
    
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
                        
                        HStack {
                            TextField("Search...", text: $searchText)
                                .font(.title3)
                                .padding(10)
                                .background(.gray.opacity(0.1))
                            Spacer()
                            NavigationLink(destination: Dictionary()) {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: SwiftUI.ContentMode.fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.mint)
                            }
                        }
                        .padding(.vertical, 20)
                        .listRowBackground(Color.clear)
                        
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                NavigationLink(destination: FlipCardGame(), tag: 11, selection: $selection) {
                                    Button(action: {
                                        self.selection = 11
                                    }) {
                                        Text("Word Flip")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .frame(width: 140, height: 80, alignment: .center)
                                            .background(
                                                LinearGradient(gradient: Gradient(colors: [.indigo, .indigo.opacity(0.9), .indigo.opacity(0.55)]), startPoint: .top, endPoint: .bottom)
                                            ).cornerRadius(10)
                                    }
                                }
                                NavigationLink(destination: RandomSentenceView(), tag: 12, selection: $selection) {
                                    Button(action: {
                                        self.selection = 12
                                    }) {
                                        Text("Random Sentences")
                                            .font(.title3)
                                            .foregroundColor(.white)
                                            .frame(width: 140, height: 80, alignment: .center)
                                            .background(
                                                LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.9), .blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                                            ).cornerRadius(10)
                                    }
                                }
                            }
                            .padding(0)
                        }
                        .padding(0)
                        .listRowBackground(Color.clear)
                        
                        
                        Section(header: Text("Words"), footer: WordListFooter) {
                            ForEach(userWordListVM.userWordRecentEntries, id:\.objectID) {userword in
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("\(userword.word!)")
                                            .font(.headline)
                                            .bold()
                                        Text(" \(userword.meaning ?? "")")
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
                            ForEach(userSentenceListVM.userSentenceRecentEntries, id:\.objectID) {sentence in
                                Text("\(sentence.sentence ?? "")").font(.subheadline)
                            }
                        }
                        
                        Section(header: Text("Phrases / Idioms"),  footer: PhraseListFooter) {
                            ForEach(userPhraseListVM.userPhraseRecentEntries, id:\.objectID) {phrase in
                                Text("\(phrase.phrase ?? "")").font(.subheadline)
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
//                    .ignoresSafeArea(.container, edges: .top)
//                    .ignoresSafeArea(.all, edges: .bottom)
                    
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
                                .background(Color.cyan)
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
                .padding(0)
            }
            .padding(0)
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
