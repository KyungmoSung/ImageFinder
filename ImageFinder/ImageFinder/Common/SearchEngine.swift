//
//  SearchEngine.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

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
    
    static func key(for searchEngine: SearchEngine) -> String {
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
