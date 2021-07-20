//
//  ImageListViewController.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

import UIKit

class ImageListViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
//    var images: [Document] = []
    var images: [Item] = []
    var searchEngine: SearchEngine = .naver
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        fetchImages()
    }
    
    func fetchImages() {
        APIManager.request(AppURL.searchImage(on: searchEngine), method: .get, params: ["query": "apple"], responseType: NaverResponse.self) { result in
            switch result {
            case .success(let response):
                dump(response)
//                if let documents = response.documents {
//                    self.images = documents
//                    self.imageCollectionView.reloadData()
//                }
                if let items = response.items {
                    self.images = items
                    self.imageCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ImageListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell,
//              let thumbnailUrl = images[safe: indexPath.row]?.thumbnailUrl else {
              let thumbnailUrl = images[safe: indexPath.row]?.thumbnail else {
            return UICollectionViewCell()
        }
        
        let url = URL(string: thumbnailUrl)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.image = UIImage(data: data!)
            }
        }
        return cell
    }
}
