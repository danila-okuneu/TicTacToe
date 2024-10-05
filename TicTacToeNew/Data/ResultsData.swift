
//
//  ResultsData.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 30.09.24.
//


struct Results: Codable {
    
    static var list: [Result] = []
    
    
    // MARK: - Static methods
    
	static func clearResults() {
        Results.list = []
    }
    
	
	
    static func getResults() -> [(Int, Result)] {

        var results: [(Int, Result)] = []
        
        for (index, result) in Results.list.enumerated() {
            results.append((index + 1, result))
        }
        
        return results
    }
    
    
    static func save() {
        Saves.set(list, for: "Results")
    }
    
	
    static func load() {
        Results.list = Saves.get(for: "Results", as: [Result].self) ?? []
    }
    

}
