//
//  FormValidation.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 14/06/2019.
//  Copyright © 2019 101 GROUP. All rights reserved.
//

import Eureka

extension Form {
	func validateURL(value: String?, errorMessage: String) -> ValidationError? {
		guard let value = value, value.isNotEmpty else { return ValidationError(msg: errorMessage) }
		let predicate = NSPredicate(format: "SELF MATCHES %@", RegExprPattern.URL.rawValue)
		guard predicate.evaluate(with: value) else { return ValidationError(msg: errorMessage) }
		return nil
	}
}
