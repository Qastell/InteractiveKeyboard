//
//  FormatterExtension.swift
//  101group
//
//  Created by max on 16.01.2018.
//  Copyright © 2018 101 GROUP. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dd．MM．yyyy_HH_mm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()

    static let dd．MM．yy_HH_mm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm"
        return formatter
    }()

    static let H_mm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter
    }()

	static let dd．MM．yyyy: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		return formatter
	}()

	static let dd．MM．yy: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yy"
		return formatter
	}()

	static let d_MMMM_yyyy: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "d MMMM yyyy"
		return formatter
	}()
}

extension NumberFormatter {
	static let decimalWithSpaces: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.groupingSeparator = " "
		formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
		return formatter
	}()
}

extension Decimal {
    var stringWithSpaces: String {
        return NumberFormatter.decimalWithSpaces.string(for: self) ?? ""
    }
}

extension BinaryInteger {
	var stringWithSpaces: String {
		return NumberFormatter.decimalWithSpaces.string(for: self) ?? ""
	}
}

extension Double {
    var stringWithSpaces: String {
        return NumberFormatter.decimalWithSpaces.string(for: self) ?? ""
    }
}
