
class Installer8502 < VagrantVbguest::Installers::Ubuntu
  def install(opts=nil, &block)
    super
    communicate.sudo('[ -d /opt/VBoxGuestAdditions-5.1.20 ] && ln -sf /opt/VBoxGuestAdditions-5.1.20/lib/VBoxGuestAdditions/mount.vboxsf /sbin/mount.vboxsf', nil, &block)
  end
end

