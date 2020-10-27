*1章　scalar、演算子
*この章では、基礎的な概念であるscalarを学びます。
*基本的な四則演算をできるようになり、論理演算子の扱いがわかるようになるのが目標です。
*使用ファイルは特にありません。

*Stataで四則演算をしたいとき、次回以降扱う変数では不便です。これは、変数は列ベクトルであるからです。
*そこで、scalarを導入します。

*1. scalarの定義と四則演算、論理演算子

*1.1 scalarの定義と表示
 *[scalar スカラー名=数式or"文字列"]　で、scalarを定義することができる。
 *[display スカラー名]で、スカラーを表示する。
 *使い道はないが、一応文字列は""で囲う。
 scalar sc="hello world"
 display sc

*1.2 四則演算
 *計算したいときは、まずscalarを定義し、それを表示する形をとる。
 *四則は+-*/

 *① オーソドックスな足し算。
 scalar s1=3+2
 display s1

 *②（）の使い方や、足し算割り算は通常の表記と同じ。
 scalar s2=2*3/(5-1)
 display s2

 *③指数とルート(ルートはもちろん1/2乗でもOK)。
 scalar s3=sqrt(3^4)
 display s3

 *④既に定義したscalarは式中にも入れられる。ln()は自然対数。
 scalar s4=ln(10*28/7-s1)
 display s4

*1.3 関数の利用
 *関数も利用可能
 *⑤max, min
 scalar s5=max(s1,s2,s3,s4)
 scalar s6=min(s1,s2,s3,s4)
 display s5 s6

*1.4 floor, round ceil
 *⑥floor(N)はNを越えない最大の整数。ceil(N)はNを越える最小の整数。round(N)は四捨五入した結果の整数
 scalar s7=floor(3.3)
 scalar s8=ceil(3.3)
 display s7,s8

*1.5 論理演算子
 *いずれ使うので覚えましょう。=は代入という意味でのイコール、==が一般的なイコールの意味なのに注意。!=は≠
 *<, >, <=, >=, ==, !=
 *&はand、|はor
