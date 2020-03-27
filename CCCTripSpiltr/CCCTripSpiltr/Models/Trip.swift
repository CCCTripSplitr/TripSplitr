//
//  Trip.swift
//  CCCTripSpiltr
//
//  Created by jonathan ferrer on 3/27/20.
//  Copyright © 2020 Ryan Murphy. All rights reserved.
//

import UIKit

class Trip {
    let id: UUID
    var users: [User]
    var isComplete: Bool
    var name: String
    var image: UIImage
    let startDate: Date
    var endDate: Date?

    init(id: UUID = UUID(), users: [User] = [], isComplete: Bool = false, name: String, image: UIImage = Constants.Images.defaultTrip!, startDate: Date = Date()) {
        self.id = id
        self.users = users
        self.isComplete = isComplete
        self.name = name
        self.image = image
        self.startDate = startDate
    }
}

class User {
    let id: UUID
    var username: String
    var fullName: String
    var avatar: UIImage
    
    init(id: UUID = UUID(), username: String, fullName: String, avatar: UIImage) {
        self.id = id
        self.username = username
        self.fullName = fullName
        self.avatar = avatar
    }
}