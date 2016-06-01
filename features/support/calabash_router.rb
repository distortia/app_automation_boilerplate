module Calabash
  class Page
    def route_for(page)
      routes("#{(page.gsub(' ', '_')+ '_page')}")
    end

    def routes(page)
      routes =
      {
          :home_page =>[[:HomePage, :await]]
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