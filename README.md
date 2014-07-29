       Requirements:
An erlang installation 
rebar (https://github.com/rebar/rebar)
       
       Installing:
1) Install erlang
2) Clone this repo (git clone git@github.com:moxford/erskel.git)

    Generating:
    1) Run the gen.esc file (./gen.esc <app_name> <dir>)

    Building with make:
    1) Go to the target directory and type 'make' (you can compile or gen by itself, too)

    Building with rebar:
    1) Go to the target directory
    2) rebar get-deps compile
    3) cd rel
    4) rebar generate
    5) cd ..

    Running with make:
    1) make <start|stop|console>

    Otherwise:
    1) ./rel/<app>/bin/<app> <start|stop|console>

    Edit your web stuff in priv/web.  When you "generate" your applcation either through `rebar generate` or
    via `make` or `make gen` it builds eveything into a distribution and buries it down under rel/<app>/lib/<app>-<version>/

    The same goes for your src files; they get buried.  The erlang VM started by these commands will look into ebin/ for updated files (hotloading of modules.)  The priv stuff is an extra, more dangerous step ...

    *** WARNING ***
    If you delete your rel/ while linked IT WILL FOLLOW SYMLINKS AND YOU WILL NUKE YOUR REAL CODEBASE.  Make sure you're backed up to a remote repository if you go this route!

    You can use "make devlink" to symlink your buried priv/ directory so that when you edit priv then it's available immediately for use.
    You can use "make unlink" to remove those symlinks.

    If you delete your rel/ while linked IT WILL FOLLOW SYMLINKS AND YOU WILL NUKE YOUR REAL CODEBASE.  Make sure you're backed up to a remote repository if you go this route!
    *** WARNING ***

    Other versions of the above:
    1)  Edit in priv, re-generate, restart.  By far the slowest and by far the safest.
    2)  Edit the buried version to make it available immediately.  Risky if you forget to update priv/ in your SCM - skews your development environment away from anything the SCM knows about because rel/ is not usually checked in.

    I devlink and push stuff to github.  Even if I nuke everything I have backups.  I might lose a little work but for web-work the devlink (for me) is the fastest and easiest way to go. 
    
