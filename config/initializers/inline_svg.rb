# config/initializers/inline_svg.rb

InlineSvg.configure do |config|
  # Rails 7以降でSprocketsを使っていない場合は、この設定でOK
  config.asset_finder = InlineSvg::StaticAssetFinder

  # SVGファイルのディレクトリを指定（デフォルト: app/assets/images）
  # 特に変更不要であればこの行は省略可能
  # config.add_custom_transformation(attribute: 'aria-hidden', value: 'true')
end
