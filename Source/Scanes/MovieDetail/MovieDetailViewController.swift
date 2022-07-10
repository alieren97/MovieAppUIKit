//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by AliEren on 3.06.2022.
//

import Foundation
import UIKit

final class MovieDetailViewController: UIViewController, Layouting {
    
    private var movieID: String?
    private var movieDetailModel: DetailMovieModel?
    var movieList = [UserDefaultMovieModel]()
    
    typealias ViewType = MovieDetailView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    convenience init(movieID: String) {
        self.init()
        self.movieID = movieID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetail()
        setupTargets()
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfFavorite()
    }
}

// MARK: - MovieDetailRequest
extension MovieDetailViewController {
    func fetchMovieDetail() {
        
        guard let movieID = movieID else { return }
        let url = NetworkingManager.titleBaseURL + movieID
        guard let newURL = URL(string: url) else { return }
        NetworkingManager.shared.getMovie(url: newURL) { result in
            switch result {
            case .success(let movie):
                self.movieDetailModel = movie
                self.layoutableView.configureDetail(movie: movie)
            case .failure(let error):
                print(error)
            }

        }
    }
}

// MARK: - SetupTargets
extension MovieDetailViewController {
    func setupTargets() {
        layoutableView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        layoutableView.favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
}

// MARK: - Actions
extension MovieDetailViewController {
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func didTapFavoriteButton() {
        guard let movie = movieDetailModel else {return}
        if UserDefaultsManager.shared.isFavorite == true {
            for movies in movieList {
                if movies.model.imdbID == movie.imdbID {
                    if let itemToRemoveIndex = movieList.firstIndex(of: movies) {
                        movieList.remove(at: itemToRemoveIndex)
                        UserDefaultsManager.shared.updateFavoriteMovies(movies: movieList)
                    }
                }
            }
            layoutableView.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            UserDefaultsManager.shared.isFavorite = false
        } else {
            movieList.append(UserDefaultMovieModel(model: movie, time: Date()))
            UserDefaultsManager.shared.updateFavoriteMovies(movies: movieList)
            layoutableView.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            UserDefaultsManager.shared.isFavorite = true
        }
    }
}

// MARK: - Helpers
extension MovieDetailViewController {
    func checkIfFavorite() {
        movieList = UserDefaultsManager.shared.loadFavoriteMovies()
        guard let movieID = movieDetailModel?.imdbID else { return }
        UserDefaultsManager.shared.checkFavorite(selectedMovieID: movieID)
        if UserDefaultsManager.shared.isFavorite == true {
            layoutableView.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
}
