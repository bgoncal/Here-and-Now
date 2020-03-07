import Foundation

struct HomeViewData {

}

protocol HomeViewControllerProtocol: class {
  var viewModel: HomeViewModel? { get set }
  var viewData: HomeViewData? { get set }
}

protocol HomeViewModelDelegate: class {

}

class HomeViewModel {

  weak var delegate: HomeViewModelDelegate?
  weak var view: HomeViewControllerProtocol?

  func viewDidLoad() {
    updateView()
  }

  private func updateView() {
    view?.viewData = HomeViewData()
  }
}
