//
//  ContentView.swift
//  Mozhi
//
//  Created by Selvarajan on 13/03/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @State var selection: Int? = nil
    @State var showList: Int? = nil
    
    func delete(at indexes: IndexSet) {
        //        if let first = indexes.first {
        //            //
        //        }
    }
    
    var Footer: some View {
        NavigationLink(destination: WordList(), tag: 1, selection: $showList) {
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
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                ZStack {
                    List { //(userWordListVM.userWordAllEntries, id: \.id) { userword in
                        
                        Section(header: Text("Vocabulary"), footer: Footer) {
                            ForEach(userWordListVM.userWordRecentEntries, id:\.id) {userword in
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("\(userword.word)")
                                            .font(.headline)
                                            .bold()
                                        Text(" (\(userword.type))  \(userword.meaning)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .onDelete(perform: delete)
                        }
                        .listSectionSeparatorTint(.red)
                        
                        Section(header: Text("Sentences"),  footer: Text("Show more").foregroundColor(Color.blue)) {
                            ForEach(userWordListVM.userWordRecentEntries, id:\.id) {word in
                                if word.sampleSentence != "" {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("\(word.sampleSentence)").font(.subheadline).bold()
                                    }
                                }
                            }
                        }
                    }
                    .padding(0)
                    .listStyle(.insetGrouped)
                    //                .ignoresSafeArea(edges: .top)
                    .onAppear {
                        userWordListVM.getRecentWordEntries()
                        //userWordListVM.getAllUserWordEntries()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: AddUserWordView(), tag: 1, selection: $selection) {
                                Button(action: {
                                    // Add new word
                                    self.selection = 1
                                }, label: {
                                    Text("+")
                                        .font(.system(.largeTitle))
                                        .frame(width: 77, height: 70)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 7)
                                })
                                .background(Color.blue)
                                .cornerRadius(38.5)
                                .padding()
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                            } .ignoresSafeArea()
                            
                        }
                    }
                }
            }
            .navigationTitle("Mozhi")
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
                    NavigationLink(destination: AddUserWordView()) {
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
