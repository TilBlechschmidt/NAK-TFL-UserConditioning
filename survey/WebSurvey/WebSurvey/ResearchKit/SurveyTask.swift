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
    instructionsStep.text = "Im Folgenden werden dir einige Aufgaben gestellt. Bei diesen Fragen musst du Informationen von verschiedenen Internetseiten sammeln und diese Eintragen.\n\nAuch wenn dies unter Umständen nicht dein Gerät ist, solltest du es wie dein eigenes behandeln und dich nicht anders verhalten als du es bei deinem eigenen Computer tun würdest!\n\nOben links in dem Browser findest du eine Liste von Lesezeichen zu den Websites die du benötigst. Benutze diese und nicht die Addresszeile oder eine andere App um an die gefragten Informationen zu kommen!"
    instructionsStep.image = UIImage(named: "custom_consent_05")
    
    let completionStep = ORKCompletionStep(identifier: "completion")
    completionStep.text = "Vielen Dank, dass du die Zeit investiert hast an der Umfrage teilzunehmen! 💖\n\nDeine Ergebnisse helfen bei der Forschung in einem sehr aktuellen und relevanten Thema in der IT-Branche. Solltest du deine Kontaktdaten hinterlassen haben, so schicken wir dir in einigen Wochen die Erkenntnisse aus der Arbeit.\n\nBis dahin, bleib gesund! 🦠"

    let assignments = [
        Assignment(task: "Finde den Preis von 'RIBBA Schwarz 61x91cm' bei IKEA.", help: "Öffne den Online-Katalog von IKEA mithilfe der Lesezeichen oben links und suche nach dem Preis für den 61x91cm großen RIBBA Bilderrahmen in schwarz.", solutionLabel: "Preis in €"),
        Assignment(task: "Wie viele 1TB USB Sticks hat Mindfactory im Sortiment?", help: "Gehe auf die Website von Mindfactory mithilfe der Lesezeichen oben links. Die Firma bietet einige USB Sticks mit 1TB (~1000 GB) Speicherplatz an. Finde heraus wie viele verschiedene Sticks dieser Größe sie anbieten.", solutionLabel: "Anzahl der Speichersticks"),
        Assignment(task: "Wie alt ist der letzte Tweet von Donald Trump?", help: "Der Präsident der Vereinigten Staaten von Amerika ist sehr aktiv auf Twitter. Finde seine Seite, indem du das Lesezeichen für Twitter oben links benutzt!", solutionLabel: "Alter des neuesten Tweets"),
        Assignment(task: "Zu welcher Uhrzeit verlässt der günstigste Flug von HAM -> SFO den Flughafen?", help: "Finde den günstigsten Flug von Hamburg (HAM) nach San Francisco (SFO) an dem 01.10.20 für einen Erwachsenen in der Economy Class. Gehe dafür auf Flüge.de über die Lesezeichen oben links und gebe die Flugdaten ein. Anschließend schauen sie nach der Abflugzeit des günstigsten Flug.", solutionLabel: "Abflugzeit"),
        Assignment(task: "Wie viel kostet das teuerste Netflix Abo?", help: "Über die Lesezeichen kannst du die Startseite von Netflix aufrufen. Dort ist die Preisspanne der verschiedenen Abos versteckt. Finde die teuerste Abo-Variante!", solutionLabel: "Netflix-Abo Preis in €"),
        Assignment(task: "Was ist das Größen-Limit von Personal-Backups bei Backblaze?", help: "Öffne die Backblaze Seite über die Lesezeichen. Dort findest du verschiedene Backup-Angebote, wobei der Personal-Plan von Interesse ist. Suche nach der maximalen Größe die dein Backup haben darf auf der Startseite des Angebots!", solutionLabel: "Backup Limit")
    ].enumerated().shuffled().enumerated()
    
    steps += [
        RecordingStep.default,
        instructionsStep
    ]
    
    steps += assignments.map { (index, assignment) in
        AssignmentStep(identifier: "assignment-\(assignment.offset)", assigment: assignment.element, index: index + 1)
    }
    
    steps += [
        DemographicsStep,
        ContactDetailsStep,
        completionStep,
    ]
        
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
