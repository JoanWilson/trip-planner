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
    @State private var budget: Double = 0.0
    @State private var selectedType = 0
    @State private var showingAlert = false
    
    let travelTypes = ["Casual", "Lazer", "Trabalho", "Evento", "Academico"]
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Traveling.name, ascending: true)]) private var travelings: FetchedResults<Traveling>
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Digite o nome da viagem", text: $travelName)
                    }

                    HStack {
                        Text("Tipo da viagem")
                        Spacer()
                        Picker("Tipo da viagem",
                            selection: $selectedType) {
                            ForEach(travelTypes, id: \.self) { type in
                                    Text(type)
                                }
                            }.pickerStyle(MenuPickerStyle()
                        )

                    }
                    .padding(.trailing, 20)
                    
                    TextField("Qual o seu orçamento?", value: $budget, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Informações sobre sua viagem")
                }
                
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
        newTravel.budget = budget
        newTravel.type = Int16(selectedType)
        
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


