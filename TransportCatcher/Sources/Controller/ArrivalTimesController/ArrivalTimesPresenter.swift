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
            string: LocalizedString.Arrival.minutes(minutes: time),
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
        return [arrival.type.rawValue, arrival.model ?? ""].joined(separator: " ")
    }
    
    func remainingLength(for arrival: Arrival) -> String {
        return [String(arrival.remainingLength), LocalizedString.Arrival.metersLeftToStop, arrival.nextStopName].joined(separator: " ")
    }
    
    func invalidInfo(for arrival: Arrival) -> String? {
        return arrival.isInvalidFriendly ? LocalizedString.Arrival.invalidFriendly : nil
    }
}
