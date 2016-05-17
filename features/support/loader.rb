# Auto Loader for pages and their dependencies

pages_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'pages'))

autoload :CommonPage, File.join(pages_dir, 'common_page')
autoload :SharedHomePage, File.join(pages_dir, 'shared_home_page')