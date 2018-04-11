module.exports = {
  entry: './web/static/js/index.js',
  output: {
    path: __dirname + '/priv/static/js',
    filename: 'app.js'
  },
  resolve: {
    extensions: ['.js', '.jsx']
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      }
    ]
  }
}
