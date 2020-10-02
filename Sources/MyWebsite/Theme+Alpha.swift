//
//  File.swift
//  
//
//  Created by Navan Chauhan on 04/01/20.
//

import Foundation
import Publish
import Plot
import ReadTimePublishPlugin

public extension Theme {

    static var alpha: Self {
        Theme(
            htmlFactory: AlphaHTMLFactory(),
            resourcePaths: ["Resources/Themes/styles.css"]
        )
    }
}

private struct AlphaHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .head(.link(.attribute(named: "rel", value: "manifest"), .href("manifest.json"))),
            .head(.meta(.attribute(named: "name", value: "google-site-verification"),.attribute(named: "content", value: "LVeSZxz-QskhbEjHxOi7-BM5dDxTg53x2TwrjFxfL0k"))),
            .head(.script("var _paq=window._paq=window._paq||[];_paq.push(['trackPageView']),_paq.push(['enableLinkTracking']),function(){var a='https://navanspi.duckdns.org:6969/analytics/';_paq.push(['setTrackerUrl',a+'matomo.php']),_paq.push(['setSiteId','2']);var e=document,t=e.createElement('script'),p=e.getElementsByTagName('script')[0];t.type='text/javascript',t.async=!0,t.src=a+'matomo.js',p.parentNode.insertBefore(t,p)}();")),
            .body(
                
                .header(for: context, selectedSection: nil),

                .wrapper(
                    .h1(.text(index.title)),
                    .p(
                        .class("description"),
                        .text(context.site.description)
                    ),
                    .h2("Latest content"),
                    .itemList(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                            
                        ),
                        on: context.site
                    )
                ),
                .script(.src("assets/manup.min.js")),
                .script(.src("/pwabuilder-sw-register.js")),
                
                .script( .src("https://www.googletagmanager.com/gtag/js?id=UA-108635191-1v")
                               ),
                               .script("window.dataLayer = window.dataLayer || [];",
                                 "function gtag(){dataLayer.push(arguments);}",
                                 "gtag('js', new Date());",
                                 "gtag('config', 'UA-108635191-1');"
                           ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .head(.script("var _paq=window._paq=window._paq||[];_paq.push(['trackPageView']),_paq.push(['enableLinkTracking']),function(){var a='https://navanspi.duckdns.org:6969/analytics/';_paq.push(['setTrackerUrl',a+'matomo.php']),_paq.push(['setSiteId','2']);var e=document,t=e.createElement('script'),p=e.getElementsByTagName('script')[0];t.type='text/javascript',t.async=!0,t.src=a+'matomo.js',p.parentNode.insertBefore(t,p)}();")),
            .head(
                .script( .src("https://www.googletagmanager.com/gtag/js?id=UA-108635191-1v")
                ),
                .script("window.dataLayer = window.dataLayer || [];",
                  "function gtag(){dataLayer.push(arguments);}",
                  "gtag('js', new Date());",
                  "gtag('config', 'UA-108635191-1');"
            )),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    //.h1(.text(section.title)),
                    .contentBody(section.body),
                    .itemList(for: section.items, on: context.site)
                    
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .head(.script("var _paq=window._paq=window._paq||[];_paq.push(['trackPageView']),_paq.push(['enableLinkTracking']),function(){var a='https://navanspi.duckdns.org:6969/analytics/';_paq.push(['setTrackerUrl',a+'matomo.php']),_paq.push(['setSiteId','2']);var e=document,t=e.createElement('script'),p=e.getElementsByTagName('script')[0];t.type='text/javascript',t.async=!0,t.src=a+'matomo.js',p.parentNode.insertBefore(t,p)}();")),
            .head(
                .script( .src("https://www.googletagmanager.com/gtag/js?id=UA-108635191-1v")
                ),
                .script("window.dataLayer = window.dataLayer || [];",
                  "function gtag(){dataLayer.push(arguments);}",
                  "gtag('js', new Date());",
                  "gtag('config', 'UA-108635191-1');"
            )),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        
                        .div(
                            .class("content"),
                            .unwrap(item.readTime().time, { .span( .class("reading-time"), "\($0) minute read") }), .span(.class("reading-time"), "Created on \(getFormattedDate(date: item.date))"),
                            .if(getFormattedDate(date: item.date) != getFormattedDate(date: item.lastModified),
                                                 .span(.class("reading-time"), "Last modified on ", "\(getFormattedDate(date: item.lastModified))")
                                               ),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                        /**.div(.id("disqus_thread")),
                        .script(.src("/assets/disqus.js")),
                        .element(named: "noscript", text: "Please enable JavaScript to view the comments")**/
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .head(.script("var _paq=window._paq=window._paq||[];_paq.push(['trackPageView']),_paq.push(['enableLinkTracking']),function(){var a='https://navanspi.duckdns.org:6969/analytics/';_paq.push(['setTrackerUrl',a+'matomo.php']),_paq.push(['setSiteId','2']);var e=document,t=e.createElement('script'),p=e.getElementsByTagName('script')[0];t.type='text/javascript',t.async=!0,t.src=a+'matomo.js',p.parentNode.insertBefore(t,p)}();")),
            .head(
                .script( .src("https://www.googletagmanager.com/gtag/js?id=UA-108635191-1v")
                ),
                .script("window.dataLayer = window.dataLayer || [];",
                  "function gtag(){dataLayer.push(arguments);}",
                  "gtag('js', new Date());",
                  "gtag('config', 'UA-108635191-1');"
            )),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(

                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .head(.script("var _paq=window._paq=window._paq||[];_paq.push(['trackPageView']),_paq.push(['enableLinkTracking']),function(){var a='https://navanspi.duckdns.org:6969/analytics/';_paq.push(['setTrackerUrl',a+'matomo.php']),_paq.push(['setSiteId','2']);var e=document,t=e.createElement('script'),p=e.getElementsByTagName('script')[0];t.type='text/javascript',t.async=!0,t.src=a+'matomo.js',p.parentNode.insertBefore(t,p)}();")),
            .head(
                .script( .src("https://www.googletagmanager.com/gtag/js?id=UA-108635191-1v")
                ),
                .script("window.dataLayer = window.dataLayer || [];",
                  "function gtag(){dataLayer.push(arguments);}",
                  "gtag('js', new Date());",
                  "gtag('config', 'UA-108635191-1');"
            )),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .head(.script("var _paq=window._paq=window._paq||[];_paq.push(['trackPageView']),_paq.push(['enableLinkTracking']),function(){var a='https://navanspi.duckdns.org:6969/analytics/';_paq.push(['setTrackerUrl',a+'matomo.php']),_paq.push(['setSiteId','2']);var e=document,t=e.createElement('script'),p=e.getElementsByTagName('script')[0];t.type='text/javascript',t.async=!0,t.src=a+'matomo.js',p.parentNode.insertBefore(t,p)}();")),
            .head(
                .script( .src("https://www.googletagmanager.com/gtag/js?id=UA-108635191-1v")
                ),
                .script("window.dataLayer = window.dataLayer || [];",
                  "function gtag(){dataLayer.push(arguments);}",
                  "gtag('js', new Date());",
                  "gtag('config', 'UA-108635191-1');"
            )),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                            },
                            .li(.a(
                                .href("/assets/résumé.pdf"),
                                .text("Résumé")
                                )),
                            .li(.a(
                                .href("https://navanchauhan.github.io/repo"),
                                .text("Repo")
                            ))
                        )
                    )
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .unwrap(item.readTime().time, { .span( "🕑 \($0) minute read. \(getFormattedDate(date: item.date))") }),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Made with ❤️ using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}
    func getFormattedDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMMM d, yyyy"
        return dateformat.string(from: date)
    }

