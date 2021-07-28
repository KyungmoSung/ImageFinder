//
//  ThumbnailCell.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

import UIKit
import Kingfisher

class ThumbnailCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    var imageURL: URL? {
        didSet {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.3))])
        }
    }
    
    var image: UIImage? {
        return imageView.image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
