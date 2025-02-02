//
//  AddFriendToTripViewController.swift
//  CCCTripSpiltr
//
//  Created by Ryan Murphy on 4/22/20.
//  Copyright © 2020 Ryan Murphy. All rights reserved.
//

import UIKit
import Photos

protocol AddGuestToTripDelegate {
    func guestCreated(id: String)
}


class AddGuestVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePickerDelegate{
    var delegate: AddGuestToTripDelegate?
let containerView = UIView()
let padding: CGFloat = 20
let titleLabel = CCCTitleLabel(textAlignment: .center, fontSize: 20)
let closeActionButton = UIButton()
let updateActionButton = UIButton()
let nameTextField = UITextField()
let usernameTextField = UITextField()
let avatarImageView = CCCAvatarImageView(frame: .zero)
let addPhotoButton = UIButton()
var imagePicker: ImagePicker!
var currentUser: User!
let stackView = UIStackView()
var avatarImage: UIImage!
var buttonTitle = "Close"
var addButtonTitle = "Add Guest"
var viewTitle = "Friend Info"
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    configureContainerView()
    configureTitleLabel()
    configureActionButtons()
    configureStackView()
    configureAddPhotoButton()
    configureImageView()
    self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    
    updateViews()
}


func didSelect(image: UIImage?) {
    self.avatarImage = image
    self.avatarImageView.image = image
}


func updateViews() {
    
    nameTextField.placeholder = "Full Name"
    usernameTextField.placeholder = "Username"

    }

func configureStackView() {
    
    nameTextField.layer.borderWidth = 0.8
    nameTextField.layer.borderColor = UIColor.systemGray3.cgColor
  //  usernameTextField.layer.borderWidth = 0.8
  //  usernameTextField.layer.borderColor = UIColor.systemGray3.cgColor
    
    nameTextField.layer.cornerRadius = 10
 //   usernameTextField.layer.cornerRadius = 10

    nameTextField.textAlignment = .center
 //   usernameTextField.textAlignment = .center
    
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
  ///  usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    stackView.addArrangedSubview(nameTextField)
//    stackView.addArrangedSubview(usernameTextField)
    
    containerView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        stackView.heightAnchor.constraint(equalToConstant: 75),

    ])
    
    
    

}

func configureAddPhotoButton() {
    containerView.addSubview(addPhotoButton)
    addPhotoButton.setImage(UIImage(systemName: "camera"), for: .normal)
    addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
    addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
        addPhotoButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:  12),
        addPhotoButton.widthAnchor.constraint(equalToConstant: 30),
        addPhotoButton.heightAnchor.constraint(equalToConstant: 30),
        addPhotoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])
}


func configureImageView() {
    view.addSubview(avatarImageView)
    
    
    NSLayoutConstraint.activate([
        avatarImageView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 8),
        avatarImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        avatarImageView.bottomAnchor.constraint(equalTo: updateActionButton.topAnchor, constant: -8),
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
    ])

}

@objc func addPhotoButtonTapped() {
    self.imagePicker.present(from: self.view)
}


func configureContainerView() {
    
    
    view.addSubview(containerView)
    
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 0.5
    containerView.layer.borderColor = UIColor.systemGray.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        containerView.widthAnchor.constraint(equalToConstant: 280),
        containerView.heightAnchor.constraint(equalToConstant: 425)
    ])
    
}

func configureTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    titleLabel.text = viewTitle
    NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
}


func configureActionButtons() {
    Utilities.styleFilledButton(closeActionButton, fillColor: .systemRed)
    closeActionButton.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(closeActionButton)
    closeActionButton.setTitle(buttonTitle, for: .normal)
    closeActionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    
    Utilities.styleFilledButton(updateActionButton, fillColor: .systemGreen)
    updateActionButton.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(updateActionButton)
    updateActionButton.setTitle(addButtonTitle, for: .normal)
    updateActionButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
        closeActionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
        closeActionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
        closeActionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        closeActionButton.heightAnchor.constraint(equalToConstant: 44),
        
        updateActionButton.bottomAnchor.constraint(equalTo: closeActionButton.topAnchor, constant: -8),
        updateActionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
        updateActionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        updateActionButton.heightAnchor.constraint(equalToConstant: 44)
        
    ])
}




@objc func dismissVC() {
    self.dismiss(animated: true, completion: nil)
    
    
    
    }
    
    @objc func updateUser() {
        guard let fullName = nameTextField.text,
            !fullName.isEmpty else { return }
        NetworkController.shared.createGuest(fullName: fullName) { [weak self] (id, error) in
            guard let self = self else { return }
            if let error = error {
                NSLog(error.rawValue)
            }
            
            guard let id = id else { return }
            self.dismiss(animated: true, completion: nil)
            self.delegate?.guestCreated(id: id)
        }
    }

}
