//
//  SettingsPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 07/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

protocol SettingsPresenterDelegate: class {
    func didChangeTimeout(presenter: SettingsPresenter)
}

class SettingsPresenter {
    
    let interactor: SettingsInteractor
    weak var delegate: SettingsPresenterDelegate?
    
    let timeoutIntervalFormatter: NumberFormatter
    private var timeoutPickerWrapper: PlainPickerWrapperView!
    private var timeoutValueTextField: UITextField?
    
    init(interactor: SettingsInteractor)  {
        self.interactor = interactor
        timeoutIntervalFormatter = NumberFormatter()
        timeoutIntervalFormatter.maximumFractionDigits = 0
        timeoutIntervalFormatter.minimumFractionDigits = 0
    }
    
    var timeoutInterval: String? {
        get {
            return timeoutIntervalFormatter.string(from: NSNumber(value: self.interactor.timeoutInterval))
        }
        set {
            guard let rawValue = newValue, let value = Double(rawValue) else { return }
            interactor.timeoutInterval = value
        }
    }
    
    func createTimeoutIntervalAlert() -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: LocalizedString.Settings.setTimeoutInterval, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizedString.Alert.OK, style: .default) { (_) in
            self.interactor.userStorage.save()
            self.delegate?.didChangeTimeout(presenter: self)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: LocalizedString.Alert.Cancel, style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: {
                self.interactor.userStorage.context.undo()
            })
        }
        alert.addAction(cancelAction)
        
        alert.addTextField { (timeoutValueTextField) in
            let items: [Int] = [5, 10, 15, 20, 40, 60, 80, 120, 200]
            let wrapper = PlainPickerWrapperView(items: items.compactMap({ String($0) }))
            self.timeoutPickerWrapper = wrapper
            self.timeoutPickerWrapper.select(item: self.timeoutInterval)
            self.timeoutPickerWrapper.addTarget(self, action: #selector(self.onTimeoutChanged), for: .valueChanged)
            timeoutValueTextField.inputView = wrapper.picker
            timeoutValueTextField.placeholder = LocalizedString.Common.value
            timeoutValueTextField.text = self.timeoutPickerWrapper.value
            self.timeoutValueTextField = timeoutValueTextField
        }
        return alert
    }
    
    @objc private func onTimeoutChanged() {
        timeoutInterval = timeoutPickerWrapper.value
        timeoutValueTextField?.text = timeoutPickerWrapper.value
    }
}
