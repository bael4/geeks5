//
//  NetworkService.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 15/5/23.
//

import Foundation



struct ProductResponse: Codable {
    var products: [Product]
}

struct Product: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var thumbnail: String
}


enum Constans {
    enum URLPaths {
        static let baseURL = URL(
            string: "https://dummyjson.com/docs/products"
        )!
    }
}

//struct NetworkService {
//
//    let session = URLSession.shared
//    let decoder = JSONDecoder()
//
//
//    func fetchProducts(
//        completion: @escaping (Result<[Product], Error>) -> Void )
//    {
//        let url = URL(string: "https://dummyjson.com/products")
//
//        let request = URLRequest(url: url!)
//
//        session.dataTask(with: request) { data, response, error in
//            guard let data else {
//                return
//            }
//            do {
//                let data: ProductResponse = try decode(data: data)
//                completion(
//                    .success(
//                        data.products
//                    )
//                )
//            } catch {
//                completion(
//                    .failure(
//                        error
//                    )
//                )
//            }
//
//        }.resume()
//    }
//
//    private func decode<T: Decodable>(data: Data) throws -> T {
//      try  decoder.decode(
//        T.self,
//        from: data
//      )
//    }
//}
struct NetworkService {
    let session = URLSession.shared
    let decoder = JSONDecoder()

    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products")!

        let (data, _) = try await URLSession.shared.data(from: url)
        let productsResponse = try decode(data: data, type: ProductResponse.self)
        return productsResponse.products
    }

    private func decode<T: Decodable>(data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
