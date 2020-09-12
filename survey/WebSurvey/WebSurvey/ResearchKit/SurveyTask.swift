//
//  SurveyTask.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 26.07.20.
//

import Foundation
import ResearchKit
import UIKit

public var SurveyTask: ORKOrderedTask {
  
    var steps = [ORKStep]()
  
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: ConsentDocument)
    steps += [visualConsentStep]

    let sharingConsentStep = ORKConsentSharingStep(identifier: "SharingConsentStep", investigatorShortDescription: "der Nordakademie gAG", investigatorLongDescription: "Nordakademie gAG und externe Prüfer", localizedLearnMoreHTMLContent: "Die resultierenden Daten werden mit der Nordakademie zu Prüfungszwecken geteilt. Zu diesem Zweck gibt die Hochschule die Daten an externe Prüfer weiter, welche sie vertraulich behandeln. Sofern Sie zustimmen die Daten mit dritten zu teilen, werden diese anonymisiert für Wissenschaftler auf der ganzen Welt zugänglich gemacht.")
    steps += [sharingConsentStep]
    
    let instructionsStep = ORKInstructionStep(identifier: "instructions")
    instructionsStep.title = "Anweisungen"
    instructionsStep.text = "Im Folgenden werden dir einige Aufgaben gestellt. Bei diesen Fragen musst du Informationen von verschiedenen Internetseiten sammeln und diese Eintragen.\n\nAuch wenn dies unter Umständen nicht dein Gerät ist, solltest du es wie dein eigenes behandeln und dich nicht anders verhalten als du es bei deinem eigenen Computer tun würdest!\n\nOben links in dem Browser findest du eine Liste von Lesezeichen zu den Websites die du benötigst. Benutze diese und nicht die Addresszeile oder eine andere App um an die gefragten Informationen zu kommen! Sobald du die Antwort auf die Frage gefunden hast, kannst du über den Haken oben rechts das Ergebnis abschicken."
    instructionsStep.image = UIImage(named: "custom_consent_05")
    
    let completionStep = ORKCompletionStep(identifier: "completion")
    completionStep.text = "Vielen Dank, dass du die Zeit investiert hast an der Umfrage teilzunehmen! 💖\n\nDeine Ergebnisse helfen bei der Forschung in einem sehr aktuellen und relevanten Thema in der IT-Branche. Solltest du deine Kontaktdaten hinterlassen haben, so schicken wir dir in einigen Wochen die Erkenntnisse aus der Arbeit.\n\nBis dahin, bleib gesund! 🦠"

    let rawAssignments = [
        Assignment(task: "Wie lange geht der Gratis-Zeitraum des Heise+ Zeitschriften-Abo?", help: "Besuche die Website der IT-Zeitschrift Heise. Es wird dort für ein Premium-Abo namens 'heise+' mit einem Gratis-Zeitraum für Neukunden geworben. Finde heraus wie lange dieser Zeitraum geht", solutionLabel: "Zeitraum in Wochen", keyboardType: .numberPad),
        Assignment(task: "Wie viel kostet die UCI Unlimited Card im Monat?", help: "Die UCI Kinowelt bietet eine Kino-Flatrate namens 'Unlimited' an. Besuche ihre Website über die Lesezeichen und schaue ob du die Seite zur Flatrate ausfindig machen kannst. Dort steht auch der monatliche Preis.", solutionLabel: "Preis in €", keyboardType: .decimalPad),
        Assignment(task: "Wer hat die erste Ausgabe der Zeitschrift 'Der Postillon' herausgegeben?", help: "Die Zeitschrift existiert schon seit einer sehr langen Zeit. Finde auf deren Website, welche du über die Lesezeichen erreichen kannst, die historische Auflistung alter Ausgaben. Dort ist auch der Name des mittelfränkischen Authors angegeben, welcher die erste Ausgabe im Oktober 1845 veröffentlichte!", solutionLabel: "Nachname des Herausgebers", keyboardType: .alphabet),
        Assignment(task: "Wie heißt der Filialleiter von deinem nächstgelegenen famila?", help: "Suche über die famila Website (in den Lesezeichen zu finden) die Filiale, welche in deiner Nähe ist. Dort ist auch der Name des Warenhausleiter angegeben.", solutionLabel: "Vorname des Warenhausleiter", keyboardType: .alphabet),
        Assignment(task: "Wie hoch ist der vorausgesetzter Gehaltseingang damit das ING-DiBa Girokonto kostenlos ist?", help: "Du findest die ING-DiBa Bank in den Lesezeichen. Diese bietet ein Girokonto an, welches unter bestimmten Konditionen kostenlos ist. Finde den minimalen Geldbetrag, der monatlich auf deinem Konto eingehen muss, damit dieses kostenfrei bleibt.", solutionLabel: "Betrag in €", keyboardType: .decimalPad)
    ]
    
    let assignments = rawAssignments.enumerated().shuffled().enumerated()
    
    let fakeAssignment = Assignment(task: "Finde den Grundpreis der 'Graduation Dinky Duck' 🦆", help: "Öffne den Dcuk Shop über die Lesezeichen. Dort findest du eine Menge süßer Enten. Schaue ob du den Preis für die Dinky Duck als Abschlussgeschenk (Graduation auf Englisch) findest! Es gibt eine Suche und Kategorien.", solutionLabel: "Preis in £", keyboardType: .decimalPad)
    
    steps += [
        RecordingStep.default,
        instructionsStep
    ]
    
    steps += assignments.map { (index, assignment) in
        AssignmentStep(identifier: "assignment-\(assignment.offset)", assigment: assignment.element, index: index + 1)
    }
    
    steps += [
        AssignmentStep(identifier: "assignment-fake", assigment: fakeAssignment, index: rawAssignments.count + 1)
    ]
    
    steps += [
        SurveyActivityQuestionStep,
        DemographicsStep,
        ContactDetailsStep,
        completionStep,
    ]
        
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
