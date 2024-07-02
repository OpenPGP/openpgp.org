# openpgp.org

I encourage all visitors to participate in creating and improving content of this website to make it the new main source of information related to the OpenPGP standard.

We are open for pull requests!

# Notes on editing the site

## Modification timestamps

If you edit any page that contains an explicit `modified` header,
please remove it.  We are using
[`jekyll-last-modified-at`](https://github.com/gjtorikian/jekyll-last-modified-at)
which will use the modification time from git now.

# How to build the site locally (non-docker)

First, you'll need to install the Ruby dependencies.  Starting with
Ruby and Bundler (e.g. `apt install ruby bundler`), execute the
following commands in your checkout:

```sh
$ bundle config set --local path 'vendor/bundle'
$ bundle install
[...]
Bundle complete! 1 Gemfile dependency, 94 gems now installed.
[...]
```

Now, if you are running Ruby 3.0.0 or above, you'll need to also
install `webrick`.  This will modify `Gemfile` and `Gemfile.lock`,
please be careful not to check these in with your modifications:

```sh
$ ruby --version
ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux-gnu]
$ bundle add webrick
[...]
```

Finally, you can build and tweak the site:

```sh
$ bundle exec jekyll serve
[...]
 Auto-regeneration: enabled for '/home/teythoon/repos/pep/openpgp.org'
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
```

Go to http://127.0.0.1:4000 to see the site.  Jekyll will pick up
changes to most files (but notably not to the top-level configuration
file) and rebuild the site, but you'll still need to reload the site
in your web browser.

# How to build the site locally (docker)

```
docker build -t openpgpdotorg .
docker run -p 4000:4000 --rm openpgpdotorg
```

Note however that this will *not* auto-update when making changes to the local copy.
You will have to rebuild the docker container to pick up changes (but this should be fast).

Remember to periodically clean up stale/untagged docker images:

```
docker image list -f dangling=true -q | awk '{print $1}' | xargs docker rmi
```

# Licenses
* Theme: [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes) MIT License

# Image Licenses
All images are under Public Domain (CC0), except otherwise noted.

Sources:
* https://pixabay.com/en/castle-security-padlock-sure-metal-838353/
* https://pixabay.com/en/black-white-safe-chain-padlock-164164/
* https://pixabay.com/en/envelope-confidential-secret-264876/
* https://pixabay.com/en/mailbox-rome-newspaper-italy-post-1419789/
* https://pixabay.com/en/computer-accessories-monitor-336628/
* https://pixabay.com/en/buffer-china-administration-812510/
* https://pixabay.com/en/letter-stamp-wax-parchment-seal-735151/
* https://pixabay.com/en/workstation-office-business-336369/