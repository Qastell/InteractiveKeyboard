//
//  String+HighlightText.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 20.12.16.
//  Copyright © 2016 Yuri Kudrinetskiy. All rights reserved.
//

import UIKit

//extension NSMutableAttributedString {
//    func highlighting(_ aString: String) -> NSMutableAttributedString {
//        let highlightColor = UIColor.grpDynamicAccent.withAlphaComponent(0.2)
//
//        aString.components(separatedBy: .whitespaces).forEach { term in
//            guard term.isNotEmpty else { return }
//            string.matches(for: term).forEach { addAttribute(.backgroundColor, value: highlightColor, range: $0.range) }
//        }
//        return self
//    }
//}

extension String {
//    func highlighting(_ aString: String) -> NSAttributedString {
//        return NSMutableAttributedString(string: self).highlighting(aString)
//    }

    func matches(for regex: String) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))
            return results
        } catch {
            debugPrint("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
