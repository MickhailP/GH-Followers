//
//  FollowerListVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 15.03.2023.
//

import UIKit
import SnapKit

protocol FollowerListVCDelegate: AnyObject {
	func requestFollowers(for username: String)
}

class FollowerListVC: GFDataLoadingVC {
	
	enum Section {
		case main
	}
	
	var userName: String!
	var followers: [Follower] = []
	var filteredFollowers: [Follower] = []
	
	private var page = 1
	private var hasMoreFollowers = true
	
	private var isSearching = false
	private var isLoadingMoreFollowers = false

	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	init(userName: String) {
		super.init(nibName: nil, bundle: nil)
		self.userName = userName
		title = userName
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureNavigation()
		
		configureViewController()
		configureCollectionView()
		configureCollectionView()
		configureSearchController()
		getFollowers(for: userName, at: page)
		configureDataSource()
		
	}
	
	
	private func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
		collectionView.delegate = self
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerViewCell.self, forCellWithReuseIdentifier: Constants.CellsNames.followerCell)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		
		collectionView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
			make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
		}
	}
	
	
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}
	
	
	private func configureNavigation() {
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	private func getFollowers(for userName: String, at page: Int) {
		showLoadingView()
		NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
			
			guard let self = self else {
				return
			}
			
			self.dismissLoadingView()
			
			switch result {
				case .success(let followers):
					if followers.count < 100  { self.hasMoreFollowers = false }
					self.followers.append(contentsOf: followers)
					
					if followers.isEmpty {
						let message = "This user doesn't have followers yet. Please go follow them"
						
						DispatchQueue.main.async {
							self.showEmptyStateView(with: message, in: self.view)
						}
						return
					}

					self.updateData(on: self.followers)
				case .failure(let error):
					self.presentGFAlertOnMainTread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	
	@objc func addButtonTapped() {
		showLoadingView()
		isLoadingMoreFollowers = true
		NetworkManager.shared.getUser(for: userName) { [weak self] result in
			guard let self = self else {
				return
			}
			self.dismissLoadingView()
			
			switch result {
				case .success(let user):
					let favorite = Follower(login: user.login, avatarURL: user.avatarUrl)
					
					PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
						guard let self = self else { return }
						guard let error else {
							self.presentGFAlertOnMainTread(title: "Success", message: "You have added the user to your favorites", buttonTitle: "Yay")
							return
						}
						
						self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
					}
				case .failure(let error):
					self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}

			self.isLoadingMoreFollowers = false
		}
	}
}


//MARK: - DataSource configuration
extension FollowerListVC {
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Follower> (collectionView: collectionView,   cellProvider: { collectionView, indexPath, follower in
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellsNames.followerCell, for: indexPath) as! FollowerViewCell
			
			cell.set(follower: follower)
			return cell
		})
	}
	
	
	private func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower> ()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot)
		}
	}
}
 

//MARK: - Pagination implementation
extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if !isSearching {
			let offsetY = scrollView.contentOffset.y
			let contentHeigh = scrollView.contentSize.height
			let heigh  = scrollView.frame.size.height
			
			if offsetY > contentHeigh - heigh {
				guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
				
				page += 1
				getFollowers(for: userName, at: page)
			}
		}
	}
}


//MARK: - Search config, Delegate
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate{
	
	private func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for username"
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.searchController = searchController
	}
	
	
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else  { return }
		
		isSearching = true
		
		filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
		
		updateData(on: filteredFollowers)
	}
	
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			let sB = navigationItem.searchController?.searchBar
			searchBarCancelButtonClicked(sB!)
		}
	}
	
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		isSearching = false
		updateData(on: followers)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let activeArray = isSearching ? filteredFollowers : followers
		let follower = activeArray[indexPath.item]
		
		let destVC = UserInfoVC()
		let navController = UINavigationController(rootViewController: destVC)
		destVC.userName = follower.login
		destVC.delegate = self
		
		present(navController, animated: true)
	}
}


//MARK: FollowerListVCDelegate

extension FollowerListVC: FollowerListVCDelegate {
	func requestFollowers(for username: String) {
		self.userName = username
		title = username
		followers.removeAll()
		filteredFollowers.removeAll()
		page = 1
		isSearching = false
		hasMoreFollowers = true
		collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
		getFollowers(for: username, at: page)
	}
}


