//
//  MoviesListView.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import SnapKit

class MoviesListView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 170.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView()
        tableView.register(MoviesTableViewCell.self,
                           forCellReuseIdentifier: String(describing: MoviesTableViewCell.self))
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .orange
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return indicator
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func startLoading() {
        loadingIndicator.center = self.center
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }

}
