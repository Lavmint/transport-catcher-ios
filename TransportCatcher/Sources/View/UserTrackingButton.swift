//
//  RequestLocationButton.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 28/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class UserTrackingButton: UIButton {
 
    override open var isHighlighted: Bool {
        didSet {
            isHighlighted ? onStateChanged(state: .highlighted) : onStateChanged(state: .normal)
        }
    }
    
    func onStateChanged(state: UIControl.State) {
        switch state {
        case .highlighted:
            self.setImage(#imageLiteral(resourceName: "ic_location_pointer_highlighted"), for: .highlighted)
            self.layer.shadowRadius = 2.0
            self.layer.shadowColor = UIColor.gray.cgColor
        case .normal:
            self.setImage(#imageLiteral(resourceName: "ic_location_pointer"), for: .normal)
            self.layer.shadowRadius = 3.0
            self.layer.shadowColor = UIColor.black.cgColor
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        initialize()
    }
    
    func initialize() {
        self.layer.cornerRadius = 18
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        onStateChanged(state: .normal)
    }
}
