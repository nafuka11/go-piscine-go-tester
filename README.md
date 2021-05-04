# go-piscine-go-tester

go-piscine-go のテスターです。

## 使い方

1. リポジトリをclone

   テストしたいプロジェクトより1階層上でcloneしてください。

   ```
   git clone https://github.com/nafuka11/go-piscine-go-tester.git
   ```

1. テストしたいプロジェクトのパスを指定

   デフォルトは `../go-piscine-go-00` になっています。

   プロジェクトのディレクトリパスが異なる場合は、grademe.sh にある `PROJECT_DIR` を変更してください。

1. テストを実行

   `go-piscine-go-tester` のディレクトリに移動してからスクリプトを実行します。

   - 全てのテストを実行したい場合

     ```bash
     ./grademe.sh
     ```

   - 一部のテストを実行したい場合

     exerciseを指定することができます。

     ```bash
     # ex00をテスト
     ./grademe.sh ex00
     # ex00から05までテスト
     ./grademe.sh ex{00..05}
     ```

## テストの出力

OK/KO が表示されるテスト、出力のみ表示されるテストがあります。

OK/KO が表示されるテストは、`expected/` 下のファイルと実際の出力（`actual/`）を比較し、OK・KOいずれかを表示します。

出力のみ表示されるテストは、実装によって出力が異なるテストです。クラッシュしていないか等をご自身で確認してください。

### 注意点

ex04, ex05 は main 関数が含まれない場合、出力のテストは行われません。
