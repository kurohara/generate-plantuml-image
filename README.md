# generage-plantuml-image

githubがmermaidをサポートしてREADMEで作図がしやすくなったが、まだ一部の図はmermaidでは書きづらいという印象がある。  
できればREADMEに直接書いたplantumlがgithubサイト上でそのまま描画されるとありがたい。  
記入方法はvscodeのプラグインでサポートされているplantumlコードブロックで。  


### Github Actionsを使ったplantumlのレンダリング

幸いgithubにおけるREADMEのレンダリングは ./README.md よりも ./.github/README.md の方が優先順位が高いので、Github Actions の PUSH アクションでREADMEからplantumlのコードを抜き出してpngを生成し、./.githubの下に置いてあげれば良い。  
このやり方の欠点は、ローカルのリポジトリが毎回pushするたびにbehindになってしまうことで、手元の作業後にcommitする前にpullしておかないとconflictが発生してしまう。  
これはREADMEの更新時だけの問題なので、READMEが安定すれば事前のpullやmergeなどの面倒臭さは減るはず。  


~~現時点で一応Actionsのスクリプトは完成したが、なぜか手元のnode-plantumlよりActionsのnode-plantumlがサポートしている図形が少ないようで、あまり上手く動作しない。  （sequenceは書かれるが、use-caseがエラーになる)~~

~~手元ではVSCodeのpreviewプラグインで普通にレンダリングできているのだが。~~

![screen](/screen1.png)

普通に一人で作業するリポジトリなら、各人の作業環境を考慮する必要がないので、手元でスクリプトを使用して ./.github/README.mdとイメージファイルを生成した方が早い。  
そのような用途のために、workflowを genplantuml.sh に切り出した。  

## サンプル


```plantuml
alice -> bob:test
```

```plantuml

alice -> (何かする)

```

```plantuml
actor user as u

package Excel {
    usecase Excel入力 as ei1
}

package mycv {
    usecase web入力 as wi1
    usecase Excelアップロード as eup
    usecase Excel出力 as exp
}

u -> ei1
u -> wi1
u -> eup
u -> exp


```

