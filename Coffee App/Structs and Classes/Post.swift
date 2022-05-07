//
//  Post.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import Foundation

struct PostResponse: Codable {
    let posts: [Post]
}

struct Post: Codable{
    let id: Int
    let user_id: Int
    let content: String
    let username: String
    let image: Image
}

struct Image: Codable {
    let url: String
    let created_at: String
}
