//
//  URLConstants.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

enum AppURL {
    enum Engine {
        case kakao
    }
    
    static func domain(for engine: Engine) -> String {
        switch engine {
        case .kakao:
            return "https://dapi.kakao.com"
        }
    }
    
    static func searchImage(on engine: Engine) -> String {
        var api: String!
        
        switch engine {
        case .kakao:
            api = "/v2/search/image"
        }
        
        return AppURL.domain(for: engine) + api
    }
}
