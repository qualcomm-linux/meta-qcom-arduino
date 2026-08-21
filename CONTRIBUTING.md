# Contributing to meta-qcom-arduino

Thank you for your interest in contributing to the Yocto BSP layer for the
Arduino boards based on Qualcomm SoCs.

This layer follows the same conventions as the Yocto Project, OpenEmbedded
and the other Qualcomm Linux layers. For some useful guidelines when
submitting patches, please refer to:
[Preparing Changes for Submission](https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html#preparing-changes-for-submission)

Pull requests will be discussed within the GitHub pull-request infrastructure.

## Branching strategy

Contributors should develop on branches based off of `main` and pull
requests should be made against `main`.

## Submitting a pull request

1. Please read our [code of conduct](CODE-OF-CONDUCT.md) and
   [license](COPYING.MIT).
1. [Fork](https://github.com/qualcomm-linux/meta-qcom-arduino/fork) and clone
   the repository.

    ```bash
    git clone https://github.com/<username>/meta-qcom-arduino.git
    ```

1. Create a new branch based on `main`:

    ```bash
    git checkout -b <my-branch-name> main
    ```

1. Create an upstream `remote` to make it easier to keep your branches
   up-to-date:

    ```bash
    git remote add upstream https://github.com/qualcomm-linux/meta-qcom-arduino.git
    ```

1. Make your changes, build them and verify them on the target board.
1. Commit your changes using the [DCO](https://developercertificate.org/),
   following the commit message rules below:

    ```bash
    git commit -s
    ```

1. Run the CI checks locally (see [Validating changes](#validating-changes)).
1. After committing your changes on the topic branch, sync it with the
   upstream branch:

    ```bash
    git pull --rebase upstream main
    ```

1. Push to your fork and
   [submit a pull request](https://github.com/qualcomm-linux/meta-qcom-arduino/pulls)
   from your branch to `main`.
1. Address review feedback by amending the commits and force-pushing the
   branch; use draft mode for work-in-progress patches.

## Layer rules

### Scope of changes

- Limit changes to **BSP-specific content**: machine configuration, kernel,
  bootloader, firmware, device tree, drivers and partition configurations.
- Distribution-specific logic does not belong here. Use `nodistro` or
  [`meta-qcom-distro`](https://github.com/qualcomm-linux/meta-qcom-distro)
  for testing, and keep distro integration in the distro layer.
- SoC-generic behavior must go upstream to
  [`meta-qcom`](https://github.com/qualcomm-linux/meta-qcom) rather than be
  carried under a machine-specific path in this layer.
- Changes targeting `oe-core` or `meta-openembedded` should be sent directly
  upstream.

### No recipe forks

- Forks of recipes from `meta-qcom` or the base OE / Yocto layers are **not
  accepted**. Use `.bbappend` files for board-specific patching and keep the
  upstream recipes authoritative.
- Board-specific recipes that have no upstream counterpart (e.g. a
  bootloader tree or a kernel tree tracked by Arduino) must restrict their
  applicability with `COMPATIBLE_MACHINE`.

### Machine-specific isolation

- Use **machine overrides** (`:machine` or `:append:machine`) to confine
  board-specific logic. A change for one board must not alter the build of
  another board in this layer.
- Do not introduce SoC-generic behavior under a machine-specific path.

### Binaries and firmware

- Do **not** commit binaries. Closed-source components (boot firmware, DSP
  binaries) must be fetched via `SRC_URI` from a public, no-login mirror such
  as `downloads.arduino.cc`, with a clear `SUMMARY` and `LICENSE`.
- Custom firmware must be contributed to
  [`linux-firmware`](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/)
  whenever possible.

### Kernel enablement

- Align with `linux-qcom-next` from `meta-qcom`. Kernel patches should be
  **submitted upstream to the Linux kernel** first; temporary backports or
  in-flight patches are acceptable if tracked with a proper `Upstream-Status`.
- Board-specific `Kconfig` options go in a `configs/<board>.cfg` fragment
  merged on top of the upstream `defconfig`.

## Adding a new board

When adding a new machine, ensure the following files are present:

| File | Purpose |
| --- | --- |
| `conf/machine/<machine>.conf` | Machine definition, including the SoC `require` from `meta-qcom` |
| `recipes-bsp/packagegroups/packagegroup-<machine>.bb` | Firmware and Hexagon DSP binaries packagegroup |
| `recipes-bsp/firmware-boot/firmware-qcom-boot-<soc>-<board>_<ver>.bb` | Boot firmware recipe (when not provided by `meta-qcom`) |
| `recipes-kernel/linux/linux-<vendor>_<ver>.bb` or `.bbappend` | Kernel recipe or revision override with `COMPATIBLE_MACHINE` / machine overrides |
| `ci/<machine>.yml` | KAS machine fragment extending `ci/base.yml` |
| Entry in `.github/workflows/build-yocto.yml` matrix | CI build registration |
| Entry in `.github/workflows/test.yml` `devices` lists | LAVA boot test registration, once the board has a device in the lab and a device template in [lava-test-plans](https://github.com/qualcomm-linux/lava-test-plans) |

Take `uno-q` (Arduino UNO Q) as the reference example for a board that needs
its own bootloader and kernel recipes, and `ventuno-q` (Arduino VENTUNO Q)
for a board that reuses the `meta-qcom` recipes through appends.

## Validating changes

Before opening or updating a pull request, run the CI-equivalent checks
locally with `kas-container` (see [AGENTS.md](AGENTS.md) for the environment
setup):

```sh
ci/kas-container-shell-helper.sh ci/yocto-patchreview.sh
ci/kas-container-shell-helper.sh ci/yocto-check-layer.sh
```

Build the affected machine(s) and verify the image boots on hardware. Every
pull request is built for all machines in the layer and boot tested on the
boards available in the LAVA lab.

## Commit messages

Each commit must be atomic: it must contain exactly one logical change. Do not
squash multiple features, fixes, or otherwise unrelated changes into a single
commit — split them into separate commits, one per logical change. Each patch
must be logically coherent, self-contained, and independently buildable, and
the tree must remain in a functional state after every commit.

Each commit must contain a well-formed commit subject and message.

The commit subject must follow the form `recipe-name: summary of the changes`,
where `recipe-name` identifies the recipe or component being touched and the
summary concisely describes the change. Keep the subject short and specific,
capturing intent rather than a file-by-file dump. For example:

- `conf: add machine configuration for Arduino UNO Q`
- `linux-arduino: enable the ST7701 panel driver`
- `ci: add ventuno-q.yml kas fragment`

Use consistent wording for version upgrades, e.g.
`recipe-name: upgrade vX.Y.Z -> vA.B.C`.

The commit message (the body) must:

- be written in plain English;
- first describe the issue or the problem that is being solved, so that a
  reader can understand *why* the change is needed;
- then use the imperative mood (e.g. "add", "drop", "enable", "update")
  to describe the actions to be performed in order to solve the problem;
- not merely restate *what* the diff changes line by line — the diff
  already shows that;
- avoid unnecessary bullet lists; prefer prose paragraphs;
- wrap body lines for readability (~72 chars).

## Sign-off and trailers

Every commit must also carry a `Signed-off-by` trailer matching the
author identity from your local `git config` (use `git commit -s`). Never
fabricate a name or email; always read them from `git config`.

If an AI coding assistant or other advanced tool was used to help create the
change, acknowledge that use by adding an `Assisted-by` trailer in the form:

```text
Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
```

Where `AGENT_NAME` is the name of the AI tool or framework, `MODEL_VERSION` is
the specific model version used, and `[TOOL1] [TOOL2]` are optional specialized
analysis tools. Basic development tools (git, gcc, make, editors) should not be
listed. For example:

```text
Assisted-by: ExampleAgent:example-model-1.0
```
