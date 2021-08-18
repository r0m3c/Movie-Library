//
//  Cast.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/16/21.
//

import Foundation

struct CastResponse: Codable {
    var cast: [Cast]
    
}

struct Cast: Codable, Identifiable {
    var id: Int?
    var name: String?
    var character: String?
    var profile_path: String?
    var profile_photo: String {
        if let path = profile_path {
            return "https://image.tmdb.org/t/p/original/\(path)"
        }
        return "https://picsum.photos/200/300"
    }
}
