//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by AliEren on 3.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class MovieDetailView: UIView, Layoutable {
    
    lazy var movieDetailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.lightGrey
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.addSubview(movieDetailContainerView)
        return scrollView
    }()

    lazy var movieDetailContainerView: UIView = {
        var containerView = UIView()
        containerView.addSubview(movieDetailImageView)
        containerView.addSubview(favoriteButtonView)
        containerView.addSubview(backButtonView)
        containerView.addSubview(movieNameLabel)
        containerView.addSubview(movieDetailStackView)
        containerView.addSubview(movieDirectorStackView)
        containerView.addSubview(movieWriterStackView)
        containerView.addSubview(movieActorStackView)
        containerView.addSubview(movieSubjectStackView)
        containerView.addSubview(timeAndLanguageStackView)
        containerView.addSubview(movieWatchButton)
        return containerView
    }()
    
    lazy var movieDetailImageView: GradientImageView = {
        let imageView = GradientImageView()
        imageView.image = UIImage(named: "movie_poster")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var favoriteButtonView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.lightGold
        view.layer.opacity = 0.6
        view.layer.cornerRadius = 8
        view.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    lazy var backButtonView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.lightGold
        view.layer.opacity = 0.6
        view.layer.cornerRadius = 8
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       return view
    }()

    lazy var backButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        return button
    }()

    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 30)
        label.text = "FURRY"
        return label
    }()
    
    private lazy var movieDetailStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [setupViewForLabel(label: movieYear), setupViewForLabel(label: movieGenre), setupViewForLabel(label: movieRating)])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 10
        return stack
    }()
    
    private lazy var movieYear: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var movieGenre: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var movieRating: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var movieDirectorStackView: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(setupLabel(txt: "Director"))
        stack.addArrangedSubview(movieDirectorLabel)
        return stack
    }()
    
    private lazy var movieDirectorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var movieWriterStackView: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(setupLabel(txt: "Writer"))
        stack.addArrangedSubview(movieWriterLabel)
        return stack
    }()

    private lazy var movieWriterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var movieActorStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(setupLabel(txt: "Actors"))
        stack.addArrangedSubview(movieActorLabel)
        return stack
    }()
    
    private lazy var movieActorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var movieSubjectStackView: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(setupLabel(txt: "Subject"))
        stack.addArrangedSubview(movieSubjectLabel)
        return stack
    }()

    private lazy var movieSubjectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    private lazy var runTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timeAndLanguageStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [runTimeLabel,(languageLabel)])
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var movieWatchButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setTitle("Start Watching", for: .normal)
        return button
    }()
    
    func setupViews() {
        addSubview(movieDetailScrollView)
    }
    
    func setupLayout() {
        
        movieDetailScrollView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        movieDetailContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.greaterThanOrEqualTo(UIScreen.main.bounds.height + 400)
            make.bottom.equalTo(4)
        }
        
        favoriteButtonView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        backButtonView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        movieDetailImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.8)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieDetailImageView.snp.bottom).offset(-200)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            
            
        }
        
        movieDetailStackView.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        movieDirectorStackView.snp.makeConstraints { make in
            make.top.equalTo(movieDetailImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        movieWriterStackView.snp.makeConstraints { make in
            make.top.equalTo(movieDirectorStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        movieActorStackView.snp.makeConstraints { make in
            make.top.equalTo(movieWriterStackView.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        
        movieSubjectStackView.snp.makeConstraints { make in
            make.top.equalTo(movieActorStackView.snp.bottom).offset(20)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.centerX.equalToSuperview()
        }
        
        timeAndLanguageStackView.snp.makeConstraints { make in
            make.top.equalTo(movieSubjectStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        movieWatchButton.snp.makeConstraints { make in
            make.top.equalTo(timeAndLanguageStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(60)
            
        }
    }
}

// MARK: - Configuration
extension MovieDetailView {
    func configureDetail(movie: DetailMovieModel) {
        guard let rating = movie.imdbRating, let movieTitle = movie.title, let movieImageURLString = movie.poster, let year = movie.year else { return }
        guard let director = movie.director, let writer = movie.writer, let actor = movie.actors, let subject = movie.plot,
              let movieTime = movie.runtime, let language = movie.language else { return }
        guard let genre = movie.genre?.split(separator: ",") else { return }
        let mainGenre = String(genre[0])
        movieNameLabel.text = movieTitle
        movieYear.text = year
        movieGenre.text = mainGenre
        movieRating.text = rating
        movieDirectorLabel.text = director
        movieWriterLabel.text = writer
        movieActorLabel.text = actor
        movieSubjectLabel.text = subject
        runTimeLabel.text = movieTime
        languageLabel.text = language
        ImageDownloader.shared.downloadImage(with: movieImageURLString, completionHandler: { (image, cached) in
            self.movieDetailImageView.image = image
        }, placeholderImage: UIImage(named: "movie_poster"))
    }
}

// MARK: - Helpers
extension MovieDetailView {
    
    func setupLabel(txt: String) -> UILabel {
        lazy var label: UILabel = {
           let label = UILabel()
            label.font = UIFont(name: "Roboto-Bold", size: 22)
            label.text = txt
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        return label
    }

    func setupViewForLabel(label: UILabel) -> UIView {
        lazy var view: GradientView = {
            let view = GradientView()
            view.layer.opacity = 0.4
            view.layer.cornerRadius = 8
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(80)
            }
            return view
        }()
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        return view
    }
}
