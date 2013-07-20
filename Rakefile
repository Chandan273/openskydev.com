
require 'haml'

SITE_PATH = Dir.pwd + '/_site/'

task :default => :build

task :build do
  FileUtils.rm_rf SITE_PATH
  FileUtils.mkdir_p SITE_PATH
  puts "Compiling HAML"
  Rake::Task["compile_haml"].invoke
  puts "Compiling Sass"
  Rake::Task["compile_sass"].invoke
  puts "Compiling Coffeescript"
  Rake::Task["compile_coffee"].invoke
  puts "Coping Assets"
  Rake::Task["copy_assets"].invoke
  Rake::Task["open"].invoke
end

task :compile_haml do 
  source_path = Dir.pwd + '/_source/'

  Dir.foreach(source_path) do |f|
    if f.end_with?('.haml')
      file = File.read(source_path + f)
      haml = Haml::Engine.new(file, escape_attrs: false)
      html = haml.render
      name = f.gsub 'haml', 'html'
      File.open(SITE_PATH + name, 'w') { |file| file.write(html) }
    end
  end
end

task :compile_sass do 
  source_path = Dir.pwd + '/_css/'
  out_path = SITE_PATH + 'css/'
  if !File.directory? out_path
    FileUtils.mkdir_p out_path
  end
  Dir.foreach(source_path) do |f|
    if f.end_with?('.scss')
      name = f.gsub 'scss', 'css'
      `sass #{source_path}#{f}:#{out_path}#{name} --style compressed`
    end
    if f.end_with?('.css')
      FileUtils.cp "#{source_path}#{f}", "#{out_path}#{f}"
    end
  end
end

task :compile_coffee do 
  source_path = Dir.pwd + '/_coffee/'
  out_path = SITE_PATH + 'js/'
  if !File.directory? out_path
    FileUtils.mkdir_p out_path
  end
  Dir.foreach(source_path) do |f|
    if f.end_with?('.coffee')
      `coffee --compile --output #{out_path} #{source_path}`
    end
    if f.end_with?('.js')
      FileUtils.cp "#{source_path}#{f}", "#{out_path}#{f}"
    end
  end
end

task :copy_assets do 
  source_path = Dir.pwd + '/_assets/'
  out_path = SITE_PATH + 'assets/'
  if !File.directory? out_path
    FileUtils.mkdir_p out_path
  end
  Dir.foreach(source_path) do |f|
    if !File.directory? source_path + f 
      FileUtils.cp "#{source_path}#{f}", "#{out_path}#{f}"
    end
  end
end

task :open do 
  `open file://localhost/#{SITE_PATH}/index.html`
end