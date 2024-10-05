//
//  Saves.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 30.09.24.
//

import Foundation

struct Saves {

	static var results: [Result] = [] 
		
	static var isTimeMode = true
	static var selectedTime = 60
	static var isMusicOn: Bool {
		get {
			return UserDefaults.standard.bool(forKey: "musicOn")
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "musicOn")
			if newValue {
				MusicPlayer.shared.startBackgroundMusic()
			} else {
				MusicPlayer.shared.stopBackgroundMusic()
			}
		}
	}
	
	static var selectedSong: String {
		get {
			return UserDefaults.standard.string(forKey: "songName") ?? "Song 1"
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "songName")
			MusicPlayer.shared.stopBackgroundMusic()
			MusicPlayer.shared.startBackgroundMusic()
		}
	}

    /// Allows you to save any data under a given key
    /// - Parameters:
    ///   - data: Any data supporting the Codable protocol
    ///   - key: The key under which the data will be stored
    static func set(_ data: Codable, for key: String) {
        
        
        if let encoded = (try? JSONEncoder().encode(data)) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    /// Allows you to load saved data under a given key
    /// - Parameters:
    ///   - key: The key under which the data was stored
    ///   - type: Type of the data that has been stored
    /// - Returns: Stored data (optional)
    static func get<T: Codable>(for key: String, as type: T.Type) -> T? {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: savedData)
        }
        return nil
    }
	
	
	static func load() {

		Results.load()
		Skins.selectedPair = UserDefaults.standard.integer(forKey: "selectedPair")
		Saves.isMusicOn = UserDefaults.standard.bool(forKey: "musicOn")
		Saves.selectedSong = UserDefaults.standard.string(forKey: "selectedSong") ?? "Song 1"
		Saves.isTimeMode = UserDefaults.standard.bool(forKey: "timeMode")
	}
	
}
