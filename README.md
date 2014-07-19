# Setup Enviroment

``` bash
# Install Globals
npm install -g coffee-script pm2 pm2-web

# Activate Submodules
git submodule init
git submodule update

# Install NPM Libraries
npm install

# Configure PM2
pm2 start config.json
```

# Contributing

* In your forked repository, create a topic branch for your upcoming patch. (e.g. `feature--autoplay` or `bugfix--ios-crash`)
	* Usually this is based on the master branch.
	* Create a branch based on master; `git branch
	fix/master/my_contribution master` then checkout the new branch with `git
	checkout fix/master/my_contribution`.  Please avoid working directly on the `master` branch.
* Make sure you stick to the coding style that is used already.
* Make commits of logical units and describe them properly.
* Syntax:
    * 3 spaces, no tabs.
    * No trailing whitespace. Blank lines should not have any space.
    * a = b and not a=b.
    * Follow the conventions you see used in the source already.
