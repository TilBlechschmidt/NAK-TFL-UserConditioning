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
    step.title = "Demografie"
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
    
    step.formItems = [
        occupationQuestionItem,
        itWorkplaceQuestionItem,
        knowledgeQuestionItem
    ]
    
    step.formItems?.forEach { $0.isOptional = false }
    
    return step
}

var SurveyActivityQuestionStep: ORKFormStep {
    let step = ORKFormStep(identifier: "surveyActivity")
    step.title = "Datenschutzbewusstsein"
    step.isOptional = false
    
    let dataPrivacyAnswerFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 3, step: 1, vertical: false)
    let dataPrivacyQuestionItem = ORKFormItem(identifier: "dataPrivacyImportance", text: "Wie wichtig ist dir Datenschutz? 🔒", answerFormat: dataPrivacyAnswerFormat)
    dataPrivacyQuestionItem.detailText = "Ist dir der Schutz deiner Privatsphäre wichtig und wenn ja, wie viel Wert legst du darauf?"
    
    let gdprQuestionItem = ORKFormItem(identifier: "gdprImprovement", text: "Funktioniert die DSGVO? ⚖️", answerFormat: ORKBooleanAnswerFormat())
    gdprQuestionItem.detailText = "Hast du das Gefühl, dass deine persönlichen Daten durch die DSGVO per Gesetz besser geschützt sind als zuvor?"
    
    let considersPopupsQuestionItem = ORKFormItem(identifier: "considersPopups", text: "Achtest du explizit auf den Inhalt von Cookie-Popups? 🔍", answerFormat: ORKBooleanAnswerFormat(yesString: "Konfigurieren", noString: "Loswerden"))
    considersPopupsQuestionItem.detailText = "Konfigurierst du die Cookie-Einstellungen auf Websites häufig manuell oder willst du das Popup einfach loswerden?"
    
    let noticedBogusModalQuestionItem = ORKFormItem(identifier: "noticedBogusText", text: "Ist dir aufgefallen, dass du deine linke Niere verkauft hast? 💰", answerFormat: ORKBooleanAnswerFormat(yesString: "Ja 😏", noString: "Nein 😳"))
    noticedBogusModalQuestionItem.detailText = "Eines der DSGVO Popups beinhaltete einen künstlichen Text, der dich das Recht an deine linke Niere hat abtreten lassen!"
        
    step.formItems = [
        dataPrivacyQuestionItem,
        gdprQuestionItem,
        considersPopupsQuestionItem,
        noticedBogusModalQuestionItem
    ]
    
    step.formItems?.forEach { $0.isOptional = false }
    
    return step
}

var ContactDetailsStep: ORKFormStep {
    let step = ORKFormStep(identifier: "contactDetails")
    step.title = "Zusendung der Ergebnisse"
    step.text = "Diese Umfrage ist Teil einer zweiteiligen Serie von Forschungen, dessen Kernthema erst später veröffentlicht um eine Verfälschung der Ergebnisse zu vermeiden.\n\nSolltest du Interesse an den Forschungsergebnissen haben, kannst du hier deine Kontaktdaten eintragen. Wir kontaktieren dich, sobald Ergebnisse vorliegen!"
    step.isOptional = true
    
    let formItem = ORKFormItem(identifier: "email", text: "E-Mail Adresse", answerFormat: ORKEmailAnswerFormat())
    formItem.detailText = "Mit der Angabe deiner E-Mail Adresse stimmst du zu, dass wir dich zum Zweck weiterer Umfragen und zur Mitteilung der Ergebnisse kontaktieren dürfen"
    
    step.formItems = [
        formItem
    ]
    
    return step
}
