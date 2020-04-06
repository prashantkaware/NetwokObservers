//
//  ServerRequests.swift
//  NetwokObserverAndNetwoking
//
//  Created by Prashant on 05/04/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

//import Alamofire
//
//class ServerRequests {
//
//    static let sharedInstance = ServerRequests()
//    let net = NetworkReachabilityManager()
//
//    private init() {}
//
//    let decoder = JSONDecoder()
//
//    func makePostRequest<T: Codable>(_ url: String, _ parameters: [String: Any], responseListener: @escaping (_ data: T?) -> (), errorListener: @escaping (_ errorCode: Int, _ errorMessage: String) -> Void) {
//        if net!.isReachable{
//            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseData { (responseData) in
//                print(url)
//                if let status = responseData.response?.statusCode {
//                    if status == 200 {
//                        if let error = responseData.error {
//                            errorListener(-1, error.localizedDescription)
//                        } else {
//                            let data = responseData.data
//                            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
//                            print(dict)
//                            do {
//                                let decodedData = try self.decoder.decode(T.self, from: data!)
//                                print(decodedData)
//                                responseListener(decodedData)
//                            } catch {
//                                print("error")
//                                errorListener(-1, error.localizedDescription)
//                            }
//                        }
//                    } else {
//                        errorListener(status, responseData.error?.localizedDescription ?? "Unknown error")
//                    }
//                } else {
//                    errorListener(-1, "Unknown error")
//                }
//            }
//        }else{
//            errorListener(-2, "No internet connection")
//        }
//
//    }
//
//    func makeGetRequest<T: Codable>(_ url: String, _ parameters: [String: Any], responseListener: @escaping (_ data: T?) -> Void, errorListener: @escaping (_ errorCode: Int, _ errorMessage: String) -> Void) {
//        if net!.isReachable{
//            Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseData { (responseData) in
//                if let status = responseData.response?.statusCode {
//                    if status == 200 {
//                        if let error = responseData.error {
//                            errorListener(-1, error.localizedDescription)
//                        } else {
//                            let data = responseData.data
//                            do {
//                                let decodedData = try self.decoder.decode(T.self, from: data!)
//                                responseListener(decodedData)
//                            } catch {
//                                print("error")
//                                errorListener(-1, error.localizedDescription)
//                            }
//                        }
//                    } else {
//                        errorListener(status, responseData.error?.localizedDescription ?? "Unknown error")
//                    }
//                } else {
//                    errorListener(-1, "Unknown error")
//                }
//            }
//        }else{
//            errorListener(-2, "No internet connection")
//        }
//
//    }
//
//
//    func uploadImage<T: Codable>(_ url: String, _ parameters: [String: Any], _ image: UIImage?, _ imageName: String?, _ imageParameterName: String?, responseListener: @escaping (_ data: T?) -> Void, errorListener: @escaping (_ errorCode: Int, _ errorMessage: String) -> Void) {
//
//        var imageData: Data?
//        //var imageName: String?
//
//        if let receipt = image {
//            imageData = receipt.jpegData(compressionQuality: 0.2)!
//            //imageName = parameters["expense_title"] as? String
//        }
//        if net!.isReachable{
//            Alamofire.upload(multipartFormData: { (multipartData) in
//                if imageData != nil {
//                    multipartData.append(imageData!, withName: imageParameterName!, fileName: imageName!, mimeType: "image/jpg")
//                    for(key, value) in parameters {
//                        let val = value as? String
//                        multipartData.append((val?.data(using: String.Encoding.utf8))!, withName: key)
//                    }
//                } else {
//                    for(key, value) in parameters {
//                        let val = value as? String
//                        multipartData.append((val?.data(using: String.Encoding.utf8))!, withName: key)
//                    }
//                }
//
//            }, to: url) { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress : \(progress.fractionCompleted)")
//                    })
//                    upload.responseJSON(completionHandler: { (responseData) in
//                        let status = responseData.response?.statusCode
//                        if status == 200 {
//                            if let error = responseData.error {
//                                errorListener(-1, error.localizedDescription)
//                            } else {
//                                let data = responseData.data
//                                let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
//                                print(dict)
//                                do {
//                                    let decodedData = try self.decoder.decode(T.self, from: data!)
//                                    responseListener(decodedData)
//                                } catch {
//                                    print("decoding error : \(error.localizedDescription)")
//                                    errorListener(-1, error.localizedDescription)
//                                }
//                            }
//                        } else {
//                            errorListener(status!, responseData.error?.localizedDescription ?? "Unknown error")
//                        }
//                    })
//
//                case .failure(let encodingError):
//                    print(encodingError)
//                    errorListener(-1, encodingError.localizedDescription)
//                }
//            }
//        } else {
//            errorListener(-2, "No internet connection")
//
//        }
//
//    }
//
//}

