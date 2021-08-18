//
//  MovieAdd.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import Foundation
import UIKit

class MovieAdd: ObservableObject, Identifiable {
    var id = UUID()
    @Published var movieName = ""
    @Published var movieYear = ""
    @Published var movieDirector = ""
    @Published var movieLanguage = ""
    @Published var dateAdded = ""
    @Published var movieRating = ""
    @Published var homeOrTheatre = ""
    @Published var isComplete : Bool = false
    @Published var isFavorite: Bool = false
    @Published var movieImage : UIImage
    
    init(movieName: String, movieYear: String, movieDirector: String, movieLanguage: String, dateAdded: String, movieRating: String, homeOrTheatre: String, isComplete: Bool = false, movieImage: UIImage) {
        self.movieName = movieName
        self.movieYear = movieYear
        self.movieDirector = movieDirector
        self.movieLanguage = movieLanguage
        self.dateAdded = dateAdded
        self.movieRating = movieRating
        self.homeOrTheatre = homeOrTheatre
        self.isComplete = isComplete
        self.movieImage = movieImage
    }
}
