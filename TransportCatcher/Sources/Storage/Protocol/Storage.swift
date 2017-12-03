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
    var context: NSManagedObjectContext { get }
}

extension Storage {
    
    var primaryKeyName: String {
        return "id"
    }
    
    func find(key: PrimaryKey) -> Object? {
        let request: NSFetchRequest<NSFetchRequestResult> = Object.fetchRequest()
        if key is Int32 || key is Int {
            request.predicate = NSPredicate(format: "\(primaryKeyName) = %d", key)
        } else {
            request.predicate = NSPredicate(format: "\(primaryKeyName) = %@", key)
        }
        var results: [Object] = []
        do {
            results = try context.fetch(request) as! [Object]
        } catch {
            dprint(error)
            assertionFailure()
            return nil
        }
        guard results.count <= 1 else { assertionFailure(); return nil }
        dprint("returning \(Object.self): \(String(describing: key))")
        return results.first
    }
    
    func findOrCreate(key: PrimaryKey) -> Object {
        return find(key: key) ?? Object(context: context)
    }
    
    var all: [Object] {
        let request: NSFetchRequest<NSFetchRequestResult> = Object.fetchRequest()
        var results: [Object] = []
        do {
            results = try context.fetch(request) as! [Object]
        } catch {
            dprint(error)
            assertionFailure()
            return []
        }
        dprint("returning \(results.count) object of type \(Object.self)")
        return results
    }
    
    func delete(excludeIds: [PrimaryKey]) {
        let request: NSFetchRequest<NSFetchRequestResult> = Object.fetchRequest()
        request.predicate = NSPredicate(format: "NOT (\(primaryKeyName) IN %@)", excludeIds)
        let batch = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(batch)
        } catch {
            dprint(error)
            assertionFailure()
        }
        if isDebug {
            do {
                let deletes = try context.fetch(request) as! [Object]
                dprint("Deleted objects: \(deletes)")
            } catch { }
        }
        
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            dprint(error)
            assertionFailure()
        }
    }
}
