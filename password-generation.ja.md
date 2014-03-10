
<!--original
Password Generation and Safe Offline Storage {itemprop="name"}
============================================
-->

[translation here]

<!--original
HackThis!! - Password Generation and Safe Offline Storage https://www.hackthis.co.uk/articles/password-generation-and-safe-offline-storage
-->

[translation here]

<!--original
** February 16, 2014 · updated February 16, 2014 ** [Security](security)
** [Keeper](/user/Keeper)
-->

[translation here]

<!--original
-   [**
    10](/articles/password-generation-and-safe-offline-storage#comments)
-   [** 8](#)
-   [**](#)
-   [**](#)
-->

[translation here]

<!--original
Contents
--------
-->

[translation here]

<!--original
-   [1. Password generating](#1-password-generating)
-   - [✔ Factors:](#factors)
-   - [Analysis for the password:
    ***\^P(/5\<;=Ttj"7***](#analysis-for-the-password-ibp5ltttjquot7bi)
-   [2. Safe Storage](#2-safe-storage)
-   - [Tips:](#tips)
-   [Comments](#comments)
-->

[translation here]

<!--original
1. Password generating {#1-password-generating}
======================
-->

[translation here]

<!--original
\
 How to generate the ultimate password and store it offline as safely as
possible.\
 \
-->

[translation here]

<!--original
✔ Factors:
----------
-->

[translation here]

<!--original
\
 ➲ values
-->

[translation here]

<!--original
-   charset: a-zA-Z0-9!@\#\$%...
-   alphabets: cyrillic, latin, hebrew, greek, syllabic etc.
-->

[translation here]

<!--original
\
 !NB Do not use alt symbols. They are often misread unsupported by most
boards and sites. UTF-8 has issues interpreting them.\
 \
 ➲ length
-->

[translation here]

<!--original
-   The default length which is used for brute-forcing numeric values is
    up to 13. Choosing a password of that length mitigates the
    possibility for a middle-sized brute-force attack.
-->

[translation here]

<!--original
\
 ➲ range
-->

[translation here]

<!--original
-   Use both 'a' and 'z' & 'A' and 'Z' at least once. Why? Mask attacks
    often work on the principle of known patterns. In terms of sparing
    resources, the attacker chooses to run an attack that checks alpha
    values ranging a-f, for instance. Same refers for numeric values and
    capitalization. Even the slightest repentance is posing a threat.
-->

[translation here]

<!--original
\
 ➲ sequence
-->

[translation here]

<!--original
-   The sequence of characters must not obey any pattern of alphabet
    order. This includes no repentance and a 100% random password.
-->

[translation here]

<!--original
\
 Good password: ***0\>]tIA9SbV6\*l***\
 Bad password: ***~~Mnoxu.a\<-,@!T~~***\
 \
 ✘ Sample passwords\
 \
-->

[translation here]

<!--original
Code:
-->

[translation here]

<!--original
~~~~ {.bbcode_code_body .prettyprint style="overflow: hidden"}
tI<?gfnQNnCi`
G2;!12f4l/f]q
IZkC^Az"!b#/B
OJnx7.a<-,@!T
"T_Jl)4_Vs<+~
~~~~
-->

[translation here]

<!--original
\
-->

[translation here]

<!--original
[![xdy1dOj.png](http://i.imgur.com/xdy1dOj.png)](http://i.imgur.com/xdy1dOj.png)\
 \
 \
-->

[translation here]

<!--original
Analysis for the password: ***\^P(/5\<;=Ttj"7*** {#analysis-for-the-password-ibp5ltttjquot7bi}
------------------------------------------------
-->

[translation here]

<!--original
\
 \
 ➲ Time consumption\
-->

[translation here]

<!--original
-   The number of passwords to go through is **4.52175473e+025** or in
    other words **18 756 986 699 360 373 169 305 600** according to C
    (n, k) = Vkn / Pn. That would take approximately**\> 10 000 days**
    (or \~27 years).
-->

[translation here]

<!--original
\
 Below is the success rate of the different types of attacks illustrated
in this article. The time estimated is based on the average speed of **1
069 691 p/s**. The total number of characters used in the exhaustive
search attack is **94**.\
 \
 This results to even more than **33 years** to process each combination
under the nVidia model specified above.\
 For the record China’s supercomputer disposes with 32,000 Ivy Bridge
Xeon CPUs.\
 \
-->

[translation here]

<!--original
[![bGshgnb.png](http://i.imgur.com/bGshgnb.png)](http://i.imgur.com/bGshgnb.png)\
 \
-->

[translation here]

<!--original
2. Safe Storage {#2-safe-storage}
===============
-->

[translation here]

<!--original
\
 \
 Undoubtedly, the best way to keep your passwords safe from any worm or
intruder is to write them down on a sheet of paper. That itself,
however, is outside the scope of our objective and is not a subject of
discussion in this document. In short, we need to apply both
steganography and cryptography in order to guarantee ourselves a
somewhat decent protection.\
 \
 ⊙ **Steganography**: ensures stealth and disguise\
 ⊙ **Cryptography**: encrypts the password/s *(optional)*\
 \
 *❝ People rarely notice things right in front of their eyes ❞*. In case
you can’t think of a way to hide the passwords, simply use some
wallpaper with loads of code or writings and write the passwords
somewhere within it. Nobody would even think of looking into this
especially for a password.\
 \
 Another scenario could involve hiding the passwords within the source
code of a file. For instance, make a file in some privileged directory
and place the passwords amongst the hex values of it. The idea is to use
a file that won’t get deleted or at least not purposely.\
 \
-->

[translation here]

<!--original
[![6iISVST.png](http://i.imgur.com/6iISVST.png)](http://i.imgur.com/6iISVST.png)\
 \
 Though, the scheme presented in this document is not entirely secure,
it is considered for pre-intermediate users that are aware of what
threats exist in the known web. Information laid out here is intended to
ensure the secure authentication of the average user and a proactive
defense against a widespread hacking method that is based on database
look-ups. Notwithstanding what was mentioned so far and its obviousness,
it is something that is often neglected as a precaution against hackers
getting their hands on your passwords which may include access to your
credit card or bank account.\
 \
-->

[translation here]

<!--original
Tips:
-----
-->

[translation here]

<!--original
1.  Follow the above guidelines
2.  Never reuse one password
3.  Steganography wisely
4.  Do not write down your passwords outside the PC
5.  Do not install add-ons
6.  Do not install random software
7.  Do not share accounts with Android devices
8.  Do not share this document
9.  Format your drives
10. Always have a plan B (back-up)
-->
