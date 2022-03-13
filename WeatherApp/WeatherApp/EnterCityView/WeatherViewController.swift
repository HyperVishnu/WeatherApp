//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Vishnu Duggisetty on 13/03/22.
//

import UIKit
import Toast_Swift

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lookupButton: UIButton!
    var viewModel: WeatherViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.onSuccessWeatherInfo = { [weak self] model, weatherArr in
            let vc = WeatherInfoTableViewController()
            vc.arrayData = weatherArr
            vc.weatherInfo = model
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.view.makeToast(errorMessage ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setup() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: cityNameTextField.frame.height - 1, width: cityNameTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        cityNameTextField.borderStyle = .none
        cityNameTextField.layer.addSublayer(bottomLine)
        cityNameTextField.delegate = self
        cityNameTextField.layer.masksToBounds = true
        
        lookupButton.backgroundColor = .clear
        lookupButton.layer.cornerRadius = 8
        lookupButton.layer.borderWidth = 1
        lookupButton.layer.borderColor = UIColor.darkGray.cgColor
        lookupButton.addTarget(self, action: #selector(lookupButtonTap(_:)), for: .touchUpInside)
    }
    
    @objc func lookupButtonTap(_ sender: UIButton) {
        view.endEditing(true)
        guard let value = cityNameTextField.text,
              !value.isEmpty else {
            view.makeToast("Please enter city name")
            return
        }
        viewModel.requestWeatherInfoForCity(cityName: value)
    }
    
    public class func fromNib() -> WeatherViewController {
        let vc = WeatherViewController(nibName: "WeatherViewController", bundle: nil)
        return vc
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
