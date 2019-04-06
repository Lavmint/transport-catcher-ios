//
//  DGSTile.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class DGSTileStorage: Storage {
    
    typealias PrimaryKey = String
    typealias Object = DGSTile
    var primaryKeyName: String {
        return "url"
    }
    
    let context: NSManagedObjectContext
    private(set) var temporaryStorage: [String: Data]
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.temporaryStorage = [:]
    }
    
    func setTemporaryData(for url: NSURL, data: NSData) {
        dprint([#function, url.absoluteString!].joined(separator: " "))
        temporaryStorage[url.absoluteString!] = data as Data
        guard temporaryStorage.count >= 10 else { return }
        saveChanges()
    }
    
    private func saveChanges() {
        dprint(#function)
        let rawURLs: [String] = temporaryStorage.keys.map({ $0 })
        let request: NSFetchRequest<DGSTile> = DGSTile.fetchRequest()
        request.predicate = NSPredicate(format: "url IN %@", rawURLs)
        var fetchedTiles: [DGSTile] = []
        do {
            fetchedTiles = try context.fetch(request)
        } catch {
            dprint(error)
            assertionFailure()
        }
        
        //updating existing tiles
        for (url, data) in temporaryStorage {
            for tile in fetchedTiles {
                guard url == tile.url else { continue }
                tile.data = data
                tile.timestamp = Date().timeIntervalSince1970
                temporaryStorage.removeValue(forKey: url)
            }
        }
        
        //creating new tiles
        for (url, data) in temporaryStorage {
            let tile = DGSTile(context: context)
            tile.url = url
            tile.data = data
            tile.timestamp = Date().timeIntervalSince1970
            temporaryStorage.removeValue(forKey: url)
        }
        
        do {
            guard context.hasChanges else { return }
            try context.save()
        }
        catch {
            dprint(error)
            assertionFailure()
            return
        }
    }
}
