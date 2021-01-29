//
//  BaseViewController.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 28.01.2021.
//

import Foundation
import UIKit

public class BaseViewController: UIViewController {
	
	public func showAlert(with title:String?, message:String?) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
		
		alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
		{ action -> Void in
		})
		self.present(alertController, animated: true, completion: nil)
	}
}
