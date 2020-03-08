import Foundation

struct OnboardingViewData {
  let locationAuthorized: Bool
  let permissionRequested: Bool
}

protocol OnboardingViewControllerProtocol: class {
  var viewModel: OnboardingViewModel? { get set }
  var viewData: OnboardingViewData? { get set }
}

protocol OnboardingViewModelDelegate: class {
  func didAuthorizedLocation()
}

class OnboardingViewModel {

  private var locationService: LocationServiceProtocol
  private var locationAuthorized: Bool = false

  weak var view: OnboardingViewControllerProtocol?
  weak var delegate: OnboardingViewModelDelegate?
  
  init(locationService: LocationServiceProtocol) {
    self.locationService = locationService
    self.locationService.delegate = self
  }

  func viewDidLoad() {
    updateView()
  }

  func didTapAllow() {
    locationService.requestLocation()
  }

  func didTapManualSearch() {

  }

  func didTapOpeniPhoneSettings() {
    
  }

  private func updateView() {
    view?.viewData = OnboardingViewData(locationAuthorized: locationAuthorized,
                                        permissionRequested: locationService.permissionRequested)
  }
}

extension OnboardingViewModel: LocationServiceDelegate {
  func didChangeAuthorization(approved: Bool) {
    if approved {
      delegate?.didAuthorizedLocation()
    } else {
      locationAuthorized = approved
      updateView()
    }
  }
}
