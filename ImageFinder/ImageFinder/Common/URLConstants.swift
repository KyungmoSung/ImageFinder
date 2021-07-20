//
//  URLConstants.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

enum AppURL {
    static func domain(for searchEngine: SearchEngine) -> String {
        switch searchEngine {
        case .kakao:
            return "https://dapi.kakao.com"
        case .naver:
            return "https://openapi.naver.com"
        }
    }
    
    static func searchImage(on searchEngine: SearchEngine) -> String {
        var api: String!
        
        switch searchEngine {
        case .kakao:
            api = "/v2/search/image"
        case .naver:
            api = "/v1/search/image"
        }
        
        return AppURL.domain(for: searchEngine) + api
    }
}
