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
21: CPi 18 348 // $RA.main addr
22: CPi 15 336 // HALT addr
23: CPIi 18 15 // RA.main = HALT
24: BZJi 3 233 // Goto main
25: CPi 14 8448 // 8448
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
48: CPi 14 8450 // 8450
49: CP 18 14
50: CPI 14 18 // deref
51: CPi 18 349 // $slot.uart_getc.0
52: CPIi 18 14 // $slot.uart_getc.0
53: CP 14 4 // 1
54: CPIi 1 14 // push val
55: ADDi 1 1 // SP++
56: CPi 14 8449 // 8449
57: CP 18 14 // addr
58: ADD 1 5 // SP--
59: CPI 14 1 // pop val
60: CPIi 18 14 // *=
61: CPi 14 8449 // 8449
62: CP 18 14
63: CPI 14 18 // deref
64: CPIi 1 14 // push lhs
65: ADDi 1 1 // SP++
66: CP 14 3 // 0
67: CP 15 14 // rhs
68: ADD 1 5 // SP--
69: CPI 14 1 // pop lhs
70: CP 16 15 // sub
71: NAND 16 16 // ~
72: ADDi 16 1 // -src
73: ADD 14 16 // a-b
74: CPi 18 79 // ne? (P)
75: BZJ 18 14 // ne?
76: CP 14 5 // ne->-1
77: CPi 18 80 // ne end (P)
78: BZJi 18 0 // ne end
79: CPi 14 0 // eq->0
80: CPi 18 84 // wh exit (P)
81: BZJ 18 14 // wh exit
82: CPi 18 61 // wh loop
83: BZJi 18 0 // loop
84: CPi 18 349 // $slot.uart_getc.0
85: CPI 14 18 // $slot.uart_getc.0
86: CPi 18 344 // $RA.uart_getc
87: CPI 15 18 // load RA
88: BZJi 15 0 // return
89: CP 14 3 // ret 0
90: CPi 18 344 // $RA.uart_getc
91: CPI 15 18 // load RA
92: BZJi 15 0 // return
93: CPi 14 8452 // 8452
94: CP 18 14
95: CPI 14 18 // deref
96: CPIi 1 14 // push lhs
97: ADDi 1 1 // SP++
98: CP 14 3 // 0
99: CP 15 14 // rhs
100: ADD 1 5 // SP--
101: CPI 14 1 // pop lhs
102: CP 16 15 // sub
103: NAND 16 16 // ~
104: ADDi 16 1 // -src
105: ADD 14 16 // a-b
106: CPi 18 111 // ne? (P)
107: BZJ 18 14 // ne?
108: CP 14 5 // ne->-1
109: CPi 18 112 // ne end (P)
110: BZJi 18 0 // ne end
111: CPi 14 0 // eq->0
112: CPi 18 116 // wh exit (P)
113: BZJ 18 14 // wh exit
114: CPi 18 93 // wh loop
115: BZJi 18 0 // loop
116: CPi 18 350 // $slot.uart_putc.0
117: CPI 14 18 // $slot.uart_putc.0
118: CPIi 1 14 // push val
119: ADDi 1 1 // SP++
120: CPi 14 8451 // 8451
121: CP 18 14 // addr
122: ADD 1 5 // SP--
123: CPI 14 1 // pop val
124: CPIi 18 14 // *=
125: CP 14 4 // 1
126: CPIi 1 14 // push val
127: ADDi 1 1 // SP++
128: CPi 14 8452 // 8452
129: CP 18 14 // addr
130: ADD 1 5 // SP--
131: CPI 14 1 // pop val
132: CPIi 18 14 // *=
133: CP 14 3 // ret 0
134: CPi 18 345 // $RA.uart_putc
135: CPI 15 18 // load RA
136: BZJi 15 0 // return
137: CPi 18 351 // $slot.uart_puts.0
138: CPI 14 18 // $slot.uart_puts.0
139: CP 18 14
140: CPI 14 18 // deref
141: CPIi 1 14 // push lhs
142: ADDi 1 1 // SP++
143: CPi 14 0 // chr
144: CP 15 14 // rhs
145: ADD 1 5 // SP--
146: CPI 14 1 // pop lhs
147: CP 16 15 // sub
148: NAND 16 16 // ~
149: ADDi 16 1 // -src
150: ADD 14 16 // a-b
151: CPi 18 156 // ne? (P)
152: BZJ 18 14 // ne?
153: CP 14 5 // ne->-1
154: CPi 18 157 // ne end (P)
155: BZJi 18 0 // ne end
156: CPi 14 0 // eq->0
157: CPi 18 183 // wh exit (P)
158: BZJ 18 14 // wh exit
159: CPi 18 351 // $slot.uart_puts.0
160: CPI 14 18 // $slot.uart_puts.0
161: CP 18 14
162: CPI 14 18 // deref
163: CPIi 1 14 // push arg
164: ADDi 1 1 // SP++
165: ADD 1 5 // SP--
166: CPI 14 1 // pop arg
167: CPi 18 350 // $slot.uart_putc.0
168: CPIi 18 14 // st param
169: CPi 18 345 // $RA.uart_putc
170: CPi 15 174 // retPC
171: CPIi 18 15 // st RA
172: CPi 18 93 // uart_putc
173: BZJi 18 0 // uart_putc
174: CPi 18 351 // $slot.uart_puts.0
175: CPI 14 18 // $slot.uart_puts.0
176: CP 15 14 // old
177: ADDi 14 1 // ++
178: CPi 18 351 // $slot.uart_puts.0
179: CPIi 18 14 // $slot.uart_puts.0
180: CP 14 15 // old
181: CPi 18 137 // wh loop
182: BZJi 18 0 // loop
183: CP 14 3 // ret 0
184: CPi 18 346 // $RA.uart_puts
185: CPI 15 18 // load RA
186: BZJi 15 0 // return
187: CPi 14 10000 // 10000
188: CPi 18 352 // $slot.uart_wait_for_tx_drain.0
189: CPIi 18 14 // $slot.uart_wait_for_tx_drain.0
190: CPi 14 8452 // 8452
191: CP 18 14
192: CPI 14 18 // deref
193: CPIi 1 14 // push lhs
194: ADDi 1 1 // SP++
195: CP 14 3 // 0
196: CP 15 14 // rhs
197: ADD 1 5 // SP--
198: CPI 14 1 // pop lhs
199: CP 16 15 // sub
200: NAND 16 16 // ~
201: ADDi 16 1 // -src
202: ADD 14 16 // a-b
203: CPi 18 208 // ne? (P)
204: BZJ 18 14 // ne?
205: CP 14 5 // ne->-1
206: CPi 18 209 // ne end (P)
207: BZJi 18 0 // ne end
208: CPi 14 0 // eq->0
209: CPi 18 213 // wh exit (P)
210: BZJ 18 14 // wh exit
211: CPi 18 190 // wh loop
212: BZJi 18 0 // loop
213: CPi 18 352 // $slot.uart_wait_for_tx_drain.0
214: CPI 14 18 // $slot.uart_wait_for_tx_drain.0
215: CP 15 3 // 0
216: LT 15 14 // >
217: CP 14 15
218: CPi 18 229 // wh exit (P)
219: BZJ 18 14 // wh exit
220: CPi 18 352 // $slot.uart_wait_for_tx_drain.0
221: CPI 14 18 // $slot.uart_wait_for_tx_drain.0
222: CP 15 14 // old
223: ADD 14 5 // --
224: CPi 18 352 // $slot.uart_wait_for_tx_drain.0
225: CPIi 18 14 // $slot.uart_wait_for_tx_drain.0
226: CP 14 15 // old
227: CPi 18 213 // wh loop
228: BZJi 18 0 // loop
229: CP 14 3 // ret 0
230: CPi 18 347 // $RA.uart_wait_for_tx_drain
231: CPI 15 18 // load RA
232: BZJi 15 0 // return
233: CP 14 3 // 0
234: CPi 18 353 // $slot.main.0
235: CPIi 18 14 // st slot[]
236: CP 14 4 // 1
237: CPi 18 287 // wh exit (P)
238: BZJ 18 14 // wh exit
239: CPi 18 344 // $RA.uart_getc
240: CPi 15 244 // retPC
241: CPIi 18 15 // st RA
242: CPi 18 25 // uart_getc
243: BZJi 18 0 // uart_getc
244: CPi 18 371 // $slot.main.2
245: CPIi 18 14 // $slot.main.2
246: CPi 18 371 // $slot.main.2
247: CPI 14 18 // $slot.main.2
248: CP 15 3 // 0
249: CP 16 15 // sub
250: NAND 16 16 // ~
251: ADDi 16 1 // -src
252: ADD 14 16 // a-b
253: CPi 18 258 // eq (P)
254: BZJ 18 14 // eq
255: CPi 14 0 // ne
256: CPi 18 259 // eq end (P)
257: BZJi 18 0 // eq end
258: CPi 14 1 // eq
259: CPi 18 263 // if else (P)
260: BZJ 18 14 // if else
261: CPi 18 287 // break (P)
262: BZJi 18 0 // break
263: CPi 18 370 // $slot.main.1
264: CPI 14 18 // $slot.main.1
265: CPi 15 16 // imm
266: LT 14 15 // <
267: CPi 18 285 // if else (P)
268: BZJ 18 14 // if else
269: CPi 18 371 // $slot.main.2
270: CPI 14 18 // $slot.main.2
271: CP 15 14 // save val
272: CPi 18 353 // $slot.main.0
273: CPi 18 370 // $slot.main.1
274: CPI 14 18 // $slot.main.1
275: CPi 18 353 // $slot.main.0
276: ADD 18 14 // +idx
277: CPIi 18 15 // []=
278: CPi 18 370 // $slot.main.1
279: CPI 14 18 // $slot.main.1
280: CP 15 14 // old
281: ADDi 14 1 // ++
282: CPi 18 370 // $slot.main.1
283: CPIi 18 14 // $slot.main.1
284: CP 14 15 // old
285: CPi 18 236 // wh loop
286: BZJi 18 0 // loop
287: CPi 14 0 // chr
288: CP 15 14 // save val
289: CPi 18 353 // $slot.main.0
290: CPi 18 370 // $slot.main.1
291: CPI 14 18 // $slot.main.1
292: CPi 18 353 // $slot.main.0
293: ADD 18 14 // +idx
294: CPIi 18 15 // []=
295: CPi 14 337 // str(P)
296: CPIi 1 14 // push arg
297: ADDi 1 1 // SP++
298: ADD 1 5 // SP--
299: CPI 14 1 // pop arg
300: CPi 18 351 // $slot.uart_puts.0
301: CPIi 18 14 // st param
302: CPi 18 346 // $RA.uart_puts
303: CPi 15 307 // retPC
304: CPIi 18 15 // st RA
305: CPi 18 137 // uart_puts
306: BZJi 18 0 // uart_puts
307: CPi 14 353 // $slot.main.0
308: CPi 18 351 // $slot.uart_puts.0
309: CPIi 18 14 // st param
310: CPi 18 346 // $RA.uart_puts
311: CPi 15 315 // retPC
312: CPIi 18 15 // st RA
313: CPi 18 137 // uart_puts
314: BZJi 18 0 // uart_puts
315: CPi 14 33 // chr
316: CPi 18 350 // $slot.uart_putc.0
317: CPIi 18 14 // st param
318: CPi 18 345 // $RA.uart_putc
319: CPi 15 323 // retPC
320: CPIi 18 15 // st RA
321: CPi 18 93 // uart_putc
322: BZJi 18 0 // uart_putc
323: CPi 18 347 // $RA.uart_wait_for_tx_drain
324: CPi 15 328 // retPC
325: CPIi 18 15 // st RA
326: CPi 18 187 // uart_wait_for_tx_drain
327: BZJi 18 0 // uart_wait_for_tx_drain
328: CP 14 3 // 0
329: CPi 18 348 // $RA.main
330: CPI 15 18 // load RA
331: BZJi 15 0 // return
332: CP 14 3 // ret 0
333: CPi 18 348 // $RA.main
334: CPI 15 18 // load RA
335: BZJi 15 0 // return
336: BZJi 3 336 // HALT
//$DATA_SECTION
337: 72 // 'H'
338: 101 // 'e'
339: 108 // 'l'
340: 108 // 'l'
341: 111 // 'o'
342: 32 // ' '
343: 0 // null
344: 0 // g'$RA.uart_getc'
345: 0 // g'$RA.uart_putc'
346: 0 // g'$RA.uart_puts'
347: 0 // g'$RA.uart_wait_for_tx_drain'
348: 0 // g'$RA.main'
349: 0 // g'$slot.uart_getc.0'
350: 0 // g'$slot.uart_putc.0'
351: 0 // g'$slot.uart_puts.0'
352: 0 // g'$slot.uart_wait_for_tx_drain.0'
353: 0 // g'$slot.main.0'[0]
354: 0 // g'$slot.main.0'[1]
355: 0 // g'$slot.main.0'[2]
356: 0 // g'$slot.main.0'[3]
357: 0 // g'$slot.main.0'[4]
358: 0 // g'$slot.main.0'[5]
359: 0 // g'$slot.main.0'[6]
360: 0 // g'$slot.main.0'[7]
361: 0 // g'$slot.main.0'[8]
362: 0 // g'$slot.main.0'[9]
363: 0 // g'$slot.main.0'[10]
364: 0 // g'$slot.main.0'[11]
365: 0 // g'$slot.main.0'[12]
366: 0 // g'$slot.main.0'[13]
367: 0 // g'$slot.main.0'[14]
368: 0 // g'$slot.main.0'[15]
369: 0 // g'$slot.main.0'[16]
370: 0 // g'$slot.main.1'
371: 0 // g'$slot.main.2'
//$STACK_SECTION // none (stackless calling convention)
