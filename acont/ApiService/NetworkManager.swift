//
//  network.swift
//  acont
//
//  Created by serif mete on 8.02.2023.
//

import Foundation

// MARK: - SUNUCU BAĞLANTI KONTROLÜ
final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    // MARK: - Değerlerin Hepsini Kullanıp Kullanmıyacağımızın Kararına Geleştiriciye Bırakıyor
    @discardableResult
    /* MARK: - Download URLSessionDataTask Döndürüyor ,
     - URL Alınıyor , ENUM Bir Result İçinde DATA VE ERROR Var */
    func download(url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {
        // MARK: - URLSession closure oluşturma
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            //MARK: Error Kontrolü
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            //MARK: - Sunucudan Gelen Cevap(response) Kontrolü ( 200 ok cevabı)
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            //MARK: - Data optinal olmaktan kurtulunuyor , Data Kontrolü
            guard let data = data else {
                
                completion(.failure(URLError(.badURL)))
                return
            }
            //MARK: - data başarıyla alındı
            completion(.success(data))
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
