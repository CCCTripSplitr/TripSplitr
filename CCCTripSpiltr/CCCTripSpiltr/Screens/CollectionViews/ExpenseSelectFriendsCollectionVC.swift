//
//  SelectFriendsForExpenseVC.swift
//  CCCTripSpiltr
//
//  Created by Ryan Murphy on 4/2/20.
//  Copyright © 2020 Ryan Murphy. All rights reserved.
//

import UIKit
import Firebase

enum SelectFriendsType {
    case paidBy
    case usedBy
}


class ExpenseSelectFriendsCollectionVC: UIViewController {
    
    
    var friends = [String]()
    var collectionView: UICollectionView!
    var selectedFriends = [String]()
    
    var image: UIImage?
    var selectType: SelectFriendsType?
    var trip: Trip?
    var expense: Expense?
    
    init(selectType: SelectFriendsType) {
        super.init(nibName: nil, bundle: nil)
        self.selectType = selectType
        
        switch selectType {
            
        case .paidBy:
            title = "Paid By"
        case .usedBy:
            title = "Used By"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureCollectionView()
        configureViewController()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFriends()
        
    }
    
    func getFriends() {
        guard let trip = trip else { return }
        
        friends = trip.users
        
        
    }
    
    func configureSelectedFriends(cell: FriendCell, indexPath: IndexPath) {
        guard let expense = expense,
            let selectType = selectType,
            let userID = cell.userID else { return }
        
        switch selectType {
        case .paidBy:
            if expense.paidBy.keys.contains(userID) {
                selectedFriends.append(userID)
    
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                cell.contentView.backgroundColor = .systemTeal
            }
            
        case .usedBy:
            if expense.usedBy.keys.contains(userID) {
                selectedFriends.append(userID)

                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                cell.contentView.backgroundColor = .systemTeal
            }
        }
        
    }
        
        func configureViewController() {
            
            view.backgroundColor = .systemBackground
            navigationController?.navigationBar.prefersLargeTitles = true
            
            let createButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createButtonPressed))
            navigationItem.rightBarButtonItem = createButton
        }
        
        func configureCollectionView() {
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: Utilities.createThreeColumnFlowLayout(in: view))
            view.addSubview(collectionView)
            collectionView.backgroundColor = .systemBackground
            collectionView.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.reuseID)
            collectionView.allowsMultipleSelection = true
            
        }
        
        @objc func createButtonPressed() {
            guard let selectType = selectType,
                let expense = expense else { return }
            
            var dictionary = [String: Double]()
            switch selectType {
            case .paidBy:
                for user in selectedFriends {
                    dictionary[user] = expense.cost / Double(selectedFriends.count)
                }
                expense.paidBy = dictionary
            case .usedBy:
                for user in selectedFriends {
                    dictionary[user] = expense.cost / Double(selectedFriends.count)
                }
                expense.usedBy = dictionary
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    extension ExpenseSelectFriendsCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return friends.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCell.reuseID, for: indexPath) as? FriendCell else {
                return UICollectionViewCell() }
            let friendID = friends[indexPath.row]
            cell.set(userID: friendID)
            configureSelectedFriends(cell: cell, indexPath: indexPath)
            
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let userID = friends[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.isSelected = true
            if selectedFriends.contains(userID) {
                return
            }
            cell?.contentView.backgroundColor = .systemTeal
            selectedFriends.append(userID)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let userID = friends[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.isSelected = false
            if selectedFriends.contains(userID) {
                selectedFriends.remove(at: selectedFriends.firstIndex(of: userID)!)
            }
            cell?.contentView.backgroundColor = nil
            print(selectedFriends.count)
            
        }
        
        
}
