//
//  UIViewControllerExtension.swift
//  MovieSearch
//
//  Created by Maxwell Poffenbarger on 1/24/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
