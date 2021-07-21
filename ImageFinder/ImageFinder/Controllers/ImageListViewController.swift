//
//  ImageListViewController.swift
//  ImageFinder
//
//  Created by Front-Artist on 2021/07/16.
//

import UIKit
import Alamofire

class ImageListViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imageMetaDatas: [ImageMetaData] = []
    var searchEngine: SearchEngine = .kakao
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchController()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Image Finder"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.scopeButtonTitles = SearchEngine.allCases.map{ $0.title }
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    func fetchImages(query: String) {
        switch searchEngine {
        case .kakao:
            APIManager.request(AppURL.searchImage(on: .kakao), method: .get, params: ["query": query], responseType: KakaoResponse.self, completion: completion)
        case .naver:
            APIManager.request(AppURL.searchImage(on: .naver), method: .get, params: ["query": query], responseType: NaverResponse.self, completion: completion)
        }
        
        func completion<T>(result: (Result<T, AFError>)) where T: PageableImageInfo {
            switch result {
            case .success(let response):
                dump(response)
                if let imageMetaDatas = response.imageMetaDatas {
                    self.imageMetaDatas = imageMetaDatas
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
        return imageMetaDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell,
              let thumbnailUrl = imageMetaDatas[safe: indexPath.row]?.thumbnailUrl else {
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

extension ImageListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        fetchImages(query: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchEngine = SearchEngine(rawValue: selectedScope) else {
            return
        }
        
        self.searchEngine = searchEngine
        
        if let text = searchBar.text {
            fetchImages(query: text)
        }
    }
}
