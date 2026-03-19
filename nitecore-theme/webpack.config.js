/**
 * webpack.config.js — Webpack 5 build configuration for nitecore-theme
 *
 * Outputs:
 *  assets/css/custom.css  — compiled & minified CSS (from SCSS)
 *  assets/js/theme.js     — transpiled & minified JS bundle
 *  assets/js/megamenu.js  — transpiled & minified mega-menu bundle
 */

'use strict';

const path                  = require('path');
const MiniCssExtractPlugin  = require('mini-css-extract-plugin');
const CssMinimizerPlugin    = require('css-minimizer-webpack-plugin');
const TerserPlugin          = require('terser-webpack-plugin');

module.exports = (env, argv) => {
  const isDev = argv.mode === 'development';

  return {
    // ── Entry points ──────────────────────────────────────────────────────────
    entry: {
      custom: path.resolve(__dirname, 'assets/css/custom.scss'),
      theme:  path.resolve(__dirname, 'assets/js/theme.js'),
      megamenu: path.resolve(__dirname, 'assets/js/megamenu.js'),
    },

    // ── Output ────────────────────────────────────────────────────────────────
    output: {
      path: path.resolve(__dirname, 'assets'),
      // JS bundles
      filename: (pathData) => {
        return pathData.chunk.name === 'custom'
          ? 'css/[name].js'   // dummy — overridden by MiniCssExtractPlugin
          : 'js/[name].js';
      },
      clean: false, // don't clean the whole assets folder
    },

    // ── Source maps ───────────────────────────────────────────────────────────
    devtool: isDev ? 'source-map' : false,

    // ── Module rules ──────────────────────────────────────────────────────────
    module: {
      rules: [
        // JavaScript — Babel transpilation
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: [
                ['@babel/preset-env', {
                  targets: '> 1%, last 2 versions, not dead',
                  useBuiltIns: 'usage',
                  corejs: 3,
                }],
              ],
            },
          },
        },

        // SCSS → CSS
        {
          test: /\.(scss|css)$/,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: 'css-loader',
              options: { sourceMap: isDev, importLoaders: 2 },
            },
            {
              loader: 'resolve-url-loader',
              options: { sourceMap: isDev },
            },
            {
              loader: 'sass-loader',
              options: {
                sourceMap: true, // required by resolve-url-loader
                sassOptions: {
                  outputStyle: isDev ? 'expanded' : 'compressed',
                  includePaths: [path.resolve(__dirname, 'assets/css')],
                },
              },
            },
          ],
        },
      ],
    },

    // ── Plugins ───────────────────────────────────────────────────────────────
    plugins: [
      new MiniCssExtractPlugin({
        filename: 'css/custom.css',
      }),
    ],

    // ── Optimisation ──────────────────────────────────────────────────────────
    optimization: {
      minimizer: [
        new TerserPlugin({
          terserOptions: {
            format: { comments: false },
            compress: { pure_funcs: ['console.log', 'console.debug', 'console.info'] },
          },
          extractComments: false,
        }),
        new CssMinimizerPlugin(),
      ],
      minimize: !isDev,
    },

    // ── Stats ─────────────────────────────────────────────────────────────────
    stats: {
      colors: true,
      modules: false,
      children: false,
      chunks: false,
    },
  };
};
