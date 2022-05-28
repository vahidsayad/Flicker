//
//  Network.swift
//  Flicker
//
//  Created by Vahid Sayad on 27/5/2022 .
//
import Foundation

class Network<Response: Decodable> {
    init(api: API) {
        self.api = api
    }
    
    let api: API
    
    func execute(_ completion: @escaping (_ response: Result<Response, NetworkError>)->Void ) {
        guard let url = apiURL else {
            completion(.failure(.badUrl))
            return
        }
        
        var req = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: TimeInterval(15))
        req.httpMethod = api.method.rawValue
        
        let conf = URLSessionConfiguration.default
        conf.waitsForConnectivity = true
        conf.timeoutIntervalForResource = 50
        
        URLSession(configuration: conf).dataTask(with: req) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverIssue))
                return
            }
            
            do {
                let photos = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(photos))
                }
            } catch let error {
                print(error)
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(.encodingError))
                }
            }
        }.resume()
    }
    
    private var apiURL: URL? {
        let urlString = api.baseURL + api.endPoint
        return URL(string: urlString)
    }
    
    private var headers: [String: String] {
        ["":""]
    }
}
