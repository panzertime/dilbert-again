# Overview
This is a PSGI Perl application, intended for use with [Starman](https://github.com/miyagawa/Starman) and `nginx`. 

# Dependencies
- Perl 5
- Starman
- Template
- Plack
- YAML::PP::LibYAML

Use a package manager to install Perl (if you don't have it) and any modules in your distro repository, and `cpanminus` for the rest.

# Deployment

Use e.g. `plackup -E production -s Starman --listen /tmp/dilbert.sock --workers=10 viewer.pl` to run the web application.

