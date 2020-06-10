//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by fordlabs on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import SnapKit
import MoviesService
import MoviesDataModel

class MovieDetailsView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scrlView = UIScrollView()
        scrlView.showsVerticalScrollIndicator = false
        return scrlView
    }()
    
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeHolder")
        return imageView
    }()
    
    private let edgeMargin: CGFloat = 25
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderLabelStyle(header: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        label.text = header
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }
    
    private func configureValueLabelStyle(value: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = value
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    private func configureMovieDetailContainerStyle(header: String, value: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        
        let headerLabel = configureHeaderLabelStyle(header: header)
        let valueLabel = configureValueLabelStyle(value: value)
        
        container.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        container.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        let separator = UIView()
        separator.backgroundColor = .gray
        
        container.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        return container
    }
    
    private func loadMoviePoster(link: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: link), let data = NSData(contentsOf: url) else { return }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data as Data) else { return }
                self?.movieImageView.image = image
            }
        }
    }
    
    func setupView(movieDetail: MoviesDetails) {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.snp.topMargin).offset(5)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(mainContainer)
        mainContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(edgeMargin)
            make.width.equalToSuperview().offset(-2 * edgeMargin)
            make.top.bottom.equalToSuperview()
        }
        
        mainContainer.addArrangedSubview(movieImageView)
        movieImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        if let posterLink = movieDetail.poster {
            loadMoviePoster(link: posterLink)
        }
        
        let year = configureMovieDetailContainerStyle(header: "Year:", value: movieDetail.year ?? "N/A")
        let rated = configureMovieDetailContainerStyle(header: "Rated:", value: movieDetail.rated ?? "N/A")
        let released = configureMovieDetailContainerStyle(header: "Released:", value: movieDetail.released ?? "N/A")
        let runtime = configureMovieDetailContainerStyle(header: "Runtime:", value: movieDetail.runtime ?? "N/A")
        let genre = configureMovieDetailContainerStyle(header: "Genre:", value: movieDetail.genre ?? "N/A")
        let director = configureMovieDetailContainerStyle(header: "Director:", value: movieDetail.director ?? "N/A")
        let writer = configureMovieDetailContainerStyle(header: "writer:", value: movieDetail.writer ?? "N/A")
        let actors = configureMovieDetailContainerStyle(header: "Actors:", value: movieDetail.actors ?? "N/A")
        let plot = configureMovieDetailContainerStyle(header: "Plot:", value: movieDetail.plot ?? "N/A")
        let language = configureMovieDetailContainerStyle(header: "Language:", value: movieDetail.language ?? "N/A")
        let country = configureMovieDetailContainerStyle(header: "Country:", value: movieDetail.country ?? "N/A")
        let awards = configureMovieDetailContainerStyle(header: "Awards:", value: movieDetail.awards ?? "N/A")
        let ratings = configureMovieDetailContainerStyle(header: "Ratings:", value: movieDetail.ratings ?? "N/A")
        let metascore = configureMovieDetailContainerStyle(header: "Metascore:", value: movieDetail.metascore ?? "N/A")
        let imdbRating = configureMovieDetailContainerStyle(header: "ImdbRating:", value: movieDetail.imdbRating ?? "N/A")
        let imdbVotes = configureMovieDetailContainerStyle(header: "ImdbVotes:", value: movieDetail.imdbVotes ?? "N/A")
        let imdbID = configureMovieDetailContainerStyle(header: "ImdbID:", value: movieDetail.imdbID ?? "N/A")
        let type = configureMovieDetailContainerStyle(header: "type:", value: movieDetail.type ?? "N/A")
        let dvd = configureMovieDetailContainerStyle(header: "DVD:", value: movieDetail.dvd ?? "N/A")
        let boxOffice = configureMovieDetailContainerStyle(header: "BoxOffice:", value: movieDetail.boxOffice ?? "N/A")
        let production = configureMovieDetailContainerStyle(header: "Production:", value: movieDetail.production ?? "N/A")
        let website = configureMovieDetailContainerStyle(header: "Website:", value: movieDetail.website ?? "N/A")
        
        let movieDetailViews = [year,
                                rated,
                                released,
                                runtime,
                                genre,
                                director,
                                writer,
                                actors,
                                plot,
                                language,
                                country,
                                awards,
                                ratings,
                                metascore,
                                imdbRating,
                                imdbID,
                                imdbVotes,
                                type,
                                dvd,
                                boxOffice,
                                production,
                                website]
        
        mainContainer.addArrangedSubviews(movieDetailViews)
        makeMovieDetailConstraints(movieDetailViews)
    }
    
    private func makeMovieDetailConstraints(_ views: [UIView]) {
        views.forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
            }
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
