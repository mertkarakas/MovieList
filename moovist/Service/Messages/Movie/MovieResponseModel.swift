//
//  MovieResponseModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

struct MovieResponseModel: Codable {
	
	var results: [MovieResultModel]?
	var page: Int = 0
	var totalPages: Int = 0
	var totalResults: Int = 0
}

struct MovieResultModel: Codable {
	
	var id: Int = 0
	var title: String?
	var overview: String?
	var posterPath: String?
	var backdropImage: String?
	var voteCount: Int?
}

extension MovieResponseModel {
	
	private enum CodingKeys: String, CodingKey {
		
		case results
		case page
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}

extension MovieResultModel {
	
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case posterPath = "poster_path"
		case backdropImage = "backdrop_path"
		case voteCount = "vote_count"
	}
}
