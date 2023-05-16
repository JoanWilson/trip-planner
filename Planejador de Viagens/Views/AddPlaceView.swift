//
//  AddPlaceView.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 18/05/22.
//

import SwiftUI

struct AddPlaceView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var traveling: Traveling
    @State private var placeName: String = ""
    @State private var placeBudget: String = ""
    @State private var showingAlert = false
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Type a name your expense", text: $placeName)
                }
                
                Section {
                    HStack {
                        Text("Budget")
                        Text("R$: ")
                    
                        TextField("Value", text: $placeBudget)
                            .keyboardType(.decimalPad)
                        
                        
                    }
                    
                }
            }
            .navigationTitle("Add expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        addPlace()
                    } label: {
                        Text("Save")
                    }
                    .alert("Empty fields are not accepted", isPresented: $showingAlert) {
                        Button("Ok", role: .cancel) {}
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    private func addPlace() {
        
        guard let placeBudgetValue = Double(placeBudget) else {
            return
        }
        
        if placeName.isEmpty || placeBudgetValue == 0 {
            return showingAlert = true
        }
        
        let newPlace = Place(context: viewContext)
        newPlace.id = UUID()
        newPlace.name = placeName
        newPlace.longitude = 0
        newPlace.latitude = 0
        newPlace.budget = placeBudgetValue
        
        
        traveling.addToPlaces(newPlace)
        PersistenceController.shared.saveContext()
        
        
        dismiss()
        
    }
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelingsView()
    }
}
