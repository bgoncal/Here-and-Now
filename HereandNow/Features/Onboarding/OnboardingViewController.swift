import UIKit

class OnboardingViewController: UIViewController, OnboardingViewControllerProtocol {

  @IBOutlet private weak var allowButtonContainer: UIView!
  @IBOutlet private weak var manualSearchButton: UIButton!
  @IBOutlet private weak var iPhoneSettingsContainer: UIView!

  var viewModel: OnboardingViewModel?
  var viewData: OnboardingViewData? {
    didSet {
      guard let viewData = viewData else { return }
      updateView(with: viewData)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    allowButtonContainer.roundedCorners()
    iPhoneSettingsContainer.roundedCorners()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel?.viewDidAppear()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  @IBAction func didTapAllow(_ sender: Any) {
    viewModel?.didTapAllow()
  }

  @IBAction func didTapManualSearch(_ sender: Any) {
    viewModel?.didTapManualSearch()
  }

  @IBAction func didTapOpeniPhoneSettings(_ sender: Any) {    viewModel?.didTapOpeniPhoneSettings()
  }

  private func updateView(with viewData: OnboardingViewData) {
    allowButtonContainer.isHidden = viewData.permissionRequested
    manualSearchButton.isHidden = viewData.permissionRequested
    iPhoneSettingsContainer.isHidden = !viewData.permissionRequested
  }
}

