//
//  UIStoryboardExtension.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/23.
//

import UIKit

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as? T
    }
}
