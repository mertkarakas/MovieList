//
//  ServiceErrorModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

enum ErrorKey: String {
	case general = "Something went wrong"
	case parse = "Parse error!"
}

class ServiceErrorModel: Error {
	
	// MARK: - Properties
	
	var statusMessage: String?
	
	//{"success":false,"status_code":34,"status_message":"The resource you requested could not be found."}
	
	init(_ message: String) {
		self.statusMessage = message
	}
}

// MARK: - Public Functions

extension ServiceErrorModel {
	
	class func generalError() -> ServiceErrorModel {
		return ServiceErrorModel(ErrorKey.general.rawValue)
	}
	class func parserError() -> ServiceErrorModel {
		return ServiceErrorModel(ErrorKey.parse.rawValue)
	}
}
