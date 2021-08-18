//
//  SettingStore.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import Foundation
import Combine

enum DisplayOrderType: Int, CaseIterable {
    case alphabetical = 0
    case favoriteFirst = 1
    case ratingsLtoH = 2
    case ratingsHtoL = 3
    case directorsAlph = 4
    case languagesAlph = 5
    
    init(type: Int) {
        switch type {
        case 0: self = .alphabetical
        case 1: self = .favoriteFirst
        case 2: self = .ratingsLtoH
        case 3: self = .ratingsHtoL
        case 4: self = .directorsAlph
        case 5: self = .languagesAlph
        default: self = .alphabetical
        }
    }
    
    var text: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .favoriteFirst: return "Show Favorite's First"
        case .ratingsLtoH: return "Ratings: Lowest to Highest"
        case .ratingsHtoL: return "Ratings: Highest to Lowest"
        case .directorsAlph: return "Directors in Alphabetical"
        case .languagesAlph: return "Languages in Alphabetical"
        }
    }
    
    func predicate() -> ((MovieAdd, MovieAdd) -> Bool) {
        switch self {
        case .alphabetical: return { $0.movieName < $1.movieName}
        case .favoriteFirst: return { $0.isFavorite && !$1.isFavorite}
        case .ratingsLtoH: return { $0.movieRating < $1.movieRating }
        case .ratingsHtoL: return { $0.movieRating > $1.movieRating }
        case .directorsAlph: return { $0.movieDirector < $1.movieDirector}
        case .languagesAlph: return { $0.movieLanguage < $1.movieLanguage}
        }
    }
}

final class SettingStore: ObservableObject {
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.showFavorite'sOnly": false,
            "view.preferences.displayOrder": 0
        ])
    }
    
    @Published var showFavoriteOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferences.showFavorite'sOnly") {
        didSet {
            UserDefaults.standard.set(showFavoriteOnly, forKey: "view.preferences.showFavorite'sOnly")
        }
    }
    
    @Published var displayOrder: DisplayOrderType = DisplayOrderType(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder")) {
        didSet {
            UserDefaults.standard.set(displayOrder.rawValue, forKey: "view.preferences.displayOrder")
        }
    }
}
