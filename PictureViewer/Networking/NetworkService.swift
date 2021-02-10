//
//  NetworkManager.swift
//  PictureViewer
//
//  Created by Лера Тарасенко on 09.02.2021.
//

import UIKit

class NetworkService {
    
    func request(completion: @escaping (Data?, Error?) -> ()) {
        
        let parameters = self.prepareParameters()
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String : String]? {
        var headers = [String : String]()
        headers["Authorization"] = "Client-ID 4Y5WEWj2W5QUf-B9cnhXS82nG7FVOM9wj8wkYD87pkc"
        return headers
    }
    
    private func prepareParameters() -> [String : String] {
        var parameters = [String : String]()
        parameters["page"] = String(2)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(params: [String : String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
            
        }
    }
}
