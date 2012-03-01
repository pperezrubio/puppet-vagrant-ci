import "localconfig.pp"

node "jenkins-master"
{ 
    file {"/tmp/hello.txt": 
        content => 'hello world - demo 1'
    }

    class { 's_demo' : }
}

node "jenkins-slave-01"
{ 
    file {"/tmp/hello.txt": 
        content => 'hello world - demo 2'
    }

    class { 's_demo' : }
}

# A multiprotocol repository for local packages
node "bvox-repo" 
{
	class { "s_localrepo": }
}