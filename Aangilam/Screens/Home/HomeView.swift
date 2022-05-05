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
            if (userWordListVM.userWordRecentEntries.count > 0) {
                Button(action: {
                    // Show word list
                    self.showList = 1
                }, label: {
                    Text("Show All")
                        .foregroundColor(.blue)
                        .padding(.bottom, 7)
                })
            }
            else {
                EmptyView()
            }
        }
    }
    
    var SentenceListFooter: some View {
        NavigationLink(destination: UserSentenceList(), tag: 2, selection: $showList) {
            if (userSentenceListVM.userSentenceRecentEntries.count > 0) {
                Button(action: {
                    // Show sentence list
                    self.showList = 2
                }, label: {
                    Text("Show All")
                        .foregroundColor(.blue)
                        .padding(.bottom, 7)
                })
            }
            else {
                EmptyView()
            }
        }
    }
    
    var PhraseListFooter: some View {
        NavigationLink(destination: UserPhraseList(), tag: 3, selection: $showList) {
            if (userPhraseListVM.userPhraseRecentEntries.count > 0) {
                Button(action: {
                    // Show phrase list
                    self.showList = 3
                }, label: {
                    Text("Show All")
                        .foregroundColor(.blue)
                        .padding(.bottom, 7)
                })
            }
            else {
                EmptyView()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    List {
                        Section {
                            ZStack {
                                NavigationLink(destination:
                                                Dictionary()
                                ) {
                                    EmptyView()
                                }
                                .buttonStyle(PlainButtonStyle())
                                .opacity(0.0)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.gray.opacity(0.2))
//                                    .stroke(lineWidth: 2)
                                
                                HStack {
                                    Text("Search meaning for words here...")
                                        .font(.headline)
                                        .padding()
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.gray)
                                }
                                
                            }.padding(0)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        // Game section
                        Section(header: Text("Gamify your learning").padding(.horizontal, 15)) {
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack {
                                    NavigationLink(destination: WordFinder(), tag: 11, selection: $selection) {
                                        Button(action: {
                                            self.selection = 11
                                        }) {
                                            VStack(alignment: SwiftUI.HorizontalAlignment.leading){
                                                Text("Word Finder").font(.headline).foregroundColor(.white)
                                                Text("by meaning")
                                                    .font(.subheadline).foregroundColor(.white.opacity(0.6))
                                            }.foregroundColor(.white)
                                        }
                                        .frame(width: 140, height: 80, alignment: .center)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.indigo, .indigo.opacity(0.9), .indigo.opacity(0.55)]), startPoint: .top, endPoint: .bottom)
                                            ).cornerRadius(10)
                                    }
                                    NavigationLink(destination: PickMeaningHome(), tag: 12, selection: $selection) {
                                        Button(action: {
                                            self.selection = 12
                                        }) {
                                            VStack(alignment: SwiftUI.HorizontalAlignment.leading){
                                                Text("Meaning Picker").font(.headline).foregroundColor(.white)
                                                Text("by word").font(.subheadline).foregroundColor(.white.opacity(0.6))
                                            }
                                        }
                                        .frame(width: 140, height: 80, alignment: .center)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.9), .blue.opacity(0.55)]), startPoint: .top, endPoint: .bottom)
                                        ).cornerRadius(10)
                                    }
                                    NavigationLink(destination: RandomPickerView(), tag: 13, selection: $selection) {
                                        Button(action: {
                                            self.selection = 13
                                        }) {
                                            VStack(alignment: SwiftUI.HorizontalAlignment.leading){
                                                Text("Random Picker").font(.headline).foregroundColor(.white)
                                                Text("word, sentence")
                                                    .font(.subheadline).foregroundColor(.white.opacity(0.6))
                                            }.foregroundColor(.white)
                                        }
                                        .frame(width: 140, height: 80, alignment: .center)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.cyan, .cyan.opacity(0.9), .cyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                                        ).cornerRadius(10)
                                    }
                                }
                                .padding(0)
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        //Recent Words
                        Section(header: Text("Recent Words"), footer: WordListFooter) {
                            if (userWordListVM.userWordRecentEntries.count == 0) {
                                VStack(alignment: .leading){
                                    Text("No words are added yet.")
                                        .font(.footnote)
                                        .padding(.vertical, 10)
                                    Button {
                                        //
                                    } label: {
                                        Text("+ Add your first word")
                                            .font(.footnote)
                                            .foregroundColor(.indigo)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            else {
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
                            }
//                            .onDelete(perform: delete)
                        }
//                        .listSectionSeparatorTint(.indigo)
                        
                        //Common English Words
                        Section() {
                            Button(action: {
                                self.selection = 11
                            }) {
                                HStack(spacing: 20) {
                                    Image(systemName: "list.bullet.rectangle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                    VStack(alignment: .leading) {
                                        Text("500+ Common English Words")
                                            .font(.headline)
                                        Text("Neither basic nor advanced")
                                            .font(.subheadline).foregroundColor(.gray)
                                    }
                                }.accentColor(.indigo)
                            }
                            .frame(maxWidth:.infinity, minHeight: 60)
                            .cornerRadius(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.indigo.opacity(0.7), lineWidth: 1)
                            )
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        //Recent Sentences
                        Section(header: Text("Recent Sentences"),  footer: SentenceListFooter) {
                            if (userSentenceListVM.userSentenceRecentEntries.count == 0) {
                                VStack(alignment: .leading){
                                    Text("No sentences are added yet.")
                                        .font(.footnote)
                                        .padding(.vertical, 10)
                                    Button {
                                        //
                                    } label: {
                                        Text("+ Add your first sentence")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            else {
                                ForEach(userSentenceListVM.userSentenceRecentEntries, id:\.objectID) {sentence in
                                    Text("\(sentence.sentence ?? "")").font(.subheadline)
                                }
                            }
                        }
                        
                        //Recent Phrases / Idioms
                        Section(header: Text("Recent Phrases / Idioms"),  footer: PhraseListFooter) {
                            if (userPhraseListVM.userPhraseRecentEntries.count == 0) {
                                VStack(alignment: .leading){
                                    Text("No phrases/idioms are added yet.")
                                        .font(.footnote)
                                        .padding(.vertical, 10)
                                    Button {
                                        //
                                    } label: {
                                        Text("+ Add your first phrase/idiom")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            else {
                                ForEach(userPhraseListVM.userPhraseRecentEntries, id:\.objectID) {phrase in
                                    Text("\(phrase.phrase ?? "")").font(.subheadline)
                                }
                            }
                        }
                    }
                    .padding(0)
                    .padding(.top, -15)
                    .listStyle(.insetGrouped)
                    .onAppear {
                        userWordListVM.getRecentWordEntries()
                        userSentenceListVM.getRecentSentenceEntries()
                        userPhraseListVM.getRecentPhraseEntries()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: AddUserWordView(), tag: 1, selection: $selection) { EmptyView() }
                            NavigationLink(destination: AddUserSentenceView(), tag: 2, selection: $selection) { EmptyView() }
                            NavigationLink(destination: AddUserPhraseView(), tag: 3, selection: $selection) { EmptyView() }
                                
                            Menu {
                                Button(action: {
                                    self.selection = 1
                                }) {
                                    Text("Word")
                                }.padding()
                                
                                Button(action: {
                                    // Add new word
                                    self.selection = 2
                                }) {
                                    Text("Sentence")
                                }.padding()
                                
                                Button(action: {
                                    // Add new word
                                    self.selection = 3
                                }) {
                                    Button(action: {}) {
                                        Text("Phrase/Idiom")
                                    }
                                }.padding()
                            } label: {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [.indigo, .blue]), startPoint: .top, endPoint: .bottom)
                                        .frame(width: 65, height: 65)
                                        .cornerRadius(10)
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                                .padding(.trailing, 20)
                                .shadow(color: Color.black.opacity(0.4),
                                         radius: 3,
                                         x: 3,
                                         y: 3)
                            }
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
                    NavigationLink(destination: Test2()) {
                        Image(systemName: "line.3.horizontal.circle")
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(destination: Test()) {
                        Image(systemName: "gearshape.fill")
                        //                            .foregroundColor(.black)
                    }
                }
            }
        }
        .accentColor(.indigo)
        .ignoresSafeArea()
        .onAppear(){
            do {
                //to show launch screen atleast for one second
//                sleep(1)
                let ms = 1000
                usleep(useconds_t(600 * ms))
            }
        }
//        .overlay(SplashScreen())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
