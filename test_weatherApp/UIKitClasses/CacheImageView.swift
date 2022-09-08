//
//  CacheImageView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import UIKit

//TODO: Repository와 어떻게 엮어야 하나 고려...특히 아래 URLSessionRequest도...
class CacheImageView: UIImageView {
    
    private var sharedCache = NSCache<AnyObject, AnyObject>.sharedCache
    private var lastImageURLString: String?
    
    
    func loadImage(urlString: String) {
        self.image = nil
        self.lastImageURLString = urlString
        
        if let image = sharedCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            //TODO: 기본이미지 set
            return }
        
        //TODO: gcd, 기존의 비동기 처리 대신 "async" 애트리뷰트로 처리 간결하게...
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            //TODO: 에러 핸들링
            if let error = error {
                print("이미지 로딩 실패 : \(String(describing: error))")
            }
            //TODO: 예외처리
            if self?.lastImageURLString != url.absoluteString {
                return
            }
            //TODO: 예외처리
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self?.sharedCache.setObject(image, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
        
    }
    
    

}
