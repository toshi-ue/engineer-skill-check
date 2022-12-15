### 動作環境

- 検証環境として docker環境を用意しています。必ずdocker環境を利用してください。
- 下記コマンドを実行すると3000番ポートでRailsサーバーが起動します。
```
$ docker compose build
$ docker compose up -d
```

### バージョン
Ruby及びRuby on Railsのバージョンは下記の通りです。
```
Ruby: 3.0.2
Rails: 6.1.4.1
sqlite3: 1.4.2
```

### セットアップ情報
コンテナに入った後、yarnインストールと初期データの投入を行ってください。なお、初回起動時はyarn installされていないのでwebpackerサービスは起動に失敗します。
```
$ docker compose exec web bash
```

yarnインストール
```
# yarn install
```

初期データの投入
```
# bin/rails db:schema:load
# bin/rails db:seed
```
webpackerサービスを再度起動してください

```
$ docker compose up -d webpacker
```
