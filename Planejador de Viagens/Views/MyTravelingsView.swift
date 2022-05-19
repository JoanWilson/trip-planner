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
                if !travelings.isEmpty {
                    ForEach(travelings) { travel in
                        NavigationLink {
                            TravelingDetail(traveling: travel)
                        } label: {
                            HStack {
                                Image(systemName: getTypeAndReturnImage(for: Int(travel.type)))
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 20)
                                VStack {
                                    Text(travel.name ?? "")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Budget: \(travel.budget.formatted(.currency(code: "BRL")))")
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(.gray)
                                }
                                
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteTraveling)
                } else {
                    Text("😕 You didn't add any traveling yet")
                        .foregroundColor(.gray)
                        .padding(.vertical, UIScreen.main.bounds.height*0.3)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                }
            }
            
            .navigationTitle("My Travelings")
            .sheet(isPresented: $addTravel, content: {
                AddTravelingView()
            })
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        addTravel.toggle()
                    } label: {
                        Text("Add")
                    }
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
    
    private func getTypeAndReturnImage(for type: Int) -> String {
        switch type {
        case 0:
            return "airplane"
        case 1:
            return "allergens"
        
        case 2:
            return "briefcase"
        
        case 3:
            return "ticket"
        
        case 4:
            return "books.vertical"
        
        default:
            return "airplane"
        }
    }
    
}

struct MyTravelingsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelingsView()
    }
}

