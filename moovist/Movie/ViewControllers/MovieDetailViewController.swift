//
//  MovieDetailViewController.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation
import UIKit

final class MovieDetailViewController: BaseViewController {
	
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var favoriteButton: UIBarButtonItem!
	
	// MARK: - Properties
	
	var viewModel: MovieDetailViewModel?
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.viewModel?.delegate = self
		self.viewModel?.updateView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	// MARK: - Actions
	@IBAction private func favoriteButtonAction(_ sender: UIBarButtonItem) {
		
		self.viewModel?.makeFavorite()
	}
}

extension MovieDetailViewController: MovieDetailViewDelegate {
	
	func viewUpdate(_ movieModel: MovieModel) {
		
		self.title = movieModel.title
		self.descriptionLabel.text = movieModel.overview
		self.titleLabel.text = movieModel.title
		self.imageView.setImage(from: movieModel.backdropImage ?? "", contentMode: .scaleAspectFill)
		self.updateStar(movieModel.isFavorite)
	}
	
	func updateStar(_ isFavorite: Bool) {
		if (isFavorite) {
			self.favoriteButton.title = "★"
		}
		else {
			self.favoriteButton.title = "☆"
		}
	}
}
