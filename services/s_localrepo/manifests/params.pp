# This file is under SCM control; do not edit in-place.
#
# "s_localrepo::params" sets configurable values for the localrepo classes
class s_localrepo::params (
# chishop-related
	$pipserver = "pip.${basedomain}",
	$chishop_rootdir  = "/var/lib/chishop--pypi-server",
	
# reprepro-related
	$aptserver = "apt.${basedomain}",
	$reprepro_rootdir = "/var/lib/deb-packages"
) {}
