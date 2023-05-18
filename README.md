# RaBe Universal Base Image 9 Minimal

The RaBe Universal Base Image 9 Minimal is a stripped down image that uses microdnf for package management.

The image is based on the [Red Hat Universal Base Image 9 Minimal](https://catalog.redhat.com/software/containers/ubi9/ubi-minimal/615bd9b4075b022acc111bf5)
container provided by Red Hat.

## Features

- Based on UBI9 minimal
- Uses microdnf as a package manager
- Establishes trust with the RaBe Root CA

## Usage

Create a downstream image from `ghcr.io/radiorabe/ubi9-minimal`. Replace `:latest` with a specific version in the example below.

```Dockerfile
FROM ghcr.io/radiorabe/ubi9-minimal:latest

RUN    microdnf install -y \
         shadow-utils \
    && microdnf clean all \
    && useradd -u 1001 -r -g 0 -s /sbin/nologin \
         -c "Default Application User" default \
    && microdnf remove -y \
         libsemanage \
         shadow-utils
         
USER 1001
```

Note that `libsemanage` is being removed because is was installed as a dependency of `shadow-utils`. We only need them for
the `useradd` command so the safe solution is to remove both packages after use.

## Downstream Base Images

None yet.

## Advanced Usage

If you need packages from EPEL (like `cowsay`) your have to download an `epel-release` package first:

```Dockerfile
RUN    curl -L -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    && rpm -ivh ./epel-release-*.noarch.rpm \
    && rm ./epel-release-*.noarch.rpm \
    && microdnf install -y \
         cowsay \
    && microdnf clean all
```

To account for [CIS-DI-0008](https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#cis-di-0008) you may want to
"defang" your image by running something similar to the following `chmod` after installing setuid/setgid binaries.

```Dockerfile
RUN    microdnf install -y \
         cowsay \
    && microdnf clean all \
    && chmod a-s \
         /usr/bin/* \
         /usr/sbin/* \
         /usr/libexec/*/*
```

## Release Management

The CI/CD setup uses semantic commit messages following the [conventional commits standard](https://www.conventionalcommits.org/en/v1.0.0/).
There is a GitHub Action in [.github/workflows/semantic-release.yaml](./.github/workflows/semantic-release.yaml)
that uses [go-semantic-commit](https://go-semantic-release.xyz/) to create new
releases.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit contains the following structural elements, to communicate intent to the consumers of your library:

1. **fix:** a commit of the type `fix` patches gets released with a PATCH version bump
1. **feat:** a commit of the type `feat` gets released as a MINOR version bump
1. **BREAKING CHANGE:** a commit that has a footer `BREAKING CHANGE:` gets released as a MAJOR version bump
1. types other than `fix:` and `feat:` are allowed and don't trigger a release

If a commit does not contain a conventional commit style message you can fix
it during the squash and merge operation on the PR.

## Build Process

The CI/CD setup uses the [Docker build-push Action](https://github.com/docker/build-push-action) to publish container images. This is managed in [.github/workflows/release.yaml](./.github/workflows/release.yaml).

## License

This application is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, version 3 of the License.

## Copyright

Copyright (c) 2022 [Radio Bern RaBe](http://www.rabe.ch)
