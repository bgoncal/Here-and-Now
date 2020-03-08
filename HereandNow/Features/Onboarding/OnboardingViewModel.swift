import Foundation
import UIKit

struct OnboardingViewData: Equatable {
  let locationAuthorized: Bool
  let permissionRequested: Bool
}

protocol OnboardingViewControllerProtocol: class {
  var viewModel: OnboardingViewModel? { get set }
  var viewData: OnboardingViewData? { get set }
}

protocol OnboardingViewModelDelegate: class {
  func didAuthorizedLocation()
  func didTapOpeniPhoneSettings()
  func didTapManualSearch()
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

  func viewDidAppear() {
    updateView()
  }

  func didTapAllow() {
    locationService.requestLocation()
  }

  func didTapManualSearch() {
    delegate?.didTapManualSearch()
  }

  func didTapOpeniPhoneSettings() {
    delegate?.didTapOpeniPhoneSettings()
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
    }

    locationAuthorized = approved
    updateView()
  }
}
