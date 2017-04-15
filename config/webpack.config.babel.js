import { join } from 'path'
import { productionLoaders, developmentLoaders } from './loaders'
import { productionPlugins, developmentPlugins } from './plugins'

const paths = {
  entry: join(__dirname, '../src/static/index.js'),
  output: join(__dirname, '../dist'),
  devServer: 'webpack-dev-server/client?http://localhost:8080'
}

module.exports = env => {
  return {
    entry: () => {
      if (env === 'production') {
        return paths.entry
      } else {
        return [paths.devServer, paths.entry]
      }
    },
    output: {
      path: paths.output,
      filename: `[name]${env === 'production' ? '-[hash]' : ''}.js`
    },
    devServer: {
      historyApiFallback: true,
      contentBase: './src',
    },
    module: {
      noParse: /\.elm$/,
      loaders: env === 'production' ?
        productionLoaders :
        developmentLoaders
    },
    plugins: env === 'production' ?
      productionPlugins :
      developmentPlugins
  }
}
