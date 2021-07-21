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
}

protocol PageableImageInfo: Pageable {
    var imageMetaDatas: [ImageMetaData]? { get }
}

protocol ImageMetaData {
    var imageUrl: String? { get }
    var thumbnailUrl: String? { get }
    var imageSize: CGSize? { get }
}
