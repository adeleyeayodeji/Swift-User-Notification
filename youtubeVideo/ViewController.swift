//
//  ViewController.swift
//  youtubeVideo
//
//  Created by Adeleye Ayodeji on 20/08/2023.
//

import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a new view
        let myView = UIView()
        //set background colour
        myView.backgroundColor = .black
        //remove auto resize
        myView.translatesAutoresizingMaskIntoConstraints = false
        //add sub view
        view.addSubview(myView)
        
        //set constraint array
        let constraints = [
            //top
            myView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            //left side
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //right side
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //height
            myView.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        //activate constraints
        NSLayoutConstraint.activate(constraints)
        
        //text
        let textLabel = UILabel()
        //remove auto resize
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        //set the value
        textLabel.text = "Hello World!"
        textLabel.textColor = .white
        //add it to myView
        myView.addSubview(textLabel)
        
        //set textlabel constraints
        let labelConstraints = [
            //center x
            textLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            //center y
            textLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor)
        ]
        
        //activate constraints
        NSLayoutConstraint.activate(labelConstraints)
        
        //add button
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
         customView.center = view.center
         view.addSubview(customView)
         
         let button = UIButton(type: .system)
         button.setTitle("Schedule Notification", for: .normal)
         button.addTarget(self, action: #selector(scheduleNotificationButtonTapped), for: .touchUpInside)
         button.frame = CGRect(x: 50, y: 50, width: 150, height: 40)
         customView.addSubview(button)
        
    }
    
    @IBAction func scheduleNotificationButtonTapped(_ sender: UIButton) {
        scheduleLocalNotification()
    }
    
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "My new notification"
        content.body = "This is a local notification example new"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        let currentDelegate = UNUserNotificationCenter.current()
        //self as delegate
        currentDelegate.delegate = self
        
        currentDelegate.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
                                  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner, .list])
    }

}

