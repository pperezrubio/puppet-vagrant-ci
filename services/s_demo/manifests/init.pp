class s_demo
{
    file { "/tmp/s_demo.txt" :
        source => "puppet:///modules/s_demo/s_demo.txt";
    }
}

