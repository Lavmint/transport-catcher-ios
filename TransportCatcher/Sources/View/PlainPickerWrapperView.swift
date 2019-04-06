//
//  PlainPickerView.swift
//  OpenCity
//
//  Created by Alexey Averkin on 08/06/2017.
//  Copyright © 2017 Dmitry Golubev. All rights reserved.
//

import UIKit

class PlainPickerWrapperView: UIControl, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let items: [String]
    let picker: UIPickerView
    private(set) var value: String

    init(items: [String]) {
        self.items = items
        self.picker = UIPickerView()
        self.value = items.first ?? ""

        super.init(frame: CGRect.zero)
        picker.delegate = self
        picker.dataSource = self
        
        self.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            picker.topAnchor.constraint(equalTo: self.topAnchor),
            picker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            picker.leftAnchor.constraint(equalTo: self.leftAnchor),
            picker.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(item: String?) {
        guard let i = item, let idx = items.firstIndex(of: i) else {
            return
        }
        self.picker.selectRow(idx, inComponent: 0, animated: false)
        value = items[idx]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        value = items[row]
        sendActions(for: .valueChanged)
    }
}
