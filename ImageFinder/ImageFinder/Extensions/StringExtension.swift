//
//  StringExtension.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/23.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
