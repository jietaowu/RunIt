//
//  SearchBarHeaderView.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class SearchBarHeaderView: UIView {

    let searchBar = UISearchBar()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    

        searchBar.placeholder = "搜索"
        
        
    
        addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
