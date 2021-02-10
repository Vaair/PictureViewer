//
//  NetworkDataFetcher.swift
//  PictureViewer
//
//  Created by Лера Тарасенко on 10.02.2021.
//

import Foundation

class NetworkDataFetcher {

    var networkService = NetworkService()
    
    func getchImages(completion: @escaping ([Picture]?) -> ()) {
        networkService.request { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: [Picture].self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Codable>(type: [T].Type, from data: Data?) -> [T]? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
