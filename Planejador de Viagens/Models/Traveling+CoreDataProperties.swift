//
//  Traveling+CoreDataProperties.swift
//  Planejador de Viagens
//
//  Created by Joan Wilson Oliveira on 17/05/22.
//
//

import Foundation
import CoreData


extension Traveling {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Traveling> {
        return NSFetchRequest<Traveling>(entityName: "Traveling")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var budget: Double
    @NSManaged public var type: Int16
    @NSManaged public var places: NSSet?
    
    public var unwrappedName: String {
        name ?? "Viagem Desconhecida"
    }
    
    public var placesArray: [Place] {
        let placeSet = places as? Set<Place> ?? []
        
        return placeSet.sorted {
            $0.id < $1.id
        }
    }
    
    
    
}

// MARK: Generated accessors for places
extension Traveling {
    
    @objc(addPlacesObject:)
    @NSManaged public func addToPlaces(_ value: Place)
    
    @objc(removePlacesObject:)
    @NSManaged public func removeFromPlaces(_ value: Place)
    
    @objc(addPlaces:)
    @NSManaged public func addToPlaces(_ values: NSSet)
    
    @objc(removePlaces:)
    @NSManaged public func removeFromPlaces(_ values: NSSet)
    
}

extension Traveling : Identifiable {
    
}
