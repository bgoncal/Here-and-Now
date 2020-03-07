import UIKit

class HomeViewController: UIViewController, HomeViewControllerProtocol {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var segments: UISegmentedControl!

  private let reusableIdentifier = "cell"
  private let cellNib = UINib(nibName: "PlaceTableViewCell", bundle: nil)

  var viewModel: HomeViewModel?
  var viewData: HomeViewData? {
    didSet {
      guard let viewData = viewData else { return }
      updateView(with: viewData)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(cellNib, forCellReuseIdentifier: reusableIdentifier)
    viewModel?.viewDidLoad()
  }

  @IBAction func selectedSegmentChanged(_ sender: Any) {

  }

  private func updateView(with viewData: HomeViewData) {
    tableView.reloadData()
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData?.cells.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? PlaceTableViewCell {
      return cell
    }
    return UITableViewCell()
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}
