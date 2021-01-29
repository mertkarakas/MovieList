//
//  MovieModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation

struct MovieModel {
	
	var id: Int = 0
	var title: String?
	var overview: String?
	var image: String?
	var backdropImage: String?
	var voteCount: Int = 0
	var isFavorite: Bool = false
}

