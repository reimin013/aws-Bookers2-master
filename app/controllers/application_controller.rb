class ApplicationController < ActionController::Base

 before_action :configure_permitted_parameters, if: :devise_controller?

 Refile.secret_key = '6b7e2a7c798502136cf5adc8ee33fabac97fc324e009ab638bd3433ca0b98aeffb70ad28977de42e9fe3cd73ac78941b41519ee7995d70692f23204f7f216ad1'

 def after_sign_in_path_for(resource)
    user_path(resource.id)
 end
 # resource がないと何がログインしたかの情報を持ってこれないため、この引数を消すとエラーが出てしまう

 protected
 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    # はじめに、keys: の中身に':email'を追加していなかったので、emailがnilでかぶっていて登録できなかった可能性がある。
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])
 end
end
