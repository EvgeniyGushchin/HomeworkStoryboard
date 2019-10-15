//
//  ShareViewController.swift
//  HomeworkShareExtension
//
//  Created by Evgeniy Gushchin on 14.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit
import Social
import CoreServices

class ShareViewController: SLComposeServiceViewController {
    
    let textType      = kUTTypeText as String
    let plainTextType = kUTTypePlainText as String
    
    private var text: String?
    
    override func isContentValid() -> Bool {
        return true //(text != nil) ? true : false
    }

    override func didSelectPost() {
        
        loadTextIfPossible {
            DispatchQueue.main.async { [unowned self] in
                if let text = self.text {
                    self.saveToUserDefaults(text: text)
                }
                if let url = URL(string: "ShareHWAppUrl://text") {
                    _ = self.openURL(url)
                }
                self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
            }
        }
    }

    override func configurationItems() -> [Any]! {
        return []
    }
    
    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }

}

extension ShareViewController {
    
    func loadTextIfPossible(completion: @escaping ()->()) {
        for item in extensionContext!.inputItems {
            if let item = item as? NSExtensionItem {
                for attachment in item.attachments ?? [] {
                    if let type = checkConformingTypeId(provider: attachment) {
                        attachment.loadItem(forTypeIdentifier: type, options: nil) { (results, error) in
                            if let text = results as? String {
                                self.text = text
                            }
                            completion()
                        }
                        break
                    }
                }
            }
        }
    }
    
    func checkConformingTypeId(provider: NSItemProvider) -> String? {
        var type: String? = nil
        if provider.hasItemConformingToTypeIdentifier(textType) {
            type = textType
        } else if (provider.hasItemConformingToTypeIdentifier(plainTextType)) {
            type = plainTextType
        }
        return type
    }
    
    func loadTextItem(provider: NSItemProvider, type: String) {
        provider.loadItem(forTypeIdentifier: type, options: nil) { (results, error) in
            if let text = results as? String {
                self.text = text
            }
        }
    }
    
    func saveToUserDefaults(text: String) {
        let sharedDefaults = UserDefaults(suiteName: "group.com.egushchin.HomeworkStoryboard")
        sharedDefaults?.set(text, forKey: "Shared Text")
    }
}
