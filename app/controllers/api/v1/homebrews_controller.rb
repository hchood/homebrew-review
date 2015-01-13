class API::V1::HomebrewsController < ApplicationController
  before_action :ensure_valid_api_key!, only: [:create, :update]

  def index
    @homebrews = Homebrew.all
  end

  def show
    @homebrew = Homebrew.find(params[:id])
  end

  def create
    @homebrew = authenticated_user.homebrews.build(homebrew_params)

    if @homebrew.save
      render :show, status: 201
    else
      render json: { errors: @homebrew.errors }, status: 422
    end
  end

  def update
    @homebrew = Homebrew.find(params[:id])

    authorize_to_edit(@homebrew)
  end

  protected

  def homebrew_params
    params.require(:homebrew).permit(:name, :date_brewed, :description, tag_ids: [])
  end

  def ensure_valid_api_key!
    api_key || render_unauthorized
  end

  def api_key
    @api_key ||= APIKey.from_request(request)
  end

  def authorize_to_edit(homebrew)
    authenticated_user.brewed?(homebrew) || render_unauthorized
  end

  def authenticated_user
    api_key.user if api_key
  end

  def render_unauthorized
    self.headers["WWW-Authenticate"] = 'Token realm="Application"'
    render json: "Bad credentials", status: 401
  end
end
