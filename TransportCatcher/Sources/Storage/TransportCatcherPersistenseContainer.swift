//
//  TransportCatcherPersistenseContainer.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class TransportCatcherPersistenseContainer: NSPersistentContainer {
    
    static let shared: TransportCatcherPersistenseContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it.
         */
        let container = TransportCatcherPersistenseContainer(name: "TransportCatcher")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}



