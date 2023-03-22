//
//  UIViewControllerExtension.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 15.03.2023.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitl)
            
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true)
            
        }
    }
}



