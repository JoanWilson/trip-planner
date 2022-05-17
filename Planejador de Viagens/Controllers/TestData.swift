//
//  TestData.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 15/05/22.
//

import SwiftUI

struct TestData: View {
    private var items: [Result] = Result.allItems
    
    var body: some View {
        List {
            ForEach(items, id: \.data) { a in
                Text(a)
            }
        }
    }
}

struct TestData_Previews: PreviewProvider {
    static var previews: some View {
        TestData()
    }
}
