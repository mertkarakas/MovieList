//
//  MovieViewController.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation
import UIKit

final class MovieViewController: BaseViewController {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var layoutBarButton: UIBarButtonItem!
	@IBOutlet private weak var searchBar: UISearchBar!
	@IBOutlet private weak var searchBarTopConstraint: NSLayoutConstraint!
	
	// MARK: - Constants
	
	private let footerReuseIdentifier = "CollectionViewFooter"
	private let headerReuseIdentifier = "CollectionViewHeader"
	private let movieDetailSegueIdentifier = "goMovieDetail"
	private let movieCollectionCellClass = "MovieCollectionViewCell"
	private let movieSearchReusableView = "MovieSearchCollectionReusableView"
	private let movieFooterView = "MovieCollectionViewFooterView"
	private let movieCellIdentifier = "movieCell"
	private let searchBarTopConstraintConstant: CGFloat = 8
	private let animationDuration: Double = 0.2
	
	// MARK: - Properties
	
	private var isLoadMore: Bool = true
	private lazy var viewModel: MovieViewModel = {
		return MovieViewModel()
	}()
	private var isGridLayout: Bool = true {
		didSet {
			updateLayout()
		}
	}
	private var movies: [MovieModel] = []
	
	// MARK: - Life cycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set navigation title
		self.title = MovieConstants.movieTitle
		
		// update model
		self.viewModel.updateModel()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set delegates
		self.viewModel.delegate = self
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		self.searchBar.delegate = self
		self.searchBar.enablesReturnKeyAutomatically = false
		
		// Prepare UI
		self.prepareUI()
		
		// Load popular movies
		self.viewModel.loadMovies()
	}
	
	// MARK: - UI
	
	private func prepareUI() {
		
		// Register cell
		let nib = UINib(nibName: self.movieCollectionCellClass, bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: self.movieCellIdentifier)
		
		// Set layout
		self.updateLayout()
		
		// Hide search bar on load
		self.setSearchBarTopConstraint()
	}
	
	private func setSearchBarTopConstraint() {
		
		if self.searchBarTopConstraint.constant < 0 {
			self.searchBarTopConstraint.constant = self.searchBarTopConstraintConstant
			self.searchBar.becomeFirstResponder()
		}
		else {
			if self.searchTextExists() {
				self.searchBar.becomeFirstResponder()
				return
			}
			self.searchBarTopConstraint.constant = -1 * self.searchBar.frame.height
			self.view.endEditing(true)
		}
	}
	
	private func searchTextExists() -> Bool{
		if let text = self.searchBar.text {
			if text.count > 0 {
				return true
			}
			else {
				return false
			}
		}
		return false
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.collectionView.collectionViewLayout.invalidateLayout()
	}
	
	private func updateLayout() {
		let layout = self.isGridLayout ? GridFlowLayout() : ListFlowLayout()
		UIView.animate(withDuration: self.animationDuration) { () -> Void in
			self.collectionView.reloadData()
			self.collectionView.collectionViewLayout.invalidateLayout()
			self.collectionView.setCollectionViewLayout(layout, animated: true)
		}
	}
	
	// Collection View reload data
	
	private func reloadCollectionView() {
		
		self.collectionView.reloadData()
	}
	
	// MARK: - Actions
	
	@IBAction func layoutButtonAction(_ sender: UIBarButtonItem) {
		// Switch layout
		if self.isGridLayout {
			self.layoutBarButton.title = "[][]"
			self.isGridLayout = false
		}
		else {
			self.layoutBarButton.title = "[=]"
			self.isGridLayout = true
		}
	}
	
	@IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
		self.setSearchBarTopConstraint()
	}
	
	// MARK: - Prepare Segue
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == self.movieDetailSegueIdentifier {
			let detailViewController = segue.destination as! MovieDetailViewController
			let movieModel = sender as! MovieModel
			let detailViewModel = MovieDetailViewModel(detail: movieModel)
			detailViewController.viewModel = detailViewModel
		}
	}
}

// MARK: - Movie View Delegate

extension MovieViewController: MovieViewDelegate {
	
	func viewUpdate(_ movies: [MovieModel]) {
		self.movies = movies
		DispatchQueue.main.async {
			self.reloadCollectionView()
		}
	}
	
	func modelUpdate(_ movie: MovieModel) {
		
		if let index = self.movies.firstIndex(where: {$0.id == movie.id}) {
			self.movies[index] = movie
			self.reloadCollectionView()
		}
	}
	
	func goToDetail(with movie: MovieModel) {
		self.performSegue(withIdentifier: self.movieDetailSegueIdentifier, sender: movie)
	}
	
	func canLoadMore(_ canLoadMore: Bool) {
		self.isLoadMore = canLoadMore
	}
	
	func showMessage(_ title: String?, message: String?) {
		DispatchQueue.main.async {
			self.showAlert(with: title, message: message)
		}
	}
}

// MARK: - CollectionView Delegates

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		self.movies.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.movieCellIdentifier, for: indexPath) as! MovieCollectionViewCell
		
		let movieAtIndex = self.movies[indexPath.row]
		cell.imageView.image = nil
		cell.configureCell(imageLink: self.isGridLayout ? movieAtIndex.image : movieAtIndex.backdropImage,
						   title: movieAtIndex.title,
						   isFavorite: movieAtIndex.isFavorite)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		if kind == UICollectionView.elementKindSectionFooter {
			// register footer view
			let footerNib = UINib(nibName: self.movieFooterView, bundle: nil)
			self.collectionView.register(footerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerReuseIdentifier)
			
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.footerReuseIdentifier, for: indexPath) as! MovieCollectionViewFooterView
			footerView.isHidden = self.isLoadMore ? false : true
			footerView.configureFooter {
				
				self.viewModel.loadMovies()
			}
			
			return footerView
		}
		return UICollectionReusableView()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let movie = self.movies[indexPath.row]
		self.viewModel.didItemSelected(movie)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		
		return CGSize(width: self.collectionView.frame.width, height: 50.0)
	}
}

// MARK: - Search Bar Delegate

extension MovieViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
		self.viewModel.searchItem(searchText)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		self.searchBar.resignFirstResponder()
	}
}

// MARK: - ScrollView Delegate

extension MovieViewController: UIScrollViewDelegate {
	
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		
		let currentOffset = scrollView.contentOffset.y
		let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
		
		// Hide / Show search bar when scrolling
		
		if currentOffset > 100 {
			
			if searchTextExists() {
				return
			}
			UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut) {
				self.searchBarTopConstraint.constant = -1 * self.searchBar.frame.height
				self.view.layoutIfNeeded()
			} completion: { [weak self] _ in
				self?.view.endEditing(true)
			}
		}
		else if currentOffset < 50 {
			
			UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseIn) {
				self.searchBarTopConstraint.constant = self.searchBarTopConstraintConstant
				self.view.layoutIfNeeded()
			}
		}
		
		// Load more automatically if scroll offset high
		if (currentOffset >= maximumOffset + self.searchBar.frame.height) && self.isLoadMore {
			
			self.viewModel.loadMovies()
		}
	}
}
