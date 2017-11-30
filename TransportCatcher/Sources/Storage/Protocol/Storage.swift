//
//  Storage.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

protocol Storage {
    associatedtype PrimaryKey: CVarArg
    associatedtype Object: NSManagedObject
    var primaryKeyName: String { get }
}

extension Storage {
    
    func find(key: PrimaryKey, context: NSManagedObjectContext) -> Object? {
        let request: NSFetchRequest<NSFetchRequestResult> = Object.fetchRequest()
        request.predicate = NSPredicate(format: "\(primaryKeyName) = %@", key)
        var results: [Object] = []
        do {
            results = try context.fetch(request) as! [Object]
        } catch {
            dprint(error)
            assertionFailure()
            return nil
        }
        guard results.count <= 1 else { assertionFailure(); return nil }
        dprint(["returning \(Object.self):", String(describing: key)].joined(separator: " "))
        return results.first
    }
}
