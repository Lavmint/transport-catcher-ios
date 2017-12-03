//
//  TransportStopStorage.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class TransportStopStorage: Storage {

    typealias PrimaryKey = Int32
    typealias Object = TransportStop
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
