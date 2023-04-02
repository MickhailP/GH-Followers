//
//  GFItemInfoVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 01.04.2023.
//

import UIKit
import SnapKit

class GFItemInfoVC: UIViewController {
	
	let stackView = UIStackView()
	let itemInfoOne = GFItemInfoView()
	let itemInfoTwo = GFItemInfoView()
	let actionButton = GFButton()
	
	var user: User?
	
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureBackgroundView()
		configureStackView()

    }
	

	private func configureBackgroundView() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
		
	}
	
	
	private func configureStackView() {
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		
		stackView.addArrangedSubview(itemInfoOne)
		stackView.addArrangedSubview(itemInfoTwo)
	}
	
	
	private func layoutUI() {
		view.addSubview(stackView)
		view.addSubview(actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		actionButton.translatesAutoresizingMaskIntoConstraints = false
		
		let padding: CGFloat = 20
		
		stackView.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview().offset(padding)
			make.height.equalTo(50)
		}
		
		actionButton.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(padding)
			make.leading.trailing.equalToSuperview().offset(padding)
		}
	}
}
