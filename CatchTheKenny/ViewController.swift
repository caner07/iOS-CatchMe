//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Caner on 11.07.2020.
//  Copyright © 2020 Caner Kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var highScoreText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var againButton: UIButton!
    var kennyList : [UIImageView] = []
    
    var timer=Timer()
    var counter=9
    var score=0
    var highScore=0
    override func viewDidLoad() {
        super.viewDidLoad()
        againButton.isHidden=true
        kennyList=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        for kenny in kennyList {
            kenny.isHidden=true
            kenny.isUserInteractionEnabled=true
            let recognizer=UITapGestureRecognizer(target: self, action: #selector(scorePlus))
            kenny.addGestureRecognizer(recognizer)
        }
        let userHighScore=UserDefaults.standard.object(forKey: "highScore")
        if userHighScore != nil{
            highScore=userHighScore as! Int
            highScoreText.text="High Score= \(highScore)"
        }
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }

    @objc func timerFunc(){
        againButton.isHidden=true
        timeText.text = "Time: \(counter)"
        counter -= 1
        for kenny in kennyList {
            kenny.isHidden=true
        }
        let random=Int.random(in: 0...8)
        kennyList[random].isHidden=false
        
        
        if counter < 0 {
            timer.invalidate()
            timeText.text = "Time's Over"
            let alert=UIAlertController(title: "Time's Over", message: "Play Again?", preferredStyle: UIAlertController.Style.alert)
            let yesButton=UIAlertAction(title: "Yes!", style: UIAlertAction.Style.default, handler:{ (UIAlertAction) in
                self.restart()
                
            })
            let noButton=UIAlertAction(title: "No!", style: UIAlertAction.Style.destructive, handler:{ (UIAlertAction) in
                self.againButton.isHidden=false
            })
            alert.addAction(noButton)
            alert.addAction(yesButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func scorePlus(){
        score+=1
        scoreText.text="Score= \(score)"
        if score>highScore {
            highScore=score
            highScoreText.text="High Score= \(highScore)"
            UserDefaults.standard.set(highScore, forKey: "highScore")
        }
    }
    func restart(){
        counter=10
        score=0
        scoreText.text="Score=0"
        timeText.text="Time: \(self.counter)"
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    @IBAction func playAgain(_ sender: Any) {
        restart()
    }
    
}

