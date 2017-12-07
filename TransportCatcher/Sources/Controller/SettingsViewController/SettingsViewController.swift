//
//  SettingsViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 07/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, GenericView {

    typealias View = SettingsView
    private(set) var presenter: SettingsPresenter!
    private(set) var interactor: SettingsInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interactor = SettingsInteractor()
        presenter = SettingsPresenter(interactor: interactor)
        genericView.timeoutCell.detailTextLabel?.text = presenter.timeoutInterval
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch cell {
        case genericView.timeoutCell: onTimeoutCellTapped()
        default: break
        }
    }
    
    private func onTimeoutCellTapped() {
        let timeoutIntervalAlert = presenter.createTimeoutIntervalAlert(timeoutIntervalChangedHandler: (self, #selector(onTimeoutChanged(_:))))
        self.present(timeoutIntervalAlert, animated: true, completion: nil)
    }
    
    @objc private func onTimeoutChanged(_ timeoutValueTextField: UITextField) {
        genericView.timeoutSecondsLabel.text = timeoutValueTextField.text
        presenter.timeoutInterval = timeoutValueTextField.text
    }
}
