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
                        TravelingDetail(traveling: travel)
                    } label: {
                        HStack {
                            getTypeAndReturnImage(for: Int(travel.type))
                            Text(travel.name ?? "")
                        }
                    }
                }
                .onDelete(perform: deleteTraveling)
            }
            .listStyle(.plain)
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
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        
    }
    
    private func deleteTraveling(offsets: IndexSet) {
        withAnimation {
            offsets.map { travelings[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
    
    private func getTypeAndReturnImage(for type: Int) -> Image {
        switch type {
        case 0:
            return Image(systemName: "airplane")
        case 1:
            return Image(systemName: "allergens")
        
        case 2:
            return Image(systemName: "briefcase")
        
        case 3:
            return Image(systemName: "ticket")
        
        case 4:
            return Image(systemName: "books.vertical")
        
        default:
            return Image(systemName: "airplane")
        }
    }
}

struct MyTravelingsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelingsView()
    }
}

