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

        // 각각의 정보 UILabel에 표시
        if let imageMetaDict = imageMetaData.asDictionary {
            for (key, value) in imageMetaDict.sorted(by: { $0.key > $1.key }) {
                let label = UILabel()
                label.numberOfLines = 0
                label.text = "\(key) : \(value)"
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
    
    /// 이미지 사진첩 저장
    @IBAction func didTapSaveBtn(_ sender: Any) {
        guard let image = imageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    /// 이미지 클립보드 복사
    @IBAction func didTapCopyBtn(_ sender: Any) {
        UIPasteboard.general.image = imageView.image
        
        let ac = UIAlertController(title: "Copied!", message: "이미지 복사 완료", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    /// 이미지 공유
    @IBAction func didTapShareBtn(_ sender: Any) {
        guard let image = imageView.image else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    /// 이미지 사진첩 저장 결과
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error!", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "이미지 저장 완료", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
