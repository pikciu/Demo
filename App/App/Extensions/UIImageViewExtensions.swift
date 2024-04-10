import NukeExtensions
import UIKit
import Combine
import Nuke

extension UIImageView {
    
    func loadImage(with url: URL?) -> AnyCancellable {
        let task = NukeExtensions.loadImage(with: url, into: self) { result in
            if case .failure(let error) = result {
                debugPrint(error)
            }
        }
        return AnyCancellable {
            task?.cancel()
        }
    }
}
