import UIKit

class GridCVCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Properties
    let gridCVCellViewModel = GridCVCellViewModel()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var photoURL: URL? {
        didSet {
            gridCVCellViewModel.loadPhoto(with: photoURL!) { (image) in
                self.photoImageView.image = image
            }
        }
    }

}
