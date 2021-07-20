//
//  SearchEngine.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/20.
//

enum SearchEngine {
    case kakao
    case naver
    
    /// String URL이 해당 검색엔진인지 여부
    static func ~= (pattern: SearchEngine, value: String) -> Bool {
        return value.starts(with: AppURL.domain(for: pattern))
    }
}
