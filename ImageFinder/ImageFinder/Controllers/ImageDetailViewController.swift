//
//  ImageDetailViewController.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/23.
//

import UIKit

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var imageMetaData: ImageMetaData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: 캐시 이미지 플레이스홀더 설정
    func setupUI() {
        switch imageMetaData {
        case let document as Document:
            label.text = document.displaySitename
            imageView.kf.setImage(with: document.imageUrl?.toURL())
        case let item as Item:
            label.text = item.title
            imageView.kf.setImage(with: item.imageUrl?.toURL())
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}
