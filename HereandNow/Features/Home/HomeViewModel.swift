import Foundation

struct HomeViewData {
  let places: [Place]
  let segments: [String]
  let selectedSegmentIndex: Int
}

protocol HomeViewControllerProtocol: class {
  var viewModel: HomeViewModel? { get set }
  var viewData: HomeViewData? { get set }
}

protocol HomeViewModelDelegate: class {
  func didTapPlace(_ place: Place)
}

class HomeViewModel {

  private var locationService: LocationServiceProtocol
  private let apiService: GoogleApiServiceProtocol
  private var places: [Place] = []
  private let segments = ["Bars", "Cafes", "Restaurants"]
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

  func didRefresh() {
    getPlaces()
  }

  func didTapPlace(_ place: Place) {
    delegate?.didTapPlace(place)
  }

  private func updateView() {
    view?.viewData = HomeViewData(places: places,
                                  segments: segments,
                                  selectedSegmentIndex: 0)
  }

  private func getPlaces() {
    guard let coordinate = currentCoordinate else { return }
    apiService.getPlaces(for: coordinate, type: .restaurant) { [weak self] result in
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

extension HomeViewModel: LocationServiceDelegate {
  func didUpdateLocations(locations: [Coordinate]) {
    if currentCoordinate == nil {
      currentCoordinate = locations.last
    }
  }
}
