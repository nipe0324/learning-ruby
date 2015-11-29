module.exports = {
  // エントリファイルを記載(複数記載できます)
  entry: {
    application: './gulp/assets/javascripts/application'
  },
  // 出力先を記載
  output: {
    filename:   '[name].bundle.js',
    publicPath: './public/assets/javascripts/'
  },
  resolve: {
    extensions: ['', '.js', '.jsx']
  },
  // .jsxをコンパイルするときに、jsx-loaderというツールを使う
  module: {
    loaders: [
      { test: /\.jsx$/, loader: 'jsx-loader' }
    ]
  }
};
