//
//  ViewController.swift
//  AllWeather
//
//  Created by Alex Grazhdan on 05.01.2023.
//
import Alamofire
import CoreLocation
import RealmSwift

import UIKit

class ViewController: UIViewController {
    
    let dbManeger: RealmManeger = DBWeather()
    
    var arryaWeek : [List] = []
    
    //MARK: - IBOutlet
    @IBOutlet private var postImage: UIImageView!
    
    @IBOutlet weak var nameRegoin: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var currentWeather: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    var condition = ""

    var currenW = 1
    var max = 5
    @IBOutlet weak var contantView: UIView!
    
    @IBOutlet private var collectonView : UICollectionView!
    
    private var mainRealm = try? Realm()
    private var arrayCurrentWeater : [SaveWeather] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestWeatehrForLocation(lat: 51.5074, lon: -0.1278)
        setupView()
//
        //Register Cell
        collectonView.dataSource = self
        let WeatherCollectionViewCellNib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        collectonView.register(WeatherCollectionViewCellNib, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        weatherCondition.text = condition
        currentWeather.text = "\(Int(currenW))"
        tempMax.text = "\(Int(max))"
        
        let modal = SaveWeather()
        modal.weatherCondition = condition
        modal.currentWeather = currenW
        modal.tempMax = max
        dbManeger.save(present: modal)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
//        let modals = dbManeger.obtainWeather()
        guard let modals = mainRealm?.objects(SaveWeather.self) else {return}
        for weather in modals {
            self.arrayCurrentWeater.append(weather)
        }
        print("\(modals)")
        
//        if let lastModal = modals.last {
//            dbManeger.delete(object:lastModal)
//        }
       
        
//        self.arrayCureentWeater = []
//
//        guard let infoMWeathers = realm?.objects(SaveWeather.self) else {return}
//
//        for weater in infoMWeathers {
//            self.arrayCureentWeater.append(weater)
//        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        let modals = dbManeger.obtainWeather()
//        print("\(modals)")
    }
    
//    func saveWeathers(weater: SaveWeather){
//
//        let arrayCureentWeater = SaveWeather()
//        arrayCureentWeater.currentWeather = weater.currentWeather
//        arrayCureentWeater.weatherCondition = weater.weatherCondition
//        arrayCureentWeater.tempMax = weater.tempMax
//        arrayCureentWeater.humidity = weater.humidity
//        arrayCureentWeater.precipitation = weater.precipitation
//        arrayCureentWeater.wind = weater.wind
//
//        try? realm?.write {
//            realm?.add(arrayCureentWeater, update: .all)
//        }
//
//    }
//
//
//
//    func deleteIfExists(weatherData: SaveWeather) {
//        if let existingData = realm?.object(ofType: SaveWeather.self, forPrimaryKey: weatherData.weatherCondition) {
//              do {
//                  try realm?.write {
//                      realm?.delete(existingData)
//                      print("???????? ???????????? ?????????????? ????????????????")
//                  }
//              } catch {
//                  print("?????????????? ?????? ?????????????????? ?????????? ????????????: \(error.localizedDescription)")
//              }
//          } else {
//              print("???????? ???????????? ???????????????? ?? ???????? ??????????")
//          }
//      }
    
   
    func setupView(){
        contantView.layer.cornerRadius = 20
    }
    func requestWeatehrForLocation(lat: Double, lon: Double){
        
        //        guard let currentLocation = currentLocation else {
        //            return
        //        }
        //        let lon = currentLocation.coordinate.longitude
        //        let lat = currentLocation.coordinate.latitude
        
        print("\(lon) | \(lat)")
        
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=246aae878eba3bb799b8cb312a03ed5f&units=metric"
        
        AF.request(url).responseJSON { response in
            guard let responseData = response.data else {return}
            let dataString = String(data: responseData, encoding: .utf8) ?? ""
//            print(dataString)
            do {
                let data = try JSONDecoder().decode(WeatherResponse.self, from: response.data!)
                
                self.nameRegoin.text = data.city.name
                self.postImage.image = data.list[0].weather[0].conditionImage
                self.weatherCondition.text = data.list[0].weather[0].main.rawValue
                self.currentWeather.text = "\(Int(data.list[0].main.temp))????"
                self.tempMax.text = "\(Int(data.list[0].main.tempMax))????"
                self.humidity.text = "\(Int(data.list[0].main.humidity))%"
                self.precipitation.text = "\(Int(data.list[0].main.feelsLike))????"
                self.wind.text = "\(Int(data.list[0].wind.gust))km/gh"
                self.dataLabel.text = data.list[0].dtTxt
                self.arryaWeek = data.list
                self.collectonView.reloadData()
                
            }catch{
                print("error \(error)")
            }
        }
        
    }
    
}

    
    //MARK: - Extension CollectinView
    
    extension ViewController :  UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return arryaWeek.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
            
            cell.configure(arryaWeek[indexPath.row])
            
            return cell
            
        }
        
    }

