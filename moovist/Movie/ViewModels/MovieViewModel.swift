//
//  MovieViewModel.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation

final class MovieViewModel {
	
	// Properties
	
	private var movies: [MovieModel] = []
	private var currentPage: Int = 0
	private var totalPage: Int = -1
	private var lastSelectedItemIndex = -1
	
	// Delegate
	
	var delegate: MovieViewDelegate?
	
	// MARK: - VM Methods
	
	func loadMovies() {
		// Fetch movies
		if currentPage != totalPage {
			self.getPopularMovies()
		}
	}
	
	func updateModel() {
		
		if lastSelectedItemIndex < 0 {
			return
		}
		
		self.movies[lastSelectedItemIndex].isFavorite = self.updateFavoriteByMovieId(self.movies[lastSelectedItemIndex].id)
		self.delegate?.modelUpdate(self.movies[lastSelectedItemIndex])
	}
	
	func getPopularMovies() {
		
		// If fetching the last page.
		if currentPage == totalPage - 1 {
			self.delegate?.canLoadMore(false)
		}
		
		Services.getPopularMovies(page: currentPage + 1) { [weak self] (result) in
			switch result {
			case .success(let response):
				guard let results = response.results else {
					return
				}
				let movieModel = results.map({ return MovieModelMapper.map(model: $0) })
				self?.movies.append(contentsOf: movieModel)
				self?.currentPage = response.page
				self?.totalPage = response.totalPages
				self?.delegate?.viewUpdate(self?.movies ?? [])
				break
			case .failure(let error):
				self?.delegate?.showMessage(nil, message: error.statusMessage ?? error.localizedDescription)
				break
			}
		}
	}
	
	func didItemSelected(_ movie: MovieModel) {
		
		if let movieIndex = self.movies.firstIndex(where: { $0.id == movie.id }) {
			self.lastSelectedItemIndex = movieIndex
		}
		Services.getMovieById(id: movie.id) { [weak self] result in
			switch result {
			case .success(let response):
				DispatchQueue.main.async {
					let mappedModel = MovieModelMapper.map(model: response)
					self?.delegate?.goToDetail(with: mappedModel)
				}
				break
			case .failure(let error):
				self?.delegate?.showMessage(nil, message: error.statusMessage ?? error.localizedDescription)
				break
			}
		}
	}
	
	func searchItem(_ text: String?) {
		
		guard let text = text else {
			return
		}
		if text == "" {
			self.delegate?.canLoadMore(true)
			self.delegate?.viewUpdate(movies)
			return
		}
		let filteredMovies: [MovieModel] = self.movies.filter({ $0.title?.lowercased().contains(text.lowercased()) != false })
		
		self.delegate?.canLoadMore(false)
		self.delegate?.viewUpdate(filteredMovies)
	}
	
	func clearListAndRefresh() {
		
		self.movies.removeAll()
		self.currentPage = 0
		self.loadMovies()
	}
	
	func updateFavoriteByMovieId(_ movieId: Int) -> Bool {
		return UserDefaultsManager.shared.isFavorite(id: movieId)
	}
}
