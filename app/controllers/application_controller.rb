class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  # URLパラメータでlocalを判定
  before_filter :set_locale
  
  # 全リンクにlocale情報をセットする/日本語でアクセスした場合はロケールが表示されない
  def default_url_options(options={})
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }.merge options
  end
  
  # リンクの多言語化に対応する
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
