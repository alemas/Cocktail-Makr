//
//  APIClient.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import Foundation
import RxSwift
import UIKit

class APIRequest {
    
    static func get(url: URL) -> Observable<Data?> {
        return Observable.create { observer in
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    // 200 to 399 status codes means everything went well
                    if (200...399).contains(statusCode) {
                        observer.onNext(data)
                    } else {
                        observer.onError(error!)
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create() {
                task.cancel()
            }
        }
        
    }
    
}
