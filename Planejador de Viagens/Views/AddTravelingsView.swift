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
    @State private var budget: String = ""
    @State private var selectedType = 0
    @State private var showingAlert = false
    
    let travelTypes = ["Casual", "Leisure", "Work", "Event", "Academic"]
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Traveling.name, ascending: true)]) private var travelings: FetchedResults<Traveling>
    
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
        self.numberFormatter.usesGroupingSeparator = true
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.locale = Locale.current
        self.numberFormatter.maximumFractionDigits = 2
    }
    
    
    
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    HStack {
                        TextField("Type the traveling's name", text: $travelName)
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Picker(selection: $selectedType, label: Text("Traveling kind")) {
                            ForEach(0..<travelTypes.count) {
                                Text(self.travelTypes[$0])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        
                    }
                    .padding(.trailing, 20)
                }
                
                Section {
                    HStack {
                        Text("Budget")
                        Text("$: ")
                        
                        TextField("Value", text: $budget)
                            .keyboardType(.decimalPad)
                    }
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
        
        guard let budgetValue = Double(budget) else {
            return
        }
        
        if travelName.isEmpty || budgetValue == 0 {
            return showingAlert = true
        }
        
        let newTravel = Traveling(context: viewContext)
        newTravel.id = UUID()
        newTravel.name = travelName
        newTravel.budget = budgetValue
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


