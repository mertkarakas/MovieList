//
//  PopularMovieRequestModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

final class PopularMovieRequestModel: BaseRequestModel {
	
	var page: Int = 0
	
	init(page: Int) {
	   self.page = page
   }
	
	override var parameters: [String : Any] {
		return ["page" : "\(page)"]
	}
	
	override var path: String {
		return "/movie/popular"
	}
}
