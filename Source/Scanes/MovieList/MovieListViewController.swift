//
//  MainViewController.swift
//  MovieApp
//
//  Created by AliEren on 2.06.2022.
//

import Foundation
import UIKit
import CollectionViewWaterfallLayout

final class MovieListViewController: UIViewController, Layouting {
    
    private lazy var moviesModel: [MovieModel] = []
    var page: Int = 1
    var searchTextt: String?
    
    lazy var cellSizes: [CGSize] = {
        var cellSizes = [CGSize]()
        var height = 0
        for _ in 0...100 {
            let random = Int(arc4random_uniform((UInt32(140))))
            if random >= 70 {
                height = 170 + random
            }
            cellSizes.append(CGSize(width: 140, height: height))
        }
        
        return cellSizes
    }()
    
    typealias ViewType = MovieListView
    
    override func loadView() {
        view = ViewType.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        navigationController?.tabBarController?.tabBar.isHidden = false
        
    }
}

// MARK: - CollectionView
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate {
    
    func setupCollectionView() {
        layoutableView.movieCollectionView.delegate = self
        layoutableView.movieCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier,
                                                            for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        let movie = moviesModel[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieIndex = moviesModel[indexPath.row]
        guard let movieID = movieIndex.imdbID else { return }
        let movieDetailViewController = MovieDetailViewController(movieID: movieID)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return cellSizes[indexPath.item]
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let newwURLString = NetworkingManager.baseURL + "\(searchTextt ?? "")&page=\(page)"
        if indexPath.item + 1 >= moviesModel.count {
            page += 1
            NetworkingManager.shared.getMoviesList(url: newwURLString, page: page) { result in
                switch result {
                case .success(let response):
                    self.moviesModel.append(contentsOf: response.search)
                    self.layoutableView.movieCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: - SetupSearchbar
extension MovieListViewController {
    func setupSearchBar() {
        layoutableView.movieSearchBar.delegate = self
        layoutableView.movieSearchBar.becomeFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchRequest), object: nil)
        self.perform(#selector(searchRequest), with: nil, afterDelay: 1)
        page = 1
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.layoutableView.movieCollectionView.isHidden = true
        self.layoutableView.emptyListLabel.isHidden = false
        
    }
    
    @objc func searchRequest() {
        moviesModel.removeAll()
        if let searchText = layoutableView.movieSearchBar.text {
            let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
            if trimmedString != " " {
                searchTextt = trimmedString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                let newwURLString = NetworkingManager.baseURL + "\(searchTextt ?? "")&page=\(page)"
                NetworkingManager.shared.getMoviesList(url: newwURLString, page: page) { result in
                    switch result {
                    case .success(let response):
                        self.moviesModel.append(contentsOf: response.search)
                        self.layoutableView.movieCollectionView.reloadData()
                        self.layoutableView.movieCollectionView.isHidden = false
                        self.layoutableView.emptyListLabel.isHidden = true
                    case .failure(let error):
                        self.moviesModel.removeAll()
                        self.layoutableView.movieCollectionView.isHidden = true
                        self.layoutableView.emptyListLabel.isHidden = false
                    }
                }
            } else {
                self.layoutableView.movieCollectionView.isHidden = true
                self.layoutableView.emptyListLabel.isHidden = false
            }
        } else {
            print("Ali")
        }
    }
    
}
