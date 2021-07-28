//
//  Pageable.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

import Foundation
import CoreGraphics

protocol Pageable {
    var isEnd: Bool { get }
    func nextPage(current: Int) -> Int
}

protocol PageableImageInfo: Pageable {
    var imageMetaDatas: [ImageMetaData] { get }
}

protocol ImageMetaData: Encodable {
    var imageUrl: String? { get }
    var thumbnailUrl: String? { get }
    var imageSize: CGSize? { get }
}
