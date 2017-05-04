//
//  EmotionViewController.swift
//  FaceIt
//
//  Created by Chi kit Lo on 1/5/2017.
//  Copyright © 2017 Chi kit Lo. All rights reserved.
//

import UIKit

class EmotionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
//    private let emotionFaces: Dictionary<String, FacialExpression> = [
//        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
//        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
//        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
//        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin),
//
//    ]
    
    private var emotionFaces: [(name: String, expression: FacialExpression)] = [
        ("angry", FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown)),
        ("happy", FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile)),
        ("worried", FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk)),
        ("mischievious", FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)),
        ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionFaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
        cell.textLabel?.text = emotionFaces[indexPath.row].name
        return cell
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
//        if let facevc = destinationvc as? FaceViewController {
//            if let identifier = segue.identifier {
//                if let expression = emotionFaces[identifier] {
//                    facevc.expression = expression
//                    if let sendingButton = sender as? UIButton {
//                        facevc.navigationItem.title = sendingButton.currentTitle
//                    }
//                }
//            }
//        }
        
        if let facevc = destinationvc as? FaceViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            facevc.expression = emotionFaces[indexPath.row].expression
            facevc.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
        
    }
    
    
    

}
