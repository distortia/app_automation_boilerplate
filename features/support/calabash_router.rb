module Calabash
  class Page
    def route_for(page)
      routes("#{(page.gsub(' ', '_')+ '_page')}")
    end

    def routes(page)
      routes =
      {
          :splash_page => [[:SplashPage, :await]],
          :login_page =>  [[:SplashPage, :tap, :btn_sign_in],
                           [:LoginPage, :await]],
          :forgot_password_page => [[:SplashPage, :tap, :btn_sign_in],
                                    [:LoginPage, :await],
                                    [:LoginPage, :tap, :btn_forgot_password],
                                    [:ForgotPasswordPage, :await]],
          :home_page => [[:SplashPage, :await], [:SplashPage, :tap, :btn_sign_in],
                          [:LoginPage, :login_for_route],
                          [:HomePage, :await]]
      }
      routes[page.to_sym]
    end

    def navigate_to_page(steps)
      steps.each do |page, method, *args|
        puts "page: #{page}, method: #{method}, args: #{args}"
        @current_page = Object.const_get page
        if args.empty?
          page(@current_page).send method
        else
          page(@current_page).send method, page(@current_page).send(*args)
        end
      end
    end
  end
end