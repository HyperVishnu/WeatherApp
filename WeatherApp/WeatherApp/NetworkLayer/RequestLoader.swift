//
//  RequestLoader.swift
//  WeatherApp
//
//  Created by Vishnu Duggisetty on 13/03/22.
//

import Foundation

protocol RequestLoaderProtocol {
    func weatherRequest(cityName: String,
                        completion: @escaping (WeatherResponseModel) -> (),
                        failure: @escaping (Swift.Error?) -> ())
    
    
}

struct RequestLoader: RequestLoaderProtocol {
    private enum Constants {
        static let api = "https://api.openweathermap.org/data/2.5/weather?q=$CITY$&APPID=$APPID$"
        static let appId = "d8e350dc396ac6ebe406b495da11095f"
    }
    
    func weatherRequest(cityName: String,
                        completion: @escaping (WeatherResponseModel) -> (),
                        failure: @escaping (Swift.Error?) -> ()) {
        var apiString = Constants.api.replacingOccurrences(
            of: "$CITY$",
            with: cityName
        ).replacingOccurrences(of: "$APPID$",
                               with: Constants.appId)
        apiString = apiString.filter {!$0.isWhitespace}
        guard let url = URL(string: apiString) else { return }
        let request = createRequest(from: url)
        let task = createDataTask(from: request) { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let response):
                failure(response)
            }
        }
        task.resume()
    }
    
    private func createRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }
    
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Result<WeatherResponseModel,
                                                              Swift.Error>) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                let errorTemp = NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(errorTemp))
            } else {
                guard let decoded = self.decodeJSON(type: WeatherResponseModel.self,
                                                    from: data)
                else {
                    let errorTemp = NSError(domain: "", code: 400, userInfo: nil)
                    completion(.failure(errorTemp))
                    return
                }
                completion(.success(decoded))
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type,
                                          from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from,
              let response = try? decoder.decode(type.self,
                                                 from: data)
        else { return nil }
        return response
    }
}
