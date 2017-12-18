//
//  String.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 18/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

extension String {
    
    var firstCapitalized: String {
        guard let f = self.first else { return "" }
        let firstUppercased: String = String(f).uppercased()
        let untochedTail: String = String(self.dropFirst())
        return firstUppercased + untochedTail
    }
}
