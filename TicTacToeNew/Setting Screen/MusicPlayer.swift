//
//  MusicPlayer.swift
//  TicTacToeNew
//
//  Created by Danila Okuneu on 5.10.24.
//
import AVFoundation

import AVFoundation

class MusicPlayer {
	static let shared = MusicPlayer()
	var audioPlayer: AVAudioPlayer?

	func startBackgroundMusic() {
		guard Saves.isMusicOn else {
			stopBackgroundMusic()
			return
		}
		
		// Проверяем, не играет ли музыка уже
		if audioPlayer?.isPlaying == true {
			return
		}
		
		// Настройка аудиосессии
		do {
			try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
			try AVAudioSession.sharedInstance().setActive(true)
		} catch {
			print("Ошибка настройки аудиосессии: \(error)")
		}

		// Загрузка и воспроизведение музыки
		if let musicURL = Bundle.main.url(forResource: Saves.selectedSong, withExtension: "mp3") {
			do {
				audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
				audioPlayer?.numberOfLoops = -1 // Бесконечный цикл
				audioPlayer?.play()
			} catch {
				print("Ошибка воспроизведения музыки: \(error)")
			}
		} else {
			print("Не удалось найти файл музыки.")
		}
	}

	func stopBackgroundMusic() {
		audioPlayer?.stop()
	}
}
