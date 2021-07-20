//
//  NaverResponse.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

import Foundation

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
