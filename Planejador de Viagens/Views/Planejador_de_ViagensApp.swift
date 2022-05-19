//
//  Planejador_de_ViagensApp.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 13/05/22.
//

import SwiftUI

@main
struct Planejador_de_ViagensApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
