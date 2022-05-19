//
//  Place+CoreDataProperties.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 17/05/22.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var budget: Double
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var traveling: Traveling?
    
    public var unwrappedName: String {
        name ?? "Local Desconhecido"
    }
    
    public var unwrappedBudget: Double {
        budget 
    }

}

extension Place : Identifiable {

}
