import Foundation

struct HomeViewData {
  let places: [Place]
  let segments: [PlaceType]
  let selectedSegmentIndex: Int
  let showLoader: Bool
  let showErrorState: Bool
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
  private let segments: [PlaceType] = [.bar, .cafe, .restaurant]
  private var currentSegment: PlaceType = .restaurant
  private var currentSegmentIndex = 0
  private var currentCoordinate: Coordinate?
  private var needRefreshForLocation = false

  weak var delegate: HomeViewModelDelegate?
  weak var view: HomeViewControllerProtocol?

  init(locationService: LocationServiceProtocol,
       apiService: GoogleApiServiceProtocol) {
    self.locationService = locationService
    self.apiService = apiService
  }

  func viewDidLoad() {
    locationService.requestLocation()
    locationService.delegate = self
  }

  func didRefresh() {
    getPlaces()
  }

  func didTapPlace(_ place: Place) {
    delegate?.didTapPlace(place)
  }

  func didSelectSegment(index: Int) {
    currentSegmentIndex = index
    currentSegment = segments[index]
    getPlaces()
  }

  func didTapTryAgain() {
    getPlaces()
  }

  func didTapSortRatingAscending() {
    places = places.sorted(by: { ($0.rating ?? 0.0) < ($1.rating ?? 0.0) })
    updateView()
  }

  func didTapSortRatingDescending() {
    places = places.sorted(by: { ($0.rating ?? 0.0) > ($1.rating ?? 0.0) })
    updateView()
  }

  private func updateView(showLoader: Bool = false, showErrorState: Bool = false) {
    view?.viewData = HomeViewData(places: places,
                                  segments: segments,
                                  selectedSegmentIndex: currentSegmentIndex,
                                  showLoader: showLoader,
                                  showErrorState: showErrorState)
  }

  private func getPlaces() {
    updateView(showLoader: true)

    guard let coordinate = currentCoordinate else {
      needRefreshForLocation = true
      locationService.requestLocation()
      return
    }

    apiService.getPlaces(for: coordinate, type: currentSegment) { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let places):
        strongSelf.places = places.results
        strongSelf.updateView(showLoader: false)
      case .failure:
        strongSelf.updateView(showLoader: false, showErrorState: true)
      }
    }
  }
}

extension HomeViewModel: LocationServiceDelegate {
  func didUpdateLocations(locations: [Coordinate]) {
    if currentCoordinate == nil {
      currentCoordinate = locations.last
      getPlaces()
    }
  }
}
