*3章　変数の基本統計情報を見る
*この章では、変数の基本的な統計情報を見る方法を学びます。これは、回帰分析などを行う前によく行います。
*変数の統計情報を自由に見られるようになるのが目標です。
*使用ファイルとして、example.dtaを用います。

*3. 変数の統計情報

*3.1変数のStata上の格納情報を見る(des)
 *describe(des)で各変数の格納形式やラベリング状態、書式などがわかる。
 des

*3.2 変数の平均や標準偏差を見る(sum)
 *3.2.1 基本統計量の参照(sum)
  *[sum(変数名)]でサンプル数、平均、標準偏差などの基本統計量がわかる。
  sum(math)
 
 *3.2.2 基本統計量のscalarとしての利用
  *sumの後、return listで、求めた値をスカラー値で保存する方法がわかる。下の例は、観測数、平均、合計。
  return list
  scalar e1=r(N)
  scalar e2=r(mean)
  scalar e3=r(sum)
  display e1 e2 e3

*3.3 変数の観測値の密度や度数表を見る。（tab）
 *[tab 変数名]で観測値ごとの密度がわかる。
 tab height
 
 *[tab 変数名　変数名]で、2変数の間の度数表がわかる。
 tab sex breakfast

*3.4 １つの変数のヒストグラムを見る。（hist）
 *[hist　変数名]で、ヒストグラム表示が可能。binの長さなどのオプションもあるのでhistのhelp参照。
 hist height, wid(15)

*3.5 ２変数の分布図を書く。（scatter）
 *[scatter 変数名　変数名]で、分布図が表示できる。
 scatter lang math

*3.6 複数の変数の間の相関係数を表示する。（corr）
 *[corr(変数名　変数名　変数名…)]で、各変数間の相関係数が表示される。（pwcorrでも同様）
 corr(lang math height)

*3.7 条件を満たす数を数える。（count）
 *数を数えるcount関数。[by 変数名: count if 条件]　で、条件を満たすサンプルの数を返す。
 *byは、ある変数の観測値ごとにというオプションなのでなくてもいい。byを使う場合、by以下の変数でのsortが必要。 
 sort sex
 by sex: count if math>=80
