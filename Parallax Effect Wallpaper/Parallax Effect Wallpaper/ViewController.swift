//
//  ViewController.swift
//  Parallax Effect Wallpaper
//
//  Created by winify on 3/16/16.
//  Copyright © 2016 Costraci Mihail. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

	
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var button3: UIButton!
	@IBOutlet weak var button4: UIButton!
	
	
	
	var motionManager  = CMMotionManager()
	
	var axisX : Double = 0.0
	var axisY : Double = 0.0
	var axisZ : Double = 0.0
	
	let xMin = CGFloat(-200)
	let xMax = CGFloat(200)
	let yMin = CGFloat(-200)
	let yMax = CGFloat(200)
	
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		self.view.bringSubviewToFront(button1)
		self.view.bringSubviewToFront(button2)
		self.view.bringSubviewToFront(button3)
		self.view.bringSubviewToFront(button4)

		
		image.contentMode = .Center
		
		let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
		xMotion.minimumRelativeValue = xMin
		xMotion.maximumRelativeValue = xMax
		
		let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
		yMotion.minimumRelativeValue = yMin
		yMotion.maximumRelativeValue = yMax
		
		let motionEffectGroup = UIMotionEffectGroup()
		motionEffectGroup.motionEffects = [xMotion, yMotion]
		
		image.addMotionEffect(motionEffectGroup)
		

		
		
		
		//UNCOMMENT TO USE GYROSCOPE
//		self.useGyro()
	}
	
	//MARK:- Move Image
	func moveImage(accData: CMAcceleration) {
		
	}
	
	
	func showErrorMessage(errorMessage: String, buttonTitle: String) {
		
		let alert = UIAlertController.init(title: "Oops",
										 message: errorMessage,
								  preferredStyle: UIAlertControllerStyle.Alert)
		
		let action = UIAlertAction.init(title: buttonTitle, style: UIAlertActionStyle.Destructive, handler: nil)
		
		alert.addAction(action)
		
		dispatch_async(dispatch_get_main_queue(), {
			self.presentViewController(alert, animated: true, completion: nil)
		})
	}
	

	//MARK: Gyroscope
	
	func useGyro() {
		
		motionManager.accelerometerUpdateInterval = 0.2
		motionManager.gyroUpdateInterval = 0.2
		
		
		if !motionManager.gyroAvailable {
			self.showErrorMessage("Your device doesn't have gyroscope", buttonTitle: "OK")
		}
			
		else {
			
			motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { ( gyroData: CMGyroData?, error: NSError?) -> Void in
				
				
				print("rotation Rate X: \(gyroData?.rotationRate.x)")
				print("rotation Rate Y: \(gyroData?.rotationRate.y)")
				print("rotation Rate Z: \(gyroData?.rotationRate.z)")
				
			})
			
		}

	}
	
	
	@IBAction func changeFirstImage(sender: AnyObject) {
		
		self.image.image = UIImage(named: "1")
	}
	
	
	@IBAction func changeSecondImage(sender: AnyObject) {
		
		self.image.image = UIImage(named: "2")
	}
	
	@IBAction func changeThirdImage(sender: AnyObject) {
	
		self.image.image = UIImage(named: "3")
	}
	
	@IBAction func changeFourthImage(sender: AnyObject) {
	
		self.image.image = UIImage(named: "4")
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

