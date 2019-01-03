//
//  ViewController.swift
//  HW_2
//
//  Created by Andrew on 28/09/2018.
//  Copyright © 2018 Andrew. All rights reserved.
//

import UIKit
import Spring

var randomCase = 0
var array:[Int] = []
var counter = 0
var langArray = ["Scheisse","Verdammte Scheisse!","scheissen","Scheiss drauf!","Ein Scheissdreck werde ich tun!","vollscheissen","beschissen","bescheissen","Anschiss","Arsch","Arschloch","verarschen","Verarsche","Leck mich am Arsch!","Schwanzlutscher","Pimmel","Fotze","Halt die Fotze!","Hure","Schlampe","Schickse","Miststueck","Mistkerl","ficken","Fick"]

class ViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var button: SpringButton!
    @IBOutlet var bulletImage: UIImageView!
    @IBOutlet var sView: SpringView!
    @IBOutlet var rowLabel: UILabel!
    @IBOutlet var rowImage: UIImageView!
    @IBOutlet var helpView: SpringView!
    @IBOutlet var vrag1view: SpringView!
    @IBOutlet var vrag2View: SpringView!
    @IBOutlet var vragImage1: UIImageView!
    @IBOutlet var vragImage2: UIImageView!
    @IBOutlet var bloodview1: SpringView!
    @IBOutlet var bloodview2: SpringView!
    @IBOutlet var bloodImage1: UIImageView!
    @IBOutlet var bloodImage2: UIImageView!
    @IBOutlet var bloodLable: SpringLabel!
    @IBOutlet var endView: SpringView!
    @IBOutlet var germanLang: UITextField!
    @IBOutlet var restartButton: SpringButton!
    @IBOutlet var kubokImage: UIImageView!
    @IBOutlet var bulletCount: UILabel!
    @IBOutlet var bullets: [SpringView]!
    @IBOutlet var bulletsImagesCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        backgroundImage.image = UIImage(named: "bck")
        array.shuffle()
        bulletImage.image = UIImage(named: "bullet")
        bulletImage.transform = CGAffineTransform(rotationAngle: (.pi / -2))
        sView.isHidden = true
        rowLabel.text = "Hit that!!!"
        rowImage.image = UIImage(named: "arrow")
        rowImage.transform = CGAffineTransform(rotationAngle: (.pi / 3))
        vragImage1.image = UIImage(named: "vrag")
        vragImage2.image = UIImage(named: "vrag")
        bloodImage1.image = UIImage(named: "blood")
        bloodImage2.image = UIImage(named: "blood")
        bloodImage2.transform = CGAffineTransform(rotationAngle: (.pi / 3))
        bloodview1.isHidden = true
        bloodview2.isHidden = true
        multiActionFunc(superview: helpView, casing: 2)
        multiActionFunc(superview: vrag1view, casing: 0)
        multiActionFunc(superview: vrag2View, casing: 0)
        vrag2View.isHidden = true
        vrag1view.isHidden  = true
        bloodLable.isHidden = true
        restartButton.layer.cornerRadius = 10
        kubokImage.image = UIImage(named: "kubok")
        kubokImage.isHidden = true
        bulletCount.text = "15"
        
        for each in 0...bulletsImagesCollection.count - 1 {
            bulletsImagesCollection[each].image = UIImage(named: "bulletCount")
            bulletsImagesCollection[each].transform = CGAffineTransform(rotationAngle: (.pi / -2))
            bulletsImagesCollection[each].clipsToBounds = true
            bulletsImagesCollection[each].contentMode = UIView.ContentMode.scaleAspectFill
        }
    }
    
    func bulletReducer(counter: Int) {
        if counter < 16 {
        bulletsImagesCollection[counter - 1].isHidden = true
        }
    }
    
    @IBAction func buttonAction(_ sender: SpringButton) {
        counter += 1
        bulletReducer(counter: counter)
        if counter < 16 && counter > 0  {
        bulletCount.text = "\(15 - counter)"
        }
        helpView.isHidden = true
        fire()
        delay(delay:0.2){
            self.logic(count: counter)
        }
    }
    
    func fire() {
        
        multiActionFunc(superview: sView, casing: 3)
        delay(delay: 0.3) {
            self.multiActionFunc(superview: self.sView, casing: 4)
        }
    }
    
    func bloodAppears() {
        multiActionFunc(superview: bloodview1, casing: 5)
        multiActionFunc(superview: bloodview2, casing: 5)
    }
    
    func logic(count: Int) {
        if count <= 5 {
            germanLang.text = langArray.randomElement()
        }
        if count > 5 && count < 10 {
        bloodAppears()
             germanLang.text = langArray.randomElement()
        }
        if count > 10 && count < 15 {
            germanLang.isHidden = true
            if count < 12 {
            multiActionFunc(superview: vrag2View, casing: 1)
            multiActionFunc(superview: vrag1view, casing: 1)
                delay(delay: 0.3) {
                    self.bloodLable.isHidden = false
                    self.multiActionFunc(superview: self.endView, casing: 0)
                    self.kubokImage.isHidden = false
                }
            }
        }
        if count > 12 {
            restartButton.isHidden = false
            restartButton.animation = "pop"
            restartButton.curve = "easeOutQuint"
            restartButton.duration = 1.0
            restartButton.damping = 0.6
            restartButton.velocity = 0.2
            restartButton.animate()
        }
    }
    
    @IBAction func restartAction(_ sender: Any) {
        restartButton.isHidden = true
        restart()
    }
    
    func restart() {
        bulletCount.text = "15"
        kubokImage.isHidden = true
        germanLang.text = ""
        germanLang.isHidden = false
        counter = 0
        randomCase = 0
        sView.isHidden = true
        rowLabel.text = "Hit that!!!"
        helpView.isHidden = false
        bloodview1.isHidden = true
        bloodview2.isHidden = true
        multiActionFunc(superview: helpView, casing: 2)
        multiActionFunc(superview: vrag1view, casing: 0)
        multiActionFunc(superview: vrag2View, casing: 0)
        vrag2View.isHidden = true
        vrag1view.isHidden  = true
        bloodLable.isHidden = true
        for each in 0...bulletsImagesCollection.count - 1 {
            bulletsImagesCollection[each].isHidden = false
        }
    }
    
    func multiActionFunc(superview view: SpringView,casing situation: Int) {
        switch situation {
        case 0:
            //celi
             delay(delay: 1) {
                self.vrag2View.isHidden = false
                self.vrag1view.isHidden = false
            view.animation = "slideDown"
            view.curve = "easeIn"
            view.duration = 1.0
            view.animate()
            }
        case 1:
            //pogibli
            view.animation = "zoomOut"
            view.curve = "easeIn"
            view.duration = 1.0
            view.animate()
        case 2:
            //shake strelka good
            view.animation = "shake"
            view.curve = "easeIn"
            view.duration = 1.0
            view.damping = 1.0
            view.velocity = 0.01
            view.repeatCount = 5
            view.animate()
        case 3:
            //bullet fire good
            view.isHidden = false
            view.animation = "squeezeUp"
            view.curve = "easeIn"
            view.duration = 0.3
            view.damping = 1.0
            view.velocity = 0.1
            view.animate()
        case 4:
            //bullet fire good
            view.isHidden = false
            view.animation = "zoomOut"
            view.curve = "easeIn"
            view.duration = 0.1
            view.damping = 1.0
            view.velocity = 0.1
            view.animate()
        case 5:
            bloodview2.isHidden = false
            bloodview1.isHidden = false
            view.animation = "zoomOut"
            view.curve = "easeOut"
            view.duration = 1.0
            view.damping = 1.0
            view.velocity = 1.0
            view.animate()
        default:
            print("thats it ;) ")
        }
    }
}

