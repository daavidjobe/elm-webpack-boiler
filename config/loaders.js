import ExtractTextPlugin from 'extract-text-webpack-plugin'

export const productionLoaders = [
  {
    test:    /\.elm$/,
    exclude: [/elm-stuff/, /node_modules/],
    loader:  'elm-webpack-loader'
  },
  {
    test: /\.js$/,
    exclude: /node_modules/,
    loaders: [ 'babel-loader' ]
  },
  {
    test: /\.(css|scss)$/,
    use: ExtractTextPlugin.extract({
      fallback: 'style-loader',
      use: 'css-loader!postcss-loader!sass-loader'
    })
  }
]

export const developmentLoaders = [
  {
    test: /\.(eot|ttf|woff|woff2|svg)$/,
    loader: 'file-loader'
  },
  {
   test: /\.elm$/,
   exclude: [/elm-stuff/, /node_modules/],
   loaders: [
     'elm-hot-loader',
     'elm-webpack-loader?verbose=true&warn=true&debug=true'
   ]
 },
 {
   test: /\.js$/,
   exclude: /node_modules/,
   loaders: [ 'babel-loader' ]
 },
 {
   test: /\.(css|scss)$/,
   loaders: [
     'style-loader',
     'css-loader',
     'postcss-loader',
     'sass-loader'
   ]
 }
]
