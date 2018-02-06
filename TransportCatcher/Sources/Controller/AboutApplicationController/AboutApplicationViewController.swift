//
//  AboutApplicationViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 06/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class AboutApplicationViewController: UIViewController {

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var destributionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let versionComponents: [String?] = [LocalizedString.Common.version.firstCapitalized, Bundle.main.releaseVersionNumber]
        let version = versionComponents.flatMap({ $0 }).joined(separator: " ")
        let components: [String?] = [Bundle.main.copyright, version]
        destributionLabel.text = components.flatMap({ $0 }).joined(separator: "\n")
        destributionLabel.numberOfLines = 0
        descriptionLabel.attributedText = getAboutAttributedText()
    }
    
    private func getAboutAttributedText() -> NSAttributedString? {
    
        let titleAttrs: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        
        let paragraphAttrs: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        ]

        let titles: [String] = [
            LocalizedString.About.purpose + "\n",
            LocalizedString.About.compatibility + "\n",
            LocalizedString.About.usedServices
        ]

        let paragraphs: [String] = [
            LocalizedString.About.purposeDescription + "\n\n",
            LocalizedString.About.compatibilityDescription + "\n\n"
        ]
        
        let mas = NSMutableAttributedString()
        for (idx, title) in titles.enumerated() {
            let attrTitle = NSAttributedString(string: title, attributes: titleAttrs)
            mas.append(attrTitle)
            guard idx < paragraphs.count else { continue }
            let paragraph = paragraphs[idx]
            let attrPar = NSAttributedString(string: paragraph, attributes: paragraphAttrs)
            mas.append(attrPar)
        }
        return mas
    }
    
    @IBAction func onToSamaraTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL.init(string: "http://tosamara.ru") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func on2GISTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL.init(string: "https://info.2gis.ru") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func onIcons8Tapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL.init(string: "https://icons8.ru") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func onContactDeveloperTapped(_ sender: UIButton) {
        var mailto: String = "mailto:lavmint@gmail.com?cc=elizarov1988@gmail.com&subject=Transport:Samara:iOS"
        let mailingComponents: [String] = [
            "\(LocalizedString.About.mailingAppVersion): \(Bundle.main.releaseVersionNumber ?? LocalizedString.About.mailingAppVersionUnidentified)",
            "\(LocalizedString.About.mailingiOSVersion): \(UIDevice.current.systemVersion)",
            "\(LocalizedString.About.mailingDevice): \(UIDevice.current.localizedModel)"
        ]
        let deviceInfo = mailingComponents.joined(separator: "\n")
        mailto += "&body=\n\n\(deviceInfo)"
        guard let rawURL = mailto.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        guard let url = URL.init(string: rawURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
