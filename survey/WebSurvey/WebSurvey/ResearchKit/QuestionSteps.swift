//
//  QuestionSteps.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 18.07.20.
//

import Foundation
import ResearchKit

var DemographicsStep: ORKFormStep {
    let step = ORKFormStep(identifier: "demographics")
    step.title = "Demografie" // NSLocalizedString("Something", comment: "")
    step.isOptional = false
        
    let occupationAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: [
        ORKTextChoice(text: "Schüler", value: "Schüler" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Student / Auszubildender", value: "Student" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Arbeitstätig", value: "Arbeitstätig" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Pensioniert", value: "Pensioniert" as NSCoding & NSCopying & NSObjectProtocol),
    ])
    let occupationQuestionItem = ORKFormItem(identifier: "occupation", text: "Was beschreibt deine Tätigkeit am besten? 💼", answerFormat: occupationAnswerFormat)
    occupationQuestionItem.detailText = "Duale Studenten gelten als Studenten auch wenn sie sich manchmal anders sehen ;)"
    
    let itWorkplaceQuestionItem = ORKFormItem(identifier: "itWorkplace", text: "Arbeitest du aktuell in der IT-Branche? 👨‍💻", answerFormat: ORKBooleanAnswerFormat())
        
    let knowledgeAnswerFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 3, step: 1, vertical: false, maximumValueDescription: "Entwickler", minimumValueDescription: "Technikneanderthaler")
    let knowledgeQuestionItem = ORKFormItem(identifier: "knowledge", text: "Computerkenntnisse 💻", answerFormat: knowledgeAnswerFormat)
    knowledgeQuestionItem.detailText = "Siehst du dich eher als ein Technikneanderthaler, der sich fragt was diese Computer eigentlich sind, oder eher als ein Software-Entwickler mit weitreichendem Informatikwissen?"
    
    let privacyAnswerFormat = ORKScaleAnswerFormat(maximumValue: 6, minimumValue: 1, defaultValue: 3, step: 1, vertical: false, maximumValueDescription: "Datenschutz", minimumValueDescription: "Komfort")
    privacyAnswerFormat.shouldHideSelectedValueLabel = true
    privacyAnswerFormat.shouldHideRanges = true
    let privacyQuestionItem = ORKFormItem(identifier: "privacy", text: "Privatsphäre & Datenschutz 🔒", answerFormat: privacyAnswerFormat)
    privacyQuestionItem.detailText = "Legst du eher Wert auf den Schutz deiner persönlichen Daten oder akzeptierst du einige Einbußen für einen erhöhten Komfort?"
    
    step.formItems = [
        occupationQuestionItem,
        itWorkplaceQuestionItem,
        knowledgeQuestionItem,
        privacyQuestionItem
    ]
    
    step.formItems?.forEach { $0.isOptional = false }
    
    return step
}

var ContactDetailsStep: ORKFormStep {
    let step = ORKFormStep(identifier: "contactDetails")
    step.title = "Zusendung der Ergebnisse"
    step.text = "Diese Umfrage ist Teil einer zweiteiligen Serie von Forschungen, dessen Kernthema erst später veröffentlicht um eine Verfälschung der Ergebnisse zu vermeiden.\n\nSolltest du Interesse daran haben an der zweiten Umfrage teilzunehmen oder die Forschungsergebnisse zugesendet zu bekommen, kannst du hier deine Kontaktdaten eintragen. Wir kontaktieren dich, sobald Ergebnisse vorliegen!"
    step.isOptional = true
    
    let formItem = ORKFormItem(identifier: "email", text: "E-Mail Adresse", answerFormat: ORKEmailAnswerFormat())
    formItem.detailText = "Mit der Angabe deiner E-Mail Adresse stimmst du zu, dass wir dich zum Zweck weiterer Umfragen und zur Mitteilung der Ergebnisse kontaktieren dürfen"
    
    step.formItems = [
        formItem
    ]
    
    return step
}
