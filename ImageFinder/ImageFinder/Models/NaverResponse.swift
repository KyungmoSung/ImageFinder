//
//  NaverResponse.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

import Foundation
import CoreGraphics

// MARK: - NaverResponse
struct NaverResponse: Codable {
    let lastBuildDate: String?
    let total: Int?
    let start: Int?
    let display: Int?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case lastBuildDate = "lastBuildDate"
        case total = "total"
        case start = "start"
        case display = "display"
        case items = "items"
    }
}

extension NaverResponse: PageableImageInfo {
    var imageMetaDatas: [ImageMetaData]? {
        return items
    }
    
    var isEnd: Bool {
        guard let total = total, let start = start, let display = display else {
            return true
        }
        
        return total <= (start + display - 1)
    }
}

// MARK: - Item
struct Item: Codable {
    let title: String?
    let link: String?
    let thumbnail: String?
    let sizeheight: String?
    let sizewidth: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case link = "link"
        case thumbnail = "thumbnail"
        case sizeheight = "sizeheight"
        case sizewidth = "sizewidth"
    }
}

extension Item: ImageMetaData {
    var imageUrl: String? {
        return link
    }
    
    var thumbnailUrl: String? {
        return thumbnail
    }
    
    var imageSize: CGSize? {
        guard let sizewidth = sizewidth, let sizeheight = sizeheight,
           let width = Int(sizewidth), let height = Int(sizeheight) else {
            return nil
        }
        
        return CGSize(width: width, height: height)
    }
}
