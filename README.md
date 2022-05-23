# docker_setting
dockerを使うための設定ファイルをまとめています。

## できること
- Dockerによる基本的なデータ分析・画像処理の環境構築（GPUも使用可）
- [おまけ] 仮想デスクトップ（jupyter labをコマンドにより起動　→　jupyter labからnovncを選択）

## 各ファイルの用途

1. build.sh

イメージ作成用コマンド

2. run.sh

コンテナ作成用コマンド

3. Dockerfile

イメージ作成用の設定ファイル

4. env.yml

コンテナ内でcondaを使えるように設定しており、具体的な環境設定用ファイルの例です。
環境をコンテナ内で構築する上でymlを使って環境構築すると楽かもしれません。
env.ymlから環境を作る方法は調べる or 誰かに聞いてください。

## 使い方

**1. リポジトリをクローン**

```java:title
git clone https://github.com/tamaryo1025/docker_setting.git
```

**2. **Dockerfile直下でImageをビルド****

build.shの内容を書き換えて使ってください 

**3. コンテナ起動**

run.shの内容を書き換えて使ってください。

**4. vscodeの拡張機能を使ってコンテナ起動 or docker attach**

vscodeの左のメニューからモニターのようなアイコン(Remote Explorer)を選択。

SSH Tragets →　Containersに変更。

立ち上げ中のコンテナには再生マークがついているので、Attach to Containerのアイコンでアタッチ。分からなければ、調べる or 身近な先輩に聞いてください。


## 注意点

- {USERNAME}などはローカルに割り当てられた各自の名前を確認して置き換えてください。
- {IMAGENAME}、{CONTAINERNAME}も任意です。
- Dockerfile内にはuidとgidを書き換える箇所があります。ローカルの環境のuidとgidをidコマンドで確認し、書き換えてください。
- port番号は他のコンテナと使用番号が被ると使えません。適宜変えましょう。
ex) 8888 →　9999
- Dockerコマンド・概念やlinuxコマンドが最低限理解できていないと、使えないかもしれません。
調べる or 身近な先輩に聞いてください。