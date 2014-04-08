% The Ultimate Guide to Solving iOS Battery Drain — Overthought
% 
% 

[![Overthought](//static.squarespace.com/static/51eaef40e4b02a3783856fac/t/52ed15d2e4b0274a477b3868/1396927216314/?format=1500w)](/ "Overthought") {.logo .image}
==================================================================================================================================================

a blog by Scotty Loveless

My thoughts and musings about life, technology, and it's affect on our
society.

-   [blog](/)
-   [featured](/featured/)
-   [archive](/archives/)
-   [about](/about/)
-   [RSS](http://rss.overthought.org/feedme)
-   []()

Navigation blog featured archive about RSS

[The Ultimate Guide to Solving iOS Battery Drain](/blog/2014/the-ultimate-guide-to-solving-ios-battery-drain) {.entry-title data-content-field="title"}
=============================================================================================================

[March 27,
2014](/blog/2014/the-ultimate-guide-to-solving-ios-battery-drain) [by
Scotty Loveless](/?author=51eaef40e4b02a3783856faa)

*Updated April 7, 2014: added Step 8 to the list.*

**

Added [Korean
Translation](http://www.overthought.org/the-ultimate-guide-to-solving-ios-battery-drain-korean/)
(provided by [Yoon Jiman](http://yoonjiman.net))

* * * * *

I worked on the Genius Bar for almost two years, and the most difficult
issue to solve was short battery life. It was extremely difficult to
pinpoint the exact reason why someone's battery was draining.

I made it my mission to discover the specific reasons for iOS battery
drainage. This article is a product of my years of research and
anecdotal evidence I gathered in the hundreds of Genius Bar appointments
I took during my time as a Genius and iOS technician, as well as testing
on my personal devices and the devices of my friends.

iOS 7.1 came out recently and brought with it a bevy of design tweaks
and performance enhancements. However, some users are reporting poor
battery life since the update, and many blogs are reporting it as
fact.^[1](#fn1)^

This is not one of those "Turn off every useful feature of iOS" posts
that grinds my gears. My goal is to deliver practical steps to truly
solve your iOS battery woes.

One quick thing before we start — 99.9% of the time it is not actually
iOS that is causing your battery to drain quickly. I guarantee you that
if you erased your phone and there were no apps or email on it, it would
last for ages. But, no one uses their device like that, nor should they.
Hopefully with these steps you will be living in iOS battery bliss while
still using all the apps and features you love.

But first, we need to test and see if you even have a problem to begin
with.

How to Test Your iOS Battery Drain
----------------------------------

There is a quick and easy battery life test built into your device, if
you do a little bit of math — the Usage and Standby times^[2](#fn2)^.
Head on over to Settings \> General \> Usage and check out your times.

Your Usage time is how long you have actually used your device, and the
Standby time is how long your device has been dormant in-between the
times you've used it. The key to look for is that your Usage time should
be *significantly* lower than your Standby time, unless you have been
using your device every single second you've had it unplugged. If this
is not the case and your Usage time is exactly equal to your Standby
time, you have a severe problem. The bottom line is that your Usage time
should be accurate to how much you've used it since you took it off the
charger.

So here's the test: write down your usage and standby time, press the
sleep/wake button (or lock button, as some call it) to put the device to
sleep, and set the device down for five minutes. When you come back,
take note of the change in time. If your device is sleeping properly,
then the Standby time should have increased by five minutes and your
Usage time by \<1 minute ^[3](#fn3)^. If your Usage time rises by more
than one minute, you have a drain problem. Something is keeping your
device from sleeping properly, significantly shortening the time it will
last.

If you do not have a battery drain issue, then great! You don't even
need the steps listed in this article. But if you or someone you know is
constantly complaining about how short their battery lasts, read onward
or send this post to them.

Here are the main causes of iOS battery drain I've found, and how to
resolve them.

Step 1: Disable Location and Background App Refresh for Facebook
----------------------------------------------------------------

This first step may seem extremely specific, but that's because it is
extremely common and extremely effective. It has also been well tested
and confirmed on many devices.

I just got the iPhone 5s about two weeks ago, and thought my battery was
draining a little too quickly. Being the nerd that I am, I decided to
run the app Instruments from Xcode, Apple's developer tool, in order to
see what the problem was. Basically, Instruments acts as an Activity
Monitor for your iPhone, allowing developers (or nerds like me) to see
every process currently running and how much memory and processing power
each app is using in real-time.

During this testing, Facebook kept jumping up on the process list even
though I wasn't using it. So I tried disabling Location Services
^[4](#fn4)^ and Background App Refresh ^[5](#fn5)^ for Facebook, and
you'll never guess what happened: my battery percentage *increased*. It
jumped from 12% to 17%. Crazy. I've never seen that happen before on an
iPhone. The iPod touch exhibits this behavior, to my memory, although I
haven't tested it in a while. For the iPhone, the battery percentage is
usually pretty consistent.^[6](#fn6)^

I have confirmed this behavior on multiple iPhones with the same result:
percentage points actually increase after disabling these background
functions of Facebook.

Bad, Facebook, bad.

Step 2: Disable Background App Refresh for Apps You Don't Care About
--------------------------------------------------------------------

My [recent
post](http://www.overthought.org/blog/2014/background-app-refresh-explained "Background App Refresh Explained in Layman's Terms")
explains the benefits of Background App Refresh. BAR ^[7](#fn7)^ is an
awesome feature added in iOS 7, but you don't necessarily need it
running for every app that supports it. Disable Background App Refresh
for Facebook or other apps you don't absolutely need to stay up-to-date
all the time.

If there are apps you check regularly, and you trust the quality of the
app and developer, then enable Background App Refresh with confidence
and enjoy your apps being updated intelligently so they're ready for
your enjoyment at a moment's notice. Background App Refresh is great if
you need it, but you really don't need it for every single app on your
iOS device.

Step 3: Stop Quitting Your Apps in Multitasking
-----------------------------------------------

iOS 7 made it super fun to close your apps: all you have to do is
double-click the home button and swipe up on the app preview to blast it
into a digital black hole.

What most people tell you is that closing your apps will save your
battery life because it keeps the apps from running in the background.

*Wrong.*

Yes, it does shut down the app, but what you don't know is that you are
actually making your battery life *worse* if you do this on a regular
basis. Let me tell you why.

By closing the app, you take the app out of the phone's RAM ^[8](#fn8)^.
While you think this may be what you want to do, it's not. When you open
that same app again the next time you need it, your device has to load
it back into memory all over again. All of that loading and unloading
puts more stress on your device than just leaving it alone. Plus, iOS
closes apps automatically as it needs more memory, so you're doing
something your device is already doing for you. You are meant to be the
user of your device, not the janitor.

The truth is, those apps in your multitasking menu are not running in
the background at all: iOS freezes them where you last left the app so
that it's ready to go if you go back. Unless you have enabled Background
App Refresh, your apps are not allowed to run in the background unless
they are playing music, using location services, recording audio, or the
sneakiest of them all: checking for incoming VOIP calls ^[9](#fn9)^,
like Skype. All of these exceptions, besides the latter, will put an
icon next to your battery icon to alert you it is running in the
background. ^[10](#fn10)^

Step 4: Disable Push Email *Temporarily*
----------------------------------------

If steps 1 through 3 did not solve your problem, try disabling Push
email temporarily to see if it helps ^[11](#fn11)^. Push email allows
your device to receive instant notifications every time you get an
email. It is great if you need to know when every single email comes in,
but does impact battery if configured incorrectly.

I've seen many devices where Push is the primary cause of battery drain,
but I've also seen plenty of devices have great battery life with Push
enabled. It is really specific to your email and server settings. Try
changing the setting to Fetch every hour, thirty minutes, or fifteen
minutes and see if the drain stops. If that doesn't help, turn it back
on. You could also trying disabling Push on individual accounts if you
have multiple. Just keep referring to the test at the beginning of the
article to see if that resolved your issue.

Unbelievably often, especially with Exchange push email, it's as if the
phone gets stuck in a loop checking for email constantly. When this
happens, the phone will usually die within six hours of being off the
charger, and the Standby and Usage times in Settings \> General \> Usage
will be exactly the same. These times are not the same because the
"firmware ^[12](#fn12)^ is bad or corrupted", it's because push email is
keeping the phone from sleeping properly.

Step 5: Disable Push Notifications for Apps That Annoy You
----------------------------------------------------------

Does that annoying game your child downloaded keep sending you push
notifications to keep buying more digital sheep for the virtual farm? If
so, every time you get one of those notifications, your phone wakes from
sleep for a few seconds to light up your screen and wait for your
potential action upon each notification.

Push notifications do not cause excess battery drain by default, so
please don't hear me say you need to turn them all off. However, every
message wakes your device for 5 to 10 seconds, so it can add up. If you
receive 50 notifications during the day and never act on them, that will
add 4 to 8 minutes to your Usage time, meaning you now have that much
less time to do things you actually want to do on your device.
^[13](#fn13)^

Turn off those annoying Push notifications for apps you don't need
notifications from. It might be a small difference, but it can add up.

Step 6: Turn Off Battery Percentage
-----------------------------------

That's right, you heard me.

Turn off that battery percentage meter and stop worrying about your
battery drain. You can find this setting in Settings \> General \>
Usage, right above where your battery times are listed.

One thing I found in my Genius Bar experience is that people that are
anxious about their iOS device battery life are constantly checking it
to see the percentage and how much it has dropped from the last time
they checked it. So if you check your device twice as much, simply to
check on the battery life, you are essentially halving the time your
device will last.

Stop freaking out and enjoy your life. There are more important things
to worry about than your device's battery life. The control freak inside
you might freak out the first few days you do this, but you'll get used
to it. ^[14](#fn14)^

Step 7: Go to an Apple Retail Store
-----------------------------------

*Update: I was informed after posting this that the Apple battery test
only runs on the iPhone 5 and up.*

I know, you hate making a Genius Bar appointment because it's loud and
crazy in there, but I have a good reason to add this to the list.

According to my sources, Apple has rolled out a new 'Extended Battery
Life Test' for all iOS technicians that allows them to see a detailed
report of battery usage on your device. It takes only a few minutes to
run and, from what I've heard, is comprehensive. I have not had a chance
to see this test for myself, but my friends tell me it rocks.

The other rare possibility is that your physical battery is defective,
and the technicians can replace it for free if your iOS device is under
warranty, or very cheaply if it's not.

Step 8: Enable Airplane Mode in Areas of Poor Cellular Service
--------------------------------------------------------------

One major reason your battery could be draining too quickly is poor
cellular service. When the iPhone detects that you are in a place of low
signal, it will increase the power to the antenna in order to stay
connected enough to receive calls (primarily) and maintain a data
connection.

This will destroy your battery life if you are constantly in a location
with 1 bar or no service at all. The unfortunate thing is that this can
happen in more places than you expect — any building with metal studs in
the walls, aluminum buildings, buildings with dense concrete walls,
heavily populated city areas, and downtown areas with with lots of tall
buildings.

Often times you may get a strong signal on the top floor of a building,
but simply moving to a lower floor, such as the basement, will
immediately cause your iPhone to hang on to signal for dear life at the
expense of your battery. Note that this severe drain will happen even if
you have a strong Wi-Fi connection, because your phone still needs the
cellular connection for calls and SMS messages (the green-colored texts
in the Messages app).

If you are in an area with poor cell coverage, and you still need to
receive calls, I've got bad news — there is really nothing you can do.
But if your service is so poor that you can't receive calls anyway, I
recommend turning on Airplane mode by swiping up from the bottom of your
device to access Control Center and tapping the Airplane icon.

One thing you may not know about Airplane mode: you can actually turn
Wi-fi *back on* after enabling Airplane mode. Just tap the Wi-Fi button
in Control Center (the icon directly to the right of the Airplane). This
is perfect for places, like an airplane, where you have zero cellular
coverage but a strong Wi-Fi signal.

If you have Wi-Fi and want to be really fancy, you can disable just the
cellular data portion of your signal, e.g. EDGE, 3G, 4G, or LTE. Most
people don't know that your phone is actually receiving two signals
simultaneously: one for calls and SMS, and one for data.

The signal strength meter on the iPhone only shows the signal strength
for the non-data connection, which means theoretically your iPhone could
show 2-3 bars (or dots on iOS7) for your 1x connection but in reality
you could be getting 1 bar of LTE/4G/3G connection, causing the phone to
go into heavy search mode. To disable just the Data connection of your
iPhone, head over to **Settings \> Cellular Data** and switch Cellular
Data off. Again, doing this will allow you to receive phone calls (if
you still have a signal) while maintaining a data connection through
Wi-Fi.

Conclusion
==========

I guarantee you that if you follow these steps, you will be getting the
best battery life possible out of your iPhone, iPad, or iPod touch.

If your device is still not lasting you a full day, and you can't
stomach heading into one of the stainless steel noise chambers I
lovingly refer to as your nearest Apple Retail Store, don't worry. There
is still hope for you.

The reason your device isn't lasting all day might simply be because you
are a heavy user, and your iOS device is acting completely normal under
the grueling pace with which you use it. That is not a fault of the
device, or you, for that matter. You are simply pushing it beyond it's
capabilities. My advice for you is to buy a car charger, a second
charger for travel/work, or a battery case to extend your battery life
^[15](#fn15)^.

I hope this article empowers you to stop stressing about your battery
life, and frees you up to enjoy the great device in your hands. There
are more important things in life that deserve our attention, so the
more we minimize the trivial stressors, like bad battery life, the more
time we can spend on people and problems that really matter.

**Footnotes**

1.  Users will report poor battery life after every iOS update. Always.
    For eternity. This is not newsworthy. [↩](#ffn1)
2.  This only works on the iPhone and iPod touch. Sorry iPad users, for
    some reason these times are not viewable. \*\*Update\*\* Reader
    [Timothy Fultz](https://twitter.com/hawkeyefultz) emailed in to let
    me know that iPads on iOS 7 do have these Standby and Usage times.
    Thanks Timothy! [↩](#ffn2)
3.  Sometimes the Usage time will go up by one minute, but really it was
    only a few seconds. The minute was close to changing, and those few
    seconds pushed it over the edge to the next minute. [↩](#ffn3)
4.  Settings - Privacy - Location Services [↩](#ffn4)
5.  Settings - General - Background App Refresh [↩](#ffn5)
6.  Note about battery percentage: it is an **estimate** of how long
    your device will last looking at the amount of charge left in the
    physical battery and comparing that to the current processes
    draining that bank of electrical charge.

    A good thing to compare the way iOS calculates battery percentage is
    ETA (estimated time of arrival) in modern GPS and navigation. Most
    devices look at the miles left to travel and compare that to the
    speed limits of all of the roads you are going to travel on your
    current route. If you drive faster than the speed limit, you will
    get there faster than the estimated time, so it's not 100% accurate.

    Battery percentage estimates work the same way, looking at the
    amount of juice left (miles) versus how fast you're draining it
    (miles per hour). That explains why disabling Facebook made the
    percentage go up, much like how if you stop on a road trip, your ETA
    climbs significantly. [↩](#ffn6)

7.  short for Background App Refresh, not the awesome Browning Automatic
    Rifle used in World War II and by Steve McQueen in the final scene
    of "The Sand Pebbles". [↩](#ffn7)
8.  Temporary, short-term memory. [↩](#ffn8)
9.  Internet phone calls. [↩](#ffn9)
10. Apps that can make or receive calls, like Skype, Viber, Tango,
    Whatsapp, and Facebook are able to check for incoming calls without
    notifying you. I believe these types of apps sometimes abuse this
    exception and could have possibly influenced Apple to add Background
    App Refresh as the sanctioned method for this type of behavior.

    I think this is why disabling Facebook's background services is so
    influential on battery life: I speculate they are abusing the fact
    that they have VOIP call features to run in the background more than
    they should. It would provide a better experience for people using
    Facebook, sure, but people would never know Facebook was the cause
    of their battery life issues, and would definitely blame the device
    or iOS itself. [↩](#ffn10)

11. Settings - Mail, Contacts, and Calendars - Fetch New Data
    [↩](#ffn11)
12. The foundational software connecting hardware and software.
    [↩](#ffn12)
13. That number may seem small, but over a year (x365) that number turns
    into 1,460 minutes (about a day) to 2,960 minutes (about two days)
    *less* battery life. [↩](#ffn13)
14. I really wish Apple had a "No battery percentage meter except under
    20%" setting, so bad. That would be my ideal configuration.
    [↩](#ffn14)
15. Or buy a second iPhone as your night phone ;) [↩](#ffn15)

[**March 27,
2014](/blog/2014/the-ultimate-guide-to-solving-ios-battery-drain)
/[**Scotty Loveless](/?author=51eaef40e4b02a3783856faa)

[permalink](http://www.overthought.org/blog/2014/the-ultimate-guide-to-solving-ios-battery-drain)

\

-   [**Newer](/blog/2014/a-review-of-my-add-self-trying-to-use-field-notes "Weekender: A Review of Myself Trying to Use Field Notes")
-   [Older**](/blog/2014/background-app-refresh-explained "Background App Refresh Explained in Layman's Terms")

[](https://twitter.com/scottyloveless "Scotty Loveless")[](http://instagram.com/scottyloveless "Scotty Loveless")[](mailto:scotty@overthought.org "scotty@overthought.org")

Search

* * * * *

Receive Updates by Email {.newsletter-form-header-title}
------------------------

Subscribe to receive free, daily updates of what I post on the blog.

Email Address

Sign Up

Thank you!

[Subscribe via RSS](http://rss.overthought.org/feedme)
