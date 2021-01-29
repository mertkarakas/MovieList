//
//  MovieDetailViewModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

final class MovieDetailViewModel {
	
	private var movieModel: MovieModel!
	
	// Delegate
	
	var delegate: MovieDetailViewDelegate?
	
	// MARK: - initialize VM
	
	init(detail: MovieModel) {
		self.movieModel = detail
	}
	
	// MARK: - VM Methods
	
	func updateView() {
		
		self.delegate?.viewUpdate(self.movieModel)
	}
	
	func makeFavorite() {
		
		if (self.movieModel.isFavorite) {
			UserDefaultsManager.shared.removeObject(id: self.movieModel.id)
			self.movieModel.isFavorite = false
		}
		else {
			UserDefaultsManager.shared.insertObject(id: self.movieModel.id)
			self.movieModel.isFavorite = true
		}
		self.delegate?.updateStar(self.movieModel.isFavorite)
		print(UserDefaults.favoriteList)
	}
}
