//
//  CurrencyTextField.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 18/05/22.
//

import Foundation
import SwiftUI

struct CurrencyTextField: UIViewRepresentable {
    
    typealias UIViewType = CurrencyUITextField
    
    let numberFormatter: NumberFormatter
    let currencyField: CurrencyUITextField
    
    init(numberFormatter: NumberFormatter, value: Binding<Int>) {
        self.numberFormatter = numberFormatter
        currencyField = CurrencyUITextField(formatter: numberFormatter, value: value)
        
    }
    
    func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }
    
    
    func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}
