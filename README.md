# wirbelsturm-rpm-storm

Builds an RPM based on an official [Apache Storm](http://storm.incubator.apache.org/) binary release, using
[fpm](https://github.com/jordansissel/fpm).

Unfortunately the official Storm project does not release ready-to-use RPM packages.  The RPM
script in this repository closes that gap.

The RPM created with this code is used by [Wirbelsturm](https://github.com/miguno/wirbelsturm).

---

Table of Contents

* <a href="#bootstrap">Bootstrapping</a>
* <a href="#supported-os">Supported target operating systems</a>
* <a href="#usage">Usage</a>
    * <a href="#build">Building the RPM</a>
    * <a href="#verify">Verifying the RPM</a>
    * <a href="#configuration">Custom configuration</a>
* <a href="#contributing">Contributing</a>
* <a href="#license">License</a>

---

<a name="bootstrap"></a>

# Bootstrapping

After a fresh checkout of this git repo you should first bootstrap the code.

    $ ./bootstrap

Basically, the bootstrapping will ensure that you have a suitable [fpm](https://github.com/jordansissel/fpm) setup.
If you already have `fpm` installed and configured you may try skipping the bootstrapping step.


<a name="supported-os"></a>

# Supported operating systems

## OS of the build server

It is recommended to run the RPM script [storm-rpm.sh](storm-rpm.sh) on a RHEL OS family machine.


## Target operating systems

The RPM files are built for the following operating system and architecture:

* RHEL 6 OS family (e.g. RHEL 6, CentOS 6, Amazon Linux), 64 bit


<a name="usage"></a>

# Usage


<a name="build"></a>

## Building the RPM

Syntax:

    $ ./storm-rpm.sh <storm-zipball-download-url>

To find a direct download URL visit the [Storm downloads](http://storm.incubator.apache.org/downloads.html) page and
click on the link to a Storm binary release.  Note: Don't use the (mirror) link on the download page because that link
will first take you to one of the Apache mirror sites.  Use one of the mirrors' direct links.

Example:

    $ ./storm-rpm.sh http://www.eu.apache.org/dist/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.zip

    >>> Will create storm-0.9.1_incubating.el6.x86_64.rpm

This will create an RPM that will package all Storm files and directories under the directory path `/opt/storm/`.


<a name="verify"></a>

## Verify the RPM

You can verify the proper creation of the RPM file with:

    $ rpm -qpi storm-*.rpm    # show package info
    $ rpm -qpR storm-*.rpm    # show package dependencies
    $ rpm -qpl storm-*.rpm    # show contents of package


<a name="configuration"></a>

## Custom configuration

You can modify [storm-rpm.sh](storm-rpm.sh) directly to modify the way the RPM is packaged.  For instance, you can
change the root level directory to something other than `/opt/storm/`, or modify the name of the package maintainer.


<a name="contributing"></a>

# Contributing to wirbelsturm-rpm-storm

Code contributions, bug reports, feature requests etc. are all welcome.

If you are new to GitHub please read [Contributing to a project](https://help.github.com/articles/fork-a-repo) for how
to send patches and pull requests to wirbelsturm-rpm-storm.


<a name="license"></a>

# License

Copyright © 2014 Michael G. Noll

See [LICENSE](LICENSE) for licensing information.
