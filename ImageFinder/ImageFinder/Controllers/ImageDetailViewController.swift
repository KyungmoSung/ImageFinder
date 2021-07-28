//
//  ImageDetailViewController.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/23.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    let imageMetaData: ImageMetaData
    
    init?(coder: NSCoder, imageMetaData: ImageMetaData) {
        self.imageMetaData = imageMetaData
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        imageViewResizing(to: imageMetaData.imageSize ?? .zero)
        
        let imageURL = imageMetaData.imageUrl?.toURL()
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.3))])

        if let imageMetaDict = imageMetaData.asDictionary {
            for (key, value) in imageMetaDict.sorted(by: { $0.key > $1.key }) {
                let label = UILabel()
                label.numberOfLines = 0
                label.text = " \(key) : \(value) "
                stackView.addArrangedSubview(label)
            }
        }
    }
    
    /// 이미지 비율에 맞게 이미지뷰 리사이징
    func imageViewResizing(to imageSize: CGSize) {
        guard imageSize.width > 0, imageSize.height > 0 else {
            imageViewHeight.constant = 0
            return
        }

        view.layoutIfNeeded()
        let ratio = imageSize.height / imageSize.width
        let width = imageView.bounds.width
        let height = width * ratio
        
        imageViewHeight.constant = height
        print("height", height)
    }
}
