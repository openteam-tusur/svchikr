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

  def render_navigation(hash)
    return '' if hash.nil? || hash.empty?
    content_tag :ul do
      hash.map do |key, value|
        content_tag :li, :class => value['selected'] ? 'selected' : nil do
          link_to(value['title'], value['path']) + render_navigation(value['children'])
        end
      end.join("\n").html_safe
    end
  end

  def render_partial_for_region(region)
    if region && (region.response_status == 200 || !region.response_status?)
      render :partial => "regions/#{region.template}",
      :locals => { :object => region, :response_status => region.response_status }
    else
      render :partial => 'regions/error', :locals => { :region => region }
    end
  end

  def person_short_address(person)
    return if person.office.blank? || person.building.blank?
    content_tag :p, "#{person.building.address}, #{person.office}", :class => 'address'
  end

  def person_full_address(person)
    return if person.office.blank? || person.building.blank?
    content_tag :p, "#{person.building.locality}, #{person.building.address} (#{person.building.downcased_title}), #{person.office}", :class => :address
  end

  def person_contacts(person)
    content = ''
    content << content_tag(:span, person.phones.squish.gsub(/;$/,''), :class => 'phones') if person.phones.present?
    content << content_tag(:span, person.emails.map{ |email| mail_to(email.value) }.join(', ').html_safe, :class => 'emails') if person.emails.any?
    content.html_safe if content.present?
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

  def parse_entry_date(item)
    date = I18n.l(Date.parse(item.since), format: '%d %B')
    { day: date.split(' ')[0], month: date.split(' ')[1] }
  end

  def truncate_entry_link(item, length = 80)
    link = ''
    if item.title.length > length
      link << link_to(truncate(item.title, length: length, separator: ' '), item.link, title: item.title)
    else
      link << link_to(item.title, item.link)
    end
    content_tag :div, link.html_safe, class: :link
  end


  def photo_tag(options={})
    size = options[:size] || '100x133'
    width, height = size.scan(/\d+/)
    url = options[:url].present? ? image_url(options[:url], width, height) : 'chief_stub.png'
    title = options[:title] || 'Фото'

    image_tag url, :size => size, :title => title, :alt => title
  end

  def image_url(url, width, height)
    url.gsub(/(?!=\/files\/\d+\/)(\d+-\d+.?.?)(?=\/)/, "#{width}-#{height}!")
  end
end
