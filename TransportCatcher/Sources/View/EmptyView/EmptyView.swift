//
//  EmptyView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 04/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class EmptyView: UIView, NibLoadableView {
    
    @IBOutlet var infoLabel: UILabel!
    
    static func create(configure: (EmptyView) -> Void) -> EmptyView {
        let view: EmptyView! = EmptyView.loadFromNib()
        view.backgroundColor = UIColor.Application.background
        configure(view)
        return view
    }
}
