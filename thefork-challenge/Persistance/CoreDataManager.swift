//
//  CoreDataManager.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "thefork-coredatamodel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
}
