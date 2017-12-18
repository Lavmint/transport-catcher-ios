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
        presenter.delegate = self
        genericView.timeoutSecondsLabel.text = presenter.timeoutInterval
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch cell {
        case genericView.timeoutCell: onTimeoutCellTapped()
        default: break
        }
    }
    
    private func onTimeoutCellTapped() {
        let timeoutIntervalAlert = presenter.createTimeoutIntervalAlert()
        self.present(timeoutIntervalAlert, animated: true, completion: nil)
    }
}

extension SettingsViewController: SettingsPresenterDelegate {
    
    func didChangeTimeout(presenter: SettingsPresenter) {
        genericView.timeoutSecondsLabel.text = presenter.timeoutInterval
    }
}
