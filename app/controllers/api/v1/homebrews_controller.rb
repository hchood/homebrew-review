class API::V1::HomebrewsController < ApplicationController
  before_action :ensure_valid_api_key!, only: :create

  def index
    @homebrews = Homebrew.all
  end

  def show
    @homebrew = Homebrew.find(params[:id])
  end

  def create
  end

  protected

  def ensure_valid_api_key!
    api_key || render_unauthorized
  end

  def api_key
    @api_key ||= APIKey.from_request(request)
  end

  def render_unauthorized
    self.headers["WWW-Authenticate"] = 'Token realm="Application"'
    render json: "Bad credentials", status: 401
  end
end
