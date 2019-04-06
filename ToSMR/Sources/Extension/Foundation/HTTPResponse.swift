//
//  HTTPResponse.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

internal extension HTTPURLResponse {
    
    var error: (code: Int, message: String)? {
        let code = self.statusCode
        let message = HTTPURLResponse.localizedString(forStatusCode: self.statusCode)
        return (code, message)
    }
    
}
