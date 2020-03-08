import UIKit

class HomeViewController: UIViewController, HomeViewControllerProtocol {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var segments: UISegmentedControl!

  private let reusableIdentifier = "cell"
  private let cellNib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
  private var refreshControl = UIRefreshControl()
  private var loader = LoaderView.loadFromNib()
  private var errorState = ErrorStateView.loadFromNib()

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
    navigationController?.navigationBar.setupBarStyle()
    setupRefreshControl()
    setupLoader()
    setupErrorState()
    setupNavigationBarActions()

    viewModel?.viewDidLoad()
  }

  @IBAction func selectedSegmentChanged(_ sender: Any) {
    let selectedIndex = segments.selectedSegmentIndex
    viewModel?.didSelectSegment(index: selectedIndex)
  }

  @objc private func refresh() {
    viewModel?.didRefresh()
  }

  private func setupLoader() {
    loader.isHidden = true
    view.addConstrainedSubview(view: loader)
  }

  private func setupNavigationBarActions() {
    let sortUp = UIBarButtonItem(title: "✪👆", style: .plain, target: self, action: #selector(didTapSortRatingDescending))
    let sortDown = UIBarButtonItem(title: "✪👇", style: .plain, target: self, action: #selector(didTapSortRatingAscending))

    navigationItem.rightBarButtonItems = [sortUp, sortDown]
  }

  @objc private func didTapSortRatingAscending() {
    viewModel?.didTapSortRatingAscending()
  }

  @objc private func didTapSortRatingDescending() {
    viewModel?.didTapSortRatingDescending()
  }

  private func setupRefreshControl() {
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
  }

  private func setupErrorState() {
    errorState.isHidden = true
    errorState.delegate = self
    view.addConstrainedSubview(view: errorState)
  }

  private func updateView(with viewData: HomeViewData) {
    tableView.reloadData()
    segments.removeAllSegments()
    viewData.segments.forEach { segment in
      segments.insertSegment(withTitle: segment.readableValue, at: 0, animated: false)
    }
    segments.selectedSegmentIndex = viewData.selectedSegmentIndex
    if !viewData.showLoader {
      refreshControl.endRefreshing()
    }
    errorState.isHidden = !viewData.showErrorState
    loader.isHidden = !viewData.showLoader
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

extension HomeViewController: ErrorStateViewDelegate {
  func didTapTryAgain() {
    viewModel?.didTapTryAgain()
  }
}
