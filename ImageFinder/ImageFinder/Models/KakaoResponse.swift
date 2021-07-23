//
//  KakaoResponse.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

import Foundation
import CoreGraphics

// MARK: - KakaoResponse
struct KakaoResponse: Codable {
    let meta: Meta?
    let documents: [Document]?

    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case documents = "documents"
    }
}

extension KakaoResponse: PageableImageInfo {
    func nextPage(current: Int) -> Int {
        return current + 1
    }
    
    var isEnd: Bool {
        guard let meta = meta, let isEnd = meta.isEnd else {
            return true
        }
        
        return isEnd
    }
    
    var imageMetaDatas: [ImageMetaData] {
        return documents ?? []
    }
}

// MARK: - Document
struct Document: Codable {
    let collection: String?
    let thumbnailUrl: String?
    let imageUrl: String?
    let width: Int?
    let height: Int?
    let displaySitename: String?
    let docUrl: String?
    let datetime: String?

    enum CodingKeys: String, CodingKey {
        case collection = "collection"
        case thumbnailUrl = "thumbnail_url"
        case imageUrl = "image_url"
        case width = "width"
        case height = "height"
        case displaySitename = "display_sitename"
        case docUrl = "doc_url"
        case datetime = "datetime"
    }
}

extension Document: ImageMetaData {
    var imageSize: CGSize? {
        guard let width = width, let height = height else {
            return nil
        }
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount: Int?
    let pageableCount: Int?
    let isEnd: Bool?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
