//
//  ApiHandler.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 08/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import Foundation
import Alamofire
//This class will handle all the network calls made to server
class ApiHandler{
    //base url
    var baseUrl = "https://2klqdzs603.execute-api.eu-west-2.amazonaws.com/cloths/"
    //end url to fetch product list
    let endUrlFetchProduct = "products"
    //end url for cart operations
    let endUrlcart = "cart"
    //authentication headers dictionary
    let headers = ["x-api-key": "ddd47077e0-fcf7-47d3-85ea-45e4788fa3b5"]
    
    //fetch the product list and save in database only if database is empty
    func productListApi(completionhandler:@escaping ([ProductModelObject]) -> ()){
        var productList:[ProductModelObject] = []
        productList = DbHandler.init().productLis()
        if productList.count == 0{
        baseUrl = baseUrl + endUrlFetchProduct
        Alamofire.request(baseUrl,
                           method: HTTPMethod.get,
        headers: headers).responseJSON { (response:DataResponse<Any>) in
            do {
                debugPrint(response)
            switch(response.result) {
            case .success(_):
                if let _ = response.result.value {
                        guard let data = response.data else {
                            print("Error in Response data")
                            return
                    }
                    let modelData = try JSONDecoder().decode([ProductModelObject].self, from: data)
                    print("modelData11111")
                    completionhandler(modelData)
                }
                break
            case .failure(_):
                print(response.result.error as Any)
                // Service call failed // Due to some reasons need to be exclusive handling like network reason or //time out or etc //
                //completionHandler(nil,response.error as NSError?)
                break
                }
            } catch { print(error) }
        }
    }
    else {
    completionhandler(productList)
    }
    }
    
    //fetch the cart list and delete the item if exist else will not do anything
    func fetchCartItemAndDelete(productModelObject : ProductModelObject,completionhandler:@escaping ([ProductModelObject])->()){
        baseUrl = baseUrl + endUrlcart
        Alamofire.request(baseUrl,
                           method: HTTPMethod.get,
        headers: headers).responseJSON { (response:DataResponse<Any>) in
            do {
            switch(response.result) {
            case .success(_):
                if let _ = response.result.value {
                        guard let data = response.data else {
                            print("Error in Response data")
                            return
                    }
                    let modelData = try JSONDecoder().decode([CartModel].self, from: data)
                    for index in 0 ... modelData.count-1{
                        if productModelObject.id == modelData[index].productId{
                            self.deleteCartItemApi(id: modelData[index].id){
                                data in
                                let cartList:[ProductModelObject] = DbHandler.init().removeFromCart(productModelObject: productModelObject)
                                completionhandler(cartList)
                            }
                            break
                        }
                    }
                }
                break
            case .failure(_):
                print(response.result.error as Any)
                // Service call failed // Due to some reasons need to be exclusive handling like network reason or //time out or etc //
                //completionHandler(nil,response.error as NSError?)
                break
                }
            } catch { print(error) }
        }
    }
    
    //for deleting the cart item called after fetching the cart list api
    func deleteCartItemApi(id : Int,completionhandler:@escaping (String)-> ()){
        let parameters: Parameters = ["id": id]
        baseUrl = baseUrl + endUrlcart
        Alamofire.request(baseUrl,
        method: HTTPMethod.delete,
        parameters: parameters,
        encoding: URLEncoding(destination: .queryString),
        headers: headers).responseJSON { (response:DataResponse<Any>) in
            do {
            switch(response.result) {
            case .success(_):
                if let _ = response.result.value {
                        guard let data = response.data else {
                            print("Error in Response data")
                            return
                    }
                    let modelData = try JSONDecoder().decode(AddCartModel.self, from: data)
                               completionhandler(modelData.message)
                    print("cart value added >>>  \(data)")
                }
                break
            case .failure(_):
                print(response.result.error as Any)
                // Service call failed // Due to some reasons need to be exclusive handling like network reason or //time out or etc //
                //completionHandler(nil,response.error as NSError?)
                break
                }
        }catch { print(error) }
    }
    }
    
    //add to cart api where item will get added in cart list
    func addToCartApi(productModelObject : ProductModelObject,completionhandler:@escaping (String) -> ()){
        baseUrl = baseUrl + endUrlcart
        let parameters: Parameters = ["productId": productModelObject.id]
        var modelData: AddCartModel = AddCartModel()
        Alamofire.request(baseUrl,
        method: HTTPMethod.post,
        parameters: parameters,
        encoding: URLEncoding(destination: .queryString),
        headers: headers).responseJSON { (response:DataResponse<Any>) in
            debugPrint(response)
            do {
            switch(response.result) {
            case .success(_):
                if let _ = response.result.value {
                        guard let data = response.data else {
                            print("Error in Response data")
                            return
                    }
                    debugPrint(response)
                     modelData = try JSONDecoder().decode(AddCartModel.self, from: data)
                    completionhandler(modelData.message)
                    print("cart value added >>>  \(data)")
                }
                break
            case .failure(_):
                print(response.result.error as Any)
                // Service call failed // Due to some reasons need to be exclusive handling like network reason or //time out or etc //
                //completionHandler(nil,response.error as NSError?)
                break
                }
            } catch { print(error) }
        }
    }
}

