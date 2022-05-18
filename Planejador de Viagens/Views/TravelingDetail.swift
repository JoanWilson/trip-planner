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
        //        VStack {
        //            TextField("Digite um lugar", text: $placeName)
        //            TextField("Digite o valor do orçamento", value: $placeBudget, format: .number)
        //            Button {
        //                addPlace()
        //            } label: {
        //                 Text("Adicionar")
        //            }
        VStack {
            HStack {
                Text("\(traveling.budget)")
                Text("\(returnTotal())")
                Text("Restante")
            }
            .background(.clear)
            List {
                ForEach(traveling.placesArray) { place in
                    Text(place.unwrappedName)
                }.onDelete(perform: deletePlace)
            }
            .listStyle(.plain)
            .searchable(text: $searchField, prompt: "Pesquisa")
        }
        .navigationTitle(traveling.name ?? "")
        .sheet(isPresented: $addPlace, content: {
            AddPlaceView(traveling: traveling)
        })
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    addPlace.toggle()
                } label: {
                    Label("Adicionar", systemImage: "plus")
                }
                EditButton()
            }
            
        }
        
        //        }
        
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
        MyTravelingsView()
    }
}
