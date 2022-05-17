//
//  MyTravelingsView.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 17/05/22.
//

import SwiftUI
import CoreData

struct MyTravelingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Traveling.name, ascending: true)]) private var travelings: FetchedResults<Traveling>
    
    @State private var addTravel = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(travelings) { travel in
                    NavigationLink {
                        Text(travel.name ?? "")
                    } label: {
                        Text(travel.name ?? "")
                    }
                }
            }
            .navigationTitle("Minhas viagens")
            .sheet(isPresented: $addTravel, content: {
                AddTravelingView()
            })
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        addTravel.toggle()
                    } label: {
                        Label("Adicionar", systemImage: "plus")
                    }
                }
            }
        }
        
    }
}

struct MyTravelingsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelingsView()
    }
}

