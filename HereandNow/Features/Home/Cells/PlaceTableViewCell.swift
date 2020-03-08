import UIKit

class PlaceTableViewCell: UITableViewCell {

  @IBOutlet private weak var placeName: UILabel!
  @IBOutlet private weak var openNow: UILabel!
  @IBOutlet private weak var ratingLabel: UILabel!

  func setup(with place: Place) {
    placeName.text = place.name
    openNow.text = place.opening_hours?.readableValue
    ratingLabel.text = place.readableRating
  }
}
