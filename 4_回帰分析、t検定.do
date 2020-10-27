*4章　回帰分析とt検定
*この章では、最も基本的な統計分析である回帰分析とt検定を行う方法を学びます。
*回帰分析をできるようになるのが目標です。
*使用ファイルとして、example.dtaを用います。

*4. 回帰分析、t検定

*4.1 回帰分析
 *4.1.1 回帰分析の基本(reg)
  *回帰分析の基本は、[reg 被説明変数　説明変数　説明変数…]
  *下の例は国語の点数を被説明変数、数学の点数と身長を説明変数にしての重回帰分析。
  reg lang math height
  
 *4.1.2 回帰結果の利用①推定値の保存、表示
  *[est store 推定結果名]　で、推定結果を保存できる。
  *[est table 推定結果名(複数も可)]で、推定された係数を表にする。
  *推定結果名カンマ以降で、載せる推定結果を選べる。（b＝係数、t＝ｔ値、p＝p値など、est tableのhelp参照）
  *他にも有効数字の桁数を変えたり、決定係数を加えたりなどが可能。(stats以下はregのhelp参照)
  *今回は係数、t値、p値、観測数、修正済み決定係数を表示。
  reg lang math height
  est store e1
  est table e1
  est table e1, b(%7.4f) t(%7.4f) p(%7.4f) stats(N, r2_a)

 *4.1.3 回帰結果の利用②推定値のスカラー利用
  *regの後システム変数を用いれば、推定値をスカラーとして利用できる。
  *_b[_cons]で、定数項、_b[説明変数名]で、その説明変数の推定された係数をスカラーとして利用可能。
  reg lang math height
  gen fittedvalue=_b[_cons]+_b[math]*math+_b[height]*height
  
  *上の例では、（定数項＋係数×説明変数＋係数×説明変数）を計算して手動でfitted　valueを作成している。
  
 *4.1.4 回帰結果の利用③fitted value
  *regの後[predict 新変数名]　で、fitted valueを作成できる。[predict 新変数名,residual]なら
  *残差を保存。
  reg lang math height
  predict bhat
  
  *一個上で手動で作ったfittedvalueと一致するか確認しよう。  
  
 *4.1.5 回帰分析で用いるオプション
  *quietlyは結果の省略、[,robust]は頑健標準誤差、ifは条件の付与。
  quietly reg lang math
  reg lang math, robust
  reg lang math if height>=160

 *4.1.6 交差項やカテゴリカル変数の利用
  *i.変数を使えば、カテゴリカル変数を簡単に（カテゴリー数ー１）個入れられる。（値ごとにダミー変数を入れなくてもいい）
  reg lang i.breakfast
  
  *#を用いると簡単に交差項を作れる。[reg 被説明変数　ダミー変数#（or##）ダミー変数]で、各ダミーとその交互
  *作用が一気に入る。#と##で少し違うが、##の方が便利と思う。
  reg lang male##i.breakfast

*4.2 t検定
 *[ttest 変数名＝変数名]で、2変数に統計的に有意な差があるかのt検定ができる。
 ttest math=lang

*4.3 F検定
 *[reg height lang math] のあとに[test lang math]とすることでlangとmathの係数が両方０という
 *帰無仮説を検証するF検定ができる。(通常regの結果表の中に含まれる。)
 reg height lang math 
 test lang math
