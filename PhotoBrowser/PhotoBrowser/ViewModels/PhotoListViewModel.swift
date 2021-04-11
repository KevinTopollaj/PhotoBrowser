//
//  PhotoListViewModel.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

protocol PhotoListViewModelDelegate: class {
  func photosLoaded(sender: PhotoListViewModel)
}

final class PhotoListViewModel {
  
  private var photos = [Photo]()
  private let pexelsClient: PexelsClient
  weak var delegate: PhotoListViewModelDelegate?
  var currentPage = 0
  
  init() {
    pexelsClient = PexelsClient()
    loadPhotos()
  }
  
  var count: Int {
    photos.count
  }
  
  func getPhoto(at indexPath: IndexPath) -> Photo {
    photos[indexPath.row]
  }
  
  func loadPhotos() {
    currentPage += 1
    let feed = PhotoFeed.curated(currentPage: currentPage, perPage: 20)
    
    pexelsClient.getPhotos(from: feed) {[weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let photoFeedResult):
        self.photos.append(contentsOf: photoFeedResult.photos)
        self.delegate?.photosLoaded(sender: self)
      case .failure(let error):
        print(error)
      }
    }
  }
  
}
