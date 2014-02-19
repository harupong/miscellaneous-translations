<!--# How the Bitcoin protocol actually works-->
# Bitcoin の仕組み

[How the Bitcoin protocol actually works | DDI](http://www.michaelnielsen.org/ddi/how-the-bitcoin-protocol-actually-works/)

by Michael Nielsen on December 6, 2013

<!--
Many thousands of articles have been written purporting to explain Bitcoin, the online, peer-to-peer currency. Most of those articles give a hand-wavy account of the underlying cryptographic protocol, omitting many details. Even those articles which delve deeper often gloss over crucial points. My aim in this post is to explain the major ideas behind the Bitcoin protocol in a clear, easily comprehensible way. We’ll start from first principles, build up to a broad theoretical understanding of how the protocol works, and then dig down into the nitty-gritty, examining the raw data in a Bitcoin transaction.
-->
P2P ベースのオンライン通貨である Bitcoin について、幾多の解説が書かれてきたことだろう。しかし、それらの大半では、ベースとなっている暗号技術・プロトコルの詳細をきちんと説明されていない。また、綿密な調査のもとに書かれたものですら、極めて重要な点を軽んじていることが多い。以下に続くこの文章の目的は、Bitcoin の仕組み・プロトコルの主たる概念を、明快かつ分かりやすく解説することである。初歩的な原則を1つずつ解説していき、Bitcoin のプロトコルを論理的に理解できるようにする。そののち、Bitcoin 取引においてやりとりされる実データを用いて具体的なポイントを解説する。

<!--
Understanding the protocol in this detailed way is hard work. It is tempting instead to take Bitcoin as given, and to engage in speculation about how to get rich with Bitcoin, whether Bitcoin is a bubble, whether Bitcoin might one day mean the end of taxation, and so on. That’s fun, but severely limits your understanding. Understanding the details of the Bitcoin protocol opens up otherwise inaccessible vistas. In particular, it’s the basis for understanding Bitcoin’s built-in scripting language, which makes it possible to use Bitcoin to create new types of financial instruments, such as [smart contracts](http://szabo.best.vwh.net/formalize.html). New financial instruments can, in turn, be used to create new markets and to enable new forms of collective human behaviour. Talk about fun!
-->
Bitcoin のプロトコルを詳細に理解するには困難が伴う。そんな面倒な事はせず、Bitcoin をあって当然のものと捉え、それをつかってどうやって稼ぐか、Bitcoin はバブルだ、Bitcoin は税制を抜け出す第一歩だ、などといったやりとりに参加したくなる。確かにそれは楽しそうだけど、Bitcoin をきちっと理解することを妨げるに違いない。Bitcoin の仕組みを正確に理解すれば、これまでは想像も出来なかったような展望を持つこともできる。またそれは、Bitcoin のプログラミング言語としての側面を理解する助けにもなるだろう。Bitcoin のプログラミング機能は、[smart contracts](http://szabo.best.vwh.net/formalize.html) のような新しい種類の金融商品を創りうるものだ。新しい金融商品ができれば、そこにはマーケットが生まれ、人々の生活を変えることにもつながる。実に楽しそうだ。

<!--
I’ll describe Bitcoin scripting and concepts such as smart contracts in future posts. This post concentrates on explaining the nuts-and-bolts of the Bitcoin protocol. To understand the post, you need to be comfortable with [public key cryptography](http://en.wikipedia.org/wiki/Public-key_cryptography), and with the closely related idea of [digital signatures](https://en.wikipedia.org/wiki/Digital_signature). I’ll also assume you’re familiar with [cryptographic hashing](https://en.wikipedia.org/wiki/Cryptographic_hash_function).  None of this is especially difficult. The basic ideas can be taught in freshman university mathematics or computer science classes. The ideas are beautiful, so if you’re not familiar with them, I recommend taking a few hours to get familiar.
-->
smart contracts のようなブログラミング機能の部分は別途解説することにし、Bitcoin プロトコルの基本的な部分をしっかりと説明していくことにする。内容を理解するには、[公開鍵暗号](http://en.wikipedia.org/wiki/Public-key_cryptography)と[電子署名](https://en.wikipedia.org/wiki/Digital_signature)について把握できている必要がある。また、[暗号学的ハッシュ](https://en.wikipedia.org/wiki/Cryptographic_hash_function)も把握されているものとして解説を進める。これらはいずれも複雑なものではなく、大学1年生向けの数学、コンピューターサイエンスの授業で十分カバーできる内容だ。もしまだ把握できていないなら、少し時間をとってよく把握しておくことをおすすめする。

<!--
It may seem surprising that Bitcoin’s basis is cryptography. Isn’t Bitcoin a currency, not a way of sending secret messages? In fact, the problems Bitcoin needs to solve are largely about securing transactions — making sure people can’t steal from one another, or impersonate one another, and so on. In the world of atoms we achieve security with devices such as locks, safes, signatures, and bank vaults. In the world of bits we achieve this kind of security with cryptography. And that’s why Bitcoin is at heart a cryptographic protocol.
-->
Bitcoin の根幹は暗号だ、と知って驚くかもしれない。Bitcoin は通貨であって、秘密文書をやりとりする手段じゃないでしょ！？と。実際のところ、盗難やなりすましを防止するためにいかに取引の安全性を高めるかが、 Bitcoin が抱える最大の課題である。リアル世界では、錠前、金庫、署名捺印、銀行の金庫といった「モノ」を用いて取引の安全性を高めている。電子、ネットの世界では、暗号を用いて同等の安全性を確保する。その意味において、Bitcoin とはまさに暗号の仕組みそのものだと言ってもよい。

<!--
My strategy in the post is to build Bitcoin up in stages. I’ll begin by explaining a very simple digital currency, based on ideas that are almost obvious. We’ll call that currency *Infocoin*, to distinguish it from Bitcoin. Of course, our first version of Infocoin will have many deficiencies, and so we’ll go through several iterations of Infocoin, with each iteration introducing just one or two simple new ideas. After several such iterations, we’ll arrive at the full Bitcoin protocol. We will have reinvented Bitcoin!
-->
解説の仕方だが、Bitcoin を順を追って組み立ててみる。まずは、説明するまでもないような単純なデジタル通貨の解説をする。ここでは、その通貨を *Infocoin* と呼び、Bitcoin と区別する。Infocoin バージョン1は不具合だらけになるに違いないので、バージョンアップの過程で不具合解消策を順を追って解説する。バージョンアップを何度か繰り返し、Bitcoin の仕組みにまで追いつく予定だ。Bitcoin の再発明！ということになる。

<!--
This strategy is slower than if I explained the entire Bitcoin protocol in one shot. But while you can understand the mechanics of Bitcoin through such a one-shot explanation, it would be difficult to understand *why* Bitcoin is designed the way it is. The advantage of the slower iterative explanation is that it gives us a much sharper understanding of each element of Bitcoin.
-->
このやり方は、一度に Bitcoin の仕組みを解説してしまうより時間がかかる。まとめて解説されても仕組みの理解はできるだろうけど、その理由にまで理解を進めるのは難しくなる。順を追って解説すれば、Bitcoin の仕組み一つ一つをより正確に理解できるはずだ。

<!--
Finally, I should mention that I’m a relative newcomer to Bitcoin. I’ve been following it loosely since 2011 (and cryptocurrencies since the late 1990s), but only got seriously into the details of the Bitcoin protocol earlier this year. So I’d certainly appreciate corrections of any misapprehensions on my part. Also in the post I’ve included a number of “problems for the author” – notes to myself about questions that came up during the writing. You may find these interesting, but you can also skip them entirely without losing track of the main text.
-->
ところで、解説を始める前に一つ。自分は、Bitcoin に関しては素人に毛が生えた程度であることを断っておきたい。2011年以降意識はしてきたけど(cryptocurrency (訳注：デジタルな流通通貨、若しくは物々交換に変わる交換手段) については1990年代から)、Bitcoin の詳細を真剣に調べだしてからようやく一年、といったところ。なので、こちらの理解に誤りがあると思ったら、ぜひ指摘していただきたい。また、この文章にはいくつも「自分への問いかけ」と題した、文章作成中に思いついた疑問を書き残してある。興味があれば読んでみてもいいし、全て読み飛ばしても本文の理解には差し障りない。

<!--
## First steps: a signed letter of intent
-->
## はじめの一歩：署名済み意向表明書

<!--
So how can we design a digital currency?
-->
デジタル通貨はどのように設計すればよいだろうか。

<!--
On the face of it, a digital currency sounds impossible. Suppose some person – let’s call her Alice – has some digital money which she wants to spend. If Alice can use a string of bits as money, how can we prevent her from using the same bit string over and over, thus minting an infinite supply of money? Or, if we can somehow solve that problem, how can we prevent someone else forging such a string of bits, and using that to steal from Alice?
-->
一見したところ、デジタル通貨は空想の産物に思える。例えば、デジタル通貨を所持していて、それを使おうとしてる人がいるとしよう。その人を仮に一郎と呼ぶ。一郎がデジタルデータをお金として使うことが出来る場合、同一のデジタルデータを繰り返し利用し、貨幣を鋳造し続けられるような状態になれることをどうやって防げばいいだろう？また、仮にその問題を解決できたとしても、そのデジタルデータを何らかの方法で捏造し、一郎の所持金を奪おうとする行為はどうやって防げるだろうか？

<!--
These are just two of the many problems that must be overcome in order to use information as money.
-->
上に挙げた2つの問題は、情報をお金として使おうとする際に解決しなければならい問題の一部にすぎない。

<!--
As a first version of Infocoin, let’s find a way that Alice can use a string of bits as a (very primitive and incomplete) form of money, in a way that gives her at least some protection against forgery. Suppose Alice wants to give another person, Bob, an infocoin. To do this, Alice writes down the message “I, Alice, am giving Bob one infocoin”. She then digitally signs the message using a private cryptographic key, and announces the signed string of bits to the entire world.
-->
Infocoin バージョン1として、原始的かつ不完全ではあるが、デジタルデータを何らかの捏造対策が施されたお金の一種として、一郎が使えるようにしてみる。一郎が二郎に 1 infocoin を譲渡したい場合、まず一郎は「私、一郎は、二郎に 1 infocoin を譲渡します」と書かれた文書を作成する。そしてその文書に秘密鍵を使ってデジタル署名を施し、署名済み文書を公開する。

<!--
(By the way, I’m using capitalized “Infocoin” to refer to the protocol and general concept, and lowercase “infocoin” to refer to specific denominations of the currency. A similar useage is common, though not universal, in the Bitcoin world.)
-->
(ここでは、大文字で始まる Infocoin をプロトコルやコンセプトとして、小文字で始まる infocoin を通貨の単位として使う。BitCoin の世界でも、この使い分けは一般的だ)

<!--
This isn’t terribly impressive as a prototype digital currency! But it does have some virtues. Anyone in the world (including Bob) can use Alice’s public key to verify that Alice really was the person who signed the message “I, Alice, am giving Bob one infocoin”. No-one else could have created that bit string, and so Alice can’t turn around and say “No, I didn’t mean to give Bob an infocoin”. So the protocol establishes that Alice truly intends to give Bob one infocoin. The same fact – no-one else could compose such a signed message – also gives Alice some limited protection from forgery. Of course, *after* Alice has published her message it’s possible for other people to duplicate the message, so in that sense forgery is possible. But it’s not possible from scratch.  These two properties – establishment of intent on Alice’s part, and the limited protection from forgery – are genuinely notable features of this protocol.
-->
このデジタル通貨、プロトタイプだとしてもとても褒められたものではない。けれど、いいところもある。「私、一郎は、二郎に 1 infocoin を譲渡します」と書かれた文書にデジタル署名を施したのが一郎であることが、二郎含め誰でも、一郎の公開鍵を使って確認することができる、という点だ。一郎以外には同じ署名を施せないので、裏を返せば、「二郎に 1 infocoin を譲渡するつもりなんてなかった」という一郎の虚偽の申告はすぐ見破られる。このように、このルール、プロトコルによって、一郎が文書にした「二郎への 1 infocoin 譲渡の意思」が裏付けされることになる。また、上述の「一郎以外には同じ署名付き文書を作成できない」という点が、部分的ではあるが、一郎に捏造防止策を与えることになる。もちろん、一郎が文書を公開した *後* にその文書を複製することはできるから、その観点では捏造は可能といえる。それでも、いちからの捏造はできないことになる。これら2つの性質、一郎の意思の裏付けと部分的捏造防止策、はこのプロトコルの特筆すべき機能だ。

<!--
I haven’t (quite) said exactly what digital money *is* in this protocol.  To make this explicit: it’s just the message itself, i.e., the string of bits representing the digitally signed message “I, Alice, am giving Bob one infocoin”. Later protocols will be similar, in that all our forms of digital money will be just more and more elaborate messages [1].
-->
ここで、Infocoin プロトコルにおけるデジタル通貨の実態が何であるか、改めて明確にしておこう。それは、文書そのもの、つまり、「私、一郎は、二郎に 1 infocoin を譲渡します」というデジタル署名付き文書のバイト列に他ならない。今後の説明は複雑さが増すものの、本質的にはこの点は変わらない [^1]。

<!--
## serial numbers to make coins uniquely identifiable
-->
## 硬貨を区別するための連番

<!--
A problem with the first version of Infocoin is that Alice could keep
sending Bob the same signed message over and over. Suppose Bob receives
ten copies of the signed message “I, Alice, am giving Bob one infocoin”.
Does that mean Alice sent Bob ten *different* infocoins? Was her message
accidentally duplicated? Perhaps she was trying to trick Bob into
believing that she had given him ten different infocoins, when the
message only proves to the world that she intends to transfer one
infocoin.
-->
Infocoin バージョン1 の問題点は、一郎は二郎に対し同一の文書を繰り返し送れる、ということだ。仮に、「私、一郎は、二郎に 1 infocoin を譲渡します」という署名付き文書を10通、二郎が受け取ったとする。それは、一郎が二郎に 10 の異なる infocoin を送ったことになるのだろうか？一郎の文書は、たまたま複製されてしまった可能性は？ひょっとしたら、一郎は、二郎を騙して 10 infocoin を送ったことにしようとしたのかもしれない。文書そのものは、一郎が 1 infocoin 二郎を送ろうとしたという証明にしかならないにも関わらず、だ。

<!--
What we’d like is a way of making infocoins unique. They need a label or
serial number. Alice would sign the message “I, Alice, am giving Bob one
infocoin, with serial number 8740348″. Then, later, Alice could sign the
message “I, Alice, am giving Bob one infocoin, with serial number
8770431″, and Bob (and everyone else) would know that a different
infocoin was being transferred.
-->
ここで、infocoin を区別する手段、連番やラベルが必要になる。「私、一郎は二郎に、連番 8740348 の 1 infocoin を譲渡します」という文書に一郎がデジタル署名を付与したとする。その後、一郎が「私、一郎は二郎に、連番 8770431 の 1 infocoin を譲渡します」という文書にデジタル署名を付与すれば、二郎(や他のみんな)は送金されようとしているのが違う infocoin であることを確認できる。

<!--
To make this scheme work we need a trusted source of serial numbers for
the infocoins. One way to create such a source is to introduce a *bank*.
This bank would provide serial numbers for infocoins, keep track of who
has which infocoins, and verify that transactions really are legitimate,
-->
この仕組みをうまくまわすためには、連番に重複がないようにしなければならない。方法の一つとして、銀行が挙げられる。連番発行、各 infocoin の所有者管理、取引有効性の裏付けなどを銀行が行えば良い。

<!--
In more detail, let’s suppose Alice goes into the bank, and says “I want
to withdraw one infocoin from my account”. The bank reduces her account
balance by one infocoin, and assigns her a new, never-before used serial
number, let’s say 1234567. Then, when Alice wants to transfer her
infocoin to Bob, she signs the message “I, Alice, am giving Bob one
infocoin, with serial number 1234567″. But Bob doesn’t just accept the
infocoin. Instead, he contacts the bank, and verifies that: (a) the
infocoin with that serial number belongs to Alice; and (b) Alice hasn’t
already spent the infocoin. If both those things are true, then Bob
tells the bank he wants to accept the infocoin, and the bank updates
their records to show that the infocoin with that serial number is now
in Bob’s possession, and no longer belongs to Alice.
-->
具体例を挙げよう。一郎が「僕の口座から 1 infocoin を引き出したい」と銀行のカウンターで告げたとする。銀行は一郎の口座残高を 1 infocoin 減額し、過去に未使用な連番、1234567、を一郎に付与する。そして、一郎が二郎に infocoin を送金するときには、「私、一郎は二郎に、連番 1234567 の 1 infocoin を譲渡します」という文書にデジタル署名を付与すればよい。一方、二郎の方は、すぐに送金を受領しない。銀行に連絡し、該当連番の infocoin の所有者が一郎であること、一郎がまだその infocoin を使っていないことを確認する必要がある。その2点の確認がとれたら、二郎は銀行に送金受領の意思を伝え、銀行は管理台帳上の該当連番の infocoin の所有者を一郎から二郎に変更する。

<!--
## Making everyone collectively the bank
-->
## 一人ひとりが「銀行」

<!--
This last solution looks pretty promising. However, it turns out that we
can do something much more ambitious. We can eliminate the bank entirely
from the protocol. This changes the nature of the currency considerably.
It means that there is no longer any single organization in charge of
the currency. And when you think about the enormous power a central bank
has – control over the money supply – that’s a pretty huge change.
-->
上述の例はかなり筋がよさそう。けれど、さらにもう一歩踏み込んで、銀行をなくしてしまうのはどうだろう。通貨の性質を大きく変える、つまり、通貨を管理する組織体がなくなる、ということだ。中央銀行が持つマネーサプライへの影響力の強さを考えれば、これがいかに大きな変化かよく分かる。

<!--
The idea is to make it so *everyone* (collectively) is the bank. In
particular, we’ll assume that everyone using Infocoin keeps a complete
record of which infocoins belong to which person. You can think of this
as a shared public ledger showing all Infocoin transactions. We’ll call
this ledger the *block chain*, since that’s what the complete record
will be called in Bitcoin, once we get to it.
-->
どういうことかというと、、*関係者全員*で銀行の機能を果たす共同体を作り上げられないか、ということだ。具体的には、まず Infocoin 所有者全員が、全 infocoin 所持者履歴、infocoin の全取引を記録した公開型の共同台帳のようなものを保持しているとする。Bitcoin にならって、ここではこの台帳を *block chain* と呼ぶことにしよう。

<!--
Now, suppose Alice wants to transfer an infocoin to Bob. She signs the
message “I, Alice, am giving Bob one infocoin, with serial number
1234567″, and gives the signed message to Bob. Bob can use his copy of
the block chain to check that, indeed, the infocoin is Alice’s to give.
If that checks out then he broadcasts both Alice’s message and his
acceptance of the transaction to the entire network, and everyone
updates their copy of the block chain.
-->
続いて、一郎が二郎に 1 infocoin を送金するケースを想定してみる。一郎は「私、一郎は二郎に、連番 1234567 の 1 infocoin を譲渡します」という文書に署名を施し、二郎にその文書を送る。二郎は、自分が保持している block chain を使ってその infocoin が一郎のものであることを確認する。確認がとれたら、一郎の文書と受領の意思の双方を、二郎は関係者に向けて発信する。二郎からのメッセージを受け取った者は、自身が管理する block chain を更新する。

<!--
We still have the “where do serial number come from” problem, but that
turns out to be pretty easy to solve, and so I will defer it to later,
in the discussion of Bitcoin. A more challenging problem is that this
protocol allows Alice to cheat by double spending her infocoin. She
sends the signed message “I, Alice, am giving Bob one infocoin, with
serial number 1234567″ to Bob, and the message”I, Alice, am giving
Charlie one infocoin, with [the same] serial number 1234567″ to Charlie.
Both Bob and Charlie use their copy of the block chain to verify that
the infocoin is Alice’s to spend. Provided they do this verification at
nearly the same time (before they’ve had a chance to hear from one
another), both will find that, yes, the block chain shows the coin
belongs to Alice. And so they will both accept the transaction, and also
broadcast their acceptance of the transaction. Now there’s a problem.
How should other people update their block chains? There may be no easy
way to achieve a consistent shared ledger of transactions. And even if
everyone can agree on a consistent way to update their block chains,
there is still the problem that either Bob or Charlie will be cheated.
-->
「連番を誰が発行するか」という問題は上述の流れでも解消できないけれど、Bitcoin の解説のなかであっさり解決される問題でもあるので、ここでは触れない。その代わり、このプロトコルだと一郎が infocoin を多重使用できてしまうという、もっとやっかいな問題と向き合うことにしよう。一郎が二郎に「私、一郎は二郎に、連番 1234567 の 1 infocoin を譲渡します」という署名付き文書を、三郎には「私、一郎は三郎に、(同じ)連番 1234567 の 1 infocoin を譲渡します」という署名付き文書を送ったとする。二郎と三郎は、その infocoin が一郎のものであることを自分が保持している block chain を使って確認する。そのとき、仮にこの確認作業がほぼ同時に行われた(事前に両者が何もやりとりせずに)とすると、二郎と三郎はともにその infocoin は一郎のものであると判断する。そして、二人揃ってその送金取引を受領することになる。この流れの問題点にお気づきだろうか？block chain、共有取引台帳を正確な状態に保ち続ける簡単な方法が見当たらないのである。更に厄介なことに、仮にそのような方法が見つかったとしても、二郎か三郎、いずれかが騙される可能性が残ってしまう。

<!--
At first glance double spending seems difficult for Alice to pull off.
After all, if Alice sends the message first to Bob, then Bob can verify
the message, and tell everyone else in the network (including Charlie)
to update their block chain. Once that has happened, Charlie would no
longer be fooled by Alice. So there is most likely only a brief period
of time in which Alice can double spend. However, it’s obviously
undesirable to have any such a period of time. Worse, there are
techniques Alice could use to make that period longer. She could, for
example, use network traffic analysis to find times when Bob and Charlie
are likely to have a lot of latency in communication. Or perhaps she
could do something to deliberately disrupt their communications. If she
can slow communication even a little that makes her task of double
spending much easier.
-->
とはいえ、一見すると一郎が多重使用をやり果せる可能性は低いように思える。具体的には、まず一郎が二郎にだけ文書を送り、受け取った二郎はその文書を確認する。確認ができたら、 block chain を更新するよう三郎を含む関係者宛に二郎が通知する。この一連の手続きが流れば、三郎が一郎に騙されることはないからだ。このことからも、一郎が実際に多重使用を試みれる時間的猶予はとても短いことが分かる。しかしながらそのような猶予がわずかでも存在することは、やはり望ましいとは言えない。というのも、その猶予を引き伸ばす手法がいくつも存在するからだ。二郎と三郎が属するネットワークを分析し、遅延が多くなる時間帯を割り出しておくこともできるだろう。あるいは、二郎や三郎が属するネットワークを意図的に遅延させることも可能だ。少しでも遅延を発生させられれば、一郎が多重使用をなし得る可能性はずっと高くなる。

<!--
How can we address the problem of double spending? The obvious solution
is that when Alice sends Bob an infocoin, Bob shouldn’t try to verify
the transaction alone. Rather, he should broadcast the possible
transaction to the entire network of Infocoin users, and ask them to
help determine whether the transaction is legitimate. If they
collectively decide that the transaction is okay, then Bob can accept
the infocoin, and everyone will update their block chain. This type of
protocol can help prevent double spending, since if Alice tries to spend
her infocoin with both Bob and Charlie, other people on the network will
notice, and network users will tell both Bob and Charlie that there is a
problem with the transaction, and the transaction shouldn’t go through.
-->
では、多重使用をどうやって防げばよいだろうか。分かりやすいやり方として、一郎が 1infocoin を送ってきた時、二郎はその取引を単独で確認しようとしない、というのがある。単独で確認する代わりに、取引の情報をネットワークに流し、ネットワークに接続中の infocoin 所有者たちに当該取引の有効性を確認してもらうといい。所有者の間で「この取引は有効」という合意が形成されたら、二郎は送られてきた infocoin を受け取り、みなが block chain を更新出来る。この手順を踏めば多重使用の防止に効果がある。というのも、一郎が同じ infocoin を二郎と三郎に送ろうと(多重使用)しても、ネットワーク上の infocoin 所有者たちは不正に気づくことができ、二郎や三郎に対しその旨通知することができるからだ。そうすれば、この不正取引の試みは失敗に終わる。

<!--
In more detail, let’s suppose Alice wants to give Bob an infocoin. As
before, she signs the message “I, Alice, am giving Bob one infocoin,
with serial number 1234567″, and gives the signed message to Bob. Also
as before, Bob does a sanity check, using his copy of the block chain to
check that, indeed, the coin currently belongs to Alice. But at that
point the protocol is modified. Bob doesn’t just go ahead and accept the
transaction. Instead, he broadcasts Alice’s message to the entire
network. Other members of the network check to see whether Alice owns
that infocoin. If so, they broadcast the message “Yes, Alice owns
infocoin 1234567, it can now be transferred to Bob.” Once enough people
have broadcast that message, everyone updates their block chain to show
that infocoin 1234567 now belongs to Bob, and the transaction is
complete.
-->
より具体的に説明しよう。まず、一郎が二郎に 1infocoin を譲渡したいとする。これまで同様、一郎は「私、一郎は二郎に、連番 1234567 の 1 infocoin を譲渡します」という文書にデジタル署名を付与し、二郎に送信する。次に二郎は、こちらもこれまで同様、自分の block chain を使って取引の正常性確認を行うのだが、多重使用防止策としてここで手順が変わる。正常性確認の代わりに、一郎からのメッセージをネットワーク全体に配信するのだ。そしてネットワーク参加者が、一郎が譲渡しようとしている infocoin が実際に本人のものなのかを確認する。確認がとれたら、ネットワーク参加者たちはそれぞれ「連番 1234567 の 1 infocoin は確かに一郎のものです。二郎に譲渡して問題ありません。」というメッセージを配信する。同メッセージの発信者が一定数集まったら、infocoin 所有者たちは block chain 上にある 連番 1234567 の infocoin の所有者を二郎に書き換える。これをもって、取引は完了する。

<!--
This protocol has many imprecise elements at present. For instance, what
does it mean to say “once enough people have broadcast that message”?
What exactly does “enough” mean here? It can’t mean everyone in the
network, since we don’t *a priori* know who is on the Infocoin network.
For the same reason, it can’t mean some fixed fraction of users in the
network. We won’t try to make these ideas precise right now. Instead, in
the next section I’ll point out a serious problem with the approach as
described. Fixing that problem will at the same time have the pleasant
side effect of making the ideas above much more precise.
-->
現時点では、このプロトコルはあまり厳密にできていない。例えば「同メッセージの発信者が一定数集まったら」というのは具体的にどういうことだろう。「一定数」？誰が Infocoin ネットワークに参加しているかを*前もって*把握できないので、一定数＝ネットワーク参加者全員、というわけにはいかない。また、同じ理由で、一定数＝予め決められた少数の参加者、というわけにもいかない。けれども、この問題についてはひとまず横においておく。というのも、次の章で述べる「上述手順の致命的な問題」を解決できれば、嬉しい副作用としてここに述べた厳密さの問題も解決できるからだ。

<!--
## Proof-of-work
-->
## プルーフオブワーク

<!--
Suppose Alice wants to double spend in the network-based protocol I just
described. She could do this by taking over the Infocoin network. Let’s
suppose she uses an automated system to set up a large number of
separate identities, let’s say a billion, on the Infocoin network. As
before, she tries to double spend the same infocoin with both Bob and
Charlie. But when Bob and Charlie ask the network to validate their
respective transactions, Alice’s sock puppet identities swamp the
network, announcing to Bob that they’ve validated his transaction, and
to Charlie that they’ve validated his transaction, possibly fooling one
or both into accepting the transaction.
-->
上述したようなプロトコルで、一郎が多重使用を試みるとしよう。Infocoin ネットワークを乗っ取ってしまえば、うまくいく可能性が出てくる。そのためには一郎はまず、アカウント作成ツールを用いて相当数、ここでは10億としよう、のアカウントをネットワーク上に作成しておく。そして、これまでと同様、二郎と三郎に対し同一 infocoin の多重使用を試みる。二郎と三郎は取引の確認をネットワークにリクエストするが、そのネットワークは一郎の自作自演アカウントで埋め尽くされており、二郎と三郎、双方の取引は有効であると返してしまう。うまくいけば一方、もしくは両方の偽取引が「有効」として受け入れられてしまうことになりかねない。

<!--
There’s a clever way of avoiding this problem, using an idea known as
*proof-of-work*. The idea is counterintuitive and involves a combination
of two ideas: (1) to (artificially) make it *computationally costly* for
network users to validate transactions; and (2) to *reward* them for
trying to help validate transactions. The reward is used so that people
on the network will try to help validate transactions, even though
that’s now been made a computationally costly process. The benefit of
making it costly to validate transactions is that validation can no
longer be influenced by the number of network identities someone
controls, but only by the total computational power they can bring to
bear on validation. As we’ll see, with some clever design we can make it
so a cheater would need enormous computational resources to cheat,
making it impractical.
-->
*プルーフオブワーク*という考え方に基づく優れた方法で、この問題は解決できる。その考え方というのは、1) ネットワーク参加者による取引確認が*多大な計算能力を要する*よう人為的に調整する、2)ネットワーク参加者による取引確認行為が成功した際は報酬を与える、という2つの考え方を組み合わせた、一見ピンと来ないものではある。この報酬は、膨大な計算能力を要する作業になってしまった「取引の確認行為」をネットワーク参加者が行いたくなるような、「アメ」の役割を果たす。取引確認行為を大変にすることのメリットは、ネットワーク上のアカウント数が取引確認行為の鍵を握らなくなる、ということである。そして、その代わりに鍵を握るのは、取引確認行為のために注ぎ込める計算能力の量になる。うまく設計すれば、詐欺行為を行うには膨大な計算能力が必要になり、実質上それを不可能にすることができる。

<!--
That’s the gist of proof-of-work. But to really understand
proof-of-work, we need to go through the details.
-->
プルーフオブワークの触りの部分は上述のとおりだ。とはいえ、実際にそれを理解するには、もっと深堀りする必要がある。

<!--
Suppose Alice broadcasts to the network the news that “I, Alice, am
giving Bob one infocoin, with serial number 1234567″.
-->
ここでまた、一郎がネットワークに対し「私、一郎は二郎に、連番 1234567 の 1 infocoin を譲渡します」という文書を発信するケースを考える。

<!--
As other people on the network hear that message, each adds it to a
queue of pending transactions that they’ve been told about, but which
haven’t yet been approved by the network. For instance, another network
user named David might have the following queue of pending transactions:
-->
その文書を受け取ると、ネットワーク参加者たちはそれぞれ、その文書を確認待ち取引のリストに追加する。ここで、デービッドというネットワーク参加者のリストには、以下の取引が載っているとしよう。

<!--
I, Tom, am giving Sue one infocoin, with serial number 1201174.
-->
「私、トムはスーに、連番 1201174 の 1 infocoin を譲渡します」

<!--
I, Sydney, am giving Cynthia one infocoin, with serial number 1295618.
-->
「私、シドニーはシンシアに、連番 1295618 の 1 infocoin を譲渡します」

<!--
I, Alice, am giving Bob one infocoin, with serial number 1234567.
-->
「私、一郎は二郎に、連番 1234567 の 1 infocoin を譲渡します」

<!--
David checks his copy of the block chain, and can see that each
transaction is valid. He would like to help out by broadcasting news of
that validity to the entire network.
-->
デービッドが自分の block chain を使って確認したところ、いずれの取引も有効であることが分かった。そこで、彼はそれらの取引が有効である旨をネットワーク参加者に発信し、確認作業に協力したいと考えた。

<!--
However, before doing that, as part of the validation protocol David is
required to solve a hard computational puzzle – the proof-of-work.
Without the solution to that puzzle, the rest of the network won’t
accept his validation of the transaction.
-->
けれど、そうする前に、デービッドは難解な計算問題、プルーフオブワーク、を確認手順の一環として解かなければならない。その問題への回答がなければ、彼の確認作業が有効と認められないのだ。

<!--
What puzzle does David need to solve? To explain that, let
![h](http://s.wordpress.com/latex.php?latex=h&bg=ffffff&fg=000000&s=0 "h")
be a fixed hash function known by everyone in the network – it’s built
into the protocol. Bitcoin uses the well-known
[SHA-256](https://en.wikipedia.org/wiki/SHA-2) hash function, but any
cryptographically secure hash function will do. Let’s give David’s queue
of pending transactions a label,
![l](http://s.wordpress.com/latex.php?latex=l&bg=ffffff&fg=000000&s=0 "l"),
just so it’s got a name we can refer to. Suppose David appends a number
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x")
(called the *nonce*) to
![l](http://s.wordpress.com/latex.php?latex=l&bg=ffffff&fg=000000&s=0 "l")
and hashes the combination. For example, if we use ![l =
](http://s.wordpress.com/latex.php?latex=l%20%3D%20&bg=ffffff&fg=000000&s=0 "l = ")
“Hello, world!” (obviously this is not a list of transactions, just a
string used for illustrative purposes) and the nonce ![x =
0](http://s.wordpress.com/latex.php?latex=x%20%3D%200&bg=ffffff&fg=000000&s=0 "x = 0")
[then](https://en.bitcoin.it/wiki/Proof_of_work) (output is in
hexadecimal)
-->
What puzzle does David need to solve? To explain that, let ![h](http://s.wordpress.com/latex.php?latex=h&bg=ffffff&fg=000000&s=0 "h") be a fixed hash function known by everyone in the network ? it’s built into the protocol. Bitcoin uses the well-known [SHA-256](https://en.wikipedia.org/wiki/SHA-2) hash function, but any cryptographically secure hash function will do. Let’s give David’s queue of pending transactions a label, ![l](http://s.wordpress.com/latex.php?latex=l&bg=ffffff&fg=000000&s=0 "l"), just so it’s got a name we can refer to. Suppose David appends a number ![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x") (called the *nonce*) to ![l](http://s.wordpress.com/latex.php?latex=l&bg=ffffff&fg=000000&s=0 "l") and hashes the combination. For example, if we use ![l = ](http://s.wordpress.com/latex.php?latex=l%20%3D%20&bg=ffffff&fg=000000&s=0 "l = ") “Hello, world!” (obviously this is not a list of transactions, just a string used for illustrative purposes) and the nonce ![x = 0](http://s.wordpress.com/latex.php?latex=x%20%3D%200&bg=ffffff&fg=000000&s=0 "x = 0") [then](https://en.bitcoin.it/wiki/Proof_of_work) (output is in hexadecimal) 

    h("Hello, world!0") = 
      1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64

The puzzle David has to solve – the proof-of-work – is to find a nonce
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x")
such that when we append
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x")
to
![l](http://s.wordpress.com/latex.php?latex=l&bg=ffffff&fg=000000&s=0 "l")
and hash the combination the output hash begins with a long run of
zeroes. The puzzle can be made more or less difficult by varying the
number of zeroes required to solve the puzzle. A relatively simple
proof-of-work puzzle might require just three or four zeroes at the
start of the hash, while a more difficult proof-of-work puzzle might
require a much longer run of zeros, say 15 consecutive zeroes. In either
case, the above attempt to find a suitable nonce, with ![x =
0](http://s.wordpress.com/latex.php?latex=x%20%3D%200&bg=ffffff&fg=000000&s=0 "x = 0"),
is a failure, since the output doesn’t begin with any zeroes at all.
Trying ![x =
1](http://s.wordpress.com/latex.php?latex=x%20%3D%201&bg=ffffff&fg=000000&s=0 "x = 1")
doesn’t work either:

    h("Hello, world!1") = 
      e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8

We can keep trying different values for the nonce, ![x = 2,
3,\\ldots](http://s.wordpress.com/latex.php?latex=x%20%3D%202%2C%203%2C%5Cldots&bg=ffffff&fg=000000&s=0 "x = 2, 3,\ldots").
Finally, at ![x =
4250](http://s.wordpress.com/latex.php?latex=x%20%3D%204250&bg=ffffff&fg=000000&s=0 "x = 4250")
we obtain:

    h("Hello, world!4250") = 
      0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9

This nonce gives us a string of four zeroes at the beginning of the
output of the hash. This will be enough to solve a simple proof-of-work
puzzle, but not enough to solve a more difficult proof-of-work puzzle.

What makes this puzzle hard to solve is the fact that the output from a
cryptographic hash function behaves like a random number: change the
input even a tiny bit and the output from the hash function changes
completely, in a way that’s hard to predict. So if we want the output
hash value to begin with 10 zeroes, say, then David will need, on
average, to try ![16\^{10} \\approx
10\^{12}](http://s.wordpress.com/latex.php?latex=16%5E%7B10%7D%20%5Capprox%2010%5E%7B12%7D&bg=ffffff&fg=000000&s=0 "16^{10} \approx 10^{12}")
different values for
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x")
before he finds a suitable nonce. That’s a pretty challenging task,
requiring lots of computational power.

Obviously, it’s possible to make this puzzle more or less difficult to
solve by requiring more or fewer zeroes in the output from the hash
function. In fact, the Bitcoin protocol gets quite a fine level of
control over the difficulty of the puzzle, by using a slight variation
on the proof-of-work puzzle described above. Instead of requiring
leading zeroes, the Bitcoin proof-of-work puzzle requires the hash of a
block’s header to be lower than or equal to a number known as the
[target](https://en.bitcoin.it/wiki/Target). This target is
automatically adjusted to ensure that a Bitcoin block takes, on average,
about ten minutes to validate.

(In practice there is a sizeable randomness in how long it takes to
validate a block – sometimes a new block is validated in just a minute
or two, other times it may take 20 minutes or even longer. It’s
straightforward to modify the Bitcoin protocol so that the time to
validation is much more sharply peaked around ten minutes. Instead of
solving a single puzzle, we can require that multiple puzzles be solved;
with some careful design it is possible to considerably reduce the
variance in the time to validate a block of transactions.)

Alright, let’s suppose David is lucky and finds a suitable nonce,
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x").
Celebration! (He’ll be rewarded for finding the nonce, as described
below). He broadcasts the block of transactions he’s approving to the
network, together with the value for
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x").
Other participants in the Infocoin network can verify that
![x](http://s.wordpress.com/latex.php?latex=x&bg=ffffff&fg=000000&s=0 "x")
is a valid solution to the proof-of-work puzzle. And they then update
their block chains to include the new block of transactions.

For the proof-of-work idea to have any chance of succeeding, network
users need an incentive to help validate transactions. Without such an
incentive, they have no reason to expend valuable computational power,
merely to help validate other people’s transactions. And if network
users are not willing to expend that power, then the whole system won’t
work. The solution to this problem is to reward people who help validate
transactions. In particular, suppose we reward whoever successfully
validates a block of transactions by crediting them with some infocoins.
Provided the infocoin reward is large enough that will give them an
incentive to participate in validation.

In the Bitcoin protocol, this validation process is called *mining*. For
each block of transactions validated, the successful miner receives a
bitcoin reward. Initially, this was set to be a 50 bitcoin reward. But
for every 210,000 validated blocks (roughly, once every four years) the
reward halves. This has happened just once, to date, and so the current
reward for mining a block is 25 bitcoins. This halving in the rate will
continue every four years until the year 2140 CE. At that point, the
reward for mining will drop below
![10\^{-8}](http://s.wordpress.com/latex.php?latex=10%5E%7B-8%7D&bg=ffffff&fg=000000&s=0 "10^{-8}")
bitcoins per block.
![10\^{-8}](http://s.wordpress.com/latex.php?latex=10%5E%7B-8%7D&bg=ffffff&fg=000000&s=0 "10^{-8}")
bitcoins is actually the minimal unit of Bitcoin, and is known as a
*satoshi*. So in 2140 CE the total supply of bitcoins will cease to
increase. However, that won’t eliminate the incentive to help validate
transactions. Bitcoin also makes it possible to set aside some currency
in a transaction as a *transaction fee*, which goes to the miner who
helps validate it. In the early days of Bitcoin transaction fees were
mostly set to zero, but as Bitcoin has gained in popularity, transaction
fees have gradually risen, and are now a substantial additional
incentive on top of the 25 bitcoin reward for mining a block.

You can think of proof-of-work as a competition to approve transactions.
Each entry in the competition costs a little bit of computing power. A
miner’s chance of winning the competition is (roughly, and with some
caveats) equal to the proportion of the total computing power that they
control. So, for instance, if a miner controls one percent of the
computing power being used to validate Bitcoin transactions, then they
have roughly a one percent chance of winning the competition. So
provided a lot of computing power is being brought to bear on the
competition, a dishonest miner is likely to have only a relatively small
chance to corrupt the validation process, unless they expend a huge
amount of computing resources.

Of course, while it’s encouraging that a dishonest party has only a
relatively small chance to corrupt the block chain, that’s not enough to
give us confidence in the currency. In particular, we haven’t yet
conclusively addressed the issue of double spending.

I’ll analyse double spending shortly. Before doing that, I want to fill
in an important detail in the description of Infocoin. We’d ideally like
the Infocoin network to agree upon the *order* in which transactions
have occurred. If we don’t have such an ordering then at any given
moment it may not be clear who owns which infocoins. To help do this
we’ll require that new blocks always include a pointer to the last block
validated in the chain, in addition to the list of transactions in the
block. (The pointer is actually just a hash of the previous block). So
typically the block chain is just a linear chain of blocks of
transactions, one after the other, with later blocks each containing a
pointer to the immediately prior block:

![](http://michaelnielsen.org/ddi/wp-content/uploads/2013/12/block_chain.png)

Occasionally, a fork will appear in the block chain. This can happen,
for instance, if by chance two miners happen to validate a block of
transactions near-simultaneously – both broadcast their newly-validated
block out to the network, and some people update their block chain one
way, and others update their block chain the other way:

![](http://michaelnielsen.org/ddi/wp-content/uploads/2013/12/block_chain_fork.png)

This causes exactly the problem we’re trying to avoid – it’s no longer
clear in what order transactions have occurred, and it may not be clear
who owns which infocoins. Fortunately, there’s a simple idea that can be
used to remove any forks. The rule is this: if a fork occurs, people on
the network keep track of both forks. But at any given time, miners only
work to extend whichever fork is longest in their copy of the block
chain.

Suppose, for example, that we have a fork in which some miners receive
block A first, and some miners receive block B first. Those miners who
receive block A first will continue mining along that fork, while the
others will mine along fork B. Let’s suppose that the miners working on
fork B are the next to successfully mine a block:

![](http://michaelnielsen.org/ddi/wp-content/uploads/2013/12/block_chain_extended.png)

After they receive news that this has happened, the miners working on
fork A will notice that fork B is now longer, and will switch to working
on that fork. Presto, in short order work on fork A will cease, and
everyone will be working on the same linear chain, and block A can be
ignored. Of course, any still-pending transactions in A will still be
pending in the queues of the miners working on fork B, and so all
transactions will eventually be validated.

Likewise, it may be that the miners working on fork A are the first to
extend their fork. In that case work on fork B will quickly cease, and
again we have a single linear chain.

No matter what the outcome, this process ensures that the block chain
has an agreed-upon time ordering of the blocks. In Bitcoin proper, a
transaction is not considered confirmed until: (1) it is part of a block
in the longest fork, and (2) at least 5 blocks follow it in the longest
fork. In this case we say that the transaction has “6 confirmations”.
This gives the network time to come to an agreed-upon the ordering of
the blocks. We’ll also use this strategy for Infocoin.

With the time-ordering now understood, let’s return to think about what
happens if a dishonest party tries to double spend. Suppose Alice tries
to double spend with Bob and Charlie. One possible approach is for her
to try to validate a block that includes both transactions. Assuming she
has one percent of the computing power, she will occasionally get lucky
and validate the block by solving the proof-of-work. Unfortunately for
Alice, the double spending will be immediately spotted by other people
in the Infocoin network and rejected, despite solving the proof-of-work
problem. So that’s not something we need to worry about.

A more serious problem occurs if she broadcasts two separate
transactions in which she spends the same infocoin with Bob and Charlie,
respectively. She might, for example, broadcast one transaction to a
subset of the miners, and the other transaction to another set of
miners, hoping to get both transactions validated in this way.
Fortunately, in this case, as we’ve seen, the network will eventually
confirm one of these transactions, but not both. So, for instance, Bob’s
transaction might ultimately be confirmed, in which case Bob can go
ahead confidently. Meanwhile, Charlie will see that his transaction has
not been confirmed, and so will decline Alice’s offer. So this isn’t a
problem either. In fact, knowing that this will be the case, there is
little reason for Alice to try this in the first place.

An important variant on double spending is if Alice = Bob, i.e., Alice
tries to spend a coin with Charlie which she is also “spending” with
herself (i.e., giving back to herself). This sounds like it ought to be
easy to detect and deal with, but, of course, it’s easy on a network to
set up multiple identities associated with the same person or
organization, so this possibility needs to be considered. In this case,
Alice’s strategy is to wait until Charlie accepts the infocoin, which
happens after the transaction has been confirmed 6 times in the longest
chain. She will then attempt to fork the chain before the transaction
with Charlie, adding a block which includes a transaction in which she
pays herself:

![](http://michaelnielsen.org/ddi/wp-content/uploads/2013/12/block_chain_cheating.png)

Unfortunately for Alice, it’s now very difficult for her to catch up
with the longer fork. Other miners won’t want to help her out, since
they’ll be working on the longer fork. And unless Alice is able to solve
the proof-of-work at least as fast as everyone else in the network
combined – roughly, that means controlling more than fifty percent of
the computing power – then she will just keep falling further and
further behind. Of course, she might get lucky. We can, for example,
imagine a scenario in which Alice controls one percent of the computing
power, but happens to get lucky and finds six extra blocks in a row,
before the rest of the network has found any extra blocks. In this case,
she might be able to get ahead, and get control of the block chain. But
this particular event will occur with probability ![1/100\^6 =
10\^{-12}](http://s.wordpress.com/latex.php?latex=1%2F100%5E6%20%3D%2010%5E%7B-12%7D&bg=ffffff&fg=000000&s=0 "1/100^6 = 10^{-12}").
A more general analysis along these lines shows that Alice’s probability
of ever catching up is infinitesimal, unless she is able to solve
proof-of-work puzzles at a rate approaching all other miners combined.

Of course, this is not a rigorous security analysis showing that Alice
cannot double spend. It’s merely an informal plausibility argument. The
[original paper](http://bitcoin.org/bitcoin.pdf) introducing Bitcoin did
not, in fact, contain a rigorous security analysis, only informal
arguments along the lines I’ve presented here. The security community is
still analysing Bitcoin, and trying to understand possible
vulnerabilities. You can see some of this research [listed
here](https://en.bitcoin.it/wiki/Research), and I mention a few related
problems in the “Problems for the author” below. At this point I think
it’s fair to say that the jury is still out on how secure Bitcoin is.

The proof-of-work and mining ideas give rise to many questions. How much
reward is enough to persuade people to mine? How does the change in
supply of infocoins affect the Infocoin economy? Will Infocoin mining
end up concentrated in the hands of a few, or many? If it’s just a few,
doesn’t that endanger the security of the system? Presumably transaction
fees will eventually equilibriate – won’t this introduce an unwanted
source of friction, and make small transactions less desirable? These
are all great questions, but beyond the scope of this post. I may come
back to the questions (in the context of Bitcoin) in a future post. For
now, we’ll stick to our focus on understanding how the Bitcoin protocol
works.

## Problems for the author

-   I don’t understand why double spending can’t be prevented in a
    simpler manner using [two-phase
    commit](http://en.wikipedia.org/wiki/Two-phase_commit_protocol).
    Suppose Alice tries to double spend an infocoin with both Bob and
    Charlie. The idea is that Bob and Charlie would each broadcast their
    respective messages to the Infocoin network, along with a request:
    “Should I accept this?” They’d then wait some period – perhaps ten
    minutes – to hear any naysayers who could prove that Alice was
    trying to double spend. If no such nays are heard (and provided
    there are no signs of attempts to disrupt the network), they’d then
    accept the transaction. This protocol needs to be hardened against
    network attacks, but it seems to me to be the core of a good
    alternate idea. How well does this work? What drawbacks and
    advantages does it have compared to the full Bitcoin protocol?
-   Early in the section I mentioned that there is a natural way of
    reducing the variance in time required to validate a block of
    transactions. If that variance is reduced too much, then it creates
    an interesting attack possibility. Suppose Alice tries to fork the
    chain in such a way that: (a) one fork starts with a block in which
    Alice pays herself, while the other fork starts with a block in
    which Alice pays Bob; (b) both blocks are announced nearly
    simultaneously, so roughly half the miners will attempt to mine each
    fork; (c) Alice uses her mining power to try to keep the forks of
    roughly equal length, mining whichever fork is shorter – this is
    ordinarily hard to pull off, but becomes significantly easier if the
    standard deviation of the time-to-validation is much shorter than
    the network latency; (d) after 5 blocks have been mined on both
    forks, Alice throws her mining power into making it more likely that
    Charles’s transaction is confirmed; and (e) after confirmation of
    Charles’s transaction, she then throws her computational power into
    the other fork, and attempts to regain the lead. This balancing
    strategy will have only a small chance of success. But while the
    probability is small, it will certainly be much larger than in the
    standard protocol, with high variance in the time to validate a
    block. Is there a way of avoiding this problem?
-   Suppose Bitcoin mining software always explored nonces starting with
    ![x =
    0](http://s.wordpress.com/latex.php?latex=x%20%3D%200&bg=ffffff&fg=000000&s=0 "x = 0"),
    then ![x = 1, x =
    2,\\ldots](http://s.wordpress.com/latex.php?latex=x%20%3D%201%2C%20x%20%3D%202%2C%5Cldots&bg=ffffff&fg=000000&s=0 "x = 1, x = 2,\ldots").
    If this is done by all (or even just a substantial fraction) of
    Bitcoin miners then it creates a vulnerability. Namely, it’s
    possible for someone to improve their odds of solving the
    proof-of-work merely by starting with some other (much larger)
    nonce. More generally, it may be possible for attackers to exploit
    any systematic patterns in the way miners explore the space of
    nonces. More generally still, in the analysis of this section I have
    implicitly assumed a kind of symmetry between different miners. In
    practice, there will be asymmetries and a thorough security analysis
    will need to account for those asymmetries.

## Bitcoin

Let’s move away from Infocoin, and describe the actual Bitcoin protocol.
There are a few new ideas here, but with one exception (discussed below)
they’re mostly obvious modifications to Infocoin.

To use Bitcoin in practice, you first install a
[wallet](http://bitcoin.org/en/choose-your-wallet) program on your
computer. To give you a sense of what that means, here’s a screenshot of
a wallet called [Multbit](https://multibit.org/). You can see the
Bitcoin balance on the left — 0.06555555 Bitcoins, or about 70 dollars
at the exchange rate on the day I took this screenshot — and on the
right two recent transactions, which deposited those 0.06555555
Bitcoins:

![](http://michaelnielsen.org/ddi/wp-content/uploads/2013/12/wallet_transaction.jpg)

Suppose you’re a merchant who has set up an online store, and you’ve
decided to allow people to pay using Bitcoin. What you do is tell your
wallet program to generate a *Bitcoin address*. In response, it will
generate a public / private key pair, and then hash the public key to
form your Bitcoin address:

![](http://michaelnielsen.org/ddi/wp-content/uploads/2013/12/bitcoin_address.jpg)

You then send your Bitcoin address to the person who wants to buy from
you. You could do this in email, or even put the address up publicly on
a webpage. This is safe, since the address is merely a hash of your
public key, which can safely be known by the world anyway. (I’ll return
later to the question of why the Bitcoin address is a hash, and not just
the public key.)

The person who is going to pay you then generates a *transaction*. Let’s
take a look at the data from an [actual
transaction](http://blockexplorer.com/tx/7c402505be883276b833d57168a048cfdf306a926484c0b58930f53d89d036f9)
transferring
![0.31900000](http://s.wordpress.com/latex.php?latex=0.31900000&bg=ffffff&fg=000000&s=0 "0.31900000")
bitcoins. What’s shown below is very nearly the raw data. It’s changed
in three ways: (1) the data has been deserialized; (2) line numbers have
been added, for ease of reference; and (3) I’ve abbreviated various
hashes and public keys, just putting in the first six hexadecimal digits
of each, when in reality they are much longer. Here’s the data:

    1.  {"hash":"7c4025...",
    2.  "ver":1,
    3.  "vin_sz":1,
    4.  "vout_sz":1,
    5.  "lock_time":0,
    6.  "size":224,
    7.  "in":[
    8.    {"prev_out":
    9.      {"hash":"2007ae...",
    10.      "n":0},
    11.    "scriptSig":"304502... 042b2d..."}],
    12. "out":[
    13.   {"value":"0.31900000",
    14.    "scriptPubKey":"OP_DUP OP_HASH160 a7db6f OP_EQUALVERIFY OP_CHECKSIG"}]}

Let’s go through this, line by line.

Line 1 contains the hash of the remainder of the transaction,
`7c4025...`, expressed in hexadecimal. This is used as an identifier for
the transaction.

Line 2 tells us that this is a transaction in version 1 of the Bitcoin
protocol.

Lines 3 and 4 tell us that the transaction has one input and one output,
respectively. I’ll talk below about transactions with more inputs and
outputs, and why that’s useful.

Line 5 contains the value for `lock_time`, which can be used to control
when a transaction is finalized. For most Bitcoin transactions being
carried out today the `lock_time` is set to 0, which means the
transaction is finalized immediately.

Line 6 tells us the size (in bytes) of the transaction. Note that it’s
not the monetary amount being transferred! That comes later.

Lines 7 through 11 define the input to the transaction. In particular,
lines 8 through 10 tell us that the input is to be taken from the output
from an earlier transaction, with the given `hash`, which is expressed
in hexadecimal as `2007ae...`. The `n=0` tells us it’s to be the first
output from that transaction; we’ll see soon how multiple outputs (and
inputs) from a transaction work, so don’t worry too much about this for
now. Line 11 contains the signature of the person sending the money,
`304502...`, followed by a space, and then the corresponding public key,
`04b2d...`. Again, these are both in hexadecimal.

One thing to note about the input is that there’s nothing explicitly
specifying how many bitcoins from the previous transaction should be
spent in this transaction. In fact, *all* the bitcoins from the `n=0`th
output of the previous transaction are spent. So, for example, if the
`n=0`th output of the earlier transaction was 2 bitcoins, then 2
bitcoins will be spent in this transaction. This seems like an
inconvenient restriction – like trying to buy bread with a 20 dollar
note, and not being able to break the note down. The solution, of
course, is to have a mechanism for providing change. This can be done
using transactions with multiple inputs and outputs, which we’ll discuss
in the next section.

Lines 12 through 14 define the output from the transaction. In
particular, line 13 tells us the value of the output, 0.319 bitcoins.
Line 14 is somewhat complicated. The main thing to note is that the
string `a7db6f...` is the Bitcoin address of the intended recipient of
the funds (written in hexadecimal). In fact, Line 14 is actually an
expression in Bitcoin’s scripting language. I’m not going to describe
that language in detail in this post, the important thing to take away
now is just that `a7db6f...` is the Bitcoin address.

You can now see, by the way, how Bitcoin addresses the question I swept
under the rug in the last section: where do Bitcoin serial numbers come
from? In fact, the role of the serial number is played by transaction
hashes. In the transaction above, for example, the recipient is
receiving 0.319 Bitcoins, which come out of the first output of an
earlier transaction with hash `2007ae...` (line 9). If you go and look
in the block chain for that transaction, you’d see that its output comes
from a still earlier transaction. And so on.

There are two clever things about using transaction hashes instead of
serial numbers. First, in Bitcoin there’s not really any separate,
persistent “coins” at all, just a long series of transactions in the
block chain. It’s a clever idea to realize that you don’t need
persistent coins, and can just get by with a ledger of transactions.
Second, by operating in this way we remove the need for any central
authority issuing serial numbers. Instead, the serial numbers can be
self-generated, merely by hashing the transaction.

In fact, it’s possible to keep following the chain of transactions
further back in history. Ultimately, this process must terminate. This
can happen in one of two ways. The first possibilitty is that you’ll
arrive at the very first Bitcoin transaction, contained in the so-called
[Genesis block](https://en.bitcoin.it/wiki/Genesis_block). This is a
special transaction, having no inputs, but a 50 Bitcoin output. In other
words, this transaction establishes an initial money supply. The Genesis
block is treated separately by Bitcoin clients, and I won’t get into the
details here, although it’s along similar lines to the transaction
above. You can see the deserialized raw data
[here](http://blockexplorer.com/rawblock/000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f),
and read about the Genesis block
[here](https://en.bitcoin.it/wiki/Genesis_block).

The second possibility when you follow a chain of transactions back in
time is that eventually you’ll arrive at a so-called *coinbase
transaction*. With the exception of the Genesis block, every block of
transactions in the block chain starts with a special coinbase
transaction. This is the transaction rewarding the miner who validated
that block of transactions. It uses a similar but not identical format
to the transaction above. I won’t go through the format in detail, but
if you want to see an example, see
[here](http://blockexplorer.com/rawtx/c3facb1e90fdbaf0ee59e342a00e1c82588af138784fabad7398eb9dab3a0e5a).
You can read a little more about coinbase transactions
[here](https://en.bitcoin.it/wiki/Protocol_specification#Transaction_Verification).

Something I haven’t been precise about above is what exactly is being
signed by the digital signature in line 11. The obvious thing to do is
for the payer to sign the whole transaction (apart from the transaction
hash, which, of course, must be generated later). Currently, this is
*not* what is done – some pieces of the transaction are omitted. This
makes some pieces of the transaction
[malleable](https://en.bitcoin.it/wiki/Transaction_Malleability), i.e.,
they can be changed later. However, this malleability does not include
the amounts being paid out, senders and recipients, which can’t be
changed later. I must admit I haven’t dug down into the details here. I
gather that this malleability is under discussion in the Bitcoin
developer community, and there are efforts afoot to reduce or eliminate
this malleability.

## Transactions with multiple inputs and outputs

In the last section I described how a transaction with a single input
and a single output works. In practice, it’s often extremely convenient
to create Bitcoin transactions with multiple inputs or multiple outputs.
I’ll talk below about why this can be useful. But first let’s take a
look at the data from an [actual
transaction](http://blockexplorer.com/tx/99383066a5140b35b93e8f84ef1d40fd720cc201d2aa51915b6c33616587b94f):

    1. {"hash":"993830...",
    2. "ver":1,
    3. "vin_sz":3,
    4.  "vout_sz":2,
    5.  "lock_time":0,
    6.  "size":552,
    7.  "in":[
    8.    {"prev_out":{
    9.      "hash":"3beabc...",
    10.        "n":0},
    11.     "scriptSig":"304402... 04c7d2..."},
    12.    {"prev_out":{
    13.        "hash":"fdae9b...",
    14.        "n":0},
    15.      "scriptSig":"304502... 026e15..."},
    16.    {"prev_out":{
    17.        "hash":"20c86b...",
    18.        "n":1},
    19.      "scriptSig":"304402... 038a52..."}],
    20.  "out":[
    21.    {"value":"0.01068000",
    22.      "scriptPubKey":"OP_DUP OP_HASH160 e8c306... OP_EQUALVERIFY OP_CHECKSIG"},
    23.    {"value":"4.00000000",
    24.      "scriptPubKey":"OP_DUP OP_HASH160 d644e3... OP_EQUALVERIFY OP_CHECKSIG"}]}

Let’s go through the data, line by line. It’s very similar to the
single-input-single-output transaction, so I’ll do this pretty quickly.

Line 1 contains the hash of the remainder of the transaction. This is
used as an identifier for the transaction.

Line 2 tells us that this is a transaction in version 1 of the Bitcoin
protocol.

Lines 3 and 4 tell us that the transaction has three inputs and two
outputs, respectively.

Line 5 contains the `lock_time`. As in the single-input-single-output
case this is set to 0, which means the transaction is finalized
immediately.

Line 6 tells us the size of the transaction in bytes.

Lines 7 through 19 define a list of the inputs to the transaction. Each
corresponds to an output from a previous Bitcoin transaction.

The first input is defined in lines 8 through 11.

In particular, lines 8 through 10 tell us that the input is to be taken
from the `n=0`th output from the transaction with `hash` `3beabc...`.
Line 11 contains the signature, followed by a space, and then the public
key of the person sending the bitcoins.

Lines 12 through 15 define the second input, with a similar format to
lines 8 through 11. And lines 16 through 19 define the third input.

Lines 20 through 24 define a list containing the two outputs from the
transaction.

The first output is defined in lines 21 and 22. Line 21 tells us the
value of the output, 0.01068000 bitcoins. As before, line 22 is an
expression in Bitcoin’s scripting language. The main thing to take away
here is that the string `e8c30622...` is the Bitcoin address of the
intended recipient of the funds.

The second output is defined lines 23 and 24, with a similar format to
the first output.

One apparent oddity in this description is that although each output has
a Bitcoin value associated to it, the inputs do not. Of course, the
values of the respective inputs can be found by consulting the
corresponding outputs in earlier transactions. In a standard Bitcoin
transaction, the sum of all the inputs in the transaction must be at
least as much as the sum of all the outputs. (The only exception to this
principle is the Genesis block, and in coinbase transactions, both of
which add to the overall Bitcoin supply.) If the inputs sum up to more
than the outputs, then the excess is used as a *transaction fee*. This
is paid to whichever miner successfully validates the block which the
current transaction is a part of.

That’s all there is to multiple-input-multiple-output transactions!
They’re a pretty simple variation on
single-input-single-output-transactions.

One nice application of multiple-input-multiple-output transactions is
the idea of *change*. Suppose, for example, that I want to send you 0.15
bitcoins. I can do so by spending money from a previous transaction in
which I received 0.2 bitcoins. Of course, I don’t want to send you the
entire 0.2 bitcoins. The solution is to send you 0.15 bitcoins, and to
send 0.05 bitcoins to a Bitcoin address which I own. Those 0.05 bitcoins
are the change. Of course, it differs a little from the change you might
receive in a store, since change in this case is what you pay yourself.
But the broad idea is similar.

## Conclusion

That completes a basic description of the main ideas behind Bitcoin. Of
course, I’ve omitted many details – this isn’t a formal specification.
But I have described the main ideas behind the most common use cases for
Bitcoin.

While the rules of Bitcoin are simple and easy to understand, that
doesn’t mean that it’s easy to understand all the consequences of the
rules. There is vastly more that could be said about Bitcoin, and I’ll
investigate some of these issues in future posts.

For now, though, I’ll wrap up by addressing a few loose ends.

**How anonymous is Bitcoin?** Many people claim that Bitcoin can be used
anonymously. This claim has led to the formation of marketplaces such as
[Silk Road](http://en.wikipedia.org/wiki/Silk_Road_(marketplace)) (and
various successors), which specialize in illegal goods. However, the
claim that Bitcoin is anonymous is a myth. The block chain is public,
meaning that it’s possible for anyone to see every Bitcoin transaction
ever. Although Bitcoin addresses aren’t immediately associated to
real-world identities, computer scientists have done a [great deal of
work](http://scholar.google.com/scholar?q=de-anonymization) figuring out
how to de-anonymize “anonymous” social networks. The block chain is a
marvellous target for these techniques. I will be extremely surprised if
the great majority of Bitcoin users are not identified with relatively
high confidence and ease in the near future. The confidence won’t be
high enough to achieve convictions, but will be high enough to identify
likely targets. Furthermore, identification will be retrospective,
meaning that someone who bought drugs on Silk Road in 2011 will still be
identifiable on the basis of the block chain in, say, 2020. These
de-anonymization techniques are well known to computer scientists, and,
one presumes, therefore to the NSA. I would not be at all surprised if
the NSA and other agencies have already de-anonymized many users. It is,
in fact, ironic that Bitcoin is often touted as anonymous. It’s not.
Bitcoin is, instead, perhaps the most open and transparent financial
instrument the world has ever seen.

**Can you get rich with Bitcoin?** Well, maybe. Tim O’Reilly [once
said](http://radar.oreilly.com/2006/05/my-commencement-speech-at-sims.html):
“Money is like gas in the car – you need to pay attention or you’ll end
up on the side of the road – but a well-lived life is not a tour of gas
stations!” Much of the interest in Bitcoin comes from people whose life
mission seems to be to find a *really big* gas station. I must admit I
find this perplexing. What is, I believe, much more interesting and
enjoyable is to think of Bitcoin and other cryptocurrencies as a way of
enabling new forms of collective behaviour. That’s intellectually
fascinating, offers marvellous creative possibilities, is socially
valuable, and may just also put some money in the bank. But if money in
the bank is your primary concern, then I believe that other strategies
are much more likely to succeed.

**Details I’ve omitted:** Although this post has described the main
ideas behind Bitcoin, there are many details I haven’t mentioned. One is
a nice space-saving trick used by the protocol, based on a data
structure known as a [Merkle
tree](http://en.wikipedia.org/wiki/Merkle_tree). It’s a detail, but a
splendid detail, and worth checking out if fun data structures are your
thing. You can get an overview in the [original Bitcoin
paper](http://bitcoin.org/bitcoin.pdf). Second, I’ve said little about
the [Bitcoin network](https://en.bitcoin.it/wiki/Network) – questions
like how the network deals with denial of service attacks, how nodes
[join and leave the
network](https://en.bitcoin.it/wiki/Satoshi_Client_Node_Discovery), and
so on. This is a fascinating topic, but it’s also something of a mess of
details, and so I’ve omitted it. You can read more about it at some of
the links above.

**Bitcoin scripting:** In this post I’ve explained Bitcoin as a form of
digital, online money. But this is only a small part of a much bigger
and more interesting story. As we’ve seen, every Bitcoin transaction is
associated to a script in the Bitcoin programming language. The scripts
we’ve seen in this post describe simple transactions like “Alice gave
Bob 10 bitcoins”. But the scripting language can also be used to express
far more complicated transactions. To put it another way, Bitcoin is
*programmable money*. In later posts I will explain the scripting
system, and how it is possible to use Bitcoin scripting as a platform to
experiment with all sorts of amazing financial instruments.

*Thanks for reading. Enjoy the essay? You can tip me with Bitcoin (!) at
address: 17ukkKt1bNLAqdJ1QQv8v9Askr6vy3MzTZ. You may also enjoy the
[first chapter](http://neuralnetworksanddeeplearning.com/chap1.html) of
my forthcoming book on neural networks and deep learning, and may wish
to [follow me on Twitter](https://twitter.com/michael_nielsen).*

## Footnote

<!--
[1] In the United States the question “Is money a form of speech?” is an
important legal question, because of the protection afforded speech
under the US Constitution. In my (legally uninformed) opinion digital
money may make this issue more complicated. As we’ll see, the Bitcoin
protocol is really a way of standing up before the rest of the world (or
at least the rest of the Bitcoin network) and avowing “I’m going to give
such-and-such a number of bitcoins to so-and-so a person” in a way
that’s extremely difficult to repudiate. At least naively, it looks more
like speech than exchanging copper coins, say.
-->

[^01]: アメリカだと、憲法が定める言論の自由との絡みで、「言論が通貨そのものになるの？」って疑問は法的に論議の的になりそう。BitCoin って、つまるところは「私は xxxx bitcoin を abc に譲渡します」という宣言をほぼ否定不可能なやり方で行う手段だからだ。細かい話をすれば、実物の貨幣のやりとりよりも言葉のやりとりに近いわけだし。
