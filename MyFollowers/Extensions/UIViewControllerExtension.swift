//
//  UIViewControllerExtension.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 15.03.2023.
//

import UIKit
import SnapKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
	func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			
			self.present(alertVC, animated: true)
			
		}
	}
	
	
	func showLoadingView() {
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		
		UIView.animate(withDuration: 0.25) {
			containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		activityIndicator.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
		}
		
		activityIndicator.startAnimating()
	}
	
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}
	
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptySateView = GFEmptyView(message: message)
		emptySateView.frame = view.bounds
		view.addSubview(emptySateView)
	}
	
	
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
}

