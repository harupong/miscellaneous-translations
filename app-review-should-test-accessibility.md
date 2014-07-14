---
title: 'Apple’s App Review Should Test Accessibility – Marco.org'
...

 

[Marco.org](/) • [About ▾](#)
=============================

I’m [Marco Arment](/about): a programmer, writer, podcaster, geek, and coffee enthusiast.

[About](/about) • [Podcast](http://atp.fm/) • [Best Of](/tagged-bestof) • [Twitter](https://twitter.com/marcoarment)

[Apple’s App Review Should Test Accessibility](/2014/07/10/app-review-should-test-accessibility)
------------------------------------------------------------------------------------------------

July 10, 2014 • [∞http://www.marco.org/2014/07/10/app-review-should-test-accessibility](/2014/07/10/app-review-should-test-accessibility "Permalink")

[Christina Farr’s Reuters article](http://www.reuters.com/article/2014/07/09/us-apple-mobilephone-accessibility-idUSKBN0FE12Q20140709) is pretty bad, as helpfully detailed by [John Gruber](http://daringfireball.net/linked/2014/07/10/reuters-accessibility). Apple’s accessibility support leads the industry by a mile.

But the actual issue, buried in the sloppy article, is legitimate:

> But when apps don’t work, life can grind to a stop. Jonathan Lyens, a San Francisco city employee, who is legally blind, has a hard time browsing jobs on professional networking site LinkedIn.
>
> “The app is insane. Buttons aren’t labeled. It’s difficult to navigate,” said Lyens. When it comes to social media apps, new problems arise with every release, he said. “I get nervous every time I hit the update button.” …
>
> Now, Apple and Google both have developer guidelines on how to make features accessible, such as labeling buttons that can be read by Apple’s VoiceOver software.
>
> But they don’t require accessibility, in contrast to other strictly enforced rules, such as a ban on apps that present crude or objectionable content. Nor do they offer an accessibility rating system, which some disabled advocates say would be a big help.

Apps with standard UIs get most accessibility for free, Apple doesn’t reject apps for inaccessibility, and most customers don’t rely on accessibility tools, so most developers never hear about accessibility problems.

In the rush to get apps and updates out the door, it’s easy to forget to test every UI change with VoiceOver. I’ve certainly forgotten many times.

But while accessibility problems only affect a small percentage of an app’s userbase, their impact can be extremely damaging or fatal to those customers’ ability to use the app.

Accessibility failures should be *embarrassments* to all developers because they’re usually *very* easy to fix. For most problems, you just need to add label text to a custom control or image button. Rare “complex” issues are usually less than an hour’s work.

I try hard to get accessibility right… when I remember to. My triple-tap home-button shortcut is always mapped to VoiceOver so I can easily test. I include VoiceOver users in betas whenever possible and had an extremely valuable and insightful accessibility review in the WWDC labs this year. But I *still* occasionally ship unlabeled buttons, hidden-view clutter, or inaccessible custom views.

Poor or broken accessibility is exactly the sort of problem that Apple’s App Review team *should* check for: many developers forget to test it, it’s easy for Apple to quickly test when reviewing each app, and it’s easy to fix.

It’s even more clear when considering the customers’ point of view. App Review assures customers of minimum quality and security standards so they feel comfortable buying apps, and [we all benefit](http://www.marco.org/2011/02/04/ode-to-the-app-review-team) from it. The [App Store Review Guidelines](https://developer.apple.com/appstore/resources/approval/guidelines.html) are quite clear on the basics:

> **2.2** Apps that exhibit bugs will be rejected
>
> **2.3** Apps that do not perform as advertised by the developer will be rejected

Of course. Customers should know that they’re getting what’s promised.

But those rules aren’t applied to accessibility. For a customer who uses VoiceOver, rows of unlabeled buttons and inescapable screens are “bugs”, and an app with inaccessible features certainly does not “perform as advertised”.

This sucks for everyone: Apple, developers, and most of all, customers relying on accessibility aides who unknowingly pick a bad app, can’t do what they need, and now can’t trust the App Store with future purchases.

Requiring all apps and games to be completely accessible is probably infeasible. But that’s not the only option. My proposed fix:

1.  Allow developers to *opt into* accessibility testing for each submission in iTunes Connect. Put it on the screen that asks about cryptography so all developers must answer it and are made aware of it.
2.  Show a small badge on each app’s page in the Store that passes accessibility testing. This helps customers make buying decisions for their needs.

    Passing requires all advertised functionality to be accessible, all accessible controls to have accurate labels, and no navigational traps such as inescapable screens or stuck states.

3.  If a user has VoiceOver enabled while downloading an app that has *not* been tested for accessibility, or while updating a previously tested app to to an untested version, show a warning dialog and ask them to confirm whether they still want to proceed. This helps them *and* gives developers a good reason to opt into accessibility testing.

There’s definitely more Apple can do to address this very real problem, and a system like this would make a huge difference.

◆

Follow Marco.org posts: [Twitter](https://twitter.com/marco_org), [RSS feed](/rss), or the [alternate RSS feed](/rss2) in which link posts always point here first instead of their targets. \
 [Follow @marcoarment on Twitter](https://twitter.com/marcoarment) if you’d like.

© 2006–2014 Marco Arment.

[![](/ads-via-the-deck.png)Ads via The Deck](http://decknetwork.net/)
