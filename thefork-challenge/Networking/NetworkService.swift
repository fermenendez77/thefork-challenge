//
//  NetworkService.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

protocol NetworkService {
    
    func fetchData<T>(from url : URL,
                      returnType : T.Type,
                      completionHandler: @escaping (Result<T,NetworkError>) -> Void) where T : Decodable
}

class NetworkServiceImpl : NetworkService {
    
    let session = URLSession.shared
    
    func fetchData<T>(from url : URL,
                      returnType : T.Type,
                      completionHandler: @escaping (Result<T,NetworkError>) -> Void) where T : Decodable {
        let decoder = JSONDecoder()
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data else {
                      DispatchQueue.main.async {
                          completionHandler(.failure(.networkError))
                      }
                      return
                  }
            do {
                let restaurantsResponse = try decoder.decode(T.self,
                                                         from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(restaurantsResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.badResponse))
                }
            }
            
        }.resume()
    }
}

enum NetworkError : Error {
    case networkError, badResponse, badRequest
}
