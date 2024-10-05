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
	private var audioPlayer: AVAudioPlayer?
	private let audioQueue = DispatchQueue(label: "com.yourapp.audioQueue", qos: .userInitiated)

	func startBackgroundMusic() {
		audioQueue.async { [weak self] in
			guard let self = self else { return }
			guard Saves.isMusicOn else {
				self.stopBackgroundMusic()
				return
			}

			if self.audioPlayer?.isPlaying == true {
				return
			}

			do {
				try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
				try AVAudioSession.sharedInstance().setActive(true)
			} catch {
				print("Ошибка настройки аудиосессии: \(error)")
			}

			guard let musicURL = Bundle.main.url(forResource: Saves.selectedSong, withExtension: "mp3") else {
				print("Не удалось найти файл музыки.")
				return
			}

			do {
				self.audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
				self.audioPlayer?.numberOfLoops = -1
				self.audioPlayer?.prepareToPlay()
				self.audioPlayer?.play()
			} catch {
				print("Ошибка воспроизведения музыки: \(error)")
			}
		}
	}

	func stopBackgroundMusic() {
		audioQueue.async { [weak self] in
			self?.audioPlayer?.stop()
			self?.audioPlayer = nil
		}
	}

	func pauseBackgroundMusic() {
		audioQueue.async { [weak self] in
			self?.audioPlayer?.pause()
		}
	}

	func resumeBackgroundMusic() {
		audioQueue.async { [weak self] in
			guard Saves.isMusicOn else { return }
			self?.audioPlayer?.play()
		}
	}
}
