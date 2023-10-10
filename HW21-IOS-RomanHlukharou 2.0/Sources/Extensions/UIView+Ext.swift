import UIKit
import Alamofire

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageFromUrl(urlString: String) {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage? {
            self.image = imageFromCache
            return
        }
        
        AF.request(urlString, method: .get).response { responseData in
            if let data = responseData.data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                    }
                }
            }
        }
     }
}
