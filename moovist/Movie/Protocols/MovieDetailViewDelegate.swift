//
//  MovieDetailViewDelegate.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

protocol MovieDetailViewDelegate {
	
	func viewUpdate(_ movieDetailModel: MovieModel)
	func updateStar(_ isFavorite: Bool)
}
