//
//  BaseResponseModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

struct BaseResponseModel<T: Codable>: Codable {
	
	// MARK: - Properties
	
	var rawData: Data?
	var statusMessage: String?
	var error: ServiceErrorModel {
		return ServiceErrorModel(statusMessage ?? "")
	}
	var data: T? {
		guard let rawData = rawData else { return nil }
		let data = try? JSONDecoder().decode(T.self, from: rawData)
		if data != nil {
			return data
		}
		return nil
	}
	
	init(from decoder: Decoder) throws {
		let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)

		statusMessage = (try? keyedContainer.decode(String.self, forKey: CodingKeys.statusMessage)) ?? ""

	}
}

extension BaseResponseModel {
	
	private enum CodingKeys: String, CodingKey {
		case statusMessage = "status_message"
	}
}


