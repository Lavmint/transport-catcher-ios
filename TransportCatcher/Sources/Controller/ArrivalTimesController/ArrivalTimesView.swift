//
//  ArrivalTimesView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalTimesView: UIView {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyViewContainer: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.Application.background
    }
    
    func configure() {
        tableView.register(UINib.init(nibName: ArrivalTableViewCell.stringClass, bundle: nil), forCellReuseIdentifier: ArrivalTableViewCell.stringClass)
    }
    
    func setEmptyView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        emptyViewContainer.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        NSLayoutConstraint.dock(view: view, in: emptyViewContainer)
    }
    
    func setEmptyViewHidden(isHidden: Bool) {
        tableView.isHidden = !isHidden
        emptyViewContainer.isHidden = isHidden
    }
    
    func reload() {
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.contentOffset = CGPoint.zero
    }
}
