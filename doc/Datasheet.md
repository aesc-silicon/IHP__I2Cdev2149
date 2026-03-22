# I2C GPIO Expander

**aesc silicon** | License: CERN-OHL-W-2.0

## Miscellaneous

The entire chip core is a synchronous design operating at 50 MHz. This clock must be supplied via an external oscillator connected to the clock pin. The design also requires an active-low reset signal, which must be externally provided. It is recommended to hold the reset signal low for at least 1 µs until the core voltage stabilizes. This ensures proper initialization of all registers and correct latching of the external address.

## Communication

The chip features an I2C interface for receiving and handling transmissions from an external I2C controller. Additionally, it includes an interrupt pin to notify the controller of any pending interrupts on one of the GPIO pins.

This device supports `I2C Fast Mode`, enabling communication speeds of up to 400 kbit/s.

### Device Address

The 7-bit I2C device address is composed of a fixed upper 4 bits and 3 configurable lower bits set by the `io_address` pins at reset:

| Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2        | Bit 1        | Bit 0        |
|-------|-------|-------|-------|--------------|--------------|--------------|
| 0     | 1     | 1     | 0     | io_address_2 | io_address_1 | io_address_0 |

### Write Transaction

A write transaction sets a register value. The master sends a START condition, the device address with the R/W bit low, the target register address, and the data byte, each acknowledged by the device.

```
Master: S | ADDR + W | ·   | REG  | ·   | DATA | ·   | P
Device: · | ·        | ACK | ·    | ACK | ·    | ACK | ·
```

| Step | Sender | Description                        |
|------|--------|------------------------------------|
| S    | Master | START condition                    |
| ADDR | Master | 7-bit device address + W bit (0)   |
| ACK  | Device | Acknowledge                        |
| REG  | Master | 8-bit register address (0x0–0x2)   |
| ACK  | Device | Acknowledge                        |
| DATA | Master | 8-bit data to write                |
| ACK  | Device | Acknowledge                        |
| P    | Master | STOP condition                     |

### Read Transaction

A read transaction first writes the target register address, then restarts and reads back the value. The master sends a NAK after the data byte to signal it does not require further data.

```
Master: S | ADDR + W | ·   | REG  | ·   | P | Sr | ADDR + R | ·   | ·    | NAK | P
Device: · | ·        | ACK | ·    | ACK | · | ·  | ·        | ACK | DATA | ·   | ·
```

| Step | Sender | Description                        |
|------|--------|------------------------------------|
| S    | Master | START condition                    |
| ADDR | Master | 7-bit device address + W bit (0)   |
| ACK  | Device | Acknowledge                        |
| REG  | Master | 8-bit register address (0x0–0x2)   |
| ACK  | Device | Acknowledge                        |
| P    | Master | STOP condition                     |
| Sr   | Master | Repeated START condition           |
| ADDR | Master | 7-bit device address + R bit (1)   |
| ACK  | Device | Acknowledge                        |
| DATA | Device | 8-bit register value               |
| NAK  | Master | No acknowledge (end of read)       |
| P    | Master | STOP condition                     |

## GPIO

The device is equipped with 8 General Purpose Input/Output (GPIO) pins, configurable through the I2C interface.

| Register | Name      | Access | Description          |
|----------|-----------|--------|----------------------|
| 0x0      | Value     | R      | Returns IO value     |
| 0x1      | Write     | R/W    | Writes output value  |
| 0x2      | Direction | R/W    | Enables output value |

> **Note:** The interrupt registers are currently missing and will be added later.

## Chip Pin-Out

The table that follows provides a detailed explanation of each I/O pin's function.

| Pin | Position | Name              | IO  | Function                                          |
|-----|----------|-------------------|-----|---------------------------------------------------|
| 1   | East     | io_address_2      | I   | I2C Device address bit 2.                         |
| 2   | East     | io_address_1      | I   | I2C Device address bit 1.                         |
| 3   | East     | io_address_0      | I   | I2C Device address bit 0.                         |
| 4   | East     | VSS               |     | Ground                                            |
| 5   | East     | VDD               |     | 1.2V                                              |
| 6   | South    | io_i2c_interrupt  | O   | I2C interrupt to external controller.             |
| 7   | South    | io_i2c_sda        | IO  | I2C Open-Drain SDA signal. Requires external pull-ups. |
| 8   | South    | io_i2c_scl        | IO  | I2C Open-Drain SCL signal. Requires external pull-ups. |
| 9   | South    | io_reset          | I   | Active-low reset signal.                          |
| 10  | South    | io_clock          | I   | 50 MHz input clock.                               |
| 11  | West     | IOVDD             |     | 3.3V                                              |
| 12  | West     | IOVSS             |     | Ground                                            |
| 13  | West     | io_gpio_0         | IO  | GPIO Pin 0                                        |
| 14  | West     | io_gpio_1         | IO  | GPIO Pin 1                                        |
| 15  | West     | io_gpio_2         | IO  | GPIO Pin 2                                        |
| 16  | North    | io_gpio_3         | IO  | GPIO Pin 3                                        |
| 17  | North    | io_gpio_4         | IO  | GPIO Pin 4                                        |
| 18  | North    | io_gpio_5         | IO  | GPIO Pin 5                                        |
| 19  | North    | io_gpio_6         | IO  | GPIO Pin 6                                        |
| 20  | North    | io_gpio_7         | IO  | GPIO Pin 7                                        |
