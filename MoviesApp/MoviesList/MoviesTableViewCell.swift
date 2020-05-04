//
//  MoviesTableViewCell.swift
//  MoviesApp
//
//  Created by    on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var chervon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chevron"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        
        addSubview(poster)
        poster.snp.makeConstraints {
            $0.width.height.equalTo(120)
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(25)
            $0.bottom.equalToSuperview().inset(25)
        }
        
        addSubview(chervon)
        chervon.snp.makeConstraints {
            $0.width.height.equalTo(15)
            $0.centerY.equalTo(poster)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.top.bottom.equalTo(poster)
            $0.leading.equalTo(poster.snp.trailing).offset(10)
            $0.trailing.equalTo(chervon.snp.leading).offset(-10)
        }
        
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func prepareCell(with title: String) {
        self.title.text = title
        self.poster.image = UIImage(named: "placeHolder")
    }
    
    func updatePoster(with image: UIImage?) {
        guard let image = image else { return }
        self.poster.image = image
    }
}
