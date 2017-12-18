//
//  ArrivalTimesViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

protocol ArrivalTimesViewControllerDelegate: class {
    func willFetchArrivals(arrivalTimesViewController: ArrivalTimesViewController, for stopId: Int)
    func didFetchArrivals(arrivalTimesViewController: ArrivalTimesViewController, for stopId: Int)
}

class ArrivalTimesViewController: UIViewController, GenericView {

    typealias View = ArrivalTimesView
    private(set) var intercator: ArrivalTimesInteractor!
    private(set) var presenter: ArrivalTimesPresenter!
    private(set) var emptyViewController: EmptyViewController!
    weak var delegate: ArrivalTimesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intercator = ArrivalTimesInteractor()
        self.presenter = ArrivalTimesPresenter(interactor: intercator)
        self.emptyViewController = EmptyViewController()
        genericView.setEmptyView(view: emptyViewController.view)
        presenter.configure(controller: emptyViewController, on: genericView, with: nil, isInitial: true)
        self.genericView.configure()
        self.genericView.tableView.dataSource = self
    }
    
    func reload(withStopId stopId: Int) {
        delegate?.willFetchArrivals(arrivalTimesViewController: self, for: stopId)
        intercator.fetchArrivals(toStopId: stopId) { (error) in
            self.present(error: error)
            self.presenter.configure(controller: self.emptyViewController, on: self.genericView, with: error)
            self.genericView.reload()
            self.delegate?.didFetchArrivals(arrivalTimesViewController: self, for: stopId)
        }
    }
}

extension ArrivalTimesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArrivalTableViewCell.stringClass, for: indexPath) as! ArrivalTableViewCell
        guard indexPath.row < intercator.arrivals.count else { return cell }
        let arrival = intercator.arrivals[indexPath.row]
        cell.timeLabel.attributedText = presenter.timeAttributedString(for: arrival)
        cell.timeLabel.backgroundColor = presenter.timeBackgroundColor(for: arrival)
        cell.routeLabel.text = presenter.route(for: arrival)
        cell.vehicleInfoLabel.text = presenter.vehicleInfo(for: arrival)
        cell.trackingLabel.text = presenter.remainingLength(for: arrival)
        cell.invalidInfoLabel.text = presenter.invalidInfo(for: arrival)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return intercator.arrivals.count < 1 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intercator.arrivals.count
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
