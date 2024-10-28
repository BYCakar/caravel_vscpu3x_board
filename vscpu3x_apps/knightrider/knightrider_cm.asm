// main
0:  ADD 0 0                                     // NOP
1:  CPi 8254 3                                  // gpio_out = 3

// loop
2:  CP 48 34                                    // counter = count_half_sec_val
3:  ADD 48 33                                   // counter -= 1
4:  BZJ 35 48                                   // branch update_gpio if counter == 0
5:  BZJi 32 3                                   // return to loop+1 if counter != 0

// update_gpio
6:  CP 50 49                                    // gpio_shift = dir
7:  MULi 50 32                                  // gpio_shift *= 32
8:  ADDi 50 1                                   // gpio_shift += 1
9:  SRL 8254 50                                 // (gpio_shift < 32) ? gpio_out >> gpio_shift : gpio_out << (gpio_shift - 32)
10: CPi 51 8                                    // update_gpio_temp1 = 8
11: CP 52 8254                                  // update_gpio_temp2 = gpio_out
12: LT 51 52                                    // update_gpio_temp1 = (8 < gpio_out) ? 1 : 0
13: BZJ 36 51                                   // if (update_gpio_temp1)
14: CPi 49 0                                    // dir = 0
15: CPi 51 4                                    // update_gpio_temp1 = 4
16: CP 52 8254                                  // update_gpio_temp2 = gpio_out
17: LT 52 51                                    // update_gpio_temp2 = (gpio_out < 4) ? 1 : 0
18: BZJ 37 52                                   // if (update_gpio_temp2)
19: CPi 49 1                                    // dir = 1
20: BZJi 32 2                                   // return to loop

// Constants
32: 0                                           // 0
33: 4294967295                                  // -1
34: 277778                                      // count_half_sec_val
35: 6                                           // update_gpio
36: 15                                          // update_gpio+9
37: 20                                          // update_gpio+14

// Variables
48: 0                                           // counter
49: 1                                           // dir
50: 1                                           // gpio_shift
51: 0                                           // update_gpio_temp1
52: 0                                           // update_gpio_temp2

