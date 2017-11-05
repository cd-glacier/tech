//
//  FiveDaysViewController.swift
//  
//
//  Created by glacier on 2017/11/05.
//

import UIKit
import Alamofire
import SwiftyJSON

class FiveDaysViewController: UIViewController {
    var weatherIcons = [UIImageView]()
    var dateLabels = [UILabel]()
    
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var backgoundImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherIcons = [icon1, icon2, icon3, icon4]
        dateLabels = [label1, label2, label3, label4]
        getWeathers(icons: weatherIcons, labels: dateLabels)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeathers(icons: [UIImageView], labels: [UILabel]) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?APPID=a3318e2703222b96985b824503780a40&q=NewYork").responseJSON { (response) in
            let data = JSON(response.result.value!)
            let weathers = data["list"].array?.filter({ $0["dt_txt"].string!.contains("12:00:00") })
            let strWeathers = weathers!.map({ $0["weather"][0]["main"].string! })
            
            self.changeBackgroundImg(weather: weathers![0]["weather"][0]["main"].string!, backgroundImg: self.backgoundImg)
            self.changeIcons(weathers: strWeathers)
            //self.changeDateLabels(today: self.getToday(format: "yyyy/MM/dd"))
            
            print(strWeathers)
        }
    }
    
    func changeIcons(weathers: [String]) {
        weatherIcons.enumerated().forEach { (i, icon) in
            changeWeatherImg(weather: weathers[i], weatherImg: icon)
        }
    }
    
    func changeBackgroundImg(weather: String, backgroundImg: UIImageView) {
        switch weather {
        case "Clear":
            backgroundImg.image = UIImage(named: "sun-background.jpg")
        case "Clouds":
            backgroundImg.image = UIImage(named: "cloud-background.jpg")
        case "Rain":
            backgroundImg.image = UIImage(named: "rain-background.jpg")
        default:
            backgroundImg.image = UIImage(named: "sun-background.jpg")
        }
    }
    
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    func changeWeatherImg(weather: String, weatherImg: UIImageView) {
        switch weather {
        case "Clear":
            weatherImg.image = UIImage(named: "sun.png")
        case "Clouds":
            weatherImg.image = UIImage(named: "cloud.png")
        case "Rain":
            weatherImg.image = UIImage(named: "rain.png")
        default:
            weatherImg.image = UIImage(named: "sun.png")
        }
    }
    
    @IBAction func pushReloadBtn(_ sender: Any) {
        getWeathers(icons: weatherIcons, labels: dateLabels)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
