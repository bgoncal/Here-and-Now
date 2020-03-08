import UIKit

extension UIView {

  static var nibName: String {
    return String(describing: self)
  }

  static var bundle: Bundle {
    return Bundle(for: self)
  }

  static var nib: UINib {
    return UINib(nibName: nibName, bundle: bundle)
  }

  static func loadFromNib() -> Self {
    return loadFromNib(self)
  }

  static func loadFromNib<T: UIView>(_ viewType: T.Type) -> T {
    let className = String(describing: viewType)
    guard let view = bundle.loadNibNamed(className, owner: nil, options: nil)?.first as? T else {
      preconditionFailure("Couldn't load nib for class \(className)")
    }
    return view
  }

  func addConstrainedSubview(view: UIView) {
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    self.addConstraint(NSLayoutConstraint(item: self,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .top,
                                          multiplier: 1.0,
                                          constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: self,
                                          attribute: .bottom,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .bottom,
                                          multiplier: 1.0,
                                          constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: self,
                                          attribute: .left,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .left,
                                          multiplier: 1.0,
                                          constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: self,
                                          attribute: .right,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .right,
                                          multiplier: 1.0,
                                          constant: 0.0))
  }
}
