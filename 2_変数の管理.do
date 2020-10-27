*2章　変数の管理
*この章では、Stataで最も頻繁に使う、変数の基本的な管理の仕方を学びます。
*変数の作成や整理ができるようになるのが目標です。
*使用ファイルとして、example.dtaを用います。これは、一応生徒何人かのテストの点数や身長などをまとめたものですが、
*内容に意味はありません。

*Stataでは、列ベクトルである変数を利用して統計分析を行うのが基本です。

*2. 変数の基本的管理

*2.1 既にある変数の消去
 *頻出のdrop,keep
 *[drop 変数名] は変数自体を落とす。[drop_all]で全変数、[drop val*]で、valから始まる全変数を
 *落とす。
 drop error
 
 *[drop if 条件]は条件に合ったサンプルを落とす。keepは逆に残す。
 drop if height>=200
 
*2.2 変数の並び替え
 *sortは並び替えを行う。複数の場合は、まずsex、次にheightで並び替え。
 sort sex height
 
*2.3　変数の作成 
 *2.3.1　変数の作成①gen
 
  *①全てのサンプルで２をとるvalという変数を作る。
  gen val=2
 
  *②sexがmaleとなるときだけ１をとる変数を作る。
  gen male=1 if sex=="male"

  *③heightが175以上のとき１をとる変数を作る。
  gen high=1 if height>=175

  *④国語と算数の合計値をとる変数を作る。
  gen stotal=lang+math
 
  *⑤身長の2乗項となる変数を作る。
  gen height2=height^2
 
 *2.3.2 変数の作成②egen
  *変数の作成に関数を使う場合は基本的にegenを使う。
 
  *①国語の平均点を、全サンプルに入れる変数を作る。
  egen ave=mean(lang)
 
 *2.3．3　特殊な例（sum関数）
  *①[egen 新変数名=sum(変数名)]で、変数の合計値を全サンプルに入れる変数を作る。 ,by(変数名)
  *はオプションで、変数ごとの合計値にできる（今回だと性別ごとの合計点）。
  egen sum1=sum(math), by(sex)

  *②[gen 新変数名=sum(変数名)]だと上から順に足していった値が入る。（byオプションは使えない）
  gen sum2=sum(math)
  
  *補足：sumやmeanはscalarの中では使えない。例えばmeanをscalar値として利用したい場合、
  *[gen 新変数名=mean(変数)　scalar スカラー名=変数名[1]]のようにする。(後で別の方法も示す)
  scalar avescalar=ave[1]
  display avescalar


*2.4 string形式の解消（group関数）、ダミー変数の作成
 *2.4.1 group関数
  *group関数は、変数内で同じ観測値ごとに数字を割り当てる。IDを振るようなもの。
  *使用データだと、studentがstring(文字列)形式で使いづらいので、group関数を使う。
  egen StudentID=group(student)
 
 *2.4.2 ダミー変数の作成（tab+gen）
  *tabは次回詳述するが、[tab 変数, gen(新変数名)]でダミー変数を一気に作成することができる。カテゴリーの
  *数（今回のデータのsexだとmaleとfemaleの２つ）分、その値をとるときに１、その他の場合は０をとる変数が作成される。
  *手動で条件分を使って作るより楽。
  tab sex, gen(sex)
 
*2.5 名前や観測値の変更 
 *2.5.1 観測値の変更（recode）
  *[recode 変数名　（〇＝△）（△＝□）]　で、観測値の〇を△に、△を□に変更できる。
  *Stataでは、欠損値は.で表すことに注意。
  recode male(1=2)(.=1)
 
 *2.5.2 変数名の変更（rename）
  *[rename 変数名　新変数名]　で、変数名を変えられる。
  rename student seito

*2.6 変数のラベリング
 *2.6.1 ラベリングの確認（describe）
  *[describe]で変数のラベリングの状況を確認する。(次回の範囲)
  describe
 
 *2.6.2 変数に新しくラベルを付ける。(label var)
  *[label var 変数名　"ラベル内容"]で、変数にラベルを付けられる。一般に変数の定義を書くことが多い。
  label var math "scores of the math test"

 *2.6.3 変数に新しく値ラベルを付け、変数に付与する。（label define, label val）
  *[label define 値ラベル名　値１　観測値１　値２　観測値２…]で、観測値１に値１を、観測値２に値２を
  *付与する値ラベルを定義できる。
  *例えば、０、１からなるカテゴリ変数があるとき、０に"yes",１に"no"を付与できる。
  *これを[label val 変数名　値ラベル名]で、変数に貼り付ける。このとき変数はcategory変数でないといけない。 
  egen sex3=group(sex)
  label define sexlabel 2 "maleeeee" 1 "female"
  label val sex3 sexlabel  
 
  *1行目…string形式の変数には値ラベルが付与できないので、まずgroup関数でcategory変数にしている。
  *2行目…２に"male"、１に"female"を対応させる、sexlabelというvalue labelを作る。
  *3行目…sex2という変数に、上で作ったsexlabelを対応させる。
  *ポイントは、value labelが変数とは独立にあって、それを変数にくっつけるイメージだということ。
  
 *2.6.4 ラベルを更新する、ラベルを消す
  *既に値ラベルが付いていて、それを変えたいときは、modify、付け加えるときはaddを使う。
  label define sexlabel 2 "male", modify
 
  *ラベルを落とすにはlabel dropを用いる。
  label drop sexlabel
