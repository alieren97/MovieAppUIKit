//
//  MainCollectionViewCell.swift
//  MovieApp
//
//  Created by AliEren on 2.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionContainerView: UIView = {
        var containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        containerView.addSubview(collectionImageView)
        containerView.addSubview(imdbRatingLabel)
        return containerView
    }()
    
    lazy var collectionImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "movie_poster")
        return imageView
    }()
    
    lazy var imdbRatingLabel: UILabel = {
        var label = UILabel()
        label.text = "9.5"
        label.textColor = .white
        return label
    }()
    
    func setupViews() {
        addSubview(collectionContainerView)
    }
    
    func setupLayout() {
        collectionContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        collectionImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        imdbRatingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}

extension MovieListCollectionViewCell {
    func configure(movie: MovieModel) {
        guard let movieIMDB = movie.imdbID, let movieImageURLString = movie.poster else {return}
        imdbRatingLabel.text = movieIMDB
        ImageDownloader.shared.downloadImage(with: movieImageURLString, completionHandler: { (image, cached) in
            self.collectionImageView.image = image
        }, placeholderImage: UIImage(named: "movie_poster"))
    }
}
