//
//  DGSTile.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class DGSTileInteractor {
    
    let managedObjectContext: NSManagedObjectContext
    let operationQueue: OperationQueue
    
    init(managedObjectContext: NSManagedObjectContext = TransportCatcherPersistenseContainer.shared.viewContext) {
        self.managedObjectContext = managedObjectContext
        self.operationQueue = OperationQueue()
        self.operationQueue.qualityOfService = .userInteractive
    }
    
    func getTile(for url: NSURL, completion: @escaping (DGSTile?) -> Void) throws {
        
        var calloutTile: DGSTile?
        defer {
            OperationQueue.main.addOperation {
                completion(calloutTile)
            }
        }
        
        let request: NSFetchRequest<DGSTile> = DGSTile.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", url.absoluteString!)
        let results = try managedObjectContext.fetch(request)
        guard results.count <= 1 else { assertionFailure(); return }
        calloutTile = results.first
    }
    
    func getData(for url: NSURL, completion: @escaping (NSData?) -> Void) throws {
    
        try getTile(for: url, completion: { (tile) in
            
            var calloutData: NSData?
            defer {
                if calloutData != nil { dprint([#function, url.absoluteString!].joined(separator: " ")) }
                completion(calloutData)
            }
            
            guard let data = tile?.data else { return }
            calloutData = data as NSData
        })
    }
    
    func getOrCreateTile(for url: NSURL, completion: @escaping (DGSTile) -> Void) throws {
        var calloutTile: DGSTile!
        let context = self.managedObjectContext
        try getTile(for: url, completion: { (tile) in
            calloutTile = tile ?? DGSTile(context: context)
            calloutTile.url = url.absoluteString
            calloutTile.timestamp = Date().timeIntervalSince1970
            completion(calloutTile)
        })
    }
    
    func setData(for url: NSURL, data: NSData, completion: (() -> Void)? = nil) throws {
        try getOrCreateTile(for: url) { (tile) in
            dprint([#function, url.absoluteString!].joined(separator: " "))
            tile.data = data as Data
            completion?()
        }
    }
}
