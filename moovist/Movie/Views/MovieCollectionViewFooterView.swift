//
//  MovieCollectionViewFooterView.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation
import UIKit

typealias LoadMoreButtonHandler = () -> Void

final class MovieCollectionViewFooterView: UICollectionReusableView {
	
	// MARK: - Properties
	
	private var buttonTapped: LoadMoreButtonHandler?
	
	// MARK: - Configure
	
	public func configureFooter(buttonTapped: @escaping LoadMoreButtonHandler) {
		self.buttonTapped = buttonTapped
	}
	
	// MARK: - Action
	
	@IBAction func loadMoreButtonAction(_ sender: UIButton) {
		self.buttonTapped?()
	}
}
