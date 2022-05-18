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
    @State private var placeBudget = 0
    @State private var showingAlert = false
    
    //    private var numberFormatter: NumberFormatter =
    //
    //    init(numberFormatter: NumberFormatter = NumberFormatter()) {
    //        self.numberFormatter = numberFormatter
    //        self.numberFormatter.usesGroupingSeparator = true
    //        self.numberFormatter.numberStyle = .currency
    //        self.numberFormatter.locale = Locale.current
    //        self.numberFormatter.maximumFractionDigits = 2
    //    }
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Qual o nome do local", text: $placeName)
                }
                
                Section {
                    TextField("Orçamento", value: $placeBudget, format: .currency(code: "BRL"))
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        addPlace()
                    } label: {
                        Text("Salvar")
                    }
                    .alert("O nome do local não pode ser vazio!", isPresented: $showingAlert) {
                        Button("Tudo bem", role: .cancel) {}
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                }
            }
        }
    }
    
    private func addPlace() {
        
        
        if placeName.isEmpty {
            return showingAlert = true
        }
        
        let newPlace = Place(context: viewContext)
        newPlace.id = UUID()
        newPlace.name = placeName
        newPlace.longitude = 0
        newPlace.latitude = 0
        newPlace.budget = Double(placeBudget)
        
        
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
