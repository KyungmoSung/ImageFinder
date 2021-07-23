//
//  ThumbnailCell.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

import UIKit
import Kingfisher

class ThumbnailCell: UICollectionViewCell {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    var imageURL: URL? {
        didSet {
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.3))])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
    }
}
