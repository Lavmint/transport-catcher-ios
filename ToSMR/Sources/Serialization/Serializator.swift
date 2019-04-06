//
//  Serializator.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

public protocol Serializer {
    func data<T>(from object: T?) -> Data?
    func object<T>(from data: Data?) -> T?
}
