//
//  ContentView.swift
//  Aangilam
//
//  Created by Selvarajan on 13/03/22.
//

import Foundation
import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    @StateObject var userPhraseListVM = UserPhraseListViewModel()
    @State var selection: Int? = nil
    @State var showList: Int? = nil
    @State private var searchText = ""
    @State var appTheme: String = "dark"
    
    var WordListFooter: some View {
        NavigationLink(destination: UserWordList(), tag: 1, selection: $showList) {
            if (userWordListVM.userWordRecentEntries.count > 0) {
                Button(action: {
                    // Show word list
                    self.showList = 1
                }, label: {
                    Text("View All ")
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
                    Text("View All ")
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
                    Text("View All ")
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
                        //Search bar
                        Section(footer: EmptyView().padding(0)) {
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
                                
                                HStack {
                                    Text("Search words in dictionary...")
                                        .font(.headline)
                                        .padding()
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.gray)
                                }
                                
                            }.padding(0)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        //Resources
                        Section() { //header: Text("Resources").padding(.horizontal, 15)) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top, spacing: 20) {
                                    Button {
                                        //
                                    } label: {
                                        VStack(alignment: .center, spacing: 15) {
                                            Text("Verb")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .shadow(color: Color.black.opacity(0.4),
                                                        radius: 2,
                                                        x: 3,
                                                        y: 3)
                                                .padding(20)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [.indigo, .indigo.opacity(0.8), .indigo.opacity(0.4)]), startPoint: .topLeading , endPoint: .bottomTrailing)
                                                )
                                                .clipShape(Circle())
                                            
                                            Text("Intermediate \nVerbs")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    
                                    Button {
                                        //
                                    } label: {
                                        VStack(alignment: .center, spacing: 15) {
                                            Text("Adj")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .shadow(color: Color.black.opacity(0.4),
                                                        radius: 2,
                                                        x: 3,
                                                        y: 3)
                                                .padding(20)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.8), .blue.opacity(0.4)]), startPoint: .topLeading , endPoint: .bottomTrailing)
                                                )
                                                .clipShape(Circle())
                                            
                                            Text("Common \nAdjectives")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                            
                                        }
                                    }
                                    
                                    Button {
                                        //
                                    } label: {
                                        VStack(alignment: .center, spacing: 15) {
                                            Text("Adv")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .shadow(color: Color.black.opacity(0.4),
                                                        radius: 2,
                                                        x: 3,
                                                        y: 3)
                                                .padding(20)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [.cyan, .cyan.opacity(0.8), .cyan.opacity(0.4)]), startPoint: .topLeading , endPoint: .bottomTrailing)
                                                )
                                                .clipShape(Circle())
                                            
                                            Text("Common \nAdverbs")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                            
                                        }
                                    }
                                    
                                    Button {
                                        //
                                    } label: {
                                        VStack(alignment: .center, spacing: 15) {
                                            Text("Ph")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .shadow(color: Color.black.opacity(0.4),
                                                        radius: 2,
                                                        x: 3,
                                                        y: 3)
                                                .padding(20)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [.indigo, .indigo.opacity(0.8), .indigo.opacity(0.4)]), startPoint: .topLeading , endPoint: .bottomTrailing)
                                                )
                                                .clipShape(Circle())
                                            
                                            Text("Useful \nPhrases")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                            
                                        }
                                    }
                                    
                                    Button {
                                        //
                                    } label: {
                                        VStack(alignment: .center, spacing: 15) {
                                            Text("Id")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .shadow(color: Color.black.opacity(0.4),
                                                        radius: 2,
                                                        x: 3,
                                                        y: 3)
                                                .padding(20)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.8), .blue.opacity(0.4)]), startPoint: .topLeading , endPoint: .bottomTrailing)
                                                )
                                                .clipShape(Circle())
                                            
                                            Text("Useful \nIdioms")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                            
                                        }
                                    }
                                }.padding(.bottom, 10)
                            }
                        }
                        .padding(.top, 0)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        // Game section
                        Section(header: Text("Gamify your learning").padding(.horizontal, 15)) {
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    NavigationLink(destination: RandomPickerView(), tag: 13, selection: $selection) {
                                        Button(action: {
                                            self.selection = 13
                                        }) {
                                            VStack(alignment: SwiftUI.HorizontalAlignment.leading){
                                                Text("Randomizer")
                                                    .font(.callout).bold()
                                                    .foregroundColor(.white)
                                                Text("word, sentence")
                                                    .font(.footnote).foregroundColor(.white.opacity(0.6))
                                            }.foregroundColor(.white)
                                        }
                                        .frame(width: 145, height: 75, alignment: .center)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.indigo, .indigo.opacity(0.9), .indigo.opacity(0.55)]), startPoint: .top, endPoint: .bottom)
                                        ).cornerRadius(10)
                                    }
                                    
                                    NavigationLink(destination: PickDefinitionHome(), tag: 12, selection: $selection) {
                                        Button(action: {
                                            self.selection = 12
                                        }) {
                                            VStack(alignment: SwiftUI.HorizontalAlignment.leading){
                                                Text("Pick Definition")
                                                    .font(.callout).bold()
                                                    .foregroundColor(.white)
                                                Text("by word").font(.footnote).foregroundColor(.white.opacity(0.6))
                                            }
                                        }
                                        .frame(width: 145, height: 75, alignment: .center)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.9), .blue.opacity(0.55)]), startPoint: .top, endPoint: .bottom)
                                        ).cornerRadius(10)
                                    }
                                    
                                    NavigationLink(destination: SpellWord(), tag: 11, selection: $selection) {
                                        Button(action: {
                                            self.selection = 11
                                        }) {
                                            VStack(alignment: SwiftUI.HorizontalAlignment.leading){
                                                Text("Spell Word")
                                                    .font(.callout).bold()
                                                    .foregroundColor(.white)
                                                Text("by definition")
                                                    .font(.footnote).foregroundColor(.white.opacity(0.6))
                                            }.foregroundColor(.white)
                                        }
                                        .frame(width: 145, height: 75, alignment: .center)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.teal, .teal.opacity(0.9), .teal.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                                        ).cornerRadius(10)
                                    }
                                }
                                .padding(0)
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        //Your Recent Words
                        Section(header: Text("Your Recent Words"), footer: WordListFooter) {
                            if (userWordListVM.userWordRecentEntries.count == 0) {
                                VStack(alignment: .leading){
                                    Button {
                                        self.selection = 1
                                    } label: {
                                        Text("No words yet. \nClick here to add your first word")
                                            .font(.footnote)
                                            .foregroundColor(.indigo)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            else {
                                ForEach(userWordListVM.userWordRecentEntries, id:\.objectID) {userword in
                                    HStack {
                                        Text("\(userword.word!)")
                                            .font(.headline)
                                            .bold()
                                        Text(" \(userword.meaning ?? "")")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                    .padding(.vertical, 10)
                                    .background(NavigationLink("", destination: ViewUserWord(word: userword)).opacity(0))
                                }
                            }
                        }
                        
                        //Common English Words
                        Section(header: Text("Resources").padding(.horizontal, 15)) {
                            Button(action: {
                                self.selection = 11
                            }) {
                                HStack(spacing: 20) {
                                    Image(systemName: "character.book.closed.fill")
                                        .resizable()
                                        .frame(width: 20, height: 25)
                                        .foregroundColor(.indigo)
                                    
                                    VStack(alignment: .leading) {
                                        Text("500+ Intermediate Vocabulary")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text("Verbs, Adjectives, Adverbs")
                                            .font(.subheadline).foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.leading)
                            }
                            .frame(maxWidth:.infinity, minHeight: 60)
                            //                            .background(
                            //                                RoundedRectangle(cornerRadius: 10)
                            //                                    .stroke(.indigo.opacity(0.7), lineWidth: 0)
                            //                            )
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        //                        .listRowBackground(Color.clear)
                        
                        //Recent Phrases / Idioms
                        Section(header: Text("Recent Phrases / Idioms"),  footer: PhraseListFooter) {
                            if (userPhraseListVM.userPhraseRecentEntries.count == 0) {
                                VStack(alignment: .leading){
                                    Button {
                                        self.selection = 3
                                    } label: {
                                        Text("No phrases/idioms yet. \nClick here to add your first phrase/idiom")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                            .padding(.vertical, 10)
                                    }
                                }
                            }
                            else {
                                ForEach(userPhraseListVM.userPhraseRecentEntries, id:\.objectID) {phrase in
                                    HStack {
                                        Text("\(phrase.phrase ?? "")").font(.subheadline)
                                    }.background(NavigationLink("", destination: ViewPhrase(userPhrase: phrase))
                                        .opacity(0))
                                }
                            }
                        }
                        
                        //Recent Sentences
                        Section(header: Text("Recent Sentences"),  footer: SentenceListFooter) {
                            if (userSentenceListVM.userSentenceRecentEntries.count == 0) {
                                VStack(alignment: .leading){
                                    Button {
                                        self.selection = 2
                                    } label: {
                                        Text("No sentences yet. \nClick here add your first sentence")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                            .padding(.vertical, 10)
                                    }
                                }
                            }
                            else {
                                ForEach(userSentenceListVM.userSentenceRecentEntries, id:\.objectID) {sentence in
                                    HStack {
                                        Text("\(sentence.sentence ?? "")")
                                            .font(.subheadline)
                                    }
                                    .background(NavigationLink("", destination: ViewUserSentence(userSentence: sentence))
                                        .opacity(0))
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
                                        .frame(width: 55, height: 55)
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
                    Button(action: {
                        if appTheme == "dark" {
                            UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                        }
                        else {
                            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                        }
                        appTheme = appTheme == "dark" ? "light" : "dark"
                    }, label: {
                        Image(systemName: "gearshape.fill")
                    })
                    
                }
            }
        }
        .accentColor(.indigo)
        .ignoresSafeArea()
        .onAppear(){
            //            do {
            //                //to show launch screen atleast for one second
            //                let ms = 1000
            //                usleep(useconds_t(600 * ms))
            //            }
        }
        .environment(\.colorScheme, appTheme == "light" ? .light : .dark)
        //        .overlay(SplashScreen())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
