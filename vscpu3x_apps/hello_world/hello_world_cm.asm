0: BZJi 3 20 // Goto init
//$REGISTERS_SECTION
1: 0 // SP (unused - stackless, no expression spills)
2: 0 // BP (unused - stackless calling convention)
3: 0 // CONST_ZERO
4: 1 // CONST_ONE
5: 0 // CONST_NEG_ONE (computed)
6: 0 // reserved
7: 0 // reserved
8: 0 // reserved
9: 0 // reserved
10: 0 // reserved
11: 0 // reserved
12: 0 // reserved
13: 0 // reserved
14: 0 // TEMP1
15: 0 // TEMP2
16: 0 // TEMP3
17: 0 // TEMP4
18: 0 // TEMP5
19: 0 // TEMP6
//$TEXT_SECTION
20: NAND 5 3 // CONST_NEG_ONE = ~(0&0)
21: CPi 18 178 // $RA.main addr
22: CPi 15 162 // HALT addr
23: CPIi 18 15 // RA.main = HALT
24: BZJi 3 119 // Goto main
25: CPi 14 8452 // 8452
26: CP 18 14
27: CPI 14 18 // deref
28: CPIi 1 14 // push lhs
29: ADDi 1 1 // SP++
30: CP 14 3 // 0
31: CP 15 14 // rhs
32: ADD 1 5 // SP--
33: CPI 14 1 // pop lhs
34: CP 16 15 // sub
35: NAND 16 16 // ~
36: ADDi 16 1 // -src
37: ADD 14 16 // a-b
38: CPi 18 43 // ne? (P)
39: BZJ 18 14 // ne?
40: CP 14 5 // ne->-1
41: CPi 18 44 // ne end (P)
42: BZJi 18 0 // ne end
43: CPi 14 0 // eq->0
44: CPi 18 48 // wh exit (P)
45: BZJ 18 14 // wh exit
46: CPi 18 25 // wh loop
47: BZJi 18 0 // loop
48: CPi 18 179 // $slot.uart_putc.0
49: CPI 14 18 // $slot.uart_putc.0
50: CPIi 1 14 // push val
51: ADDi 1 1 // SP++
52: CPi 14 8451 // 8451
53: CP 18 14 // addr
54: ADD 1 5 // SP--
55: CPI 14 1 // pop val
56: CPIi 18 14 // *=
57: CP 14 4 // 1
58: CPIi 1 14 // push val
59: ADDi 1 1 // SP++
60: CPi 14 8452 // 8452
61: CP 18 14 // addr
62: ADD 1 5 // SP--
63: CPI 14 1 // pop val
64: CPIi 18 14 // *=
65: CP 14 3 // ret 0
66: CPi 18 176 // $RA.uart_putc
67: CPI 15 18 // load RA
68: BZJi 15 0 // return
69: CPi 18 180 // $slot.uart_puts.0
70: CPI 14 18 // $slot.uart_puts.0
71: CP 18 14
72: CPI 14 18 // deref
73: CPIi 1 14 // push lhs
74: ADDi 1 1 // SP++
75: CPi 14 0 // chr
76: CP 15 14 // rhs
77: ADD 1 5 // SP--
78: CPI 14 1 // pop lhs
79: CP 16 15 // sub
80: NAND 16 16 // ~
81: ADDi 16 1 // -src
82: ADD 14 16 // a-b
83: CPi 18 88 // ne? (P)
84: BZJ 18 14 // ne?
85: CP 14 5 // ne->-1
86: CPi 18 89 // ne end (P)
87: BZJi 18 0 // ne end
88: CPi 14 0 // eq->0
89: CPi 18 115 // wh exit (P)
90: BZJ 18 14 // wh exit
91: CPi 18 180 // $slot.uart_puts.0
92: CPI 14 18 // $slot.uart_puts.0
93: CP 18 14
94: CPI 14 18 // deref
95: CPIi 1 14 // push arg
96: ADDi 1 1 // SP++
97: ADD 1 5 // SP--
98: CPI 14 1 // pop arg
99: CPi 18 179 // $slot.uart_putc.0
100: CPIi 18 14 // st param
101: CPi 18 176 // $RA.uart_putc
102: CPi 15 106 // retPC
103: CPIi 18 15 // st RA
104: CPi 18 25 // uart_putc
105: BZJi 18 0 // uart_putc
106: CPi 18 180 // $slot.uart_puts.0
107: CPI 14 18 // $slot.uart_puts.0
108: CP 15 14 // old
109: ADDi 14 1 // ++
110: CPi 18 180 // $slot.uart_puts.0
111: CPIi 18 14 // $slot.uart_puts.0
112: CP 14 15 // old
113: CPi 18 69 // wh loop
114: BZJi 18 0 // loop
115: CP 14 3 // ret 0
116: CPi 18 177 // $RA.uart_puts
117: CPI 15 18 // load RA
118: BZJi 15 0 // return
119: CPi 14 163 // str(P)
120: CPIi 1 14 // push arg
121: ADDi 1 1 // SP++
122: ADD 1 5 // SP--
123: CPI 14 1 // pop arg
124: CPi 18 180 // $slot.uart_puts.0
125: CPIi 18 14 // st param
126: CPi 18 177 // $RA.uart_puts
127: CPi 15 131 // retPC
128: CPIi 18 15 // st RA
129: CPi 18 69 // uart_puts
130: BZJi 18 0 // uart_puts
131: CPi 14 8452 // 8452
132: CP 18 14
133: CPI 14 18 // deref
134: CPIi 1 14 // push lhs
135: ADDi 1 1 // SP++
136: CP 14 3 // 0
137: CP 15 14 // rhs
138: ADD 1 5 // SP--
139: CPI 14 1 // pop lhs
140: CP 16 15 // sub
141: NAND 16 16 // ~
142: ADDi 16 1 // -src
143: ADD 14 16 // a-b
144: CPi 18 149 // ne? (P)
145: BZJ 18 14 // ne?
146: CP 14 5 // ne->-1
147: CPi 18 150 // ne end (P)
148: BZJi 18 0 // ne end
149: CPi 14 0 // eq->0
150: CPi 18 154 // wh exit (P)
151: BZJ 18 14 // wh exit
152: CPi 18 131 // wh loop
153: BZJi 18 0 // loop
154: CP 14 3 // 0
155: CPi 18 178 // $RA.main
156: CPI 15 18 // load RA
157: BZJi 15 0 // return
158: CP 14 3 // ret 0
159: CPi 18 178 // $RA.main
160: CPI 15 18 // load RA
161: BZJi 15 0 // return
162: BZJi 3 162 // HALT
//$DATA_SECTION
163: 72 // 'H'
164: 101 // 'e'
165: 108 // 'l'
166: 108 // 'l'
167: 111 // 'o'
168: 32 // ' '
169: 87 // 'W'
170: 111 // 'o'
171: 114 // 'r'
172: 108 // 'l'
173: 100 // 'd'
174: 33 // '!'
175: 0 // null
176: 0 // g'$RA.uart_putc'
177: 0 // g'$RA.uart_puts'
178: 0 // g'$RA.main'
179: 0 // g'$slot.uart_putc.0'
180: 0 // g'$slot.uart_puts.0'
//$STACK_SECTION // none (stackless calling convention)
