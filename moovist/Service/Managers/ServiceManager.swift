//
//  ServiceManager.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

final class ServiceManager {
	
	// MARK: - Properties
	
	public static let shared: ServiceManager = ServiceManager()
}

// MARK: - Public Functions

extension ServiceManager {
	
	func sendRequest<T: Codable>(request: BaseRequestModel, completion: @escaping(Swift.Result<T, ServiceErrorModel>) -> Void) {
		
		URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
			guard let data = data, var responseModel = try? JSONDecoder().decode(BaseResponseModel<T>.self, from: data) else {
				completion(Result.failure(ServiceErrorModel(ErrorMessagesConstants.mapModelError)))
				return
			}
			
			responseModel.rawData = data
			
			if let data = responseModel.data {
				completion(Result.success(data))
			} else {
				completion(Result.failure(responseModel.error))
			}
		
		}.resume()
	}
}
