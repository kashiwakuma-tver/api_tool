# TVerCMS関連APIツール
## このツールについて
* このツールはTVerCMSのAPIを使ってCMSの情報を取得するためのツールである

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
  * (準備中)
* STREAKS
  * (準備中)

## APIリファレンス情報
* [TVerCMS](https://s3-ap-northeast-1.amazonaws.com/tverservice-docs-omniscient/reference/cms/index.html#cms-episode-vod-get)
* [STREAKS API](https://docs.streaks.jp/api/#/)
* [VideoCloud API](https://apis.support.brightcove.com/index.html)
* [新メタコンマスAPI](https://precas.atlassian.net/wiki/spaces/spec2/pages/2208104461/VOD+API)