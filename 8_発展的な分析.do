*8章　発展的な分析
*この章では、発展的な分析を学びます。
*実際に分析を行うときに何でhelpすればいいかをわかるようになるのが目標です。
*使用ファイルはありません。また、今回のみはdofileを回してもエラーとなります。

*8. 発展的な分析

*8.1　操作変数法（ivreg)
 *内生変数と操作変数を＝で繋ぐという点だけ覚えておけば、後はその外にコントロール変数などを書くだけ。
 ivreg 2sls 被説明変数 外生説明変数…　（内生変数 = 操作変数　コントロール変数…)
　
 *例えば、双子ダミーをIVに使って、子供の数の増加が子供の教育年数に与える影響を見る場合、
 ivreg 2sls schoolyear parentincome race.. (familysize=twindummy birthage..)
 
 *などとなる。familysizeがschoolyearの内生変数なので、schoolyearの外生変数であるtwindummy
 *で置き換えているというイメージ。
 *2slsのところは、推定方法の指定になる。他にもliml(最尤法)などがあるが、基本2slsと書いておけば間違いない
 *と思われる。

*8.2 probitモデル(probit)
 *probitモデルは、regをprobに変えるだけ。
 *ただし、probitやlogitでは、出てきた係数≠限界効果。そのため、marginsコマンドを用いて限界効果を出す必要
 *がある。その方法は2通りあるが、詳しくはprobitやlogitをやる際に自分で学んでください。
 
 prob 被説明変数　説明変数…
 margins, dydx(*) atmeans
 margins, dydx(*)

*8.3 logitモデル(logit)
 *logitモデルはprobitモデルとほぼ同じ。
 logit 被説明変数　説明変数…
 margins, dydx(*) atmeans
 margins, dydx(*)
 
*8.4 tobitモデル(tobit)
 *tobitは、普通の回帰にカットオフラインを追加するという形をとる。
 *regに、lower-limit(ll)かupper-limit(ul)のカットオフのラインを指定するオプションを付け、ll(0)の
 *ような形で、実際に数字を指定するというイメージ。
 tobit 被説明変数　説明変数…, ll(数字)
 
*8.5　heckmanの2段階推定(heckman)
 *heckmanは、1段階目のダミー変数の推定に用いる説明変数をselectの中に入れて、twostepをつけるだけ。
 *heckmanはいくつかタイプがあるが、それはheckmanのところで学んでください。
 heckman 被説明変数　説明変数… ,select(1段階目の説明変数…) twostep
