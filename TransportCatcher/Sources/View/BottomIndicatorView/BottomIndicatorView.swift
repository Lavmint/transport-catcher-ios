//
//  BottomIndicatorView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 04/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

protocol BottomIndicatorViewDelegate: class {
    func bottomIndicatorView(bottomIndicatorView: BottomIndicatorView, didRemovedFromSuperView: Bool)
}

class BottomIndicatorView: UIView, NibLoadableView {

    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    weak var delegate: BottomIndicatorViewDelegate?
}
