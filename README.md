# TVerCMS関連APIツール
## このツールについて
* このツールはTVerCMSのAPIを使ってCMSの情報を取得するためのツールである
* Mac OSで開発を行っており、動作確認もMac OSのみ。Intel CPUのMacでは動作未確認

## セットアップ
1. Ruby（というかrbenv）をインストールする
  * [rbenv installation](https://github.com/rbenv/rbenv#installation)に沿ってrbenvでインストール。rbenv使わなくても動作には問題ないはず
  * バージョンは3.2.3で動作確認済

2. 環境変数を設定する
コード内では一部環境変数を設定しているため、以下の通りローカル環境の環境変数に指定しておく
VIDEO_CLOUT_ACCOUNT_IDは局ごとに存在するので、全局分登録しておくとよい
```
export VIDEO_CLOUD_CLIENT_ID=(知っている人に聞いて下さい)
export VIDEO_CLOUD_CLIENT_SECRET=(知っている人に聞いて下さい)
export LOCAL_TVER_CMS_URL=http://localhost:8610
export DEV_TVER_CMS_URL=https://service-manager-tenjin-devintegrate.in-tver.jp
export STG_TVER_CMS_URL=https://service-manager-gion-staging.in-tver.jp
export PRD_TVER_CMS_URL=https://service-manager.in-tver.jp
export VIDEO_CLOUD_CMS_API=https://cms.api.brightcove.com/v1/accounts
export VIDEO_CLOUD_ACCOUNT_{局ID}=(知っている人に聞いて下さい)
```

## 使い方
1. {tvercms|contentmaster|videocloud}.rbを編集する。
  1.実行したいAPIをコメントアウトする。例えばVODエピソード一覧APIを実行したい場合は「Episode.new~~.exec_paging_api」をコメントアウトする
  2. optionsとparamsを指定する。大まかには以下の通りだが、詳細はmain.rbを参照のこと
    1. options・・・実行するAPI、実行環境、IDなどを指定する
    2. params・・・API実行時に指定するクエリパラメータ。必要に応じてAPIリファレンスの仕様に沿って指定する
2. ターミナルで{tvercms|contentmaster|videocloud}.rbのあるディレクトリに移動し「ruby {tvercms|contentmaster|videocloud}.rb」を実行する
    

## 対応API
* TVerCMS
  * VODエピソード一覧
  * VODエピソード取得
  * LIVEエピソード一覧
  * LIVEエピソード取得
  * シリーズ一覧
  * シリーズ取得
  * シーズン一覧
  * シーズン取得
  * VOD一覧
* VideoCloud
  * GetVideo
  * DynamicIntest
* コンマスAPI
* STREAKS(準備中)

## APIリファレンス情報
* [TVerCMS](https://s3-ap-northeast-1.amazonaws.com/tverservice-docs-omniscient/reference/cms/index.html#cms-episode-vod-get)
* [STREAKS API](https://docs.streaks.jp/api/#/)
* [VideoCloud API](https://apis.support.brightcove.com/index.html)
* [新メタコンマスAPI](https://precas.atlassian.net/wiki/spaces/spec2/pages/2208104461/VOD+API)
