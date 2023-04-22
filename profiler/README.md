# Profiler for Ruby

## Setup

```
# run mysql
docker-compose up -d 

# create table and insert record
docker-compose exec mysql mysql -h 127.0.0.1 -P 3306 -u my-user -p ruby-profiler-database 
# paste init.sql

# run server
bundle exec puma -e development  -w 2
```

- [ruby-prof](https://github.com/ruby-prof/ruby-prof)
  - star 2k
  - Rubyプログラムの実行速度をプロファイルする高速なコードプロファイラです。多様なレポート形式や、グラフ表示が可能
- [stackprof](https://github.com/tmm1/stackprof)
  - star 2k
  - コールスタックのプロファイラ
  - CPU使用率を分析して、パフォーマンスのボトルネックを特定できる
- [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler)
  - star 3.5k
  - RackベースのWebアプリケーションのパフォーマンスをプロファイリングするためのミニマルなツール
  - リクエスト毎のタイムラインやSQLクエリの分析が可能
  - 機能
    - database profiling (mysql2, porstgres, oracle, mongoid3)
    - call stack profiling
    - memory profiling
- [rack-lineprof](https://github.com/kainosnoema/rack-lineprof)
  - star 155
  - 簡易なRackミドルウェア
- [memory_profiler](https://github.com/SamSaffron/memory_profiler)
  - star 1.6k
  - Rubyプログラムのメモリ使用量を詳細に分析することができるgem
  - オブジェクトごとのメモリ消費やガーベジコレクタの動作を調べることができる
- [test-prof](https://github.com/test-prof/test-prof)
  - テストスイートのパフォーマンスを向上させるためのツールでFactoryBotやRSpecの最適化に役立つ
  - テストスイートの実行時間を短縮するためのプロファイリングデータを取得できる
