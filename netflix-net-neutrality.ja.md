併せて読みたい 

http://www.marco.org/2014/02/27/netflix-and-net-neutrality

2800words


<!--original
[Netflix and Net Neutrality](http://stratechery.com/2014/netflix-net-neutrality/ "Netflix and Net Neutrality")
--------------------------------------------------------------------------------------------------------------
-->
[ネットの動画配信(Netflix)とネットワーク中立性](http://stratechery.com/2014/netflix-net-neutrality/ "Netflix and Net Neutrality")
--------------------------------------------------------------------------------------------------------------

<!--original
Thursday, February 27, 2014 — [Tweet this
article](http://twitter.com/home?status=Netflix%20and%20Net%20Neutrality%20@stratechery%20http://stratechery.com/2014/netflix-net-neutrality/ "Tweet this article")
-->

<!--original
*This article is by definition very US-centric, but the general
principles apply broadly*
-->
*以下の記事の内容はアメリカの事情に特化していますが、根底にある考え方は他の地域でも当てはまると思います。*

<!--original
For anyone remotely connected to technology, the idea that net neutrality is an unabashed good seems incontrovertible, and one of the most popular examples of why it matters is Netflix. Consumers get a video competitor to their cable provider over said cable provider’s pipes; surely the end of net neutrality would mean the end of Netflix!  For example, consider this section from Netflix CEO Reed Hastings’ [2014 letter to shareholders](http://files.shareholder.com/downloads/NFLX/2913616374x0x720306/119321bc-89c3-4306-93ac-93c02da2354f/Q4%2013%20Letter%20to%20shareholders.pdf):
-->
ネットワーク中立性は unabashed good だ、という考え方は、インターネット技術と少しでも関わりあいのある人には議論の余地がないように思えるでしょう。そのネットワーク中立性の、重要性を示す一番の例が Netflix です。Netflix 利用者はケーブルテレビ会社の回線を使って、ケーブルテレビ会社の競合である Netflix が提供するビデオを見ています。ネットワーク中立性の死は Netflix の死をも意味するのです！その具体例として、Netflix CEO の Reed Hastings が今年の初めにシェアホルダー宛に出した[手紙](http://files.shareholder.com/downloads/NFLX/2913616374x0x720306/119321bc-89c3-4306-93ac-93c02da2354f/Q4%2013%20Letter%20to%20shareholders.pdf)の内容を見てみましょう。


<!--original
> Unfortunately, Verizon successfully challenged the U.S. net neutrality
> rules. In principle, a domestic ISP now can legally impede the video
> streams that members request from Netflix, degrading the experience we
> jointly provide. The motivation could be to get Netflix to pay fees to
> stop this degradation. Were this draconian scenario to unfold with
> some ISP, we would vigorously protest and encourage our members to
> demand the open Internet they are paying their ISP to deliver.
-->
> 残念ながら、アメリカにおけるネットワーク中立性に対する Verizon の異議申し立てが通ってしまいました。これにより、原則として国内の ISP は、Netflix 会員が Netflix で見ようとした動画の配信を合法的に妨げることができることになります。これは、ISP と Netflix が共同で提供している価値を引き下げるものです。意図としては、それを避けるために Netflix がもっと手数料を ISP に払うようになればいい、ということかもしれません。仮にこのような極めてひどい仮説が現実になるならば、我々は大いに抗議しますし、会員の皆さんには「我々がそのためにお金を払っている、開かれたインターネットを返すよう ISP に求めましょう」とお願いすることでしょう。

<!--original
And yet, just last week, Netflix – without much protest – did exactly what Hastings described: they [paid Comcast](http://online.wsj.com/news/articles/SB10001424052702304834704579401071892041790?mg=reno64-wsj&url=http%3A%2F%2Fonline.wsj.com%2Farticle%2FSB10001424052702304834704579401071892041790.html&fpid=2,7,121,122,201,401,641,1009) to stop the degradation of Netflix’s services, and are expected to reach a deal with Verizon and other ISPs soon. The stock market promptly punished Netflix, sending the stock down 3.4 percent the day after the announcement.
-->
しかしながら、つい先週、特段の抗議もせず、Netflix は Hastings が語った通りのことを実行しました。彼らは [Comcast に手数料を払い](http://online.wsj.com/news/articles/SB10001424052702304834704579401071892041790?mg=reno64-wsj&url=http%3A%2F%2Fonline.wsj.com%2Farticle%2FSB10001424052702304834704579401071892041790.html&fpid=2,7,121,122,201,401,641,1009)、Netflix のサービスに Comcast がに課している制限を解除してもらったのです。Verizon、及びいくつかの ISP でも、同じような交渉がまもなく合意に至ると見られています。株式市場はこれに適切に反応し、Netflix の株価は上述のニュース発表の翌日3.4％下落しました。

<!--original
Oh, wait, never mind: the stock was **up** 3.4 percent, [hitting an
all-time
high](http://www.mercurynews.com/business/ci_25216762/comcast-deal-sends-netflix-record-highs-verizon-may)
of \$447. This may be the opposite of what most tech observers expected,
but Wall Street is not stupid: this is a great deal for Netflix, a
company who has every incentive to *not* support true, end-to-end net
neutrality.
-->
おっと失礼、今のは忘れてください。株価は3.4％**上がり**、[過去最高](http://www.mercurynews.com/business/ci_25216762/comcast-deal-sends-netflix-record-highs-verizon-may)の447ドルを記録したんでした。テック業界のウォッチャーたちの思惑とは真反対かもしれませんが、ウォールストリートの目は節穴じゃありませんよ。エンドツーエンドでのネットワーク中立性を支持する理由を**一切持たない**企業である Netflix にとって、この合意は素晴らしいものなのです。

<!--original
#### Defining Net Neutrality
-->
## ネットワーク中立性とは？

<!--original
The first problem with the net neutrality debate is that there are three
competing definitions:
-->
ネットワーク中立性に関する議論でまず問題になるのが、3つの相反する定義の存在です。

<!--original
-   **The public definition** – For most people, particularly those of
    us in the tech industry, net neutrality means non-discrimination
    against packets from origin to destination. A packet from Netflix or
    YouTube or PornHub or the New York Times is treated and priced the
    exact same from server to client and back again.
-->
-   **The public definition** – ネットワーク中立性というのは、大半の人、特にテック業界に身を置く我々のような者にとっては、パケットが発信元から受信先までの経路で一切区別されない、ということを指します。パケットが Netflix からのものであれ、YouTube や PronHub やニューヨークタイムズからのものであれ、サーバーとクライアントの間を行き来する間は同じように取り扱われ、かつ課金される、ということです。

<!--original
-   **The legal definition** – The FCC’s [Open Internet
    rules](http://www.fcc.gov/guides/open-internet), which were ruled as [overreaching](http://www.bloomberg.com/news/2014-01-14/verizon-wins-net-neutrality-court-ruling-against-fcc.html) by the U.S. Court of Appeals in Washington, yet still apply to Comcast due to an agreement they signed as part of their acquisition of NBC Universal, only ever applied to traffic *within* an ISP’s network; in other words, once data is within Comcast or Verizon’s network, they can’t discriminate, delivering some data faster or slower. The Netflix/Comcast deal, on the other hand, is about peering: the point at which data enters the Comcast network (there is a useful overview of peering available [here](http://www.btigresearch.com/2014/02/11/forget-net-neutrality-peering-and-interconnection-set-to-be-the-internet-issue-of-2014/#ixzz2tEtvJnuH)).  This is not (and never was) covered by net neutrality, as many geeks are now learning to their dismay.
-->
-   **The legal definition** – FCC の [中立性規則](http://www.fcc.gov/guides/open-internet) は、[行き過ぎである](http://www.bloomberg.com/news/2014-01-14/verizon-wins-net-neutrality-court-ruling-against-fcc.html)として米連邦控訴裁判所によって無効判決が下されましたが、NBC Universal 買収時の合意事項の一環として Comcast には適用されたままになっています。ただし、その規則自体は ISP ネットワーク*内*の通信にのみ適用されてきました。すなわち、一度データが Comcast や Verizon のネットワークに入ってしまえば、優先したり制限をかけたりするために区別することができなくなる、ということです。一方、Netflix/Comcast の合意は、Comcast のネットワークにデータが入る入口、ピアリングに関するものでした (ピアリングの詳細は[ここ](http://www.btigresearch.com/2014/02/11/forget-net-neutrality-peering-and-interconnection-set-to-be-the-internet-issue-of-2014/#ixzz2tEtvJnuH)を参照してください。)。ピアリングは、今日に至るまでネットワーク中立性の範囲には含まれておらず、ギークたちはそれを知ってがっかりしているわけです。

<!--original
-   **The Netflix definition** – Netflix has a subtly different view,
    best articulated by Reed Hastings himself in [a Facebook
    post](https://www.facebook.com/reed1960/posts/10150706947044584) two
    years ago:
-->
<!--original
    > Comcast no longer following net neutrality principles.
    >
    > Comcast should apply caps equally, or not at all.
    >
    > I spent the weekend enjoying four good internet video apps on my > Xbox: Netflix, HBO GO, Xfinity, and Hulu.
    >
    > When I watch video on my Xbox from three of these four apps, it > counts against my Comcast internet cap. When I watch through > Comcast’s Xfinity app, however, it does not count against my > Comcast internet cap.
    >
    > For example, if I watch last night’s SNL episode on my Xbox > through the Hulu app, it eats up about one gigabyte of my cap, but > if I watch that same episode through the Xfinity Xbox app, it > doesn’t use up my cap at all.
    >
    > The same device, the same IP address, the same wifi, the same > internet connection, but totally different cap treatment.
    >
    > In what way is this neutral?
-->
<!--original
    What Netflix is most concerned about from a non-discrimination standpoint [are broadband caps](http://apps.fcc.gov/ecfs/document/view?id=7021917119), and, more broadly, usage-based broadband pricing. It’s not that their position differs on a point-by-point basis from most net neutrality advocates; rather, the priorities are different.
-->

-   **The Netflix definition** – Netflix は少し違った見方をしていて、Reed Hastings 自身が2年前に [Facebook に投稿した内容](https://www.facebook.com/reed1960/posts/10150706947044584)にその違いを見て取ることができます。

    > Comcast はもはやネットワーク中立性原則に従っていない。

    > Comcast は等しく制限をかけるか、もしくは何もしないべきだ。

    > この週末、僕は Xbox で使える Netflix、HBO GO、Xfinity、Hulu の4つのアプリを使って、ネット配信の動画を見て楽しい時間を過ごした。

    > 上記4つのうち3つのアプリで動画を見ると、Comcast が課すデータ使用量制限枠に加算される。けれど、Comcast が提供する Xfinity のアプリを使って同じ動画を見ると、それはデータ使用量制限枠には加算されない。

    > 例えば、仮に昨日の Saturda Night Live を Xbox 上の Hulu アプリ経由で見たとすると、データ使用量制限枠から1GBを使ってしまうけど、同じものを Xbox 上の Xfinity アプリ経由で見たとすると、それはとデータ使用量制限枠を一切使わない、ということだ。

    > 同じデバイス、同じ IP アドレス、同じ wifi、同じインターネット回線。なのにデータ使用量制限の扱いは全く違う。

    > これのどこが中立なんだろう？

    不当差別禁止の観点からすると、Netflix にとって一番気がかりなのは [ブロードバンド回線の利用制限](http://apps.fcc.gov/ecfs/document/view?id=7021917119)、より広義に言えば、従量課金制のブロードバンド回線、ということになります。Netflix のスタンスは、ネットワーク中立性推進派と個別の論点では隔たりはなく、優先順位が違うだけと言えます。 

<!--original
#### Why the Comcast Agreement is Good for Netflix
-->
## Comcast との合意が Netflix に好都合な理由

<!--original
This deal is in many ways a win-win for Netflix: they are likely paying
less for better quality.
-->
上述した Comcast との合意は、Netflix にとって多くの点で Win-Win です。彼らはより良いものを、より安く手に入れられるようになるでしょう。

<!--original
Previously Netflix paid backbone providers such as Cogent for transit; it was then Cogent’s responsibility to interface with last mile provides such as Comcast or Verizon. Cogent [made a lot of noise](http://arstechnica.com/information-technology/2014/02/netflix-packets-being-dropped-every-day-because-verizon-wants-more-money/) about Comcast and other ISPs wanting to get paid on both sides – by customers for Internet access, and Cogent for peering agreements – but the truth is Cogent was just as guplicitous: they wanted to be paid by Netflix on one side, and effectively subsidized by ISPs on the other.
-->
これまで、バックボーン回線事業者である Cogent のような会社に Netflix はトランジット費用を支払ってきました。そして、ラストマイル、足回り回線の事業者である Comcast や Verizon との接続は、Cogent の責任範囲になっていました。そのような状況から Cogent は、Comcast などの ISP が消費者のインターネット回線利用とバックボーン回線事業者とのピアリング契約の双方から利益を得ようとしている、として[一騒動起こした](http://arstechnica.com/information-technology/2014/02/netflix-packets-being-dropped-every-day-because-verizon-wants-more-money/)わけですが、実際のところ Cogent は二枚舌を使っていた、と言えます。Cogent は、Netflix からの売り上げを狙いつつ、ISP から事実上の支援をも受けようとしていたからです。 

<!--original
Free peering agreements between Internet providers were premised on the
idea that a roughly equal amount of traffic was going in both
directions, meaning there was no net increase in cost as a result of a
peering agreement. Netflix, though, changed that equation by moving as
much as 30% of all the United States’ internet traffic in one direction
(on Cogent’s backbone). Cogent’s insistence on “free” peering, then, was
not at all consistent with such previous agreements: Cogent was not
carrying an in-kind amount of traffic in exchange for the traffic they
were dumping onto ISPs.
-->
インターネット回線事業者間の無償ピアリング契約というのは、トラフィックは内向き外向きでだいたい同じ量が流れるので、ピアリング契約を結んでもコスト増には繋がらない、という発想を前提にしていました。しかし、Netflix がその等式を変えてしまいました。Netflix は全米のインターネットトラフィックの30％もの量を、特定の片方向の通信(Cogent のバックボーン内)に集めてしまったのです。その結果、Cogent が無償ピアリングを継続しようとしても、契約内容が成り立たなくなってしまいます。つまり、Cogent から ISP に向けて出ていく膨大な外向きのトラフィックが、ISP から Cogent に上がってくる内向きのトラフィックと釣り合わなくなったのです。

<!--original
As an analogy, suppose my friend Bob and I agreed to watch the other’s dog in the event of a trip or vacation. We both travel about three weeks of the year, so while I have to watch Bob’s dog for three weeks, he watches mine for three weeks as well. While the specific amount of travel may vary year-by-year, it all evens out in the end, and we’re both happy. A few years later, though, I take a job as a consultant, and am suddenly traveling 30 weeks a year. Wouldn’t it be unfair for me to insist that Bob hold to the terms of our agreement, even though it entails him watching my dog 27 weeks more than I watch his? Yet that is exactly what Cogent was demanding for direct access to ISPs’ networks, and the ISPs in turn demanded compensation (keep in mind, Netflix has *always* been free to use the open Internet to reach customers; they simply find the performance unacceptable and wants shortcuts into ISP networks).
--
つまり、例えば、私と友だちのボブが、旅行や休暇の際はお互いが飼っている犬の面倒を見合うことにしよう、という約束をしたとします。どちらも年に3週間ほど旅行に出かけるので、ボブと私はそれぞれ相手の犬を3週間ほど面倒を見ることになります。年によって旅行日数は違ってきますが結局同じくらいになるので、私たちはお互い満足していました。ところが、数年後、私がコンサルタントとして働くようになり、年に30週間ほど出張するようになってしまいました。ここで、ボブが27週多く相手の犬の面倒を見ることになるにも関わらず、上述の約束を守るよう私がボブに要求するのは不公平ではないでしょうか？とはいえ、これこそがまさに Cogent が ISP のネットワークへの接続の対価として要求していたものだったのです。そしてまた ISP も、その見返りとして支払いを求めていました。

<!--original
With this deal, Netflix has effectively cut out the middleman Cogent, and is sending traffic directly from their servers onto Comcast’s network. Not only will this mean better quality for Netflix customers on Comcast, but it also raises the barrier of entry for potential Netflix competitors. Netflix currently has unique leverage over Comcast due to Comcast’s proposed merger with Time Warner, which, combined with their brand name and favorability amongst customers and regulators likely meant they got a [great deal](http://variety.com/2014/digital/news/why-netflix-is-actually-the-big-winner-in-the-comcast-bandwidth-deal-1201118421/); future Netflix competitors, forced to go over the open Internet or rely on providers like Cogent will be at both a cost and quality disadvantage.
-->
この Comcast との合意により、Netflix は中間業者である Cogent を省き、自社のサーバーから Comcast のネットワークに直接トラフィックを流せるようになりました。これは、Comcast 経由で動画を見ている Netflix ユーザーにとって動画配信環境が向上するということだけでなく、Netflix の競合他社にとって参入障壁が上がることをも意味しています。というのも、Netflix は Comcast に対して他者にはない影響力があるからです。


<!--original
Most importantly, though, Netflix has to be thrilled that *Netflix* – not end-users – is paying for better Netflix video, shrouding the extent to which end-users are subsidizing Netflix.
-->


<!--original
#### Who Pays for Broadband?
-->
## ブロードバンドにお金を出しているのは誰？

<!--original
There’s no question, at least in my mind, that broadband is just as much
a requirement for day-to-day life as is electricity, water, sewage,
paved roads, etc. And, like said utilities, broadband lends itself to a
[natural monopoly](http://en.wikipedia.org/wiki/Natural_monopoly); the
cost of capital for building out a network are so great that the
economics demand a single provider.
-->
ブロードバンドが電気、上下水道、道路と同様日常生活において必需品になってきていることには、少なくとも私のなかでは、疑いの余地はありません。そして、上述のライフラインのように、ブロードバンドも[自然独占](http://en.wikipedia.org/wiki/Natural_monopoly)に適しているのです。つまり、ブロードバンドネットワークを構築するには膨大な費用がかかるため、経済合理性の観点から事業者は1つであることが求められるのです。

<!--original
The primary way to deal with natural monopolies is to either have said service provided by the government or provided by a private firm that is heavily regulated with strict requirements about widespread access combined with (relatively) high prices. This is indeed the case with electricity, water, sewage, and roads.^[1](#footnote_0_696 "Problems with these models arise when pricing becomes unregulated, or not included at all")^
-->
自然独占に至る主な方法は、該当のサービスを政府が提供するか、広範囲へのサービス提供に関する条件などで厳しく規制された私企業が(ある程度)高いお金をもらって提供するか、のいずれかです。電気、上下水道、道路などはまさにこれが当てはまります[^01]。


<!--original
The problem with regulating broadband in this way, though, is that the definition of acceptable broadband is much more of a moving target. As Marc Andreessen memorably put it on Twitter:
-->
ただし、自然独占方式でブロードバンドを規制すると問題になるのが、「使えるブロードバンド」というものの定義を定められない、という点にあります。この点に関しては、Marc Andreessen が Twitter に書き込んだ内容が分かりやすいでしょう。

<!--original
> [@mattyglesias](https://twitter.com/mattyglesias)
> [@binarybits](https://twitter.com/binarybits) Because sewers and
> electricity are far more static markets than broadband. You don't shit
> 10x as much every 3 yrs.
>
> — Marc Andreessen (@pmarca) [February 23,
> 2014](https://twitter.com/pmarca/statuses/437683055629570048)
-->
<blockquote class="twitter-tweet" lang="en"><p><a href="https://twitter.com/mattyglesias">@mattyglesias</a> <a href="https://twitter.com/binarybits">@binarybits</a> Because sewers and electricity are far more static markets than broadband. You don&#39;t shit 10x as much every 3 yrs.</p>&mdash; Marc Andreessen (@pmarca) <a href="https://twitter.com/pmarca/statuses/437683055629570048">February 23, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

> それは、上限水道や電気がブロードバンドよりもずっと変化の少ない市場だからだよ。うんこの量は3年ごとに倍になったりしないし。  
(訳注：ブロードバンドも水道のように規制付きの自然独占にしてしまえばいい。下水道と何が違うの？という問いに対し) 

<!--original
Remember, the United States is a country where one of the two major
political parties routinely threatens to default on the nation’s debt to
score political points. Infrastructure investment is embarrassingly low
in things like roads and bridges, much less in environmentally
sustainable power like
nuclear;^[2](#footnote_1_696 "If there is one thing to take away from this article as a whole, it is that everything is a tradeoff. I know my aside on nuclear just upset a lot of you, but when you consider the relative cost and capacity of wind, solar, etc, and the environmental destruction caused by fossil fuels, non-polluting nuclear and its spent fuel risks makes a lot of sense. Tradeoffs.")^
to put the future of broadband, something that requires continual
investment, into the hands of such a dysfunctional government seems
foolhardy at best.
-->

[translation here]

<!--original
And yet, the fact that wired broadband in particular is a natural
monopoly remains, raising the question of how you incentivize investment
in ever faster broadband? There are three main
options:^[3](#footnote_2_696 "Google Fiber is a fourth: building a straight-up competitor, natural monopoly economics be damned. It’s possible because Google already has its own backhaul network, but I have trouble seeing how it will scale at least in the near term")^
-->

[translation here]

<!--original
-   **Government mandate** – Given the assumption that broadband is a
    economic necessity, this is the prescription that follows.
    Unfortunately, the same pragmatic problems that make
    government-provided broadband a likely non-starter plague this as
    well; Republicans in particular have actively opposed any sort of
    telecom regulation, even before you get to the incentive problems of
    mandates versus markets.
-->

[translation here]

<!--original
-   **Discriminatory pricing** – Companies like Amazon know that [every
    100ms
    delay](http://blog.gigaspaces.com/amazon-found-every-100ms-of-latency-cost-them-1-in-sales/)
    causes them to lose sales; that makes guaranteed access to end users
    exceptionally valuable. It’s the same thing with Google, Netflix,
    and most other Internet companies. Comcast and other ISPs would
    certainly be incentivized to improve their networks if they knew
    that said companies would compensate them accordingly.
-->

[translation here]

<!--original
    To some extent, this is exactly what just happened with the Netflix
    peering agreement, although true discrimination within their network
    would incentivize Comcast even more.
-->

[translation here]

<!--original
-   **Usage-based pricing** – With usage-based pricing, if you use more
    data, you pay more; use less, pay less. As we’ve seen with wireless,
    this strongly incentivizes network providers to increase broadband
    capacity. It’s no accident that the rollout of LTE in the US was
    combined with the imposition of data caps, just as it’s not an
    accident that the US has far better LTE penetration than anywhere
    else in the world. This despite the fact that providing wireless
    service in the US is much more difficult than just about anywhere
    else in the world due to sheer physical size and effective
    NIMBYism.^[4](#footnote_3_696 "NIMBY = Not In My BackYard")^ AT&T,
    Verizon, etc. want you to use as much data as possible as quickly as
    possible, and to charge you for the privilege.
-->

[translation here]

<!--original
#### Making Tradeoffs
-->

[translation here]

<!--original
In the end, each of these options presents a different set of tradeoffs
among three competing ideals:
-->

[translation here]

<!--original
-   Continual investment in faster and more accessible broadband
-   Non-discriminatory treatment of data
-   Unlimited access
-->

[translation here]

<!--original
There is no approach, at least given the United State’s political
realities, that allows for all three; this is “Fast/Good/Cheap Choose
Two” applied to Internet access.
-->

[translation here]

<!--original
Thus, we need to make choices based on priorities. From my perspective,
the most important of these ideals is the non-discriminatory treatment
of data. This is what makes the Internet so profound, and what enables
new companies to disrupt the market and improve the lives of millions.
It must be protected not just within an ISPs network, but all across the
entire Internet including peering.
-->

[translation here]

<!--original
The second most important is continual investment in faster and more
accessible broadband. The flip-side of the Internet being so profound is
that improved access has an exponential return both from an economic as
well as from a societal impact perspective.
-->

[translation here]

<!--original
That leaves unlimited access on the chopping block. While I love the
idea of unlimited data, I also am aware that nothing comes for free; in
the case of unlimited data, the cost we are paying is underinvestment
and/or discriminatory treatment of data. Therefore I believe the best
approach to broadband is usage-based payment by both upstream and
downstream, with no payments in the middle.
-->

[translation here]

<!--original
The way this would have played out in the case of Netflix is that:
-->

[translation here]

<!--original
-   Netflix would pay more at the point of origin to compensate backbone
    providers for the massive amount of data they generate
-   ISP customers who watch the most video would pay more
-->

[translation here]

<!--original
It’s the latter result that terrifies Netflix, and is why, in the end,
they are not an ally of those of us who desire true net neutrality.
Currently non-Netflix broadband subscribers are effectively subsidizing
Netflix viewers; they use much less capacity, yet pay the same price.
This needs to change for the sake of true net neutrality, and if it
results in Netflix losing subscribers, so be it.
-->

[translation here]

<!--original
Unfortunately, this agreement and the others that are soon to follow
makes such an arrangement unlikely. Comcast and company are getting
paid, so they’re happy, and Netflix is disguising their true cost to end
users so they are happy as well. It’s non-Netflix users, and, more
distressingly, the startups and services that have yet to be created who
are ultimately paying the price.
-->

[translation here]

<!--original
1.  Problems with these models arise when pricing becomes unregulated,
    or not included at all [↩](#identifier_0_696)
2.  If there is one thing to take away from this article as a whole, it
    is that **everything** is a tradeoff. I know my aside on nuclear
    just upset a lot of you, but when you consider the relative cost and
    capacity of wind, solar, etc, and the environmental destruction
    caused by fossil fuels, non-polluting nuclear and its spent fuel
    risks makes a lot of sense. Tradeoffs. [↩](#identifier_1_696)
3.  Google Fiber is a fourth: building a straight-up competitor, natural
    monopoly economics be damned. It’s possible because Google already
    has its own backhaul network, but I have trouble seeing how it will
    scale at least in the near term [↩](#identifier_2_696)
4.  NIMBY = Not In My BackYard [↩](#identifier_3_696)
-->

[^01]: 価格規制が撤廃されたり無料になったりすると、このモデルの問題点が指摘されるようになります。
