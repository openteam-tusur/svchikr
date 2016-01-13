class MainController < ApplicationController
  helper_method :cms_address
  before_filter :prepare_locale

  def index
    render :file => "#{Rails.root}/public/404.html", :layout => false and return if request_status == 404

    page_regions.each do |region|
      eval "@#{region} = page.regions.#{region}"
    end

    @page_title = page.title
    @template = page.template

    render "templates/#{@template}"
  end

  private

    def cms_address
      "#{Settings['cms.url']}/nodes/#{Settings['cms.site_slug']}"
    end

    def prepare_locale
       I18n.locale = request.fullpath.gsub(/\?.*$/, '').split('/').map(&:presence).compact.first || 'ru'
    end

    def remote_url
      request_path, parts_params = request.fullpath.split('?')
      "#{cms_address}#{request_path.split('/').compact.join('/')}.json?#{parts_params}"
    end

    def page
      @page ||= Hashie::Mash.new(request_json).page
    end

    def rest_request
      @rest_request ||= RestClient::Request.execute(
        :method => :get,
        :url => remote_url,
        :timeout => nil,
        :headers => {
          :Accept => 'application/json',
        }
      ) do |response, request, result, &block|
        response
      end
    end

    def request_status
      @request_status ||= rest_request.code
    end

    def request_body
      @request_body ||= rest_request.body
    end

    def is_json?(str)
      begin
        !!JSON.parse(str)
      rescue
        false
      end
    end

    def request_json
      @request_json ||= begin
                          raise 'Response is not a JSON' unless is_json?(request_body)
                          ActiveSupport::JSON.decode(request_body)
                        end
    end

    def page_regions
      @page_regions ||= page.regions.keys
    end
end
