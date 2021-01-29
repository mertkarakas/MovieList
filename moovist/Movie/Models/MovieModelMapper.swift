//
//  MovieModelMapper.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

final class MovieModelMapper {
	
	static func map(model: MovieResultModel) -> MovieModel {
		
		var movieModel: MovieModel = .init()
		
		movieModel.id = model.id
		movieModel.title = model.title
		movieModel.overview = model.overview
		movieModel.voteCount = model.voteCount ?? 0
		movieModel.isFavorite = UserDefaultsManager.shared.isFavorite(id: model.id)
		movieModel.image = "\(ServiceConstants.imageBaseUrl)\(model.posterPath ?? "")"
		movieModel.backdropImage = "\(ServiceConstants.backdropImageBaseUrl)\(model.backdropImage ?? "")"
		return movieModel
	}
}
