//
//  UIViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 18/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func present(error err: Error?) {
        guard let error = err  else { return }
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: LocalizedString.Alert.OK, style: UIAlertActionStyle.default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
