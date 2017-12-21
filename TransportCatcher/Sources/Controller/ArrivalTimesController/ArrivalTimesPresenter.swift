//
//  ArrivalTimesPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

class ArrivalTimesPresenter {
    
    private(set) var interactor: ArrivalTimesInteractor
    private(set) var emptyView: EmptyView?
    
    init(interactor: ArrivalTimesInteractor) {
        self.interactor = interactor
    }
    
    // MARK: ArrivalTableViewCell
    
    func timeAttributedString(for arrival: Arrival) -> NSAttributedString {
        
        let time = arrival.time
        
        let timeAS = NSAttributedString(
            string: String(time) + "\n",
            attributes: [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)
            ]
        )
        
        let minutesAS = NSAttributedString(
            string: LocalizedString.Arrival.minutesShort,
            attributes: [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)
            ]
        )
        
        let result = NSMutableAttributedString()
        result.append(timeAS)
        result.append(minutesAS)
        return result.attributedSubstring(from: NSRange.init(location: 0, length: result.length))
    }
    
    func timeBackgroundColor(for arrival: Arrival) -> UIColor {
        switch arrival.type {
        case .bus:
            return UIColor.ArrivalCell.busVehicle
        case .tramway:
            return UIColor.ArrivalCell.tramwayVehicle
        case .trolleybus:
            return UIColor.ArrivalCell.trolleybusVehicle
        }
    }
    
    func route(for arrival: Arrival) -> String {
        return arrival.route
    }
    
    func vehicleInfo(for arrival: Arrival) -> String {
        return [arrival.localizedType.firstCapitalized, arrival.model ?? "", arrival.stateNumber].joined(separator: " ")
    }
    
    func remainingLength(for arrival: Arrival) -> String {
        return [String(arrival.remainingLength), LocalizedString.Arrival.metersLeftToStop, arrival.nextStopName].joined(separator: " ")
    }
    
    func invalidInfo(for arrival: Arrival) -> String? {
        return arrival.isInvalidFriendly ? LocalizedString.Arrival.invalidFriendly : nil
    }
    
    func configure(arrivalCell: ArrivalTableViewCell, for arrival: Arrival) {
        arrivalCell.timeLabel.attributedText = timeAttributedString(for: arrival)
        arrivalCell.timeLabel.backgroundColor = timeBackgroundColor(for: arrival)
        arrivalCell.routeLabel.text = route(for: arrival)
        arrivalCell.vehicleInfoLabel.text = vehicleInfo(for: arrival)
        arrivalCell.trackingLabel.text = remainingLength(for: arrival)
        arrivalCell.invalidInfoLabel.text = invalidInfo(for: arrival)
    }
    
    func presentEmptyViewIfNeeded(on view: ArrivalTimesView, with error: Error?, isInitial: Bool = false) {
        
        _ = EmptyView.create(configure: { (emptyView) in
            
            if isInitial {
                emptyView.infoLabel.text = LocalizedString.Arrival.selectStop
                view.presentOverlayView(view: emptyView)
                return
            }
            
            if let err = error {
                emptyView.infoLabel.text = err.localizedDescription
                view.presentOverlayView(view: emptyView)
                return
            }
            
            if interactor.arrivals.isEmpty {
                emptyView.infoLabel.text = LocalizedString.Arrival.emptyList
                view.presentOverlayView(view: emptyView)
                return
            }
            
            view.presentOverlayView(view: nil)
        })
    }
}
