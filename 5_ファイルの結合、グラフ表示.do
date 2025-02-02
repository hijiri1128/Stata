*5章　ファイルの結合、グラフ表示
*この章では、ファイル結合の方法と、分析結果のグラフ表示の方法を学びます。
*ファイル結合とグラフ表示の一番基本となるコマンドを覚えるのが目標です。
*ファイル結合のところは使用ファイルはありません。グラフ表示のところではexample.dtaを用います。

*5. ファイルの結合、グラフ表示

*5.1 ファイルの結合
 *5.1.1 ファイル結合のファイル結合の前提
  *Stataを使っていると、１つの統計分析を行うために２つのファイルを結合したいということが頻繁にある。
  *２つのファイルを結合するコマンドはmergeとappend。基本的なクロスセクションではmergeを使うが、パネルデータでは
  *形式によってはappendを用いる。
  *基本的に２つのファイルで同じ名前のキー変数を指定して、それを基に結合する。
 
 *5.1.2 ファイル結合の基本形（merge）
  *[merge 1:1 キー変数 using "ファイル名"]が基本形。
  *1:1のところ、1:m, m:1, m:mにもなる。ここの：は、master側:using側を表す。これは、キー変数に指定された
  *変数について、観測値にかぶりがある方をm(many)で表す。
  *例えば、master側（現在開いている方）ではstudentというキー変数について、2回以上登場する生徒が存在し、
  *using側（結合する方）では全ての生徒が１度だけ登場するとする。その場合は、m:1を用いるということになる。
  *m:mを用いるのが一番無難ではある。詳しくはhelp merge参照。
 
 *5.1.3 結合状況の確認
  *mergeを行うと、_mergeという変数が自動生成される。これは、キー変数のある観測値が、_merge==1のときは
  *masterファイルのみ、_merge==2のときはusingファイルのみに存在し、_merge==3のときはいずれにも存在す
  *るということである。



*5.2 グラフ表示
 *5.2.1 ２変数のグラフ作成（twoway）
  *2変数のグラフを書きたいときは、以前少し紹介したscatterなどでもいいが、twowayのコードが非常に有用。
  *twowayを使えば複数のグラフを同一平面上に表示できる。
  *下では、分布図と、fitted valueを表示している。他のグラフ形式についてはhelp twoway参照。
  twoway(scatter lang math)(lfit lang math)
 
 *5.2.2 グラフ作成のオプション
 *条件を指定したり、大きさや色を変えたりなど色々できる。詳しくはhelp twoway参照。
  twoway(scatter lang math, mc(red) ms(huge))(lfit lang math if height>160)

*5.3 求めた結果の外部への出力(outreg2)
 *outreg2コマンドを使えば、回帰結果などをワードファイルにして出力できる。
 *ここではコードは載せないので、詳しくはhelp outreg2。
 *keepコマンドで説明変数の内載せたいもののみを選んだりもできるので、論文を書くときには使う。
