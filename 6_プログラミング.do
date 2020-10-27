*6章　プログラミング　
*この章では、簡単なプログラミング方法を学びます。
*こうした方法によって処理を簡略化できることを理解することが目標です。
*使用ファイルとして、example.dtaを用います。

*6. プログラミング

*6.1 プログラミングの基本
 *Stataでは、プログラミングに近いコードを利用することで、処理を大幅に簡略化できる。
 *その方法はprogramやforeachなどいくつかあるが、基本的に同じものを何度も入れるといった繰り返し処理はプログラ
 *ミングを用いて簡略化できる可能性が高い。

*6.2　programコマンド 
 *programを用いると、同じ処理を複数回したい場合などに、その処理の一部を変数にして、値を簡単に代入できる。
 *下は、数学の点数を被説明変数、身長を説明変数にして回帰したもの。身長ごとに条件付けしているので、program
 *を組んで大幅に簡略化した。
 capture program drop program1
 program program1
 quietly reg `1' height if height>=`2'
 est store k`2'
 end

 program1 math 175
 program1 math 170
 program1 math 165
 program1 math 160
 program1 math 155
 program1 math 150
 
 est table k*

 *1行目…[capture program drop program名]で、同名のプログラムを落とす。これはそのまま覚えてください。
 *2~5行目…[program program名~（処理）~end]で、プログラムを作成。処理内で、`1',`2'などの形で、変数
 *や文字を置き換える。
 *7~12行目…[program名　代入する値　代入する値　…]で、programの`1'`2'...の部分に順に値が入って実行
 *される。この場合には、{`1'にmath、`2'に175}、{`1’にmath、`2'に170}…と入っていく。
 *14行目…kから始まる推定結果を一括表示。今回はk150~k175が一気に表示されるはず。
 
*6.3 foreachコマンド 
 *foreachを用いると、1変数の場合programより簡単に値を代入できる。
 *基本形は、[foreach i in 入れる値… {処理}]。
 *代入するところにとる引数は`i'。下の例は、１から７まで足すプログラム。
 scalar sum=0
 foreach i in 1 2 3 4 5 6 7{
 scalar sum=sum+`i'
 }
 display sum

 *下のようにすれば、１から100までなどと指定することもできる。例は、1から100まで足すプログラム。
 scalar sum=0
 foreach i of num 1/100{
 scalar sum=sum+`i'
 }
 display sum

*6.4 whileコマンド
 *あまり使わないが、while構文なども存在する。
 *[while 条件 {処理}]が基本形。条件が満たされる間処理を繰り返す。
 *下の例では、8*1*2*3*4*5*6*7*8*9*を計算している。
 scalar aa=1
 scalar bb=8

 while aa<10{
 scalar bb=bb*aa
 scalar aa=aa+1
 }
 display bb
