//
//  MovieViewDelegate.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation

protocol MovieViewDelegate {
	
	func viewUpdate(_ movies: [MovieModel])
	func modelUpdate(_ movie: MovieModel)
	func showMessage(_ title: String?, message: String?)
	func canLoadMore(_ canLoadMore: Bool)
	func goToDetail(with movie: MovieModel)
}
