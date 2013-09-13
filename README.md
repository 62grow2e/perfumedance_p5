# perfumedance\_p5 README
## はじめに

これは [Perfume Global Site](http://www.perfume-global.com/)で配布されているダンスモーションを [Processing](http://processing.org/) で可視化する[サンプルプログラム](https://github.com/perfume-dev/example-processing) に、改造しやすくなるよう手を加えたものです。

### オリジナルとの差分

- ポリゴンが裏返っているのを解消
- [Minim](http://code.compartmental.net/tools/minim/) を標準で組込
- 公式配布データ用にあらかじめ設定変更
- その他見た目の細かい調整

## 使い方

まずは本プログラムを展開します。お使いの Processing 用のスケッチブック保存フォルダの中に、本プログラムを展開してください。ZIP ファイルで入手した場合は、展開された perfumedance\_p5 というフォルダをそのままスケッチブック保存フォルダに置いてください。

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

以上のファイルが用意できたら、まずは実行してみて、Perfume の三人が音楽にあわせて踊っているグラフィクスが見られるかどうかを確認してみてください。もしうまく行かない場合は、上述した各種ファイルの置き場所が間違っている可能性があります。

## 改造のポイント

プログラムのあちこちをいじってみることで、感覚的にプログラムの仕組みや 3D CG の動かし方を学んでいくとよいでしょう。以下に、とっかかりの改造ポイントを記しますので参考にしてください。

### 大きさを変える

頭や身体のパーツの大きさを変えてみましょう。身体を描く部分は PBvh.pde の中に記述されています。Processing のエディタ上で PBvh.pde のタブを開き、下記の箇所を探してみましょう。

```java
        translate( b.absEndPos.x, b.absEndPos.y, b.absEndPos.z);
        sphere(20);
```


ここは頭や手足の先の部分

- 形を変える
- 音に反応させる
- ボーンの描画の仕方
