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
    
    let travelTypes = ["Casual", "Lazer", "Trabalho", "Evento", "Academico"]
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
                        TextField("Digite o nome da viagem", text: $travelName)
                    }
                } header: {
                    Text("Nome da Viagem")
                }
                
                Section {
                    HStack {
                        Text("Qual o tipo da Viagem?")
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
                    Text("Orçamento: ")
                    Spacer()
                    CurrencyTextField(numberFormatter: numberFormatter, value: $budget)
                    
                }
                
                Text("Seu tipo de viagem é: \(self.travelTypes[selectedType])")
                
            }
            .navigationTitle("Adicionar Viagem")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveTravel()
                        
                    } label: {
                        Text("Salvar")
                    }
                    .alert("O nome da viagem não pode ser vazio!", isPresented: $showingAlert) {
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
    
    
    private func saveTravel() {
        
        if travelName.isEmpty {
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


