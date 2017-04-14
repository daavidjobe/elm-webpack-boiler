import { join } from 'path'
import HtmlWebpackPlugin from 'html-webpack-plugin'
import ExtractTextPlugin from 'extract-text-webpack-plugin'
import CopyWebpackPlugin from 'copy-webpack-plugin'
import autoprefixer from 'autoprefixer'

const paths = {
  entry: join(__dirname, 'src/static/index.js'),
  output: join(__dirname, 'dist')
}

const devConf = () => {
  console.log('Building for development..')
  return {
    entry: [
      'webpack-dev-server/client?http://localhost:8080',
      paths.entry
    ],
    output: {
      path: paths.output,
      filename: '[name].js'
    },
    devServer: {
      historyApiFallback: true,
      contentBase: './src',
    },
    module: {
      noParse: /\.elm$/,
      loaders: [
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
    },
    plugins: [
      new HtmlWebpackPlugin({
        template: 'src/static/index.html',
        inject:   'body',
        filename: 'index.html'
      })
    ]
  }
}

const prodConf = () => {
  console.log('Building for production..')
  return {
    entry: paths.entry,
    output: {
      path: paths.output,
      filename: '[name]-[hash].js'
    },
    module: {
      loaders: [
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
    },
    plugins: [
      new CopyWebpackPlugin([
        {
          from: 'src/static/img/',
          to:   'static/img/'
        }
      ]),
      new HtmlWebpackPlugin({
        template: 'src/static/index.html',
        inject:   'body',
        filename: 'index.html'
      }),
      new ExtractTextPlugin({
        filename: 'static/css/[name]-[hash].css',
        allChunks: true
      })
    ]
  }
}

module.exports = env => env === 'production' ? prodConf() : devConf()
