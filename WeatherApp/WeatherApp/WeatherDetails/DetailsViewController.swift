//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Vishnu Duggisetty on 13/03/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    public var weatherInfo: WeatherResponseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        firstLabel.text = String(weatherInfo.main?.temp ?? 0)
        secondLabel.text = "Feels Like: \(String(weatherInfo.main?.feelsLike ?? 0))"
        thirdLabel.text = weatherInfo.weather?[0].weatherDescription ?? ""
        fourthLabel.text = weatherInfo.weather?[0].main ?? ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = weatherInfo.name
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
    }
}
