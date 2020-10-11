//
//  Utilities.swift
//  RedditClient
//
//  Created by Ram Jalla on 11/10/20.
//

import Foundation
import UIKit

extension UITableView {
    func showSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        backgroundView = spinner
        separatorStyle = .none
    }
    
    func hideSpinner() {
        separatorStyle = .singleLine
        backgroundView = nil
    }
}
