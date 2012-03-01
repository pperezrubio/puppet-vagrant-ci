# This file is under SCM control; do not edit in-place.
#
# "s_localrepo" manages our publications service for local packages
class s_localrepo inherits s_localrepo::params {
# A reprepro environment
	package { "reprepro": ensure => present }
	user { "reprepro":
		ensure     => present,
		comment    => "APT repository manager",
		shell      => "/bin/bash",
		managehome => true;
	}
	# global datadir
	file {
		"$reprepro_rootdir":
			ensure  => directory,
			owner   => "reprepro",
			require => User["reprepro"];
		"${reprepro_rootdir}/key.asc":
			ensure  => present,
			source  => "puppet:///modules/s_localrepo/reprepro/key.asc",
			require => File["${reprepro_rootdir}"];
	# a symlink to make things easier for the reprepro user
	# NOTE: I would prefer not to use an absolute path but something akin to '~reprepro', but puppet doesn't seem to offer such a functionality
		"/home/reprepro/deb-packages":
			ensure  => link,
			target  => "$reprepro_rootdir",
			require => [User["reprepro"],File["$reprepro_rootdir"]];
	}
	# TODO: The structure is the same for every managed distribution, so it could be managed by a parametrized class
	# debian
	file {
		["${reprepro_rootdir}/debian", "${reprepro_rootdir}/debian/conf"]:
			ensure  => directory,
			owner   => "reprepro",
			require => User["reprepro"];
		"${reprepro_rootdir}/debian/conf/distributions":
			ensure  => present,
			source  => "puppet:///modules/s_localrepo/reprepro/distributions.debian",
			require => File["${reprepro_rootdir}/debian/conf"];
	}
	# ubuntu
	file {
		["${reprepro_rootdir}/ubuntu", "${reprepro_rootdir}/ubuntu/conf"]:
			ensure  => directory,
			owner   => "reprepro",
			require => User["reprepro"];
		"${reprepro_rootdir}/ubuntu/conf/distributions":
			ensure  => present,
			source  => "puppet:///modules/s_localrepo/reprepro/distributions.ubuntu",
			require => File["${reprepro_rootdir}/ubuntu/conf"];
	}
	
# Apache content publishing
# TODO: it's not the first time we manage an apache enviro (see i.e. 's_intranet')
# it would be good to extract common functionality and refactor it into its own apache module
# (or have a look at some of the modules published in the Internet)
	package { ["apache2", "libapache2-mod-wsgi"]: ensure => present }
	file {
		"/etc/apache2/sites-enabled/${aptserver}.conf":
			ensure  => present,
			content => template("s_localrepo/apache/${aptserver}.conf.erb"),
			require => Package["apache2"],
			notify  => Service["apache2"];
		"/etc/apache2/sites-enabled/${pipserver}.conf":
			ensure  => present,
			content => template("s_localrepo/apache/${pipserver}.conf.erb"),
			require => Package["apache2", "libapache2-mod-wsgi"],
			notify  => [Exec["modrewrite"],Exec["modssl"],Service["apache2"]];
		"/etc/apache2/sites-enabled/000-default":
			ensure  => absent,
			require => File["/etc/apache2/sites-enabled/${aptserver}.conf", "/etc/apache2/sites-enabled/${pipserver}.conf"],
			notify  => Service["apache2"];
	}
	service { "apache2":
		ensure  => running,
		enable  => true,
		require => Package["apache2"];
	}
	# apache-related tools
	exec {
		"modrewrite":
			command     => "/usr/sbin/a2enmod rewrite",
			refreshonly => true;
		"modssl":
			command     => "/usr/sbin/a2enmod ssl",
			refreshonly => true;
	}
}
