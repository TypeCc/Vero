//
//  Service.swift
//  acont
//
//  Created by serif mete on 8.02.2023.
//


import Foundation


final class DownloadService {
    
    func downloadService(completion: @escaping ([PostElement]?) -> ()) {
        guard let url = URL(string: APIURLs.getapi()) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data): // success data
                completion(self.handleWithData(data))
            case .failure(let error): // error part
                self.handleWithError(error)
            }
        }
    }
    
    
    //MARK: - Error
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    //MARK: - Data
    private func handleWithData(_ data: Data) -> [PostElement]? {
        do {
            let JsonDec = try JSONDecoder().decode([PostElement].self, from: data)
            return JsonDec
        } catch {
            print(error)
            return nil
        }
    }
}




