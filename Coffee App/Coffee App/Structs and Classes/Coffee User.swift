//
//  Coffee User.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import Foundation

struct CoffeeUserResponse: Codable {
    let matches: Matches
}

struct Matches: Codable {
    let city: CoffeeUser?
    let favoritedrink: CoffeeUser?
    let flavor: CoffeeUser?
}
struct CoffeeUser: Codable {
    //let sessiontoken: String
    let id: Int
    let username: String
    let email: String
}

struct Userauth: Codable {
    let id: Int
    let session_token: String
    let session_expiration: String
    let update_token: String
}

struct Preferences: Codable{
    let id: Int
    let city: String
    let age: Int
    let caffeinemg: Int
    let maxcalories: Int
    let hotorcold: String
    
    let drinkfav: String
    let favspot: String
    let flavors: String
    let bio: String
    let matchme: Bool
}
