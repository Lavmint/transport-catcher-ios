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
    
    func fetchStops(completion: @escaping (Error?) -> Void) {
        
        let userStorage = UserStorage(context: TransportCatcherPersistenseContainer.shared.newBackgroundContext())
        let transportStopStorage = TransportStopStorage(context: ClassifierPersistenseContainer.shared.newBackgroundContext())
        let user: User! = userStorage.standard
        let storedStops = transportStopStorage.all
        let timeNow = Date()
        guard storedStops.isEmpty
            || !user.transportStopTimestamp.isBetween(i1: Date.dateAWeekAgo.timeIntervalSince1970, i2: timeNow.timeIntervalSince1970) else {
            completion(nil)
            return
        }
        
        Service.shared.stops { (box) in
            
            var callbackError: Error? = nil
            defer {
                completion(callbackError)
            }
            
            switch box.result {
            case .success(let result):
                let remoteStops = result ?? []
                var localStops: [TransportStop] = []
                var updatedOrCreatedStops: [Int32] = []
                for rstop in remoteStops {
                    let id = Int32(rstop.id)
                    let angel = rstop.angle == nil ? nil : Int32(rstop.angle!)
                    let lstop = transportStopStorage.findOrCreate(key: id)
                    lstop.id = Int32(rstop.id)
                    lstop.adjacentStreet = rstop.adjacentStreet
                    lstop.adjacentStreetEn = rstop.adjacentStreetEn
                    lstop.angle = angel ?? 0
                    lstop.busesCommercial = rstop.busesCommercial
                    lstop.busesMunicipal = rstop.busesMunicipal
                    lstop.busesPrigorod = rstop.busesMunicipal
                    lstop.busesSeason = rstop.busesSeason
                    lstop.busesSpecial = rstop.busesSpecial
                    lstop.cluster = rstop.cluster
                    lstop.direction = rstop.direction
                    lstop.directionEn = rstop.directionEn
                    lstop.latitude = rstop.latitude
                    lstop.longitude = rstop.longitude
                    lstop.metros = rstop.metros
                    lstop.name = rstop.name
                    lstop.nameEn = rstop.nameEn
                    lstop.tramways = rstop.tramways
                    lstop.trolleybuses = rstop.trolleybuses
                    updatedOrCreatedStops.append(id)
                    localStops.append(lstop)
                }
                transportStopStorage.delete(excludeIds: updatedOrCreatedStops)
                transportStopStorage.save()
                user.transportStopTimestamp = timeNow.timeIntervalSince1970
                userStorage.save()
            case .failure(let error):
                callbackError = error
            }
        }
    }
}
