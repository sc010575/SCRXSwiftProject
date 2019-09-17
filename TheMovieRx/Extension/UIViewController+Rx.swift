import UIKit
import RxSwift

extension UIViewController {

    func alert(title: String, text: String?) -> Completable {
        return Completable.create { [weak self] completable in
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
                completable(.completed)
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }

    func showError(_ error: Error, bag: DisposeBag) {
        if let e = error as? RxURLSessionError {
            switch e {
            case .requestFailed:
                alert(title: "Error", text: "Request failed").subscribe().disposed(by: bag)
            case .unknown:
                alert(title: "Error", text: "Unknown error").subscribe().disposed(by: bag)
            case .invalidResponse(_):
                alert(title: "Error", text: "Invalid response").subscribe().disposed(by: bag)
            case .deserializationFailed:
                alert(title: "Error", text: "Serialization failed").subscribe().disposed(by: bag)

            }
        }else {
            alert(title: "Error", text: "Unknown error!!!") .subscribe().disposed(by: bag)
        }
    }
}

