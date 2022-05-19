//
//  AddTravelingsView.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 17/05/22.
//

import SwiftUI



struct AddTravelingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var travelName: String = ""
    @State private var type: String = ""
    @State private var budget = 0
    @State private var selectedType = 0
    @State private var showingAlert = false
    
    let travelTypes = ["Casual", "Leisure", "Work", "Event", "Academic"]
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Traveling.name, ascending: true)]) private var travelings: FetchedResults<Traveling>
    
    
    private var numberFormatter: NumberFormatter
    
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
        self.numberFormatter = numberFormatter
        self.numberFormatter.usesGroupingSeparator = true
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.locale = Locale.current
        self.numberFormatter.maximumFractionDigits = 2
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    HStack {
                        TextField("Type the traveling`s name", text: $travelName)
                    }
                }
                
                Section {
                    HStack {
                        Text("Traveling kind")
                        Spacer()
                        Picker(selection: $selectedType, label: Text("Tipo da Viagem")) {
                            ForEach(0..<travelTypes.count) {
                                Text(self.travelTypes[$0])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        
                    }
                    .padding(.trailing, 20)
                }
                
                HStack {
                    Text("Budget")
                    Text("R$: ")
                
                    TextField("Valor", value: $budget, format: .number)
                    
                    
                }
                
                
                
            }
            .navigationTitle("Add a traveling")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveTravel()
                        
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
    
    
    private func saveTravel() {
        
        if travelName.isEmpty || budget == 0 {
            return showingAlert = true
        }
        let newTravel = Traveling(context: viewContext)
        newTravel.id = UUID()
        newTravel.name = travelName
        newTravel.budget = Double(budget)
        newTravel.type = Int16(selectedType)
        print(selectedType)
        
        do {
            try viewContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
        }
        dismiss()
        
    }
}


struct AddTravelingView_Previews: PreviewProvider {
    static var previews: some View {
        AddTravelingView()
    }
}


