import Foundation

class UnsplashPhotoService {
    
    static let shared = { UnsplashPhotoService() }()
    
    func getRandomPhotos(count: Int, success: @escaping (Int, [UnsplashPhoto]) -> (), failure: @escaping (Int) -> ()) {
        
        APIClient.shared.getArray(configureAPICall(on: GET_RANDOM_PHOTOS, count: count), success: { (code, unsplashPhotoModels: [UnsplashPhoto]) in
            success(code, unsplashPhotoModels)
        }) { (code) in
            failure(code)
        }
    }
    
    func configureAPICall(on baseAPICall: String, count: Int) -> String {
        return baseAPICall + "?" + "count" + "=" + "\(count)"
    }
    
}
