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
    
    let numberOfSearchResults = 10
    
    var searchEngine: SearchEngine = .kakao {
        didSet {
            page = 1
            hasMoreImages = true
            imageMetaDatas.removeAll()
            imageCollectionView.reloadData()
        }
    }
    
    var imageMetaDatas: [ImageMetaData] = []
    var page: Int = 1
    var hasMoreImages: Bool = true
    
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
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    func fetchImages(on searchEngine: SearchEngine, query: String) {
        guard hasMoreImages else {
            return
        }
        
        var params: [String: Any] = [
            "query": query,
        ]
        
        switch searchEngine {
        case .kakao:
            params["sort"] = "accuracy"
            params["page"] = page
            params["size"] = numberOfSearchResults
            APIManager.request(AppURL.searchImage(on: .kakao), method: .get, params: params, responseType: KakaoResponse.self, completion: completion)
        case .naver:
            params["sort"] = "sim"
            params["start"] = page
            params["display"] = numberOfSearchResults
            APIManager.request(AppURL.searchImage(on: .naver), method: .get, params: params, responseType: NaverResponse.self, completion: completion)
        }
        
        func completion<T>(result: (Result<T, AFError>)) where T: PageableImageInfo {
            switch result {
            case .success(let response):
                dump(response)
                if page == 1 {
                    imageMetaDatas = response.imageMetaDatas
                } else {
                    imageMetaDatas += response.imageMetaDatas
                }
                
                page = response.nextPage(current: page)
                hasMoreImages = !response.isEnd

                imageCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let text = navigationItem.searchController?.searchBar.text,
           indexPath.row == imageMetaDatas.count - 1 {
            fetchImages(on: searchEngine, query: text)
        }
    }
}

extension ImageListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        fetchImages(on: searchEngine, query: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchEngine = SearchEngine(rawValue: selectedScope) else {
            return
        }
        
        self.searchEngine = searchEngine
        
        if let text = searchBar.text {
            fetchImages(on: searchEngine, query: text)
        }
    }
}
