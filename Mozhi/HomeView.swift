//
//  ContentView.swift
//  Mozhi
//
//  Created by Selvarajan on 13/03/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var myWordListVM = MyWordListViewModel()
    @State var selection: Int? = nil
    
    func delete(at indexes: IndexSet) {
        if let first = indexes.first {
            //
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack{
                //            ZStack {
                List { //(myWordListVM.myWordAllEntries, id: \.id) { myword in
                    
                    Section(header: Text("Vocabulary").padding()) {
                        ForEach(myWordListVM.myWordAllEntries, id:\.id) {myword in
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(myword.word)").font(.subheadline).bold()
                                Text("\(myword.meaning)").font(.subheadline)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    
                    Section(header: Text("Sentences").padding()) {
                        ForEach(myWordListVM.myWordAllEntries, id:\.id) {word in
                            if word.sampleSentence != "" {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(word.sampleSentence)").font(.subheadline).bold()
                                }
                            }
                        }
                    }
                }
//                .ignoresSafeArea(edges: .top)
                .onAppear {
                    myWordListVM.getAllMyWordEntries()
                }
                
                
            }
            
            //                VStack {
            //                    Spacer()
            //                    HStack {
            //                        Spacer()
            //                        NavigationLink(destination: AddWordView(), tag: 1, selection: $selection) {
            //                            Button(action: {
            //                                // Add new word
            //                                self.selection = 1
            //                            }, label: {
            //                                Text("+")
            //                                    .font(.system(.largeTitle))
            //                                    .frame(width: 77, height: 70)
            //                                    .foregroundColor(Color.white)
            //                                    .padding(.bottom, 7)
            //                            })
            //                            .background(Color.blue)
            //                            .cornerRadius(38.5)
            //                            .padding()
            //                            .shadow(color: Color.black.opacity(0.3),
            //                                    radius: 3,
            //                                    x: 3,
            //                                    y: 3)
            //                        } .ignoresSafeArea()
            //
            //                    }
            //                }
            //            }
            .navigationTitle("Mozhi")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                        .onTapGesture {
                            //looListVM.getLooEntriesFor(date: listDate)
                        }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(destination: AddWordView()) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
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
