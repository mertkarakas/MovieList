//
//  GridFlowLayout.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation
import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
	
	// MARK: - Constants
	
	let itemHeight: CGFloat = 250
	
	// MARK: - Initialize
	
	override init() {
		super.init()
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
	
	func setupLayout() {
		minimumInteritemSpacing = 1
		minimumLineSpacing = 1
		scrollDirection = .vertical
	}
	
	var itemWidth: CGFloat {
		return collectionView!.frame.width / 2 - 1
	}
	
	override var itemSize: CGSize {
		set {
			self.itemSize = CGSize(width: itemWidth, height: itemHeight)
			
		}
		get {
			return CGSize(width: itemWidth, height: itemHeight)
		}
	}
	
	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
		return collectionView!.contentOffset
	}
}

