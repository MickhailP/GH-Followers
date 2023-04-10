//
//  GFDataLoadingVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 07.04.2023.
//

import UIKit

class GFDataLoadingVC: UIViewController {
	
	var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	
	func showLoadingView() {
		
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		
		UIView.animate(withDuration: 0.25) {
			self.containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		activityIndicator.snp.makeConstraints { make in
			make.centerX.centerY.equalTo(containerView)
		}
		
		activityIndicator.startAnimating()
	}
	
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			self.containerView.removeFromSuperview()
			self.containerView = nil
		}
	}
	
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptySateView = GFEmptyView(message: message)
		emptySateView.frame = view.bounds
		view.addSubview(emptySateView)
	}
}
