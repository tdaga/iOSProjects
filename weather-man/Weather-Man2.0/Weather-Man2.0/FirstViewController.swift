//
//  FirstViewController.swift
//  Weather-Man2.0
//
//  Created by Tanvi Daga on 4/13/19.
//  Copyright © 2019 Tanvi Daga. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var TopClothing: UILabel!
    
    @IBOutlet weak var BottomClothing: UILabel!
    
    @IBOutlet weak var OuterClothing: UILabel!
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var whiteBox: UIImageView!
    let dummyClothing = clothing.init(name: "", temperature: 0, precipitationType: [], type: .TOP, worn: false)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        //getWeather(42.3601, 71.0589)
        whiteBox.alpha = 0.5
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServices()
        
        
    }

    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            print("in checkLocationServices")
        } else {
            print("error")
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            // mapView.showsUserLocation = true
            centerViewOnUserLocation()
            print("authorized")
        // locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            //   mapView.setRegion(region, animated: true)
            getWeather(location.latitude, location.longitude)
            
        }
    }
    
    func getWeather(_ lat: Double, _ long: Double){
        let key = "f188fd3d9c794413a663be68aba8173b/"
        let req = "https://api.darksky.net/forecast/"
        let lat = String(lat)
        let toAdd = ","
        let lon = String(long)
        let toReq = req + key + lat + toAdd + lon
        Alamofire.request(toReq).validate().responseJSON { response in
            let json = JSON(response.result.value)
            let date = Date()
            let calendar = NSCalendar.current
            let hourlyData = json["hourly"]["data"]
            let hoursUntil12 = 24 - calendar.component(.hour, from: date)
            var count = 0;
          //  print(hoursUntil12)
            let currentHour = calendar.component(.hour, from: date)
            var startHourInd = -1
            var endHourInd = -1
            if(7 < currentHour  && currentHour < 21){
                startHourInd = 0
                let hoursUntil21  = 21 - currentHour + 14
                endHourInd = hoursUntil21
            } else if (currentHour >= 21) {
                let hoursUntil7 = 24 - currentHour + 7
                let hoursUntil21 = hoursUntil7 + 14
                startHourInd = hoursUntil7
                endHourInd = hoursUntil21
            } else if (currentHour <= 7) {
                let hoursUntil7 = 7 - currentHour
                let hoursUntil21 = hoursUntil7 + 14
                startHourInd = hoursUntil7
                endHourInd = hoursUntil21
            }
            print(startHourInd)
            print(endHourInd)
            var bestTemp = -460.0
            var worstTemp = 1000.0
            var bestPrecipProbability = 1.01
            var worstPrecipProbability = -1.0
            var isRain = false
            var isSnow = false
            var isSleet = false
            
            for val in startHourInd...endHourInd {
                let temp = hourlyData[val]["temperature"]
                if(temp.double! > bestTemp){
                    bestTemp = temp.double!
                }
                if (temp.double! < worstTemp){
                    worstTemp = temp.double!
                }
              //  print(hourlyData[val]["cloudCover"])
                let precip = hourlyData[val]["precipProbability"]
                if(precip.double! < bestPrecipProbability){
                    bestPrecipProbability = precip.double!
                }
                if(precip.double! > worstPrecipProbability){
                    worstPrecipProbability = precip.double!
                }
                let image = UIImage(named: "sunny.jpg")
                self.backgroundImage.image = image
                self.backgroundImage.alpha = 0.5
                if(precip.double! > 0.5){
                    let type = (hourlyData[val]["precipType"])
                    if(type.string == "rain"){
                        let image = UIImage(named: "rain.jpg")
                    
                        isRain = true
                    }
                    if(type.string == "snow"){
                        let image = UIImage(named: "snow.jpg")
                        isSnow = true
                    }
                    if(type.string == "sleet"){
                        let image = UIImage(named: "sleet.jpg")
                        isSleet = true
                    }
                    
                }
            }
            self.toWear(bestTemp: bestTemp, worstTemp: worstTemp, bestPP: bestPrecipProbability, worstPP: worstPrecipProbability, isRain: isRain, isSnow: isSnow, isSleet: isSleet)
            print(bestTemp)
            print(worstTemp)
            print(bestPrecipProbability)
            print(worstPrecipProbability)
            print(isSleet)
            print(isSnow)
            print(isRain)
        }
    }
    
    func toWear(bestTemp: Double, worstTemp: Double, bestPP: Double, worstPP: Double, isRain : Bool, isSnow: Bool, isSleet: Bool){
        for clothing in preferences {
            print(clothing.name)
            print(clothing.temperature)
        }
        var topBestDiff = 1000.0
        var bottomBestDiff = 1000.0
        var bestTop = dummyClothing
        var bestBottom = dummyClothing
        var outer = dummyClothing
        var listOfPrecip:[clothing] = []
       
        for top in topList {
            if (top.worn) {
            if (abs(bestTemp - top.temperature) < topBestDiff){
                topBestDiff = abs(bestTemp - top.temperature)
                bestTop = top
                TopClothing.text = top.name
            }
            }
        }
        for lower in bottomList {
            if (lower.worn) {
            if (abs(bestTemp - lower.temperature) < bottomBestDiff){
                bottomBestDiff = abs(bestTemp - lower.temperature)
                bestBottom = lower
                BottomClothing.text = lower.name
            }
            }
        }
            if (isRain){
                for outer in outerwearList {
                    if (outer.worn) {
                    if(outer.precipitationType.contains(Precipitation.RAIN)){
                        listOfPrecip.append(outer)
                        }}
                }
            }
            if(isSnow){
                for outer in outerwearList{
                    if (outer.worn) {
                    if(outer.precipitationType.contains(Precipitation.SNOW)){
                        listOfPrecip.append(outer)
                    }
                    }
                }
            }
            if(isSleet){
                for outer in outerwearList{
                    if (outer.worn) {
                    if(outer.precipitationType.contains(Precipitation.SLEET)){
                        listOfPrecip.append(outer)
                    }
                    }
            }
        }
        var outerwearBestTempDiff = 1000.0
        var bestOuterClothing = dummyClothing
        if(listOfPrecip.count > 0){
        for outer in listOfPrecip {
            if (outer.worn) {
            if(abs(worstTemp - outer.temperature) > outerwearBestTempDiff){
                outerwearBestTempDiff = abs(worstTemp - outer.temperature)
                bestOuterClothing = outer
                OuterClothing.text = outer.name;
            }
            }
        }
        } else {
            var bestOuterClothingNoPP = dummyClothing
            var bestOuterTempDiff = 100.0
            for outerwear in outerwearList {
                if (outerwear.worn) {
                if(abs(outerwear.temperature - worstTemp) < bestOuterTempDiff){
                    bestOuterTempDiff = abs(outerwear.temperature - worstTemp)
                    
                    bestOuterClothingNoPP = outerwear
                    OuterClothing.text = outerwear.name
                }
                }
                
            }
            
            if (bestOuterTempDiff > 10){
                OuterClothing.text = ""
                //bestOuterClothing = bestOuterClothingNoPP
            }
        }
        
//        TopClothing.text = bestTop.name
//        BottomClothing.text = bestBottom.name
//        if (!(bestOuterClothing.name == "")) {
//            OuterClothing.text = bestOuterClothing.name
//        }
        
        print(bestTop.name)
        print(bestBottom.name)
        print(bestOuterClothing.name)
    }
}

        
    


extension FirstViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //  self.getWeather(center.latitude, center.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        //  mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}



