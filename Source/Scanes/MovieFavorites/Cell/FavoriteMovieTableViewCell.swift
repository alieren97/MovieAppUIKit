//
//  FavoriteMovieTableViewCell.swift
//  MovieApp
//
//  Created by AliEren on 23.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class FavoriteMovieTableViewCell: UICollectionViewCell {
    
    static let identifier = "FavoriteMovieTableViewCell"
    let dateFormatter = DateFormatter()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var favoriteCellContainerView: UIView = {
        let view = UIView()
        view.addSubview(favoriteCellImageView)
        view.addSubview(favoriteCellTimeLabel)
        return view
    }()
    
    private lazy var favoriteCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var favoriteCellTimeLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(favoriteCellContainerView)
    }
    
    private func setupLayout() {
        
        favoriteCellContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        favoriteCellImageView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(150)
        }
        
        favoriteCellTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(favoriteCellImageView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Configure
extension FavoriteMovieTableViewCell {
    
    func configure(movie: UserDefaultMovieModel) {
        guard let movieImage = movie.model.poster else {return}
        favoriteCellTimeLabel.text = confgiureTime(movieTime: movie.time)
        ImageDownloader.shared.downloadImage(with: movieImage, completionHandler: { (image, cached) in
            self.favoriteCellImageView.image = image
        }, placeholderImage: UIImage(named: "movie_poster"))
    }
    
    func confgiureTime(movieTime: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        formatter.unitsStyle = .full
        guard let string = formatter.string(from: movieTime, to: Date()) else { return " " }
        return string
    }
}
