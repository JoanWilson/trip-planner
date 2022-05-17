//
//  ContentView.swift
//  RoadTrip
//
//  Created by Joan Wilson Oliveira on 11/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MyTravelingsView()
                .tabItem {
                    Label("Tours", systemImage: "airplane")
                }
            Text("test")
                .tabItem {
                    Label("Mapa", systemImage: "map")
                }
            Text("Home")
                .tabItem {
                    Label("Utilitários", systemImage: "link")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
