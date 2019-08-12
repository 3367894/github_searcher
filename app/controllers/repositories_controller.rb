class RepositoriesController < ApplicationController
  get '/' do
    param :q, String, required: true
    param :page, Integer

    @repositories_getter = RepositoriesGetter.new(params.slice(:q, :page))

    haml :'repositories/index'
  end

  helpers do
    def next_page_href
      url("/?q=#{params[:q]}&page=#{(params[:page] || 1).to_i + 1}")
    end

    def prev_page_href
      url("/?q=#{params[:q]}&page=#{params[:page].to_i - 1}")
    end
  end
end
