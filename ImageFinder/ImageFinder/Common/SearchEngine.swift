//
//  SearchEngine.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

import UIKit

enum SearchEngine: Int, CaseIterable {
    case kakao = 0
    case naver
    
    var title: String {
        switch self {
        case .kakao:
            return "Kakao"
        case .naver:
            return "Naver"
        }
    }
    
    /// String URL이 해당 검색엔진인지 여부
    static func ~= (pattern: SearchEngine, value: String) -> Bool {
        return value.starts(with: AppURL.domain(for: pattern))
    }
}

enum Sort {
    case accuracy
    case recency
    
    func key(for searchEngine: SearchEngine) -> String {
        switch (self, searchEngine) {
        case (.accuracy, .kakao):
            return "accuracy"
        case (.accuracy, .naver):
            return "sim"
        case (.recency, .kakao):
            return "recency"
        case (.recency, .naver):
            return "date"
        }
    }
}

enum Grid: Int {
    case one = 1
    case two
    case three
    
    var image: UIImage? {
        switch self {
        case .one:
            return UIImage(systemName: "rectangle.grid.1x2")
        case .two:
            return UIImage(systemName: "rectangle.grid.2x2")
        case .three:
            return UIImage(systemName: "rectangle.grid.3x2")
        }
    }
    
    var nextGrid: Grid {
        if let netxtGrid = Grid(rawValue: self.rawValue + 1) {
            return netxtGrid
        } else {
            return .one
        }
    }
}
