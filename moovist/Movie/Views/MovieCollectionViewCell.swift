//
//  MovieCollectionViewCell.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation
import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet private weak var starLabel: UILabel!
	
	// MARK: - Privates
	
	private var task: URLSessionDataTask?
	
	// MARK: - Cell Reuse
	
	override func prepareForReuse() {
		
		/* Prevent task resumes when cell reuse */
		
		task?.cancel()
		task = nil
		self.imageView.image = nil
	}
	
	// MARK: - Configure
	
	public func configureCell(imageLink: String?, title: String?, isFavorite: Bool) {
		self.starLabel.isHidden = !isFavorite
		self.titleLabel.text = title
		if self.task == nil {
			self.task = self.imageView.setImage(from: imageLink ?? "", contentMode: .scaleAspectFill)
		}
	}
}
