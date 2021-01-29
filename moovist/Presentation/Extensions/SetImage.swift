//
//  SetImage.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 26.01.2021.
//

import Foundation
import UIKit

public extension UIImageView {
	
	@discardableResult
	func setImage(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) -> URLSessionDataTask? {
		contentMode = mode
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
			else { return }
			DispatchQueue.main.async() { [weak self] in
				self?.image = image
			}
		}
		task.resume()
		return task
	}
	
	@discardableResult
	func setImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) -> URLSessionDataTask? {
		guard let url = URL(string: link) else { return nil }
		return setImage(from: url, contentMode: mode)
	}
}
