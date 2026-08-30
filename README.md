<div align="center">
  <img src="https://raw.githubusercontent.com/mizgo/pingvin-share-x-x86-64-v1/main/unraid/icon.png" width="80"/>

  <h1>Pingvin Share X — x86-64-v1</h1>

  <p align="center">

[![Build](https://img.shields.io/github/actions/workflow/status/mizgo/pingvin-share-x-x86-64-v1/build.yml?style=for-the-badge&label=build)](https://github.com/mizgo/pingvin-share-x-x86-64-v1/actions/workflows/build.yml)
[![Latest processed](https://img.shields.io/github/v/tag/mizgo/pingvin-share-x-x86-64-v1?filter=v%2A&sort=semver&label=latest%20processed&style=for-the-badge)](https://github.com/mizgo/pingvin-share-x-x86-64-v1/tags)
[![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fghcr-badge.elias.eu.org%2Fapi%2Fmizgo%2Fpingvin-share-x-x86-64-v1%2Fpingvin-share-x-x86-64-v1&style=for-the-badge&label=Docker%20Pulls)](https://github.com/mizgo/pingvin-share-x-x86-64-v1/pkgs/container/pingvin-share-x-x86-64-v1)
  </p>
</div>

Unofficial community build of [Pingvin Share X](https://github.com/smp46/pingvin-share-x) for systems with **x86-64-v1** CPU support.

## Why?

Starting with Pingvin Share X `v1.21.2`, the Docker image uses a prebuilt `sharp 0.35.3` binary. Its official Linux x64 prebuilt runtime requires the **x86-64-v2** microarchitecture, which prevents the official Docker image from running on older x86-64 CPUs that only support the x86-64-v1 baseline.

Pingvin Share X `v1.21.1` still works on these older CPUs, while newer releases require a different `sharp` build.

This project rebuilds the native `sharp` component from source with an **x86-64-v1 baseline**, allowing newer Pingvin Share X releases to run on older x86-64 systems without changing the application source code.

## Upstream

This project builds directly from releases of:

https://github.com/smp46/pingvin-share-x

The Pingvin Share X source code is **not maintained in this repository**. The build process downloads the upstream release and applies the x86-64-v1 compatibility patch before building the Docker image.

This is an **unofficial community project** maintained by [mizgo](https://github.com/mizgo). It is not affiliated with or endorsed by the Pingvin Share X maintainers.

## Compatibility

The resulting Docker image targets the **x86-64-v1 baseline**.

It is intended for older x86-64 CPUs that do not support x86-64-v2.

The build has been validated on an **Intel Core 2 Quad Q9550**.

## Docker image

The published image is available from GitHub Container Registry:

```text
ghcr.io/mizgo/pingvin-share-x-x86-64-v1:latest
```

Versioned images are also retained:

```text
ghcr.io/mizgo/pingvin-share-x-x86-64-v1:v1.22.1
```

The `latest` tag points to the most recent upstream **stable release** that successfully passes the build and runtime tests.

## Unraid

An Unraid Docker template is included in this repository:

```text
unraid/my-mizgo-Pingvin-Share-X.xml
```

The template uses the `latest` image tag and includes the WebUI button, application-data mappings, and Pingvin Share X icon.

The default Docker network in the template is `bridge`. Users can select their own network, such as `proxynet`, when installing the container.

## How it works

```text
Pingvin Share X stable release
            ↓
      download source
            ↓
 apply x86-64-v1 patch
            ↓
     rebuild sharp
            ↓
       Docker build
            ↓
       runtime tests
            ↓
      publish to GHCR
            ↓
       update latest
```

The `latest` tag is updated **only after the image passes the build and runtime tests**.

## Automated updates

GitHub Actions checks the upstream Pingvin Share X repository once per day for a new stable release.

If the upstream version is already present in GHCR, no build is performed.

If a new stable release is found:

```text
new release
    ↓
build
    ↓
health check
    ↓
sharp runtime test
    ↓
publish version tag
publish latest
```

Prereleases such as beta and release-candidate versions are not selected by the release detection process.

## Status

Currently validated with Pingvin Share X `v1.22.1` on an Intel Core 2 Quad Q9550.

## License

### This project

The original build scripts, compatibility patch, GitHub Actions
workflows, and Unraid template in this repository are licensed under
the BSD 2-Clause License.

### Pingvin Share X

Pingvin Share X is a separate upstream project licensed under the
BSD 2-Clause License by its respective copyright holders.

See the upstream license:

https://github.com/smp46/pingvin-share-x/blob/main/LICENSE