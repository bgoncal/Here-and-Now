import UIKit

struct DetailsViewData: Equatable {
  let name: String
  let openNow: String
  let rating: String
  let image: UIImage?
  let location: Location
}

protocol DetailsViewControllerProtocol: class {
  var viewModel: DetailsViewModel? { get set }
  var viewData: DetailsViewData? { get set }
}

class DetailsViewModel {

  private let place: Place
  private let apiService: GoogleApiServiceProtocol
  private var cachedImage: UIImage? {
    didSet {
      updateView()
    }
  }

  weak var view: DetailsViewControllerProtocol?

  init(place: Place,
       apiService: GoogleApiServiceProtocol) {
    self.place = place
    self.apiService = apiService
  }

  func viewDidAppear() {
    updateView()
    getPlaceImage()
  }

  private func getPlaceImage() {
    if let photoReference = place.photos?.first?.photo_reference {
      apiService.getPlaceImage(photoReference: photoReference) { [weak self] result in
        switch result {
        case .success(let image):
          self?.cachedImage = image
        case .failure:
          break
        }
      }
    }
  }

  private func updateView() {
    view?.viewData = DetailsViewData(name: place.name,
                                     openNow: place.opening_hours?.readableValue ?? "",
                                     rating: place.readableRating,
                                     image: cachedImage,
                                     location: place.geometry.location)
  }
}
