# perfumedance\_p5 README
## はじめに

これは [Perfume Global Site](http://www.perfume-global.com/)で配布されているダンスモーションを [Processing](http://processing.org/) で可視化する[サンプルプログラム](https://github.com/perfume-dev/example-processing)に、改造しやすくなるよう手を加えたものです。

### オリジナルとの差分

- ポリゴンが裏返っているのを解消
- [Minim](http://code.compartmental.net/tools/minim/) を標準で組込
- 公式配布データ用にあらかじめ設定変更
- その他見た目の細かい調整

## 使い方

まずは本プログラムをダウンロードして、Processing で実行できるようにしましょう。以下の ZIP ファイルをまずはダウンロードしてください。

- [https://github.com/fukuchi/perfumedance\_p5/archive/master.zip](https://github.com/fukuchi/perfumedance_p5/archive/master.zip)

この ZIP ファイルを展開すると perfumedance\_p5 というフォルダが作られますので、それをお使いの Processing 用のスケッチブック保存フォルダの中に置いてください。

次にダンスモーションのデータと楽曲データを下記サイトからダウンロードしましょう。

- [Perfume Global Site](http://www.perfume-global.com/)

2013年9月現在、上記サイトにアクセスすると二つのリンクがありますが、"Perfume Global Site" と書かれた左側のリンクを辿ってください。その後表示されるページの左上隅にナビゲーションエリアがあり、マウスカーソルを近付けると下図のような画面になりますので、「Download」を選択しクリックしてください。

![](perfume_global_site.png)

続くページの「Vol.01 Motion Capture Data」の欄に、ダウンロード用リンクが表示されています。"Terms of use" というリンクに、データの使用上の注意が書かれていますので、よく読んで納得したら "You agree to our terms" にチェックを入れ、"BVH" および "SOUND" のリンクをクリックすると、それぞれの ZIP ファイルがダウンロードされます。

次に、ダウンロードしたファイルを展開します。まずダンスモーションデータが格納されている bvhfiles.zip を展開し、その中に含まれている下記のみっつのファイルを、perfumedance\_p5/data の中に置きます。

- aachan.bvh
- kashiyuka.bvh
- nocchi.bvh

また、Perfume\_globalsite\_sound.wav.zip を展開し、その中に含まれている Perfume\_globalsite\_sound.wav もやはり perfumedance\_p5/data の中に置きます。

以上のファイルが用意できたら、まずは実行してみて、Perfume の三人が音楽にあわせて踊っているグラフィクスが見られるかどうかを確認してみてください。下のような映像が表示されれば成功です。もしうまく行かない場合は、上述した各種ファイルの置き場所が間違っている可能性があります。

<iframe width="420" height="315" src="//www.youtube.com/embed/3OktmR75A4s" frameborder="0" allowfullscreen><img src="screenshot.jpg" alt=""/></iframe>

## 改造のポイント

プログラムのあちこちをいじってみることで、感覚的にプログラムの仕組みや 3D CG の動かし方を学んでいくとよいでしょう。以下に、とっかかりの改造ポイントを記しますので参考にしてください。

### 大きさを変える

頭や身体のパーツの大きさを変えてみましょう。身体を描く部分は PBvh.pde の中に記述されています。Processing のエディタ上で PBvh.pde のタブを開き、下記の箇所を探してみましょう。

```java
        translate( b.absEndPos.x, b.absEndPos.y, b.absEndPos.z);
        sphere(20);
```

ここは頭や手足の先の部分を描写している部分です。この [`sphere(20)`](http://processing.org/reference/sphere_.html) は、半径20の球を表示する関数です。この`20`の部分の数値を大きくしたり小さくしてみて、何が起きるか見てみましょう。ちょっと変えたくらいではわかりませんので、極端に大きくしたり小さくしてみたり、何度も試してみてください。

また、腕や脚の部分を描いているのは以下の部分です。

```java
      translate(b.absPos.x, b.absPos.y, b.absPos.z);
      ellipse(0, 0, 5, 5);
```

ここでも、[`ellipse`](http://processing.org/reference/ellipse_.html) の後ろにある数値を色々と変えてみましょう。それぞれの数値がどんな意味を持っているのか、描かれたグラフィクスから推測してみてください。

### 形を変える

次は形を変えてみましょう。さっきの `sphere` の部分を [`box`](http://processing.org/reference/box_.html) に変えてみると…

`ellipse` の方も変えてみましょう。三角形を描くなら、[`triangle`](http://processing.org/reference/triangle_.html) を使います。

```java
      triangle(0, 5, -5, -5, 5, -5);
```

と書いてみましょう。他にも色々な図形を試してみてください。

また、`translate()` に与えられた引数は、その図形を描く座標を指定しています。順に X 座標・Y 座標・Z 座標の値が与えられているのは、コードを見ればなんとなくわかりますね。では、それらの値を倍にするように書き換えてみたり、適当な値を足してみたりして、何が起きるか試してみてください。

### 音に反応させる

本プログラムでは、FFT を使った音の周波数解析のための基本的なコードが組込まれています。試しにそれを使ってみましょう。

`soundLevel` というグローバル変数が定義されており、これは `draw()` の瞬間にどれくらいの音圧がかかっていたかを示すようになっています。この曲の場合、最高でだいたい 3000 くらいの値になります。この値を使って球の大きさを変えてみましょう。PBvh.pde の中の該当箇所を

```java
        sphere(soundLevel / 100);
```

としてみてください。音に合わせて球の大きさが変化しますね。

周波数解析の結果を上手に使うと、例えば音域の低い音や高い音にそれぞれ反応するようなアニメーションを作ることができます。コード中の、

```java
  soundLevel = 0;
  for (int i=0; i<fft.specSize(); i++) {
    soundLevel += fft.getBand(i);
  }
```

の部分を見てみると、周波数毎の値を取り出す方法が見えてくると思います。

Processing では、[minim](http://code.compartmental.net/tools/minim/) というライブラリが音まわりを担当しています。[minim のドキュメント](http://code.compartmental.net/tools/minim/manual-fft/)もあわせて参考にしてください。

### ボーンの描画の仕方

ここまでの描画では、人体モデルの関節に相当する部分に球や円を描画しているだけでしたが、ここでは関節と関節の間をつなぐ、骨組の部分（ボーン）を描く方法を説明します。

PBvh.pde の `draw()` メソッドの中にある、`for ( BvhBone b : parser.getBones())` で始まるループの中で各関節が描画されているのはすでになんとなくわかってきていると思います。このループの中では、`b` という変数で参照できるオブジェクトによって、関節に関するデータが管理されています。

このオブジェクトには、`getParent()` というメソッドが用意されています。このメソッドを呼ぶと、その関節につながっている別の関節オブジェクトのうち、「親関節」として指定されているものを取り出すことができます。これを使うと、骨でつながっている二つの関節の座標を取り出すことができるようになりますので、その二つの座標を線で結ぶことで、ボーンを描くことができます。

では実際にやってみましょう。PBvh.pde の中に以下のような箇所があるはずです。行頭に `//` と書くことでこれらのコードはコメントとして扱われています。この `//` を取り除くと、ボーンを描画します。

```java
      //BvhBone p = b.getParent();
      //if(p != null) {
      //  stroke(255);
      //  line(b.absPos.x, b.absPos.y, b.absPos.z, p.absPos.x, p.absPos.y, p.absPos.z);
      //  noStroke();
      //}
```

1行目では、親関節のオブジェクトは変数 `p` で参照できるようにしています。もし `p` が空 (null) の場合は、親がないことを意味しますので何もしないよ、というのが2行目の if 文の意味です。親がある場合には、4行目で `b` の関節と `p` の関節との間に線を描いています。関節を描くときと違い、`translate()` を使っていませんが、このようにしても狙った場所に図形を描くことができます。

ちなみに、このボーンデータを表しているオブジェクトは `BvhBone` クラスのインスタンスになります。BvhBone クラスは lib/src/BvhBone.java というファイルの中で定義されています。このコードを読むことでボーンデータがどのように格納されているか、より詳しくわかってくるかと思います。なぜ関節どうしの関係に「親 (parent)」や「子 (childlen)」という関係があるのか、いろいろ試しながら調べてみましょう。

## おわりに

どうでしょう、プログラムも 3DCG もいまひとつわかっていなかったとしても、あちこちを少しづついじるだけで色々と試すことができます。他にも色を変えたり他の図形を追加したりして、どんな表現ができるか、どんどん試してみてください。それを繰り返すことで、3DCG の扱いや、オブジェクト指向の考え方を一端を学べるでしょう。下の写真は、Processing も 3DCG もほとんど経験がない学生が、このプログラムを改造して作ったものの一部です。試行錯誤の積み重ねとちょっとしたアイデアで、面白い映像表現を自分の手で作ってみてください。

![](samples.jpg)
