# CCBT Camp vol.4

採取した微生物サンプルのDNAデータをQiime2でタクソノミー解析したサンプル

## How To Use

### 結果だけ見る場合

1. [QIIME2 View](https://view.qiime2.org/)で`notebooks/data/krona-plot.qza`を開く
  * [Release](https://github.com/Eotel/ccbt-camp4-krona-sample/releases/)から直接ダウンロードもできます

### 自分で解析する場合

```bash
$ docker compose up --build -d
```

### Notebookを開く

1. ブラウザで`http://localhost:8888`にアクセス
2. `Playground.ipynb`のセルを上から実行する
3. `notebooks/data/krona-plot.qza` が得られるので，[QIIME2 View](https://view.qiime2.org/)で開く
