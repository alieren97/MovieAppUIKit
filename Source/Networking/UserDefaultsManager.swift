//
//  UserDefaultsManager.swift
//  MovieApp
//
//  Created by AliEren on 23.06.2022.
//

import Foundation
import UIKit

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    static let key = "favoriteMovies"
    
    var favoriteMovies: [UserDefaultMovieModel] = []
    var isFavorite: Bool = false
    
    func updateFavoriteMovies(movies: [UserDefaultMovieModel]) {
        guard let data = try? JSONEncoder().encode(movies) else { return }
        UserDefaults.standard.set(data, forKey: UserDefaultsManager.key)
    }
    
    func loadFavoriteMovies() -> [UserDefaultMovieModel] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsManager.key),
            let favorites = try? JSONDecoder().decode([UserDefaultMovieModel].self, from: data)
        else { return  [] }
        return favorites
    }
    
    func checkFavorite(selectedMovieID: String) {
        for movie in loadFavoriteMovies() {
            if movie.model.imdbID == selectedMovieID {
                isFavorite = true
            } else {
                isFavorite = false
            }
        }
    }
    
    func check24H() {
        var favMovies = loadFavoriteMovies()
        for movie in favMovies {
            if let diff = Calendar.current.dateComponents([.hour], from: movie.time, to: Date()).hour, diff  >= 24 {
                while favMovies.contains(movie) {
                    if let itemToRemoveIndex = favMovies.firstIndex(of: movie) {
                        favMovies.remove(at: itemToRemoveIndex)
                        updateFavoriteMovies(movies: favMovies)
                    }
                }
            }
        }
    }
}
