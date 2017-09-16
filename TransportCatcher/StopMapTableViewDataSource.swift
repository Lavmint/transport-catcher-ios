//
//  StopMapTableViewDataSource.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

internal class StopMapTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
