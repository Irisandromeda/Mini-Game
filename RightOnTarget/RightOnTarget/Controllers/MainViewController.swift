//
//  MainViewController.swift
//  RightOnTarget
//
//  Created by Irisandromeda on 12.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var game: Game!
    
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 50
        slider.thumbTintColor = .white
        slider.minimumTrackTintColor = .systemPink
        return slider
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .black
        
        game = Game(startValue: 0, endValue: 50, rounds: 5)
        updateLabelWithSecretNumber(text: String(game.currentSecretValue))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        addConstraints()
        
        button.addTarget(self, action: #selector(checkNumber), for: .touchUpInside)
    }
    
    @objc private func checkNumber() {
        game.calculatedScore(with: Int(slider.value))
        
        if game.isGameEnded {
            showAlert(with: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        updateLabelWithSecretNumber(text: String(game.currentSecretValue))
    }
    
}

extension MainViewController {
    private func setupSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(label)
        view.addSubview(slider)
        view.addSubview(button)
    }
    
    private func addConstraints() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -60),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}

extension MainViewController {
    private func updateLabelWithSecretNumber(text: String) {
        label.text = text
    }
    
    private func showAlert(with score: Int) {
        let alert = UIAlertController(title: "Game Over",
                                      message: "You have earned - \(score) points",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Play Again",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
