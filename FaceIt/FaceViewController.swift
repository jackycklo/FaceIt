//
//  ViewController.swift
//  FaceIt
//
//  Created by Chi kit Lo on 30/4/2017.
//  Copyright © 2017 Chi kit Lo. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Neutral) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet
        {
            //faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))

            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            faceView.addGestureRecognizer(UIRotationGestureRecognizer(
                target: self, action: #selector(FaceViewController.changeBrows(recognizer:))
            ))
            
            
            updateUI()
        }
    }
    
    private struct HeadShake {
        static let angle = CGFloat.pi/6                 //radians
        static let segmentDuration: TimeInterval = 0.5  // each head shake has 3 segments
    }
    
    private func rotateFace(by angle: CGFloat)
    {
        faceView.transform = faceView.transform.rotated(by: angle) //+ve clockwise
        
    }
    
    private func shakeHead() {
        
        UIView.animate(
            withDuration: HeadShake.segmentDuration,
            animations: { self.rotateFace(by: HeadShake.angle) },
            completion: {(finished) in
                if finished {
                    UIView.animate(
                        withDuration: HeadShake.segmentDuration,
                        animations: { self.rotateFace(by: -HeadShake.angle*2) },
                        completion: {(finished) in
                            if finished {
                                UIView.animate(
                                    withDuration: HeadShake.segmentDuration,
                                    animations: { self.rotateFace(by: HeadShake.angle) },
                                    completion: {(finished) in
                                        if finished {
                                            
                                        }
                                }
                                )
                            }
                    }
                    )
                }
        }
        )
    }
    
        
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
        
    }
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
        
    }
    // shakeHead
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        
        shakeHead()
        
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open:
                expression.eyes = .Closed
            case .Closed:
                expression.eyes = .Open
            case .Squinting:
                break
            }
        }
    }
    
    func changeBrows(recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .changed,.ended:
            if recognizer.rotation > CGFloat(Double.pi/4) {
                expression.eyeBrows = expression.eyeBrows.moreRelaxedBrow()
                recognizer.rotation = 0.0
            } else if recognizer.rotation < -CGFloat(Double.pi/4) {
                expression.eyeBrows = expression.eyeBrows.moreFurrowedBrow()
                recognizer.rotation = 0.0
            }
        default:
            break
        }
    }
    
    //let instance = getFaceMVCinstanceCount()
    
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0 ]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesopen = true
            case .Closed: faceView.eyesopen = false
            case .Squinting: faceView.eyesopen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
}

