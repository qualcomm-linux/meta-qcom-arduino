# meta-qcom-arduino

[![Build on push (main)](https://img.shields.io/github/actions/workflow/status/qualcomm-linux/meta-qcom-arduino/push.yml?label=Build%20on%20push%20(main))](https://github.com/qualcomm-linux/meta-qcom-arduino/actions/workflows/push.yml)
[![Nightly Build (main)](https://img.shields.io/github/actions/workflow/status/qualcomm-linux/meta-qcom-arduino/nightly-build.yml?label=Nightly%20Build%20(main))](https://github.com/qualcomm-linux/meta-qcom-arduino/actions/workflows/nightly-build.yml)

## Introduction

OpenEmbedded/Yocto Project BSP layer for [Arduino](https://www.arduino.cc/)
boards based on Qualcomm SoCs.

This layer provides the machine configuration files and the board-specific
recipes (bootloader, boot firmware, kernel and firmware packagegroups) for the
Qualcomm-based Arduino boards. It is maintained by Qualcomm and builds on top
of `meta-qcom`, the Qualcomm hardware enablement layer, which remains the home
for everything that is SoC-generic rather than board-specific.

This layer depends on:

```text
URI: https://github.com/openembedded/openembedded-core.git
layers: meta
branch: master
revision: HEAD

URI: https://github.com/qualcomm-linux/meta-qcom.git
branch: master
revision: HEAD
```

## Branches

- **main:** Primary development branch, with focus on upstream support and
  compatibility with the most recent Yocto Project release. LTS branches will
  be created alongside the corresponding `meta-qcom` branches when needed.

## Machine Support

| Machine | Board | SoC |
| --- | --- | --- |
| `uno-q` | [Arduino UNO Q](https://www.arduino.cc/product-uno-q) | QRB2210 (QCM2290) |
| `ventuno-q` | [Arduino VENTUNO Q](https://www.arduino.cc/product-ventuno-q/) | QCS8275 (QCS8300) |

See `conf/machine` for the complete list of supported devices.

## Quick build

The steps below use `kas-container`, which runs the build inside a container,
so the only host requirements are a container runtime (Docker or Podman) and
the `kas-container` wrapper script. For more details, visit the
[KAS documentation](https://kas.readthedocs.io/en/latest/index.html).

1. Get the `kas-container` script on your `PATH`
   (from [kas-container](https://github.com/siemens/kas/blob/master/kas-container)).

2. Clone the meta-qcom-arduino layer

    ```bash
    git clone https://github.com/qualcomm-linux/meta-qcom-arduino.git -b main
    ```

3. Build using the KAS configuration for one of the supported boards

    ```bash
    kas-container build meta-qcom-arduino/ci/uno-q.yml
    ```

   To build with the Qualcomm Linux distribution
   ([meta-qcom-distro](https://github.com/qualcomm-linux/meta-qcom-distro))
   instead of `nodistro`, append the distro fragment:

    ```bash
    kas-container build meta-qcom-arduino/ci/uno-q.yml:meta-qcom-arduino/ci/qcom-distro.yml
    ```

This reuses the same `ci/<machine>.yml` configurations that CI uses. See
[AGENTS.md](AGENTS.md) for more advanced usage, including sharing the
`DL_DIR`/`SSTATE_DIR` caches across builds and running the CI checks locally.

For flashing instructions, refer to the
[meta-qcom flashing documentation](https://github.com/qualcomm-linux/meta-qcom/blob/master/docs/flashing.md).

## Contributing

Please submit any patches against the `meta-qcom-arduino` layer (branch
**main**) by using the GitHub pull-request feature. Fork the repo, create a
branch, do the work, rebase from upstream, and create the pull request.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution workflow,
the layer rules and the commit subject and message requirements before
opening a pull request.

## Communication

- **GitHub Issues:** [meta-qcom-arduino issues](https://github.com/qualcomm-linux/meta-qcom-arduino/issues)
- **Pull Requests:** [meta-qcom-arduino pull requests](https://github.com/qualcomm-linux/meta-qcom-arduino/pulls)

## Maintainer(s)

- Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>

## License

This layer is licensed under the MIT license. Check out [COPYING.MIT](COPYING.MIT)
for more details.
