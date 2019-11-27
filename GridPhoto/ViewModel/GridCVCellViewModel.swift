import Foundation
import RxSwift
import Kingfisher

struct GridCVCellViewModel {
    
    func loadPhoto(with photoURL: URL, completion: @escaping (UIImage?) -> ()) {
        KingfisherManager.shared.retrieveImage(with: photoURL, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image)")
                completion(value.image)
            case .failure(let error):
                print("Couldn't get image: \(error)")
                completion(nil)
            }
        }
    }
}
