*7章　時系列分析、パネルデータ分析
*この章では、時系列分析、パネルデータ分析の初歩を導入します。
*時系列、パネルを扱うときにまず何をするべきかを理解するのが目標です。
*使用ファイルとして、時系列ではexample2.dta、パネルではexample3.dtaを用います。

*7. 時系列、パネル

*7.1時系列データの分析
 *7.1.1 date関数
  *まずはStataのtime-variableの格納形式を知るためにdate関数を導入する。
  *date関数は、日次や月次データで、time-variableがstring形式の場合に用いる。
  *文字形式の日付などをStataが扱える形に変換する。
  gen date=date(datestring, "YMD")
 
  *[gen 新変数名=date(変数名, "YMD")]のような形が基本形。"YMD"のところは、年月日の順ならこう書く。
  *日月年なら"DMY"
  *Stataでは、日時データは1960年の何日かを基準にして、そこからの総日数で表す。
  *一般に論文では年次データを使うことが多いので、見る機会は多くはない。
 
 *7.1.2 time-variableの設定（tset）
  *時系列データ分析はtime-variableの設定を行うところから始まる。コマンドはtset。
  *このときtime-variableがStataの時間形式になっていることが必要。それを行うのが上のdate関数。西暦の
  *場合、特にdate関数など使わなくても普通にできる。
  *time-variableに被りがあるとエラーになるので注意。
  tset date
  
 *7.1.3 時系列データの視覚化（tsline）  
  *時系列データでは、まずデータを視覚化するtslineをよく用いる。
  tsline(quant aveprice)
  twoway(tsline quant, yaxis(1))(tsline aveprice, yaxis(2))

  *下のコードは、ｙ軸を2変数で変えるためのものだが、非常に有用。
 
 *7.1.4 時系列分析のキーとなる単位根検定（dfuller）
  *時系列分析でまず行うのは単位根検定。
  *単位根検定は拡張DF検定を[dfuller 変数名]で行うことができる。p-valueが0.05以下なら有意水準5%で
  *単位根は存在しないということになる。trendなどのオプションはhelp dfuller参照・
  dfuller quant

  *より発展的な時系列分析のやり方は自分で学んでください。

*7.2 パネルデータの導入
 *7.2.1 パネルのxとtの設定(xtset)
  *パネルデータの導入は、まずxtsetから行う。[xtset x側の変数　t側の変数]が基本。
  *（１行目は、x側がstring形式だと使えないので直しているだけ）
  egen itemID=group(itemname)
  xtset itemID date

 *7.2.2 パネルデータ分析（POLS,FE,RE）
  *パネルデータ分析には、POLS、FE、REがある。
  reg quant aveprice
  xtreg quant aveprice
  xtreg quant aveprice, fe
  xtreg quant aveprice i.date, fe
  
  *一つ目がPOLS、2つ目がRE、3つ目・4つ目がFEの書き方。4つ目は、i.dateによって時間ダミーをすべて入れた形。
  *どれがいいかの判別とかは自分で学んでください笑。

*7.3 パネルデータや時系列データで利用可能なシステム変数
 *Stataにはいくつか有用なシステム変数（システム変数を変数の前後につければ自動的に変換された変数となる）がある。
  
 *①ある観測値の上からの位置（ID）を表す[_n]
 display height[2]
 *heightの上から2番目の観測値を表示できる。
  
 gen height2=height[_n-1]
 *heightに対して、すべて一つ上の観測値をとるheight2を作成。これは、観測値の被りを消したい場合などに利用で
 *きる。これはクロスセクションでも利用可能。
  
 *②ある変数の一期前の値を表すl.変数(lagオペレータ)
 *[l.変数名]で、1期前の値、
 *[l5.変数名]で、5期前の値を表示する。
  
 *③ある変数の一期先の値を表すf.変数(leadオペレータ)
 *[f.変数名]で、1期先の値、
 *[f5.変数名]で、5期先の値を表示する。
  
 *④差分を表す差分演算子d.変数(差分オペレータ)
 *[d.変数名]で、{変数[_n]-変数[_n-1]}を表示。
