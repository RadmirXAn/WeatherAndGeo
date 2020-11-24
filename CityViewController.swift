//
//  CityViewController.swift
//  WeatherAndGeo
//
//  Created by Радмир Юмагужин on 24.11.2020.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var labelCity: UILabel!
    
    @IBOutlet weak var labelTemperature: UILabel!

    @IBOutlet weak var labelLat: UILabel!
    
    @IBOutlet weak var labelLon: UILabel!
    
    var nme = ""
    var tmp = ""
    var lat = ""
    var lon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelCity.text = nme
        labelTemperature.text = tmp
        labelLat.text = lat
        labelLon.text = lon
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "Map":
            guard let destination = segue.destination as? MapViewController else { return }
            destination.lat = lat
            destination.lon = lon
        default:
            break
        }
    }
    
    @IBAction func showToMap(_ sender: UIButton) {
        performSegue(withIdentifier: "Map", sender: self)
    }
}
