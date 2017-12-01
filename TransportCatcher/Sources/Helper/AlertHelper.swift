//
//  AlertPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 01/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class AlertHelper {
    
    enum InfoAlert {
        case OK
    }
    
    static func presentInfoAlert(_ alertType: InfoAlert, message: String, on controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionTitle: String!
        switch alertType {
        case .OK:
            actionTitle = LocalizedString.Alert.OK
        }
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
}
