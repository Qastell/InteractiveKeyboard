//
//  UISearchBarExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 23.07.2020.
//  Copyright © 2020 Yuri Kudrinetskiy. All rights reserved.
//

import UIKit

class WhiteTextSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(#imageLiteral(resourceName: "ic_search"), for: .search, state: .normal)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setImage(#imageLiteral(resourceName: "ic_search"), for: .search, state: .normal)
    }
}

class BlackTextSearchBar: UISearchBar { }
