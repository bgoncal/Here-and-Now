import Foundation

struct HomeViewData {
  let cells: [Places]
}

protocol HomeViewControllerProtocol: class {
  var viewModel: HomeViewModel? { get set }
  var viewData: HomeViewData? { get set }
}

protocol HomeViewModelDelegate: class {

}

class HomeViewModel {

  private var locationService: LocationServiceProtocol
  private let apiService: GoogleApiServiceProtocol
  private var places: [Places] = []
  private var currentCoordinate: Coordinate? {
    didSet {
      getPlaces()
    }
  }

  weak var delegate: HomeViewModelDelegate?
  weak var view: HomeViewControllerProtocol?

  init(locationService: LocationServiceProtocol,
       apiService: GoogleApiServiceProtocol) {
    self.locationService = locationService
    self.apiService = apiService
    self.locationService.delegate = self
  }

  func viewDidLoad() {
    locationService.requestLocation()
    updateView()
    getPlaces()
  }

  private func updateView() {
    view?.viewData = HomeViewData(cells: places)
  }

  private func getPlaces() {
    guard let coordinate = currentCoordinate else { return }
    apiService.getPlaces(for: coordinate, type: .restaurant) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let places):
          self?.places = places.results
        case .failure(let error):
          print(error)
        }
        self?.updateView()
      }
    }
  }
}

extension HomeViewModel: LocationServiceDelegate {
  func didUpdateLocations(locations: [Coordinate]) {
    if currentCoordinate == nil {
      currentCoordinate = locations.last
    }
  }
}
