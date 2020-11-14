//
//  UIViewSafeArea.swift
//  PhotoChat
//
//  Created by Alexey Nikiforov on 01.09.2020.
//  Copyright © 2020 Yuri Kudrinetskiy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {

    var safeArea: ConstraintBasicAttributesDSL {

        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }
}
