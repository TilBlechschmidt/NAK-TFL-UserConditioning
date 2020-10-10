# Why conditioning is an issue

- What is operant conditioning?
- What is negative reinforcement?
  - Experiment w/ mouse, explain positive reinforcement first with an example and then introduce the "opposite"
    - Rats turning on the light before the stimulus is even there (with a warning light obviously)!

- To explain why it might apply to users we have to deviate for a second!
- Exposed to banners and stuff for a long time (REF TFL 3)
- Websites used to be mostly accessible
  - Banners were annoying but content was still there
  - Access to pages was removed by GDPR banners
  - Extra steps are necessary to reach a goal

- Analysis of what web pages are doing out there
  - Reference list of top 500 domains [https://moz.com/top500](https://moz.com/top500)
  - Take a screenshot of the first 300 (accessed from within Germany!)
  - Manually evaluate each one
  - Category first: Modal, Banner, Nothing, Blocked, Invalid
  - Subcategory
    - Info, Reject, Config
  - Add result table
  - Majority of pages have nothing
    - Either due to them not using cookies or not being compliant (not tested, not important)
    - Some were region blocked, some domains are invalid (due to things like CDNs/APIs/Certificates)
    - Banners
      - Only a handful provided a one-click way to reject cookies
      - Informational banners and ones with configuration options are equally frequent
    - Modals
      - Two informational ones
      - Only six one-click rejectable ones
      - Overwhelming majority had a complex config flow requiring at least three clicks
  - A lot of non-compliant stuff out there (Info)
  - Many pages do not have any kind of consent mechanism
    - Either they don't use cookies OR they are not (yet) compliant, has not been evaluated
  - It is relatively complicated (>2 clicks) to reject cookies while it has been made simple to accept everything (1 click) — on avg!!
  - Take exact results with a grain of salt (human monkey brain and 'only' 300 pages) but rough estimate is expected to hold
    - It is hard to reproduce as the web changes constantly

![Privacy mechanisms of top 300 domains](src/images/website-stats.pdf){#fig:website-stats}

- How does that relate to negative reinforcement?
  - As mentioned earlier, used to be able to access websites somewhat unobstructed
  - Negative reinforcer (modals) became required due to change in legislation
  - It is expected that users want to avoid the stimuli and take evasive actions
    - These actions are presumably the fastest way to get rid of the interruption
    - Websites (presumably) made the deliberate choice to turn accepting all cookies into the fastest one
      - It could very well have been designed the other way around
      - Not proven, just an assumption.
    - Due to the consistency in the design of modals the reinforcement effect is expected to work well (theory proved later on)
      - Plus users have been exposed for consent mechanisms for *decades*
  - Not an issue with cookie banners because users were not forced to interact with them but could ignore them
    - There was no effective reinforcement going on, thus the behavior to interact with them didn't stick/develop (ref first TFL results of 55% ignore)
