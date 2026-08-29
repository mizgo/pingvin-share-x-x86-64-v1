# Pingvin Share X — x86-64-v1

Unofficial community build of [Pingvin Share X](https://github.com/smp46/pingvin-share-x) for systems with x86-64-v1 CPU support.

## Why?

Starting with Pingvin Share X v1.21.2, Docker images use a prebuilt `sharp 0.35.3` binary. Its official Linux x64 prebuilt runtime requires the x86-64-v2 microarchitecture. This prevents the official Docker image from running on older x86-64 CPUs that only support the x86-64-v1 baseline.

This project rebuilds the native `sharp` component from source with an x86-64-v1 baseline, allowing newer Pingvin Share X releases to run on older x86-64 systems without changing the application source code.

## Upstream

This project builds directly from releases of:

https://github.com/smp46/pingvin-share-x

The Pingvin Share X source code is not maintained in this repository. The build process downloads the upstream release and applies the compatibility patch during the Docker build.

This is an **unofficial community project** and is not affiliated with or endorsed by the Pingvin Share X maintainers.

## Compatibility

The resulting Docker image targets the **x86-64-v1 baseline**.

It is intended for older x86-64 CPUs that do not support x86-64-v2.

## How it works

```text
Pingvin Share X release
        ↓
download upstream source
        ↓
apply x86-64-v1 compatibility patch
        ↓
rebuild sharp from source
        ↓
build Docker image
```

## Status

Currently validated with Pingvin Share X `v1.22.1` on an Intel Core 2 Quad Q9550.

## License

Pingvin Share X is licensed under the BSD 2-Clause License.

See the upstream license:

https://github.com/smp46/pingvin-share-x/blob/main/LICENSE
