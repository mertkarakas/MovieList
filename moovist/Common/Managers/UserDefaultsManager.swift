//
//  UserDefaultsManager.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 27.01.2021.
//

import Foundation

final class UserDefaultsManager {
	
	// MARK: - Properties
	
	public static let shared: UserDefaultsManager = UserDefaultsManager()
	
	// MARK: - Methods
	
	func isFavorite(id: Int) -> Bool {
		if let list = UserDefaults.favoriteList as? [Int] {
			if let _ = list.firstIndex(where: {$0 == id}) {
				return true
			}
			return false
		}
		return false
	}
	
	func insertObject(id: Int) {
		if var list = UserDefaults.favoriteList as? [Int] {
			list.append(id)
			UserDefaults.favoriteList = list
		}
		else {
			UserDefaults.favoriteList = [id]
		}
	}
	
	func removeObject(id: Int) {
		if let list = UserDefaults.favoriteList as? [Int] {
			let filteredList = list.filter({$0 != id})
			UserDefaults.favoriteList = filteredList
		}
	}
}
