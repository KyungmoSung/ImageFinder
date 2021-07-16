//
//  ImageCell.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            } else {
                let placeHolderImage = UIImage(systemName: "heart.fill")
                imageView.image = placeHolderImage
            }
        }
    }
}
