//
//  NetworkingManager.swift
//  MovieApp
//
//  Created by AliEren on 5.06.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    static let apiKey = "d12d8839"
    static let baseURL = "https://www.omdbapi.com/?apikey=\(apiKey)&s="
    static let titleBaseURL = "https://www.omdbapi.com/?apikey=\(apiKey)&i="
    
    func getMoviesList(url: String, page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void ) {
        print(url)
        guard let requestURL = URL(string: url) else { return }
        AF.request(URLRequest(url: requestURL)).responseDecodable(of: MovieResponse.self) { response in
            
            switch response.result {
            case .success:
                if let value = response.value {
                    completion(.success(value))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getMovie(url: URL, completion: @escaping (Result<DetailMovieModel, Error>) -> Void) {
        
        AF.request(url, encoding: JSONEncoding.default).responseDecodable(of: DetailMovieModel.self) { response in
            switch response.result {
            case .success:
                if let value = response.value {
                    completion(.success(value))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
