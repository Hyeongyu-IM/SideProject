import UIKit

class WeatherViewController: UIViewController {
  
  private let viewModel = WeatherViewModel()

  
  
//  private let dateFormatter: DateFormatter = {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "EEEE, MMM d"
//    return dateFormatter
//  }()
//  private let tempFormatter: NumberFormatter = {
//    let tempFormatter = NumberFormatter()
//    tempFormatter.numberStyle = .none
//    return tempFormatter
//  }()
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  override func viewDidLoad() {
    
    viewModel.locationName.bind { [weak self] locationName in
      self?.cityLabel.text = locationName
    }
    viewModel.date.bind { [weak self] date in
      self?.dateLabel.text = date
    }
    viewModel.icon.bind { [weak self] image in
      self?.currentIcon.image = image
    }
        
    viewModel.summary.bind { [weak self] summary in
      self?.currentSummaryLabel.text = summary
    }
        
    viewModel.forecastSummary.bind { [weak self] forecast in
      self?.forecastSummary.text = forecast
    }
  }
    @IBAction func promptForLocation(_ sender: Any) {
        //1
        let alert = UIAlertController(
          title: "Choose location",
          message: nil,
          preferredStyle: .alert)
        alert.addTextField()
        //2
        let submitAction = UIAlertAction(
          title: "Submit",
          style: .default) { [unowned alert, weak self] _ in
            guard let newLocation = alert.textFields?.first?.text else { return }
            self?.viewModel.changeLocation(to: newLocation)
        }
        alert.addAction(submitAction)
        //3
        present(alert, animated: true)

    }
    
//  func fetchWeatherForLocation(_ location: Location) {
//    //1
//    WeatherbitService.weatherDataForLocation(
//      latitude: location.latitude,
//      longitude: location.longitude) { [weak self] (weatherData, error) in
//      //2
//      guard
//        let self = self,
//        let weatherData = weatherData
//        else {
//          return
//        }
//      self.dateLabel.text =
//        self.dateFormatter.string(from: weatherData.date)
//      self.currentIcon.image = UIImage(named: weatherData.iconName)
//      let temp = self.tempFormatter.string(
//        from: weatherData.currentTemp as NSNumber) ?? ""
//      self.currentSummaryLabel.text =
//        "\(weatherData.description) - \(temp)℉"
//      self.forecastSummary.text = "\nSummary: \(weatherData.description)"
//    }
//  }
}

