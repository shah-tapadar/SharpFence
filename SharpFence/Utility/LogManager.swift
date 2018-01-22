//
//  LogManager.swift
//  SharpFence
//
//  Created by Sebin on 22-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import MessageUI

class LogManager: NSObject {
    let logFileName = "SharpFenceLog"
    
    func emailLog(presentMailComposeron controller: HomeViewController) {
        createLogFile()
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([])
        mailVC.setSubject("Subject for email")
        mailVC.setMessageBody("Email message string", isHTML: false)
        let attachmentData = NSData(contentsOf: FileManagerWrapper.getFilePath(fileName: logFileName))
        mailVC.addAttachmentData(attachmentData as! Data, mimeType: "txt", fileName: "SharpFenceLog.txt")
        
        controller.present(mailVC, animated: true, completion: nil)
    }
    
    private func createLogFile(){
        guard let tripEvents = CoreDataWrapper.fetchAllTripEvents() else{
            return
        }
        var logString = ""
        for tripEvent in tripEvents {
            logString += createLogString(forEvent: tripEvent)
        }
        FileManagerWrapper.writeFile(fileName: logFileName, content: logString)
    }
    
    private func createLogString(forEvent tripEvent:TBL_TRIP_EVENT) -> String {
        var logString: String?
        logString = (logString ?? "") + "\n\n"
        logString = (logString ?? "") + "Fence ID: " + (tripEvent.geoFenceId ?? "")
        logString = (logString ?? "") + "\n\n"
        logString = (logString ?? "") + "EventType: " + (tripEvent.eventType ?? "")
        logString = (logString ?? "") + "\n\n"
        logString = (logString ?? "") + "TimeStamp: " + (tripEvent.timeStamp ?? "")
        logString = (logString ?? "") + "\n\n"
        logString = (logString ?? "") + "EventLat: " + String(tripEvent.eventLat)
        logString = (logString ?? "") + "\n\n"
        logString = (logString ?? "") + "EventLong" + String(tripEvent.eventLong)
        logString = (logString ?? "") + "\n\n"
        logString = (logString ?? "") + "*-----------------------*----------------------*-----------------------*-----------------------*--------------------*"
        return logString ?? ""
    }
}

extension LogManager: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
