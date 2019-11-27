import UIKit

//MARK: - UIImage
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}


//MARK: - Data
extension Data {
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
}
