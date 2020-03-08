import UIKit

class HomeViewController: UIViewController, HomeViewControllerProtocol {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var segments: UISegmentedControl!

  private let reusableIdentifier = "cell"
  private let cellNib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
  private var refreshControl = UIRefreshControl()

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

    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)

    viewModel?.viewDidLoad()
  }

  @IBAction func selectedSegmentChanged(_ sender: Any) {

  }

  @objc private func refresh() {
    viewModel?.didRefresh()
  }

  private func updateView(with viewData: HomeViewData) {
    tableView.reloadData()
    segments.removeAllSegments()
    viewData.segments.forEach { segment in
      segments.insertSegment(withTitle: segment, at: 0, animated: false)
    }

    segments.selectedSegmentIndex = 0
    refreshControl.endRefreshing()
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData?.places.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? PlaceTableViewCell,
      let place = viewData?.places[indexPath.row] {
      cell.setup(with: place)
      return cell
    }
    return UITableViewCell()
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let place = viewData?.places[indexPath.row] else { return }
    viewModel?.didTapPlace(place)
  }
}
