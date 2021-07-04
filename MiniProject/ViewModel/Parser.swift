//
//  Parser.swift
//  MiniProject
//
//  Created by user199474 on 7/1/21.
//

import Foundation

enum ParserError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct Parser {
    let resourceURL: URL
    
    init(gitSearch: String) {
        let resourceString = "https://api.github.com/search/repositories?q=\("\(gitSearch)")"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getparser(completion : @escaping (Result<[Item], ParserError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gitResponse = try decoder.decode(Root.self, from: jsonData)
                let gitDetails = gitResponse.items 
                completion(.success(gitDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
