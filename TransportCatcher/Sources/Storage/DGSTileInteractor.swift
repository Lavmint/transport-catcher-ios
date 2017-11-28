//
//  DGSTile.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class DGSTileInteractor {
    
    let backgroundContext: NSManagedObjectContext
    private(set) var temporaryStorage: [String: Data]
    
    init() {
        self.backgroundContext = TransportCatcherPersistenseContainer.shared.newBackgroundContext()
        self.temporaryStorage = [:]
    }
    
    func findTile(for url: NSURL) -> DGSTile? {
        let request: NSFetchRequest<DGSTile> = DGSTile.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "url = %@", url.absoluteString!)
        var results: [DGSTile] = []
        do {
            results = try backgroundContext.fetch(request)
        } catch {
            dprint(error)
            assertionFailure()
            return nil
        }
        guard results.count <= 1 else { assertionFailure(); return nil }
        dprint(["returning tile:", url.absoluteString!].joined(separator: " "))
        return results.first
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
            fetchedTiles = try backgroundContext.fetch(request)
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
            let tile = DGSTile(context: backgroundContext)
            tile.url = url
            tile.data = data
            tile.timestamp = Date().timeIntervalSince1970
            temporaryStorage.removeValue(forKey: url)
        }
        
        do {
            guard backgroundContext.hasChanges else { return }
            try backgroundContext.save()
        }
        catch {
            dprint(error)
            assertionFailure()
            return
        }
    }
}
