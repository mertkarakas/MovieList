//
//  Services.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

class Services {
	
	class func getPopularMovies(page: Int, completion: @escaping(Swift.Result<MovieResponseModel, ServiceErrorModel>) -> Void) {
		ServiceManager.shared.sendRequest(request: PopularMovieRequestModel(page: page)) { (result) in
			completion(result)
		}
	}
	
	class func getMovieById(id: Int, completion: @escaping(Swift.Result<MovieResultModel, ServiceErrorModel>) -> Void) {
		ServiceManager.shared.sendRequest(request: GetMovieByIdRequestModel(id: id)) { (result) in
			completion(result)
		}
	}
}
