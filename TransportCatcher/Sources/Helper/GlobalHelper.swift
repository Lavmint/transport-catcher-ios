//
//  Global.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

var isDebug: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
}

func dprint(_ items: Any...) {
    guard isDebug else { return }
    print(items)
}
