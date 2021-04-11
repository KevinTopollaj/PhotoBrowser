//
//  ImageLoader.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class ImageLoader {
  
  // cache
  private var loadedImages = [URL: UIImage]()
  
  // requests being performed for image download
  private var runningRequests = [UUID: URLSessionDataTask]()
  
  func loadImage(url: URL, completion: @escaping (Result<UIImage,Error>) -> Void) -> UUID? {
    if let image = loadedImages[url] {
      completion(.success(image))
      return nil
    }
    
    let uuid = UUID()
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      defer { self.runningRequests.removeValue(forKey: uuid) }
      
      if let data = data, let image = UIImage(data: data) {
        self.loadedImages[url] = image
        completion(.success(image))
        return
      }
      
      guard let error = error else { return }
      
      guard (error as NSError).code == NSURLErrorCancelled else {
        completion(.failure(error))
        return
      }
    }
    
    task.resume()
    
    runningRequests[uuid] = task
    return uuid
  }
  
  func cancel(uuid: UUID) {
    runningRequests[uuid]?.cancel()
    runningRequests.removeValue(forKey: uuid)
  }
  
}
