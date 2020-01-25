//
//  MovieController.swift
//  MovieSearch
//
//  Created by Maxwell Poffenbarger on 1/24/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static private let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static private let apiQuery = "api_key"
    static private let apiKey = "c7b605a4da539f0f14265ab6635a1b32"
    static private let movieKey = "query"
    
    static func FetchMovieData(movieValue: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        guard let url = baseURL else {return completion(.failure(.invalidURL))}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiQueryItem = URLQueryItem(name: apiQuery, value: apiKey)
        let movieQueryItem = URLQueryItem(name: movieKey, value: movieValue)
        components?.queryItems = [apiQueryItem, movieQueryItem]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movieArray = topLevelObject.results
                return completion(.success(movieArray))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func FetchMovieImage(movie: Movie, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let url: URL = URL(string: "https://image.tmdb.org/t/p/w500/") else {return completion(.failure(.invalidURL))}
        guard let posterImagePath = movie.image else {return completion(.failure(.invalidURL)) }
        let finalURL = url.appendingPathComponent(posterImagePath)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.noData))}
            
            completion(.success(image))
        }.resume()
    }
}//End of class
