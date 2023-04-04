//
//  SearchVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 14.03.2023.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextfield = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    var isUserNameEntered: Bool { !usernameTextfield.text!.isEmpty }
    
    let padding: CGFloat = 50
    let buttonHeigh: CGFloat = 44
	

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        usernameTextfield.text = "SAllen0400" 
    }

    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: Constants.Images.logo)!
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
    }
    
    private func configureTextField() {
        view.addSubview(usernameTextfield)
        usernameTextfield.delegate = self
        
        usernameTextfield.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(padding)
            make.leading.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(Constants.ViewSize.buttonHeight)
        }
        //NSLayout
        /*
         NSLayoutConstraint.activate([
         usernameTextfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
         usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
         usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
         usernameTextfield.heightAnchor.constraint(equalToConstant: 44)
         ])
         */
    }
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        callToActionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(padding)
            make.height.equalTo(Constants.ViewSize.buttonHeight)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
	}
    
    
    @objc func pushFollowerListVC() {
        
        guard isUserNameEntered else {
            self.presentGFAlertOnMainTread(title: "Empty Username.", message: "Please enter username to textfield and try again.", buttonTitle: "Ok")
            return
        }
        
        let followerListVC          = FollowerListVC()
        followerListVC.userName     = usernameTextfield.text
        followerListVC.title        = usernameTextfield.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
	
	
	private func createDismissKeyboardTapGesture(){
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

