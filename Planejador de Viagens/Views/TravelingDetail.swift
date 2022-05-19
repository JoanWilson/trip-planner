//
//  TravelingDetail.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 17/05/22.
//

import SwiftUI

struct TravelingDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var traveling: Traveling
    @State private var placeName: String = ""
    @State private var placeBudget: Double = 0.0
    @State private var addPlace = false
    @State private var searchField = ""
    
    
    var body: some View {
        
        VStack {
            if !traveling.placesArray.isEmpty {
                List {
                    Section {
                        VStack {
                            if (traveling.budget - returnTotal()) <= 0 {
                                VStack {
                                    Text("\((traveling.budget - returnTotal()).formatted(.currency(code: "BRL")))")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("Balance")
                                }
                                .foregroundColor(.red)
                            } else {
                                VStack {
                                    Text("\((traveling.budget - returnTotal()).formatted(.currency(code: "BRL")))")
                                        .fontWeight(.bold)
                                        .font(.title2)
                                    
                                    Text("Balance")
                                }
                                .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .frame(maxWidth:.infinity, alignment: .center)
                    }
                    Section {
                        
                        ForEach(traveling.placesArray) { place in
                            HStack {
                                Text(place.unwrappedName)
                                Spacer()
                                Text("\(place.unwrappedBudget.formatted(.currency(code: "BRL")))")
                                    .padding(.horizontal,5)
                                    .background(.red)
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                                
                            }
                            
                        }.onDelete(perform: deletePlace)
                    } header: {
                        Text("Expenses List")
                    }
                    
                }
            } else {
                Text("😕 You didn't add any traveling yet")
                    .foregroundColor(.gray)
                    .padding(.vertical, UIScreen.main.bounds.height*0.3)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
            }
            //            .searchable(text: $searchField, prompt: "Pesquisa")
            //            .listStyle(.plain)
        }
        .navigationTitle(traveling.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $addPlace, content: {
            AddPlaceView(traveling: traveling)
        })
        .toolbar {
            //MARK: - TOOLBAR TRAVELING DETAIL
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    addPlace.toggle()
                } label: {
                    Text("Add")
                }
            }
            
            
            
        }
        
        
        
    }
    
    func returnTotal() -> Double{
        var total: Double = 0
        for i in traveling.placesArray {
            total = i.budget + total
        }
        return total
    }
    
    private func deletePlace(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let place = traveling.placesArray[index]
                viewContext.delete(place)
                PersistenceController.shared.saveContext()
            }
        }
    }
}

struct TravelingDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
