import Foundation
import RxSwift
import RxCocoa

struct GridViewModel {
    
    var sections = [SectionOfGridCellData]()
    
    func getRandomPhotos(count: Int, completion: @escaping ([SectionOfGridCellData]?) -> ()) {
        
        UnsplashPhotoService.shared.getRandomPhotos(count: count, success: { (code, photoModels) in
            
            var gridCellData = [GridCellData]()
            
            for photoModel in photoModels {
                if let urlString = photoModel.urls!.small {
                    let url = URL(string: urlString)
                    gridCellData.append(GridCellData(photoURL: url!))
                }
            }
            
            completion([SectionOfGridCellData(title: "Photos", items: gridCellData)])
        }) { (code) in
            completion(nil)
        }
        
    }
    
}
