//
//  CodableExtension.swift
//  101group
//
//  Created by Max Petrenko on 04.12.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//

import Foundation

public extension Encodable {
	var dictionary: [String: Any]? {
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .secondsSince1970
		guard let data = try? encoder.encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
	}
}

//public extension JSONDecoder {
//	func decodeAPIError(from data: Data) throws -> APIError {
//  		var error = try decode(APIError.self, from: data)
//		let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//		error.code = dict?.keys.first
//		return error
//	}
//}
