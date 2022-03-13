//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Vishnu Duggisetty on 13/03/22.
//

import Foundation
import UIKit

protocol WeatherViewModelProtocol {
    var onSuccessWeatherInfo: ((WeatherResponseModel, [WeatherInfoData]) -> ())? { get set }
    var onError: ((String?) -> ())? { get set}
    func requestWeatherInfoForCity(cityName: String)
}

class WeatherViewModel: WeatherViewModelProtocol {
    let requestLoader: RequestLoaderProtocol
    var onError: ((String?) -> ())?
    var onSuccessWeatherInfo: ((WeatherResponseModel, [WeatherInfoData]) -> ())?
    
    init(requestLoader: RequestLoaderProtocol) {
        self.requestLoader = requestLoader
    }
    
    func requestWeatherInfoForCity(cityName: String) {
        requestLoader.weatherRequest(cityName: cityName)
        { model in
            DispatchQueue.main.async { [weak self] in
                self?.onSuccessWeatherInfo?(model, (self?.mapData(response: model))!)
            }
        } failure: { [weak self] error in
            self?.onError?("City not found")
        }
    }
    
    private func mapData(response: WeatherResponseModel) -> [WeatherInfoData] {
        var arr = [WeatherInfoData]()
        arr.append(WeatherInfoData(key: "   Clear", value: String(response.main?.temp ?? 0)))
        arr.append(WeatherInfoData(key: "   Cloudy", value: String(response.main?.humidity ?? 0)))
        arr.append(WeatherInfoData(key: "   Rain", value: String(response.main?.tempMin ?? 0)))
        return arr
    }
}

struct WeatherInfoData {
    let key: String
    let value: String
}
