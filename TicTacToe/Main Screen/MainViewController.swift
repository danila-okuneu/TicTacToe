//
//  ViewController.swift
//  TicTacToe
//
//  Kirill
//

import UIKit

class MainViewController: UIViewController {

    let playButton = UIButton()
    let xskin = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayButton()
        setupXskin()
        
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    
    func setupPlayButton() {
        view.addSubview(playButton)
        
        playButton.setTitle("Let's play", for: .normal)
        playButton.layer.cornerRadius = 30
        playButton.titleLabel?.font = .systemFont(ofSize: 20)
        playButton.tintColor = .white
        playButton.backgroundColor = UIColor(red: 132/255, green: 128/255, blue: 212/255, alpha: 1)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 692),
            playButton.heightAnchor.constraint(equalToConstant: 72),
            playButton.widthAnchor.constraint(equalToConstant: 348)
        ])
        
        
    }
    func setupXskin () {
        view.addSubview(xskin)
        xskin.contentMode = .scaleAspectFit
        xskin.image = UIImage(named: "Xskin1")
        xskin.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            xskin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            xskin.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
	
}

