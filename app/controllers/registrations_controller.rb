class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # サインアップ時のパラメータ
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname,
                                        :last_name,
                                        :first_name,
                                        :last_name_kana,
                                        :first_name_kana,
                                        :birth_date
                                      ])

    # アカウント更新時のパラメータ
    devise_parameter_sanitizer.permit(:account_update, keys: [
                                        :nickname,
                                        :last_name,
                                        :first_name,
                                        :last_name_kana,
                                        :first_name_kana,
                                        :birth_date
                                      ])
  end
end
