//
//  MainView.swift
//  MovieApp
//
//  Created by AliEren on 2.06.2022.
//

import Foundation
import UIKit
import SnapKit
import CollectionViewWaterfallLayout

final class MovieListView: UIView, Layoutable {
    
    lazy var mainContainerView: UIView = {
        var view = UIView()
        view.addSubview(movieSearchBar)
        view.addSubview(emptyListLabel)
        view.addSubview(movieCollectionView)
        return view
    }()
    
    lazy var emptyListLabel: UILabel = {
        var label = UILabel()
        label.text = "You need to search for a Movie"
        label.isHidden = true
        return label
    }()
    
    lazy var movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for a movie"
        searchBar.isTranslucent = true
        searchBar.isUserInteractionEnabled = true
        searchBar.tintColor = .black
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .black
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .gray
        searchBar.layer.borderColor = Colors.lightGold.cgColor
        searchBar.layer.borderWidth = 2
        searchBar.layer.cornerRadius = 16
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    var movieFlowLayout: CollectionViewWaterfallLayout = {
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumColumnSpacing = 15
        layout.minimumInteritemSpacing = 20
        return layout
    }()
    
    lazy var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: movieFlowLayout)
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.isHidden = false
        return collectionView
    }()
    
    func setupViews() {
        backgroundColor = .white
        addSubview(mainContainerView)
    }
    
    func setupLayout() {
        mainContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        movieSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(30)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        emptyListLabel.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(30)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
