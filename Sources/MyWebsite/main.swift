import Foundation
import Publish
import Plot
import SwiftPygmentsPublishPlugin


struct MyWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case about
        case posts
        case publications

        //case tutorials
    }
    

    struct ItemMetadata: WebsiteItemMetadata {
        //var readTime: TimeInterval
        // Add any site-specific metadata that you want to use here.
        
    }

    var url = URL(string: "https://navanchauhan.github.io/")!
    var name = "Navan Chauhan"
    var description = "Welcome to my personal fragment of the internet. Majority of the posts should be complete."
    var language: Language { .english }
    var imagePath: Path? { "images/logo.png" }
}


try MyWebsite().publish(
    using: [
    .installPlugin(.pygments()),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .alpha),
    .generateRSSFeed(including: [.posts, .publications, .about]),
    .generateSiteMap(),
    .deploy(using: .gitHub("navanchauhan/navanchauhan.github.io"))
    ])
    
    
    
   

 
