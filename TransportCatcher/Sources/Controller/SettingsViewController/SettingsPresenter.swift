//
//  SettingsPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 07/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class SettingsPresenter {
    
    let interactor: SettingsInteractor
    let timeoutIntervalFormatter: NumberFormatter
    private var timeoutPickerWrapper: PlainPickerWrapperView!
    
    init(interactor: SettingsInteractor)  {
        self.interactor = interactor
        timeoutIntervalFormatter = NumberFormatter()
        timeoutIntervalFormatter.maximumFractionDigits = 0
        timeoutIntervalFormatter.minimumFractionDigits = 0
    }
    
    var timeoutInterval: String? {
        get {
            return String(interactor.timeoutInterval)
        }
        set {
            guard let rawValue = newValue, let value = Double(rawValue) else { return }
            interactor.timeoutInterval = value
        }
    }
    
    func createTimeoutIntervalAlert(timeoutIntervalChangedHandler handler: (target: Any, selector: Selector)) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: LocalizedString.Settings.setTimeoutInterval, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizedString.Alert.OK, style: .default) { (_) in
            self.interactor.userStorage.save()
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
            let wrapper = PlainPickerWrapperView(items: items.flatMap({ String($0) }))
            self.timeoutPickerWrapper = wrapper
            timeoutValueTextField.inputView = wrapper.picker
            timeoutValueTextField.placeholder = LocalizedString.Common.value
            timeoutValueTextField.text = self.timeoutInterval
            timeoutValueTextField.addTarget(handler.target, action: handler.selector, for: .editingChanged)
        }
        
        return alert
    }
}
