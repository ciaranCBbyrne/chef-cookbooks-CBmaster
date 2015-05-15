name             'CBmaster'
maintainer       'Ciaran Byrne'
maintainer_email 'x12120502@student.ncirl.ie'
license          'All rights reserved'
description      'Installs/Configures master server to manage and launch slaves automatically'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'mysql','~>6.0'
depends 'apache2'
depends 'php'
depends 'iptables'
depends 'selinux'
depends 'minitest-handler'