//
//  FriendCell.swift
//  CCCTripSpiltr
//
//  Created by jonathan ferrer on 3/30/20.
//  Copyright © 2020 Ryan Murphy. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    static let reuseID = "FriendCell"
    let imageView = CCCAvatarImageView(frame: .zero)
    let nameLabel = CCCTitleLabel(textAlignment: .center, fontSize: 16)
    var user: User!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(user: User) {
        nameLabel.text = user.fullName
        
    }
    
    private func configure() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        
        let padding: CGFloat = 8
        
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
                
                nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                nameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
}
