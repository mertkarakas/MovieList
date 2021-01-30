//
//  TopViewControllerExtension.swift
//  moovist
//
//  Created by Mert KARAKAŞ on 30.01.2021.
//

import Foundation
import UIKit

public extension UIApplication {
	
	class func getTopViewController() -> UIViewController? {
		let rootViewController = UIApplication.shared.windows[0].rootViewController
		
		if let rootViewController: UINavigationController = rootViewController as? UINavigationController {
			if let topViewController = rootViewController.topViewController  {
				return topViewController
			}
		}
		return nil
	}
}
