//
//  ViewController.swift
//  yakala
//
//  Created by ozan aydogdu on 4.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    
    var score = 0
    var highScore = 0
    var time = 0
    var timer = Timer()
    var counter = 0
    var pikachuArray = [UIImageView]()
    var hideTimer = Timer()
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var pikachu1: UIImageView!
    @IBOutlet weak var pikachu2: UIImageView!
    @IBOutlet weak var pikachu3: UIImageView!
    @IBOutlet weak var pikachu4: UIImageView!
    @IBOutlet weak var pikachu5: UIImageView!
    @IBOutlet weak var pikachu6: UIImageView!
    @IBOutlet weak var pikachu7: UIImageView!
    @IBOutlet weak var pikachu8: UIImageView!
    @IBOutlet weak var pikachu9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text =  "Score: \(score)"
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "Highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        // Görsellere dokunabilmek için
        pikachu1.isUserInteractionEnabled = true
        pikachu2.isUserInteractionEnabled = true
        pikachu3.isUserInteractionEnabled = true
        pikachu4.isUserInteractionEnabled = true
        pikachu5.isUserInteractionEnabled = true
        pikachu6.isUserInteractionEnabled = true
        pikachu7.isUserInteractionEnabled = true
        pikachu8.isUserInteractionEnabled = true
        pikachu9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        
        pikachu1.addGestureRecognizer(recognizer1)
        pikachu2.addGestureRecognizer(recognizer2)
        pikachu3.addGestureRecognizer(recognizer3)
        pikachu4.addGestureRecognizer(recognizer4)
        pikachu5.addGestureRecognizer(recognizer5)
        pikachu6.addGestureRecognizer(recognizer6)
        pikachu7.addGestureRecognizer(recognizer7)
        pikachu8.addGestureRecognizer(recognizer8)
        pikachu9.addGestureRecognizer(recognizer9)
        
        pikachuArray = [pikachu1,pikachu2,pikachu3,pikachu4,pikachu5,pikachu6,pikachu7,pikachu8,pikachu9]
        
        
        
        
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,selector: #selector(hidePikachu), userInfo: nil,    repeats: true)
        hidePikachu()
    }
    
    
    @objc func hidePikachu (){
        for pikachu in pikachuArray{
            pikachu.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(pikachuArray.count-1)))
        pikachuArray[random].isHidden = false
    }
    
    
    
    @objc func increaseScore() {
        
        
        score+=1
        scoreLabel.text = "Score \(score)"
        
        
        
        
        
        
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for pikachu in pikachuArray{
                pikachu.isHidden = true
            }
            
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "Highscore")
                
                
            }
            
            
            
            let alert = UIAlertController(title: "Zaman doldu", message: "Tekrar oynamak ister misin?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler:  nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,selector: #selector(self.hidePikachu), userInfo: nil,    repeats: true)
                
                
                
                
                
            }
            
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}













