//
//  ViewController.swift
//  weather
//
//  Created by glacier on 2017/11/05.
//  Copyright © 2017年 glacier. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
        let weather = getWeather()
        dateLabel.text = getToday(format:"yyyy/MM/dd")
	}
    
    func getWeather() -> String {
        var weather = ""
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?APPID=a3318e2703222b96985b824503780a40&q=NewYork").responseJSON { (response) in
            let data = JSON(response.result.value!)
            weather = data["weather"][0]["main"].string!
            print(weather)
            self.changeWeatherImg(weather: weather)
        }
        return weather
    }
    
    func changeWeatherImg(weather: String) {
        switch weather {
        case "Clear":
            weatherImg.image = UIImage(named: "sun.png")
            backgroundImg.image = UIImage(named: "sun-background.jpg")
        case "Clouds": 
            weatherImg.image = UIImage(named: "cloud.png")
            backgroundImg.image = UIImage(named: "cloud-background.jpg")
        case "Rain":
            weatherImg.image = UIImage(named: "rain.png")
            backgroundImg.image = UIImage(named: "rain-background.jpg")
        default:
            weatherImg.image = UIImage(named: "sun.png")
            backgroundImg.image = UIImage(named: "sun-background.jpg")
        }
    }
    
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    @IBAction func pushReloadBtn(_ sender: Any) {
        getWeather()
    }
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

