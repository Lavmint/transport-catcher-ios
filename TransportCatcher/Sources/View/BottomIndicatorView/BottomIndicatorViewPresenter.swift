//
//  BottomIndicatorViewPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 04/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class BottomIndicatorViewPresenter {
    
    private(set) var indicator: BottomIndicatorView
    
    static let shared: BottomIndicatorViewPresenter = {
        return BottomIndicatorViewPresenter()
    }()
    
    init() {
        indicator = BottomIndicatorView.loadFromNib()
        indicator.delegate = self
        indicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func showIndicator(withText indicatorText: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        window.isUserInteractionEnabled = false
        window.addSubview(indicator)
        indicator.frame = CGRect(x: 0, y: window.frame.height - 30, width: window.frame.width, height: 30)
        window.bringSubview(toFront: indicator)
        indicator.infoLabel.text = indicatorText
        indicator.activityIndicatorView.startAnimating()
        
        window.layoutIfNeeded()
        UIView.animate(withDuration: 8, delay: 0, options: .transitionFlipFromLeft, animations: { [weak self] in
            guard let wself = self else { return }
            let constraints: [NSLayoutConstraint] = [
                wself.indicator.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                wself.indicator.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                wself.indicator.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            window.setNeedsLayout()
            window.layoutIfNeeded()
        })
    }
    
    func hideIndicator() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.isUserInteractionEnabled = true
        window.layoutIfNeeded()
        UIView.animate(withDuration: 8, delay: 0, options: .transitionCurlUp, animations: { [weak self] in
            guard let wself = self else { return }
            wself.indicator.activityIndicatorView.stopAnimating()
            wself.indicator.removeFromSuperview()
            window.setNeedsLayout()
            window.layoutIfNeeded()
        })
    }
}

extension BottomIndicatorViewPresenter: BottomIndicatorViewDelegate {
    
    func bottomIndicatorView(bottomIndicatorView: BottomIndicatorView, didRemovedFromSuperView: Bool) {
        hideIndicator()
    }
}
