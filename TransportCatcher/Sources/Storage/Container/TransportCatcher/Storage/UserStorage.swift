//
//  UserStorage.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 03/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class UserStorage: Storage {
    typealias PrimaryKey = Int
    typealias Object = User
    let context: NSManagedObjectContext
    private(set) var standard: User!
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.standard = {
            if let user = find(key: 0) {
                return user
            } else {
                let user = User(context: context)
                user.id = 0
                save()
                return user
            }
        }()
    }
}
