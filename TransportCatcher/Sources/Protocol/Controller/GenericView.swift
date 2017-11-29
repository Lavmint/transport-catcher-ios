//
//  GenericViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

protocol GenericView {
    associatedtype View: UIView
}

extension GenericView where Self: UIViewController {
    
    var genericView: View! {
        return self.view as? View
    }
}
