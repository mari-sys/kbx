module ApplicationHelper
  def ogp_title
    content_for?(:ogp_title) ? content_for(:ogp_title) : "キックボクシングスタイル診断アプリ"
  end
  
  def ogp_description
    content_for?(:ogp_description) ? content_for(:ogp_description) : "あなたに合ったキックボクシングのスタイルがわかる！"
  end
  
  def ogp_image
    image_url(content_for?(:ogp_image) ? content_for(:ogp_image) : "ogp.png")
  end
end
