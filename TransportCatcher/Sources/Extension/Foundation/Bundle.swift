//
//  Bundle.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 03/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

extension Bundle {
    
    var appInfoDictionary: [String: Any]? {
        let dict = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "TransportCatcher-Info", ofType: "plist")!) as? [String: Any]
        return dict
    }
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var copyright: String? {
        return localizedInfoDictionary?["NSHumanReadableCopyright"] as? String
    }
}
