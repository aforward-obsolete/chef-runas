# Overview #
Chef cookbook for the creating a default deployer user.

# How to add to your cookbook repository #

## Track upstream changes via git ##
I use git submodules for my chef repos so I can push/pull changes with minimal
hassle.

For more info, check out the [Pro Git](http://progit.org/book/ch6-6.html) book.

#### Add the monit repo ####

    $ cd YOUR_REPO_ROOT
    $ git submodule add https://github.com/aforward/chef-runas.git ./chef/cookbooks/runas


History
=======
version 0.1.0
-------------
 * first release
