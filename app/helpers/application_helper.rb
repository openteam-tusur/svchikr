module ApplicationHelper

  def sitemap_link
    content_tag :li, link_to(I18n.t('sitemap'), "/#{I18n.locale}/sitemap/"), class: :sitemap
  end

  def languages_links
    res = ''
    I18n.available_locales.each do |lang|
      klass = [lang.to_s]
      klass << 'active' if I18n.locale == lang
      res << content_tag(:li, link_to(lang, "/#{lang}/", title: I18n.t("locale.#{lang}")), class: klass.join(' '))
    end
    res.html_safe
  end

end
