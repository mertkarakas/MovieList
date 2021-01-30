//
//  BaseViewController.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 28.01.2021.
//

import Foundation
import UIKit

public class BaseViewController: UIViewController {
	
	private var indicatorView: UIView?
		
	public func showAlert(with title:String?, message:String?) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
		
		alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
		{ action -> Void in
		})
		self.present(alertController, animated: true, completion: nil)
	}
	
	func showLoading() {
		
		if self.indicatorView != nil {
			return
		}
		
		let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
		backgroundView.backgroundColor = UIColor.black
		backgroundView.alpha = 0.5
		
		var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
		activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
		activityIndicator.center = self.view.center
		activityIndicator.hidesWhenStopped = true
		activityIndicator.style = .medium
		activityIndicator.startAnimating()
		self.view.isUserInteractionEnabled = false
		
		backgroundView.addSubview(activityIndicator)
		self.indicatorView = backgroundView
		self.view.addSubview(self.indicatorView!)
	}
	
	func hideLoading() {
		
		if self.indicatorView != nil {
			self.indicatorView?.removeFromSuperview()
			self.indicatorView = nil
			self.view.isUserInteractionEnabled = true
		}
	}
}
