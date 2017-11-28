//
//  UIAlertController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func singleActionAlert(aTitle: String?, aCompletion:(() -> Void)? = nil, message: String? = nil, title: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: aTitle, style: UIAlertActionStyle.default) { (_) in
            alert.dismiss(animated: true, completion: aCompletion)
        }
        alert.addAction(action)
        return alert
    }
}
