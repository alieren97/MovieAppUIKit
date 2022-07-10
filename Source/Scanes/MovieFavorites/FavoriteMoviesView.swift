//
//  FavoriteMoviesView.swift
//  MovieApp
//
//  Created by AliEren on 22.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class FavoriteMoviesView: UIView, Layoutable {
    var preferredSpacing: CGFloat = 0.0
    
    private lazy var favoriteMoviesContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.addSubview(favoriteMovieTextLabel)
        view.addSubview(favoriteMoviesCollectionView)
        view.addSubview(emptyListLabel)
        return view
    }()
    
    lazy var favoriteMovieTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Favorite Movies"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var favoriteMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.register(FavoriteMovieTableViewCell.self, forCellWithReuseIdentifier: FavoriteMovieTableViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var emptyListLabel: UILabel = {
       let label = UILabel()
        label.text = "There are no favorite movies"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.isHidden = true
        return label
    }()
    func setupViews() {
        addSubview(favoriteMoviesContainerView)
    }
    
    func setupLayout() {
        favoriteMoviesContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        favoriteMovieTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(20)
        }
        
        favoriteMoviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteMovieTextLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalToSuperview()
        }
        
        emptyListLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
