# I2Cdev2149 — I2C GPIO Expander Tape-Out (IHP SG13CMOS5L)

This repository contains the tape-out configuration for the open-source
[I2C GPIO Expander](https://github.com/aesc-silicon/i2c-gpio-expander) targeting the IHP SG13CMOS5L process.

## Overview

The I2C GPIO Expander is fully implemented in SpinalHDL and uses an entirely open-source
toolchain from RTL to GDSII. The design supports I2C Fast Mode (up to 400 kbit/s) and
provides 8 configurable GPIO pins with a 3-bit address select.

**Die area:** 1050.24 × 1050.84 µm
**Core area:** 351.36 × 699.84 µm
**Process:** IHP SG13CMOS5L

## Pin Description

| Side  | Pin               | Direction | Description              |
|-------|-------------------|-----------|--------------------------|
| South | `io_clock`        | Input     | System clock             |
| South | `io_reset`        | Input     | System reset             |
| South | `io_i2c_scl`      | I/O       | I2C clock (SCL)          |
| South | `io_i2c_sda`      | I/O       | I2C data (SDA)           |
| South | `io_i2c_interrupt`| Output    | Interrupt signal         |
| East  | `io_address_0`    | Input     | I2C address bit 0        |
| East  | `io_address_1`    | Input     | I2C address bit 1        |
| East  | `io_address_2`    | Input     | I2C address bit 2        |
| North | `io_gpio_3`       | I/O       | GPIO bit 3               |
| North | `io_gpio_4`       | I/O       | GPIO bit 4               |
| North | `io_gpio_5`       | I/O       | GPIO bit 5               |
| North | `io_gpio_6`       | I/O       | GPIO bit 6               |
| North | `io_gpio_7`       | I/O       | GPIO bit 7               |
| West  | `io_gpio_0`       | I/O       | GPIO bit 0               |
| West  | `io_gpio_1`       | I/O       | GPIO bit 1               |
| West  | `io_gpio_2`       | I/O       | GPIO bit 2               |
| East  | `VDD` / `VSS`     | Power     | Core power / ground      |
| West  | `IOVdd` / `IOVss` | Power     | I/O ring power / ground  |

## Register Map

| Register | Name      | Access | Description          |
|----------|-----------|--------|----------------------|
| 0x0      | Value     | R      | Returns IO value     |
| 0x1      | Write     | R/W    | Writes output value  |
| 0x2      | Direction | R/W    | Enables output value |

## Usage

Download the tape-out release:

```sh
git clone https://github.com/aesc-silicon/i2c-gpio-expander.git -b tapeout-ihp-sg13cmos5l-2026-03-r1
```

Install dependencies:

```sh
sudo apt install virtualenv curl podman
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
task install
```

Run the full RTL-to-GDSII tape-out flow (generates source code, GDSII layout, metal dummy fill, and DRCs):

```sh
task TECH=SG13CMOS5L
```

View the final chip in KLayout:

```sh
task TECH=SG13CMOS5L view-klayout
```

**Note:** On headless systems (e.g. SSH), prefix view commands with `IS_HEADLESS=true` to bypass the X-Server requirement.

## License

Copyright (c) 2026 aesc silicon. Released under the [CERN-OHL-W-2.0](https://ohwr.org/cern_ohl_w_v2.txt) license.
