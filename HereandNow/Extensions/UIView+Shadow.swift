import UIKit

extension UIView {
  func cardShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 40
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
  }
}
