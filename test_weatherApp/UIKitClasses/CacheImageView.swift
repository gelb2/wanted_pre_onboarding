//
//  CacheImageView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import UIKit

//TODO: Repository와 어떻게 엮어야 하나 고려...특히 아래 URLSessionRequest도...
class CacheImageView: UIImageView {

    var lastImageURLString: String?

    private let sharedHandler = CacheHandler.sharedInstance
    
    func loadImage(urlString: String) {
        self.image = nil
        self.lastImageURLString = urlString
        if let image = sharedHandler.object(forKey: urlString) as? UIImage {
            self.image = image
            return
        }
        Task {
            await requestImage(urlString: urlString)
        }
    }
    
    private func requestImage(urlString: String) async {
        do {
            let data = try await sharedHandler.fetch(with: urlString)
            guard let absoluteString = data.1?.absoluteString else { return }
            guard lastImageURLString == absoluteString else { return }
            guard let image = UIImage(data: data.0) else { return }
            
            sharedHandler.setObject(image, forKey: absoluteString)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } catch {
            handleError(error: error)
        }
    }
    
    func handleError(error: Error) {
        let error = error as? HTTPError
        switch error {
        case .badURL, .badResponse, .errorDecodingData, .invalidURL, .iosDevloperIsStupid:
            print("error : \(String(describing: error))")
        default:
            break
        }
    }
    
    func deprecated_requestImage(urlString: String) {
        self.image = nil
        self.lastImageURLString = urlString

        if let image = sharedHandler.object(forKey: urlString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            //TODO: 기본이미지 set
            return }
        
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
            
            self?.sharedHandler.setObject(image, forKey: url.absoluteString)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
        
    }
}
