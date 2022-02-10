//
//  DataHandler.swift
//  BrBaFlink
//
//  Created by Paulina González Dávalos on 09/02/22.
//

import Foundation

public class DataHandler {
    var characters = [Characters]()
    
    enum CharsError: Error {
        case invalidURL
        case invalidResponse(URLResponse?)
    }

    func getChars(completion: @escaping (Result<[Characters], Error>) -> Void) {
        let queue = DispatchQueue.main

        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else {
            queue.async { completion(.failure(CharsError.invalidURL)) }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                queue.async { completion(.failure(error)) }
                return
            }

            guard
                let data = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode
            else {
                queue.async { completion(.failure(CharsError.invalidResponse(response))) }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let chars = try decoder.decode([Characters].self, from: data)
                queue.async { completion(.success(chars)) }
            } catch let parseError {
                queue.async { completion(.failure(parseError)) }
            }
        }.resume()
    }
}
