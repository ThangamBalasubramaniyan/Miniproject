//
//  GitData.swift
//  MiniProject
//
//  Created by user199474 on 7/1/21.
//

import Foundation

struct Root: Codable {
    var total_count : Int?
    var incomplete_reslts : Bool?
    var items: [Item]
}

struct Item: Codable {
    var full_name: String?
    var owner: Owner?
    var html_url: String?
    var description: String?

}

struct Owner: Codable {
    var login: String?
    var avatar_url: String?
}
//enum CodingKeys: String, CodingKey {
//    case items = "items"
//    case full_name = "full_name"
//    case login = "login"
//    case avatar_url = "avatar_url"
//    case description = "description"
//}
//
