
import UIKit
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}
 
extension ViewController: CLLocationManagerDelegate{
    
       @IBAction func locationButtonIsPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
       }
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         // print("locations = \(locations)")
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
           
        }
      }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var weatherCondition: UIImageView!
    @IBOutlet weak var locationSearchBar: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        locationSearchBar.delegate = self
    }
   
    
    
    
}
//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel){
        DispatchQueue.main.async{
            self.cityName!.text = weather.cityName
            self.temperatureValue.text = String(weather.temperatureString)
            self.weatherCondition.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    func didFailWithError(error: Error){
        print(error)
    }
}
//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
           locationSearchBar.endEditing(true)
           print(locationSearchBar.text!)
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           locationSearchBar.endEditing(true)
           cityName.text = locationSearchBar.text
           return true
       }
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != "" {
               return true
           }
           else{
               textField.placeholder = "type Something"
               return false
           }
       }
       func textFieldDidEndEditing(_ textField: UITextField){
           //Use the
           if let city = locationSearchBar.text{
               weatherManager.fetchWeather(cityName: city)
           }
           locationSearchBar.text! = ""
       }
    
}

//MARK: - Yolo

