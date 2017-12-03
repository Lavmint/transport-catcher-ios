//
//  ClassifierFetcher.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 03/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation
import ToSMR

class ClassifierFetcher {
    
    func fetchStops(completion: @escaping (() throws -> Void) -> Void) {
        
        let userStorage = UserStorage(context: TransportCatcherPersistenseContainer.shared.newBackgroundContext())
        let transportStopStorage = TransportStopStorage(context: ClassifierPersistenseContainer.shared.newBackgroundContext())
        let user = userStorage.standard
        let storedStops = transportStopStorage.all
        let timeNow = Date()
        guard storedStops.isEmpty
            || !user.transportStopTimestamp.isBetween(i1: Date.dateAWeekAgo.timeIntervalSince1970, i2: timeNow.timeIntervalSince1970) else {
            completion { return }
            return
        }
        
        Service.shared.stops { (box) in
            switch box.result {
            case .succeed(let result):
                let remoteStops = result ?? []
                var localStops: [TransportStop] = []
                var updatedOrCreatedStops: [Int32] = []
                for rstop in remoteStops {
                    let id = Int32(rstop.id)
                    let angel = rstop.angle == nil ? nil : Int32(rstop.angle!)
                    let lstop = transportStopStorage.findOrCreate(key: id)
                    lstop.id = Int32(rstop.id)
                    lstop.adjacentStreet = rstop.adjacentStreet
                    lstop.angle = angel ?? 0
                    lstop.busesCommercial = rstop.busesCommercial
                    lstop.busesMunicipal = rstop.busesMunicipal
                    lstop.busesPrigorod = rstop.busesMunicipal
                    lstop.busesSeason = rstop.busesSeason
                    lstop.busesSpecial = rstop.busesSpecial
                    lstop.cluster = rstop.cluster
                    lstop.direction = rstop.direction
                    lstop.latitude = rstop.latitude
                    lstop.longitude = rstop.longitude
                    lstop.metros = rstop.metros
                    lstop.name = rstop.name
                    lstop.tramways = rstop.tramways
                    lstop.trolleybuses = rstop.trolleybuses
                    updatedOrCreatedStops.append(id)
                    localStops.append(lstop)
                }
                transportStopStorage.delete(excludeIds: updatedOrCreatedStops)
                transportStopStorage.save()
                user.transportStopTimestamp = timeNow.timeIntervalSince1970
                userStorage.save()
                completion { return }
            case .error(let error):
                completion { throw error }
            }
        }
    }
}
