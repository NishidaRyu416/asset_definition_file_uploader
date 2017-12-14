require "asset_definition_file_uploader/version"
require "asset_definition_file_uploader/core"
require 'net/http'
require 'json'
require 'date'
require 'google_url_shortener'

module AssetDefinitionFileUploader
    @uri = URI("https://api.github.com/gists")
    FILE_NAME=Date.today.to_time

    def self.make_upload_asset_definition_file(file_description,asset_ids,asset_name_short,asset_name,contract_url,issuer,asset_description,
                                          description_mime,type,divisibility,link_to_website,icon_url,image_url,version,file_name=FILE_NAME)
      asset_definition_file={
          "asset_ids": asset_ids,
          "name_short": asset_name_short,
          "name": asset_name,
          "contract_url": contract_url,
          "issuer": issuer,
          "description": asset_description,
          "description_mime": description_mime,
          "type": type,
          "divisibility": divisibility,
          "link_to_website": link_to_website,
          "icon_url": icon_url,
          "image_url": image_url,
          "version": version
      }
      request=self.make_request_contents(file_description,file_name,asset_definition_file)
      self.do_request(request)
    end
    def self.make_request_contents(file_description,content,file_name=FILE_NAME)
      request_stuffs = {
          'description' => file_description,
          'public' => true,
          'files' => {
              "#{file_name}.json" => {
                  'content' => content.to_json
              }
          }
      }
      return request_stuffs
    end
    def self.make_asset_definition_file (asset_ids,asset_name_short,asset_name,contract_url,issuer,asset_description,description_mime,type,divisibility,link_to_website,icon_url,image_url,version)
      asset_definition_file={
          "asset_ids": asset_ids,
          "name_short": asset_name_short,
          "name": asset_name,
          "contract_url": contract_url,
          "issuer": issuer,
          "description": asset_description,
          "description_mime": description_mime,
          "type": type,
          "divisibility": divisibility,
          "link_to_website": link_to_website,
          "icon_url": icon_url,
          "image_url": image_url,
          "version": version
      }
      return asset_definition_file
    end

    def self.do_request(request)
      request_stuffs=request
      request_stuffs=request_stuffs.to_json
      req = Net::HTTP::Post.new(@uri.path)
      req.body = request_stuffs
      res = Net::HTTP.start(@uri.hostname, @uri.port, :use_ssl => true) do |http|
        http.request(req)
      end
      @response= res.body
      return @response
    end

    def self.make_url_short(api_key,file_name=FILE_NAME,response=@response)
      response=JSON.parse(response)
      response=response["files"]["#{file_name}.json"]["raw_url"]
      Google::UrlShortener::Base.api_key = api_key
      url=Google::UrlShortener.shorten!(response)
      return url
    end

    def self.shorten(api_key,url)
      Google::UrlShortener::Base.api_key = api_key
      url=Google::UrlShortener.shorten!(url)
      return url
    end
end
