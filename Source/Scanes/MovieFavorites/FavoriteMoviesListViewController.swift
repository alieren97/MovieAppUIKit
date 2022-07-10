//
//  FavoriteMoviesList.swift
//  MovieApp
//
//  Created by AliEren on 22.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class FavoriteMoviesListViewController: UIViewController, Layouting {
    
    var favoriteMoviesList = [UserDefaultMovieModel]()
    
    typealias ViewType = FavoriteMoviesView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadFavoriteMovies()
    }
    
}

// MARK: - SetupCollectionView, UICollectionDelegate, UICollectionViewDatSource
extension FavoriteMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        layoutableView.favoriteMoviesCollectionView.delegate = self
        layoutableView.favoriteMoviesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMovieTableViewCell.identifier,
                                                       for: indexPath) as? FavoriteMovieTableViewCell else { return UICollectionViewCell() }
        let movie = favoriteMoviesList[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = layoutableView.favoriteMoviesCollectionView.bounds.height
        return CGSize(width: collectionWidth / 2, height: collectionWidth / 2)
       }
}

// MARK: - Helpers
extension FavoriteMoviesListViewController {
    func reloadFavoriteMovies() {
        favoriteMoviesList = UserDefaultsManager.shared.loadFavoriteMovies()
        layoutableView.favoriteMoviesCollectionView.reloadData()
        
        if favoriteMoviesList.isEmpty {
            layoutableView.emptyListLabel.isHidden = false
        }
    }
}
