//
//  JSONManager.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 15/05/22.
//

import Foundation

struct Result: Codable {
    var data: [ResultItem]
    
    static let allItems: [Result] = Bundle.main.decode(file: "data.json")
    static let sampleItem: Result = allItems[0]
}

struct ResultItem: Codable {
    var title: String
    var items: [String]
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project")
        }
        
        return loadedData
    }
}
