//
//  Review.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/16/21.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [Review]
}

struct Review: Codable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
