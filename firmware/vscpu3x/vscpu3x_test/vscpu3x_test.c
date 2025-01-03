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
// #include <stub.c>

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

    uint32_t gpio_data;

    reg_spi_enable = 1;
    reg_wb_enable = 1;
	// reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

	// Connect the housekeeping SPI to the SPI master
	// so that the CSB line is not left floating.  This allows
	// all of the GPIO pins to be used for user functions.

    reg_mprj_io_8   = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_9   = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_10  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_11  = GPIO_MODE_USER_STD_INPUT_PULLUP;
    reg_mprj_io_12  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_13  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_14  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_15  = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_16  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_17  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_18  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_19  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_20  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_21  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_22  = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
    reg_mprj_io_23  = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
    reg_mprj_io_24  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_25  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_26  = GPIO_MODE_MGMT_STD_OUTPUT;
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
	reg_la0_data = 0x0000000B;
	
    while(1){
        // Read pins 37:36 and write them to pins 26:25 to debounce program pins
        gpio_data = (reg_mprj_datal & 0x00C00000) << 3; 
        gpio_data |= (gpio_data) ? 0x01000000 : 0x00000000;
        delay(5000000); // Wait for 500ms
        
        reg_mprj_datal |= gpio_data; 
        delay(5000000); // Wait for 500ms
    }
}
