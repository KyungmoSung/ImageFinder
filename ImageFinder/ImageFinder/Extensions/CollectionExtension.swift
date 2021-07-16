//
//  CollectionExtension.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

extension Collection {
    /// 안전하게 배열 인덱스의 값 조회
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
