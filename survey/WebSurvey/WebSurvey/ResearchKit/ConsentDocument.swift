//
//  ConsentDocument.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 26.07.20.
//

import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    let consentDocument = ORKConsentDocument()
  
    let overviewSection = ORKConsentSection(type: .overview)
    overviewSection.summary = "Es folgt eine kurze Umfrage zum Nutzerverhalten im Internet, diese wird im Rahmen einer Transferleistung an der Nordakademie Elmshorn im Bereich der Angewandten Informatik durchgeführt.\n\nIch bedanke mich im voraus für die Teilnahme an der Umfrage! Dein Beitrag hilft bei der Forschung in diesem Bereich 😇"
    
    let dataGatheringSection = ORKConsentSection(type: .dataGathering)
    dataGatheringSection.summary = "Während der Umfrage werden persönliche Daten gesammelt, um dich zum Zweck der Auswertung in eine demografische Gruppe einordnen zu können. Solltest du während der Umfrage nicht einverstanden sein die gefragten Daten zu teilen, breche die Umfrage bitte durch die Schaltfläche oben rechts ab."
    
    consentDocument.sections = [
        overviewSection,
        dataGatheringSection
    ]

    return consentDocument
}
