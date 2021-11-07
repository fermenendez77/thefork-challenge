//
//  ImageDownloader.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//

import Foundation
import UIKit

protocol ImageDownloader {
    
    func getImage(from url : URL?,
                  completionHandler : @escaping (Result<UIImage,ImageDownloaderError>) -> Void)
}

class ImageDownloaderService : ImageDownloader {
    
    func getImage(from url : URL?,
                  completionHandler : @escaping (Result<UIImage,ImageDownloaderError>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(.nullURL))
            return
        }
        
        DispatchQueue.global().async {
            var result : Result<UIImage,ImageDownloaderError>
            if let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                    result = .success(image)
            } else {
                result = .failure(.badRequest)
            }
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}

enum ImageDownloaderError : Error {
    case nullURL
    case badRequest
}
