import UIKit
import MapKit

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {

  @IBOutlet private weak var mapView: MKMapView!
  @IBOutlet private weak var placeName: UILabel!
  @IBOutlet private weak var openNow: UILabel!
  @IBOutlet private weak var rating: UILabel!
  @IBOutlet private weak var informationContainer: UIView!
  @IBOutlet private weak var imageView: UIImageView!

  var viewModel: DetailsViewModel?
  var viewData: DetailsViewData? {
    didSet {
      guard let viewData = viewData else { return }
      updateView(with: viewData)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    informationContainer.roundedCorners()
    imageView.roundedCorners()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel?.viewDidAppear()
  }

  private func updateView(with viewData: DetailsViewData) {
    setupMap(annotationName: viewData.name,
             location: viewData.location)

    placeName.text = viewData.name
    openNow.text = viewData.openNow
    rating.text = viewData.rating
    imageView.image = viewData.image
  }

  private func setupMap(annotationName: String, location: Location) {
    mapView.annotations.forEach { mapView.removeAnnotation($0) }
    let placePoint = MKPointAnnotation()
    placePoint.title = annotationName
    let coordinate = CLLocationCoordinate2D(latitude: location.lat,
                                            longitude: location.lng)
    placePoint.coordinate = coordinate
    mapView.addAnnotation(placePoint)
    mapView.showAnnotations([placePoint], animated: false)
  }
}
