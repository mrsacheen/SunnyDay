

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?&appid=&units=metric"
    
    var delegate: WeatherManagerDelegate?
    func fetchWeather(cityName: String){
        let urlString = ("\(weatherURL)&q=\(cityName)")
        print(urlString)
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            //Create a URL Session
            let session = URLSession(configuration: .default)
            //give a session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //Start the task
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.list[0].weather[0].id
            let name = decodedData.list[0].name
            let temp = decodedData.list[0].main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
