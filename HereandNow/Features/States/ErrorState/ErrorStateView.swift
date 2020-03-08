import UIKit

protocol ErrorStateViewDelegate: class {
  func didTapTryAgain()
}

class ErrorStateView: UIView {

  @IBOutlet private weak var containerButton: UIView!

  weak var delegate: ErrorStateViewDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    containerButton.roundedCorners()
  }

  @IBAction func didTapTryAgain(_ sender: Any) {
    delegate?.didTapTryAgain()
  }
}
