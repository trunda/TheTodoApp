def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install libsqlite3-dev"
    run "#{sudo} wget http://blog.anantshri.info/content/uploads/2010/09/add-apt-repository.sh.txt -O /tmp/add-apt-repository.sh"
    run "#{sudo} mv /tmp/add-apt-repository.sh /usr/sbin/add-apt-repository"
    run "#{sudo} chmod o+x /usr/sbin/add-apt-repository"
    run "#{sudo} chown root:root /usr/sbin/add-apt-repository"
  end
end