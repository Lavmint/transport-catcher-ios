//
//  NSLayoutConstraint.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 04/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    static func dock(view: UIView, in container: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        let constraints: [NSLayoutConstraint] = [
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
