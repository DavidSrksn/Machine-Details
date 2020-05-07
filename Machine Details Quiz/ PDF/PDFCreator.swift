//
//  PDFCreator.swift
//  Machine Details
//
//  Created by David Sarkisyan on 16.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import PDFKit
import UIKit

class PDFConfigurator{
    let title: String = "Результаты конфигурации и расчета схемы"
    let body: String
    let image: UIImage = UIImage(named: "МГТУ")!
    let contactInfo: String = " В составлении алгоритмов помогали: \n По всем вопросам пиши @davidsrksn. "
    
    init(result: ResultModel){
        let pdfTextConfigurator = PDFTextConfigurator()
        self.body = pdfTextConfigurator.setupPage(result: result)
    }
    
    func createResultPDF() -> Data {
        
        let pdfMetaData = [
            kCGPDFContextCreator: "Flyer Builder",
            kCGPDFContextAuthor: "raywenderlich.com",
            kCGPDFContextTitle: title
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()

            let imageBottom: CGFloat = addImage(pageRect: pageRect)
            let titleBottom = addTitle(pageRect: pageRect,topAnchor: imageBottom + 10)
            addBodyText(pageRect: pageRect, textTop: titleBottom + 20.0)
            
            let context = context.cgContext
            drawContactLabels(context, pageRect: pageRect)
        }
        
        saveViewPdf(data: data)
        
        return data
    }
    
    func saveViewPdf(data: Data) {
        let now = Date()
        let pdfPath = SavedFilesInteractor.saveToPath.appendingPathComponent("\(now.description).pdf")

        do {
            try data.write(to: URL(fileURLWithPath: pdfPath.path))
        }catch{
            print("фигня")
        }
    }
    
//    func generateFIleName() -> String{
//        var fileName: String
//        
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .localDomainMask)
//        let docDirectoryPath = paths[0]
//       
//        do {
//            try if docDirectoryPath.read
//               }catch{
//                   print("фигня")
//               }
//        
//        return fileName
//    }

    func addTitle(pageRect: CGRect, topAnchor: CGFloat) -> CGFloat {

        let titleFont = UIFont.systemFont(ofSize: 25.0, weight: .bold)

        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)

        let titleStringSize = attributedTitle.size()

        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                     y: topAnchor, width: titleStringSize.width,
                                     height: titleStringSize.height)

        attributedTitle.draw(in: titleStringRect)

        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 22.0, weight: .regular)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping

        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: body, attributes: textAttributes)

        let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                              height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textRect)
    }
    
    func addImage(pageRect: CGRect) -> CGFloat {
        let maxHeight = pageRect.height * 0.3
        let maxWidth = pageRect.width * 0.25

        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio

        let imageX = pageRect.width - scaledWidth - 10
        let imageY: CGFloat = 10
        
        let imageRect = CGRect(x: imageX, y: imageY,
                               width: scaledWidth, height: scaledHeight)

        image.draw(in: imageRect)
        return imageRect.origin.y + imageRect.size.height
    }
    
    func drawContactLabels(_ drawContext: CGContext, pageRect: CGRect) {
        let contactTextFont = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let contactBlurbAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: contactTextFont
        ]
        let attributedContactText = NSMutableAttributedString(string: contactInfo, attributes: contactBlurbAttributes)
        
        let rectToDraw = CGRect(x: 10, y: pageRect.height - attributedContactText.size().height, width: attributedContactText.size().width, height: attributedContactText.size().height)
        attributedContactText.draw(in: rectToDraw)
        
        addAuthors(pageRect: pageRect, authorNames: ["Магницкий Илья Владимирович", "Гончаров Сергей Юрьевич"], leftAnchor: rectToDraw.origin.x + rectToDraw.width + 5)
    }
    
    func addAuthors(pageRect: CGRect, authorNames: [String], leftAnchor: CGFloat) {

        let titleFont = UIFont.systemFont(ofSize: 15.0, weight: .bold)

        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        var bottomAnchor: CGFloat = pageRect.height
        
        for author in authorNames{
            let attributedTitle = NSAttributedString(string: author, attributes: titleAttributes)
            
            let titleStringSize = attributedTitle.size()
            
            let titleStringRect = CGRect(x: leftAnchor,
                                         y: bottomAnchor - titleStringSize.height, width: titleStringSize.width,
                                         height: titleStringSize.height)
            attributedTitle.draw(in: titleStringRect)
            
            bottomAnchor -= titleStringRect.size.height
        }
    }
    
}
