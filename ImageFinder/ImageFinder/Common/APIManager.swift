//
//  ApiManager.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

import Alamofire

class APIManager {
    static func request<T: Decodable>(_ stringURL: String, method: HTTPMethod, params: [String: Any]?, responseType: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        guard let url = URL(string: stringURL) else {
            return
        }
                
        var headers: HTTPHeaders = [
            .accept("application/json")
        ]
        
        switch stringURL {
        case .kakao:
            headers.add(.authorization("KakaoAK \(AppKey.Kakao.restAPI)"))
        case .naver:
            headers.add(name: "X-Naver-Client-Id", value: AppKey.Naver.clientID)
            headers.add(name: "X-Naver-Client-Secret", value: AppKey.Naver.clientSecret)
        default:
            break
        }
        
        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: responseType) { response in
                completion(response.result)
            }
    }
}
