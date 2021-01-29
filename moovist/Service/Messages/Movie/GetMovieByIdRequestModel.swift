//
//  GetMovieByIdRequestModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

final class GetMovieByIdRequestModel: BaseRequestModel {
	
	var id: Int = 0
	
	 init(id: Int) {
		self.id = id
	}
	override var path: String {
		return "/movie/\(id)"
	}
}
