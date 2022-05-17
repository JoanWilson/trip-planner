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
    
    var body: some View {
        VStack {
            TextField("Digite um lugar", text: $placeName)
            TextField("Digite o valor do orçamento", value: $placeBudget, format: .number)
            Button {
                addPlace()
            } label: {
                 Text("Adicionar")
            }
            List {
                ForEach(traveling.placesArray) { place in
                    Text(place.unwrappedName)
                }.onDelete(perform: deletePlace)
            }
            
            
        }
        
    }
    
    private func addPlace() {
        withAnimation {
            let newPlace = Place(context: viewContext)
            newPlace.id = UUID()
            newPlace.name = placeName
            newPlace.longitude = 0
            newPlace.latitude = 0
            newPlace.budget = placeBudget
            
            traveling.addToPlaces(newPlace)
            PersistenceController.shared.saveContext()
        }
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
