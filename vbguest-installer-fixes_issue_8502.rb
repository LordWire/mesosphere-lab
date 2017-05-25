
class Installer8502 < VagrantVbguest::Installers::Ubuntu
  def install(opts=nil, &block)
    super
    cmd =   'if [ ! -e /sbin/mount.vboxsf ]; then'\
	    '  v=$(/usr/bin/VBoxControl -V | cut -d"r" -f1);'\
	    '  ln -sf /opt/VBoxGuestAdditions-${v}/lib/VBoxGuestAdditions/mount.vboxsf /sbin/mount.vboxsf;'\
	    'fi'
    communicate.sudo(cmd, nil, &block)
  end
end

