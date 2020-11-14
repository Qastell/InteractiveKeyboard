//
//  UIImageView.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 07.04.2020.
//  Copyright © 2020 Yuri Kudrinetskiy. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(urlString: String, placeholderImage: UIImage? = nil) {
        guard let url = URL(string: urlString) else { return }

        af_setImage(withURL: url, imageTransition: .crossDissolve(0.2)) { image in
            if placeholderImage != nil, self.image == nil {
                self.contentMode = .center
                self.image = placeholderImage
            }
        }
    }
}
