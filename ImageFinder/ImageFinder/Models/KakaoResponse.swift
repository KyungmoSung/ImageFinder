//
//  KakaoResponse.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

import Foundation

// MARK: - KakaoResponse
struct KakaoResponse: Codable {
    let meta: Meta?
    let documents: [Document]?

    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case documents = "documents"
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
