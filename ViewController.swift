//
//  ViewController.swift
//  WeatherAndGeo
//
//  Created by Радмир Юмагужин on 24.11.2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cities = [StructCity]()
    var selectedRowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setCityInfo(name: "Moscow")
        setCityInfo(name: "London")
    }
    
    func setCityInfo(name:String){
        let API_KEY:String = "e6b420600937403eb7365444201811"
        var url:String = "http://api.weatherapi.com/v1/forecast.json?key=\(API_KEY)&q=\(name)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(url as URLConvertible, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                let temperature = json["current"]["temp_f"].stringValue
                let lal = json["location"]["lat"].stringValue
                let lon = json["location"]["lon"].stringValue
                let city = StructCity(name: name, temperature: temperature, lal: lal, lon: lon)
                print(city, city.name)
                self.cities.append(city)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "Information":
            guard let destination = segue.destination as? CityViewController else { return }

            destination.nme = cities[selectedRowIndex].name
            destination.tmp = cities[selectedRowIndex].temperature
            destination.lat = cities[selectedRowIndex].lal
            destination.lon = cities[selectedRowIndex].lon
        default:
            break
        }
    }

}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.labelCity.text = cities[indexPath.row].name
        cell.labelTemperature.text = cities[indexPath.row].temperature
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "Information", sender: self)
    }
}
