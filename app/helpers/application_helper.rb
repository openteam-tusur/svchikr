# encoding: utf-8
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

  def render_partial_for_region(region)
    if region && (region.response_status == 200 || !region.response_status?)
      render :partial => "regions/#{region.template}",
      :locals => { :object => region, :response_status => region.response_status }
    else
      render :partial => 'regions/error', :locals => { :region => region }
    end
  end

  def person_building_full_address(person)
    content_tag :p, person.building_full_address if person.building_full_address.present?
  end

  def person_contacts(person)
    content = ''
    content << person.phones
    content << person.emails.map{ |email| mail_to(email.value) }.join(', ')
    content_tag :p, content.squish.gsub(/;$/, '').html_safe if content.present?
  end

  def person_additional_contacts(person)
    content = ''
    person.additional_contacts.each do |contact|
      content << contact.kind_text
      if contact.kind_text == 'Сайт'
        content << link_to(contact.value, contact.value)
      else
        content << contact.value
      end
      content << ', '
    end
    content_tag :p, content.squish.gsub(/;$/, '').html_safe if content.present?
  end

end
