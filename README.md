# Bengal v1.0.0-alpha.0

Frontend's Boilerplate



##Usage

`npm run start` :  

初回のみ依存パッケージのインストールと、ソースのビルドを行います。  


## Command

	すべてのコマンドで共通のパラメータ env が利用できます。
	env には dev | stg | prod のいずれかを指定できます。
	（パラメータを省略した場合、自動的に dev を選択）

	開発中は特に指定する必要はないかと思いますが、
	リリース版を作成するときは stg か prod のいずれかを選択してください。


### Watch & Serve


`gulp` :  

PC版のソースを監視します。


`gulp -s` :  

SP版のソースを監視します。


### Build

`npm run build -- env` :  

すべてのソースをビルドします。   
gitから最新ファイルをpullしたときなどに使います。  
出力先は `dev/` となります。


### Release build

`npm run release -- env` :  

リリース用のソースを作成します。  
`.map` ファイルを取り除いたり、ソース圧縮などを行います。  
出力先は `dist/` となります。  


## Setting / Configuration


### app.config.json

アプリケーション全体で共有される環境変数を定義します。  
ここで定義された値はEJSやwebpackなどブラウザ用ソースからも参照することができます。  

### build/setting.json

開発用の設定ファイルです。  
ソース圧縮の有効化などをこちらで設定できます。

### build/environments/\*.json

ビルドバージョン（development, staging, production）毎の設定を行います。   
コマンド実行時の `env` パラメータに応じて、いずれかのデータを参照します。  
またここで定義された値は `appConfig(app.config.json)` に統合されるので、  
ブラウザ用のソースファイルからも参照することができます。


## Browser

### EJS

appConfigの値が参照できます。  
`<%= SITE_URL %>` のようにして出力できます。

### webpack

appConfigの値が参照できます。  
`src/common/scripts/_config.coffee` で定義されている `config` オブジェクトにextendしているので、`config.SITE_URL` のようにして取得できます。  
セキュリティなどを考慮し、js側に流すべきでないものに関してはプロパティ名に `_` をつけることで、ignoreすることができます。



また、デフォルトで[jQuery](https://www.npmjs.com/package/jquery)と[lodash](https://www.npmjs.com/package/lodash)がプラグインとして組み込まれています。  
不要な場合は `webpack.config > plugins` の項目を修正してください。


#### 拡張子とトランスパイラの対応表

jsファイルが以下の拡張子である場合、  
対応したトランスパイラが走るようになっています。

|拡張子|トランスパイラ|言語|設定ファイル|
|:-:|:-:|:-:|:-:|
|.ts|ts-loader|TypeScript|tsconfig.json|
|.coffee|coffee-loader|CoffeScript|-|
|.jsx|babel-loader|ES2015 (ES6)|.babelrc|

### Sass


## Dependencies

- [NodeJS](https://nodejs.org/en/) [v6.1.0]
- [Gulp](http://gulpjs.com/) [v3.9.0]

※末尾についたバージョンは検証環境でのバージョンです。

