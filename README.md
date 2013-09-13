はじめに
========

これは [Perfume Global Site](http://www.perfume-global.com/)で配布されているダンスモーションを [Processing](http://processing.org/) で可視化する[サンプルプログラム](https://github.com/perfume-dev/example-processing) に、改造しやすくなるよう手を加えたものです。

オリジナルとの差分
------------------

- ポリゴンが裏返っているのを解消
- [Minim](http://code.compartmental.net/tools/minim/) を標準で組込
- 公式配布データ用にあらかじめ設定変更
- その他見た目の細かい調整

使い方
======
まずはダンスモーションのデータと楽曲データを下記サイトからダウンロードしましょう。

- [Perfume Global Site](http://www.perfume-global.com/)

2013年9月現在、上記サイトにアクセスすると二つのリンクがありますが、"Perfume Global Site" と書かれた左側のリンクを辿ってください。その後表示されるページの左上隅にナビゲーションエリアがあり、マウスカーソルを近付けると下図のような画面になりますので、「Download」を選択しクリックしてください。
![](perfume_global_site.png)

続くページの「Vol.01 Motion Capture Data」の欄に、ダウンロード用リンクが表示されています。"Terms of use" というリンクに、データの使用上の注意が書かれていますので、よく読んで納得したら "You agree to our terms" にチェックを入れ、"BVH" および "SOUND" のリンクをクリックすると、それぞれの ZIP ファイルがダウンロードされます。

次に、ダウンロードしたファイルを展開します。まずダンスモーションデータが格納されている bvhfiles.zip を展開し、その中に含まれている下記のみっつのファイルを、perfumedance-p5/data の中に置きます。

- aachan.bvh
- kashiyuka.bvh
- nocchi.bvh

また、Perfume\_globalsite\_sound.wav.zip を展開し、その中に含まれている Perfume\_globalsite\_sound.wav もやはり perfumedance-p5/data の中に置きます。

以上のファイルが用意できたら、まずは実行してみて、Perfume の三人が音楽にあわせて踊っているグラフィクスが見られるかどうかを確認してみてください。もしうまく行かない場合は、上述した各種ファイルの置き場所が間違っている可能性があります。

改造のポイント
==============

※書き途中

- 大きさを変える
- 形を変える
- 音に反応させる
- ボーンの描画の仕方
