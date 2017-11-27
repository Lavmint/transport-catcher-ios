//
//  ArrivalTableViewCell.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

class ArrivalTableViewCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var routeLabel: UILabel!
    @IBOutlet var vehicleInfoLabel: UILabel!
    @IBOutlet var trackingLabel: UILabel!
    @IBOutlet var invalidInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(arrival: Arrival) {
        timeLabel.attributedText = getTimeLabelAttributedText(time: arrival.time)
        timeLabel.backgroundColor = getTimeLabelBackgroundColor(vehicle: arrival.type)
        routeLabel.text = arrival.route
        vehicleInfoLabel.text = [arrival.type.rawValue, arrival.model ?? ""].joined(separator: " ")
        trackingLabel.text = [String(arrival.remainingLength), LocalizedString.Arrival.metersLeftToStop, arrival.nextStopName].joined(separator: " ")
        invalidInfoLabel.text = arrival.isInvalidFriendly ? LocalizedString.Arrival.invalidFriendly : nil
    }
    
    private func getTimeLabelAttributedText(time: Int) -> NSAttributedString {
        
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
    
    private func getTimeLabelBackgroundColor(vehicle: TransportType) -> UIColor {
        switch vehicle {
        case .bus:
            return UIColor.ArrivalCell.busVehicle
        case .tramway:
            return UIColor.ArrivalCell.tramwayVehicle
        case .trolleybus:
            return UIColor.ArrivalCell.trolleybusVehicle
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
