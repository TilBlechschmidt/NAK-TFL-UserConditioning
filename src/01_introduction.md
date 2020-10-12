---
    header-title: Transfer paper 4
    title: Analysis of behavioral conditioning by privacy policy modals

    author: Til Blechschmidt
    Zenturie: A17a
    Studiengang: Angewandte Informatik
    Matrikelnummer: 8240

    keywords: [gdpr, dsgvo, cookies, web, banner, behavior, conditioning, survey]
    
    # This can be replaced with any valid bibliography file (.yaml, .json, .bib)
    bibliography: src/bibliography.json

    lang: en

    figPrefix:
      - "figure"
      - "figures"

    secPrefix:
      - "section"
      - "sections"

    lof: true
---

\definecolor{accept}{HTML}{A3BE8C}
\definecolor{maybe}{HTML}{EBCB8B}
\definecolor{reject}{HTML}{BF616A}

# Introduction

The internet is an essential good in todays life. It simplifies communication on a global scale, makes information about almost anything easily accessible from virtually anywhere, allows shopping without ever leaving the comfort of home, eases planning efforts of individuals and companies alike, and poses a great opportunity for research. Through all these ways it also allowed companies to easily scale to a global market^[Depending on the business sector] and even opened up new business opportunities. However, back in the day of dial-up modems and Netscape regulations were nowhere to be seen and remained scarce for a long time. Over the years, local regulations like the Telemediengesetz in Germany developed in many countries around the world.

This posed a unique challenge for web content as it had to adhere to different regulations in different areas. It became hard to comply to all regulations in every area where the website was accessible. Companies were forced to heavily invest into research on compliance and new technologies to stay on top of it all. [@race-to-gdpr]

In 2018 the (+GDPR) has taken effect in the (+EU) which created a paradigm shift [@gdpr-history]. Instead of giving users the option to opt-out of personal data collection it enforces an explicit approval. Thus the focus of companies shifted from making users not notice the opt-out to potentially tricking them into opting-in to tracking. However, one may not blame the companies for this behavior since their business case heavily relies on implicit feedback and tracking data from customers. It may even be considered a requirement to stay competitive and maintain a profitable online presence.

Looking at it from the perspective of users makes this a troublesome move. The decision on whether or not to allow such tracking is now in their hands. To cite the (+GDPR), users should give consent through "a clear affirmative act establishing a freely given, specific, informed and unambiguous indication [...]" [@gdpr-recitation-32]. While many companies are still struggling to comply with these requirements [@race-to-gdpr], it becomes more commonplace for consent questions to pop up upon visiting a website^[Later shown in [@fig:website-stats]].

Since the relevant data is of high value for companies the question arises whether users are actually being manipulated and tricked into giving consent. This will be the research question for this paper. To answer it we will begin by researching potential manipulation methods using available literature. Then an attempt to prove the real-world applicability and use of such manipulation taking place will be made by conducting an interactive survey.

\pagebreak
