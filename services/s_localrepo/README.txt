Under files/reprepro the files 'reprepro-gpg-*.key' are stored so it's easier to
redeploy the development environment without having to change declarations bound to a
specific GPG key.

In the production environment they should be deleted and they will have to be under scrow by some different means.
The files 'key.asc' and 'bvox-reprepro.gpp' need to be substituted by the production equivalents too.

For backup/restore procedures, see http://linux.koolsolutions.com/2009/04/01/gpgpgp-part-5-backing-up-restoring-revoking-and-deleting-your-gpgpgp-keys-in-debian/
