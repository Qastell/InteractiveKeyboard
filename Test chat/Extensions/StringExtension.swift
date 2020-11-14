//
//  StringExtension.swift
//  101group
//
//  Created by Max Petrenko on 30.11.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func prependingImage(_ image: UIImage, yOffset: CGFloat, spaces: String, spacesBefore: String = "") -> NSMutableAttributedString {
        let newText = "".attributed(attributes(at: 0, effectiveRange: nil))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: CGPoint(x: 0, y: yOffset), size: attachment.image!.size)
        newText.append(NSAttributedString(string: spacesBefore))
        newText.append(NSAttributedString(attachment: attachment))
        newText.append(NSAttributedString(string: spaces))
        newText.append(self)
        return newText
    }

    func appendingImage(_ image: UIImage, yOffset: CGFloat = -2, spaces: String = "") -> NSMutableAttributedString {
        let newText = NSMutableAttributedString(attributedString: self)
        newText.append(NSAttributedString(string: spaces))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: CGPoint(x: 0, y: yOffset), size: attachment.image!.size)
        newText.append(NSAttributedString(attachment: attachment))
        return newText
    }

    func settingDigitsFont(font: UIFont) -> NSMutableAttributedString? {
        let attrs = attributes(at: 0, effectiveRange: nil)
        guard attrs.contains(where: { $0.key == NSAttributedString.Key.font }) else { return nil }
        let newAttributedString = NSMutableAttributedString()
        let decimalDigitsSet = CharacterSet.decimalDigits
        var digitAttrs = attrs
        digitAttrs[NSAttributedString.Key.font] = font

        string.unicodeScalars.forEach { letter in
            let myLetter: NSAttributedString
            if decimalDigitsSet.contains(letter) {
                myLetter = NSAttributedString(string: "\(letter)", attributes: digitAttrs)
            } else {
                myLetter = NSAttributedString(string: "\(letter)", attributes: attrs)
            }
            newAttributedString.append(myLetter)
        }
        return newAttributedString
    }
}

extension NSMutableAttributedString {
    func asImage(size: CGSize = CGSize(width: 44, height: 44)) -> UIImage {
        let rect = boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil)

        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(at: CGPoint(x: (size.width - rect.width) / 2, y: (size.height - rect.height) / 2))
        }
    }

    func setAttributes(_ attrs: [NSAttributedString.Key: Any], for substring: String) {
        if let swiftRange = string.range(of: substring) {
            setAttributes(attrs, range: string.nsRange(from: swiftRange))
        }
    }
}

extension Optional where Wrapped == String {
    var isNotEmpty: Bool {
        switch self {
        case .none:
            return false
        case .some(let string):
            return !string.isEmpty
        }
    }
}

extension String {
    func roundedImage(attributes: [NSAttributedString.Key: Any], spaces: String) -> NSTextAttachment {
        let text = spaces + self + spaces
        var size = text.size(withAttributes: attributes)
        size = CGSize(width: ceil(size.width), height: ceil(size.height))
        let attachment = NSTextAttachment()
        attachment.image = UIGraphicsImageRenderer(size: size).image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: size.height / 2).addClip()
            text.draw(in: rect, withAttributes: attributes)
        }
        attachment.bounds = CGRect(origin: .zero, size: size)
        return attachment
    }

    var removingExtension: String {
        replacingOccurrences(of: ".jpg", with: "")
        .replacingOccurrences(of: ".pdf", with: "")
    }

    var isLikeUUID: Bool {
        removingExtension.count == 36 &&
        !removingExtension.contains { Character(extendedGraphemeClusterLiteral: $0).isLowercase }
    }

    var instagramUsername: String {
        return replacingOccurrences(of: "https://www.instagram.com/", with: "")
        .replacingOccurrences(of: "https://instagram.com/", with: "")
        .replacingOccurrences(of: "instagram.com/", with: "")
    }

    var abbreviation: String {
        return self
            .replacingOccurrences(of: "ООО ", with: "")
            .replacingOccurrences(of: "ИП ", with: "")
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
//            .split(separator: " ")
            .compactMap { $0.isEmpty ? nil : String($0.first!) }
            .prefix(2)
            .reversed()
            .joined()
            .uppercased()
    }

	var isNotEmpty: Bool { return !isEmpty }

    var double: Double? {
        return NumberFormatter.decimalWithSpaces.number(from: replacingOccurrences(of: ".", with: ","))?.doubleValue
    }

	var formattedPhoneNumber: String? {
		var array = [String]()
		let digits = digitsOnly

		digits.enumerated().forEach { index, value in
			let string: String = String(value)

			if digits.count == 12 {
				switch index {
				case 0:
					array.append("+" + string)
				case 1:
					array.append(string + " (")
				case 4:
					array.append(string + ") ")
				case 8, 10:
					array.append("-" + string)
				default:
					array.append(string)
				}
			} else {
				switch index {
				case 0:
					array.append("+" + string + " (")
				case 3:
					array.append(string + ") ")
				case 7, 9:
					array.append("-" + string)
				default:
					array.append(string)
				}
			}
		}
		return array.isNotEmpty ? array.joined() : nil
	}

	var digitsOnly: String {
		return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
	}
}

public extension String {
	var firstUppercased: String {
		guard let first = first else { return "" }
		return String(first).uppercased() + dropFirst()
	}

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var ruLocalized: String? {
        guard let path = Bundle.main.path(forResource: "ru", ofType: "lproj"),
            let bundle = Bundle(path: path) else { return nil }

        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }

    func attributed(_ attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: attributes)
    }

	var isValidEmail: Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self)
	}

	var data: Data { return Data(utf8) }
	var base64Encoded: Data { return data.base64EncodedData() }
	var base64Decoded: Data? { return Data(base64Encoded: self) }
}

extension StringProtocol where Index == String.Index {
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

struct StringAttributes {
	let regularBlack: [NSAttributedString.Key: Any] = [.font: UIFont.grp10, .foregroundColor: UIColor.grpBlack]
	let regularDark: [NSAttributedString.Key: Any] = [.font: UIFont.grp10, .foregroundColor: UIColor.grpDarkGrey]
	let semiboldBlack: [NSAttributedString.Key: Any] = [.font: UIFont.grpSemi10, .foregroundColor: UIColor.grpBlack]
	let regularSmallDark: [NSAttributedString.Key: Any]
    let semi13White: [NSAttributedString.Key: Any]

	init() {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineHeightMultiple = 1.2

        semi13White = [.font: UIFont.grpSemi13,
                       .foregroundColor: UIColor.grpWhiteBlack,
                       .paragraphStyle: paragraphStyle.copy()]

		paragraphStyle.tabStops.forEach { paragraphStyle.removeTabStop($0) }
		paragraphStyle.addTabStop(NSTextTab(textAlignment: .right, location: 356.0, options: [:]))

		regularSmallDark = [.font: UIFont.grp7,
							.foregroundColor: UIColor.grpDarkGrey,
							.paragraphStyle: paragraphStyle]
	}
}
