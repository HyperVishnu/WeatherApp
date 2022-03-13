//
//  WeatherInfoTableViewController.swift
//  WeatherApp
//
//  Created by Vishnu Duggisetty on 13/03/22.
//

import UIKit
import Foundation

class WeatherInfoTableViewController: UITableViewController {
    public var arrayData = [WeatherInfoData]()
    public var weatherInfo: WeatherResponseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = weatherInfo.name
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
        navigationController?.navigationBar.tintColor = uicolorFromHex(rgbValue: 0xffffff)
        navigationController?.navigationBar.barTintColor = uicolorFromHex(rgbValue: 0x5B4FC4)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        tableView.separatorColor = .darkGray
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.keyLabel.text = arrayData[indexPath.row].key
        cell.valueLabel.text = "Temp: " + arrayData[indexPath.row].value
        return cell
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.weatherInfo = weatherInfo
        navigationController?.pushViewController(vc, animated: true)
    }
}
