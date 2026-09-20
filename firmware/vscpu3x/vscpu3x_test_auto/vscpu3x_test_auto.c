/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
// #include <stub.h>

/*
	Wishbone Test:
		- Configures MPRJ lower 8-IO pins as outputs
		- Checks counter value through the wishbone port
*/

void delay(const int d)
{

    /* Configure timer for a single-shot countdown */
	reg_timer0_config = 0;
	reg_timer0_data = d;
    reg_timer0_config = 1;

    // Loop, waiting for value to reach zero
   reg_timer0_update = 1;  // latch current value
   while (reg_timer0_value > 0) {
           reg_timer0_update = 1;
   }
}


static void led_init(void)
{
    reg_gpio_mode1 = 1;
    reg_gpio_mode0 = 0;
    reg_gpio_ien   = 1;
    reg_gpio_oe    = 1;

    reg_gpio_out = 1;   // LED OFF (active-low)
}

static void pll_24mhz(void)
{
    reg_hkspi_pll_bypass = 1;
    reg_hkspi_pll_ena = 0;

    /*
     * Internal FLL target:
     * 10 MHz * 12 = 120 MHz
     *
     * Output:
     * 120 MHz / 5 = 24 MHz
     */

    reg_hkspi_pll_source = 0x12;   // (5 << 3) | 5
    reg_hkspi_pll_divider = 5;    // x12 -> 120 MHz

    reg_hkspi_pll_trim = 0x3ffffff;

    reg_hkspi_pll_ena = 1;

    for (volatile unsigned int i = 0; i < 100000; i++);

    reg_hkspi_pll_bypass = 0;
}

void main()
{

	/* 
	IO Control Registers
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 3-bits | 1-bit | 1-bit | 1-bit  | 1-bit  | 1-bit | 1-bit   | 1-bit   | 1-bit | 1-bit | 1-bit   |
	Output: 0000_0110_0000_1110  (0x1808) = GPIO_MODE_USER_STD_OUTPUT
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 110    | 0     | 0     | 0      | 0      | 0     | 0       | 1       | 0     | 0     | 0       |
	
	 
	Input: 0000_0001_0000_1111 (0x0402) = GPIO_MODE_USER_STD_INPUT_NOPULL
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 001    | 0     | 0     | 0      | 0      | 0     | 0       | 0       | 0     | 1     | 0       |
	*/

	/* Set up the housekeeping SPI to be connected internally so	*/
	/* that external pin changes don't affect it.			*/

    // Led blink and pll configuration functions, unused by now
    // led_init();
    // pll_24mhz();

    uint32_t gpio_data;

    reg_spi_enable = 1;
    reg_wb_enable = 1;
	// reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

	// Connect the housekeeping SPI to the SPI master
	// so that the CSB line is not left floating.  This allows
	// all of the GPIO pins to be used for user functions.

    reg_mprj_io_5   = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
    reg_mprj_io_6   = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
    reg_mprj_io_7   = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
    reg_mprj_io_8   = GPIO_MODE_MGMT_STD_BIDIRECTIONAL;
    reg_mprj_io_9   = GPIO_MODE_MGMT_STD_BIDIRECTIONAL;
    reg_mprj_io_10  = GPIO_MODE_MGMT_STD_BIDIRECTIONAL;
    reg_mprj_io_11  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_12  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_13  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_14  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_15  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_16  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_17  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_18  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_19  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_20  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_21  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_22  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_23  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_24  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_25  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_26  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_27  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_28  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_29  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_30  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_31  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_32  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_33  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_34  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_35  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_36  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_37  = GPIO_MODE_USER_STD_OUTPUT;
    
     /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);
    
    // Configure LA probes [31:0] as outputs from the cpu
	reg_la0_oenb = reg_la0_iena = 0xFFFFFFFF;    // [31:0]
	
	// Set UART clock divisor value to 11 through LA probes (BaudRate: 57600)
	reg_la0_data = 11;

    // LED monitoring is not used by now
    // while(1){ // You can track internal clock speed on the board LED. One period of the led will be 100/CORE_CLOCK_MHZ seconds
    //     reg_gpio_out = 1; // OFF
    //     // reg_mprj_datal ^= 0x0F000000; 
    //     delay(50000000); // Wait for 50M cycles
    //     reg_gpio_out = 0; // OFF
    //     // reg_mprj_datal ^= 0x0F000000; 
    //     delay(50000000); // Wait for 50M cycles
    // }

    while (1){ // Synchronize program and reset bits
        gpio_data = (reg_mprj_datal & 0x000000E0) << 3; 
        reg_mprj_datal = gpio_data;
    }
	
    return;
}
