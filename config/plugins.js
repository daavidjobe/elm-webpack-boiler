import HtmlWebpackPlugin from 'html-webpack-plugin'
import ExtractTextPlugin from 'extract-text-webpack-plugin'
import CopyWebpackPlugin from 'copy-webpack-plugin'

export const productionPlugins = [
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

export const developmentPlugins = [
  new HtmlWebpackPlugin({
    template: 'src/static/index.html',
    inject:   'body',
    filename: 'index.html'
  })
]
