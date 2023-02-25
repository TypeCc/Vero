//
//  ReloadOnMainThread.swift
//  acont
//
//  Created by serif mete on 19.02.2023.
//

import UIKit

extension UITableView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
