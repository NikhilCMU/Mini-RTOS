
kernel/kernel.elf:     file format elf32-littlearm


Disassembly of section .text:

00008000 <__start>:
    8000:	e10f0000 	mrs	r0, CPSR
    8004:	e321f0d2 	msr	CPSR_c, #210	; 0xd2
    8008:	e59fd034 	ldr	sp, [pc, #52]	; 8044 <hang+0x8>
    800c:	e121f000 	msr	CPSR_c, r0
    8010:	e59fd030 	ldr	sp, [pc, #48]	; 8048 <hang+0xc>
    8014:	e59f0030 	ldr	r0, [pc, #48]	; 804c <hang+0x10>
    8018:	e59f1030 	ldr	r1, [pc, #48]	; 8050 <hang+0x14>
    801c:	e3a02000 	mov	r2, #0
    8020:	e3a03000 	mov	r3, #0
    8024:	e3a04000 	mov	r4, #0
    8028:	e3a05000 	mov	r5, #0

0000802c <bss_loop>:
    802c:	e8a0003c 	stmia	r0!, {r2, r3, r4, r5}
    8030:	e1500001 	cmp	r0, r1
    8034:	3afffffc 	bcc	802c <bss_loop>
    8038:	eb000086 	bl	8258 <kernel_main>

0000803c <hang>:
    803c:	e320f003 	wfi
    8040:	eafffffd 	b	803c <hang>
    8044:	0014f000 	andseq	pc, r4, r0
    8048:	0013e000 	andseq	lr, r3, r0
    804c:	0000d000 	andeq	sp, r0, r0
    8050:	0002e000 	andeq	lr, r2, r0

00008054 <led_init>:
    8054:	e92d4008 	push	{r3, lr}
    8058:	e3a0002f 	mov	r0, #47	; 0x2f
    805c:	e3a01001 	mov	r1, #1
    8060:	eb000013 	bl	80b4 <gpio_config>
    8064:	e3a00023 	mov	r0, #35	; 0x23
    8068:	e3a01001 	mov	r1, #1
    806c:	eb000010 	bl	80b4 <gpio_config>
    8070:	e8bd8008 	pop	{r3, pc}

00008074 <led_set_green>:
    8074:	e92d4008 	push	{r3, lr}
    8078:	e3a0002f 	mov	r0, #47	; 0x2f
    807c:	eb000021 	bl	8108 <gpio_set>
    8080:	e8bd8008 	pop	{r3, pc}

00008084 <led_clr_green>:
    8084:	e92d4008 	push	{r3, lr}
    8088:	e3a0002f 	mov	r0, #47	; 0x2f
    808c:	eb00002e 	bl	814c <gpio_clr>
    8090:	e8bd8008 	pop	{r3, pc}

00008094 <led_set_red>:
    8094:	e92d4008 	push	{r3, lr}
    8098:	e3a00023 	mov	r0, #35	; 0x23
    809c:	eb000019 	bl	8108 <gpio_set>
    80a0:	e8bd8008 	pop	{r3, pc}

000080a4 <led_clr_red>:
    80a4:	e92d4008 	push	{r3, lr}
    80a8:	e3a00023 	mov	r0, #35	; 0x23
    80ac:	eb000026 	bl	814c <gpio_clr>
    80b0:	e8bd8008 	pop	{r3, pc}

000080b4 <gpio_config>:
    80b4:	e3510007 	cmp	r1, #7
    80b8:	93500035 	cmpls	r0, #53	; 0x35
    80bc:	812fff1e 	bxhi	lr
    80c0:	e30c2ccd 	movw	r2, #52429	; 0xcccd
    80c4:	e34c2ccc 	movt	r2, #52428	; 0xcccc
    80c8:	e0832290 	umull	r2, r3, r0, r2
    80cc:	e1a0c1a3 	lsr	ip, r3, #3
    80d0:	e6ef307c 	uxtb	r3, ip
    80d4:	e1a03103 	lsl	r3, r3, #2
    80d8:	e283343f 	add	r3, r3, #1056964608	; 0x3f000000
    80dc:	e2833602 	add	r3, r3, #2097152	; 0x200000
    80e0:	e5932000 	ldr	r2, [r3]
    80e4:	e08cc10c 	add	ip, ip, ip, lsl #2
    80e8:	e040008c 	sub	r0, r0, ip, lsl #1
    80ec:	e6ef0070 	uxtb	r0, r0
    80f0:	e0800080 	add	r0, r0, r0, lsl #1
    80f4:	e3a0c007 	mov	ip, #7
    80f8:	e1c2201c 	bic	r2, r2, ip, lsl r0
    80fc:	e1820011 	orr	r0, r2, r1, lsl r0
    8100:	e5830000 	str	r0, [r3]
    8104:	e12fff1e 	bx	lr

00008108 <gpio_set>:
    8108:	e3500035 	cmp	r0, #53	; 0x35
    810c:	812fff1e 	bxhi	lr
    8110:	e350001f 	cmp	r0, #31
    8114:	9a000006 	bls	8134 <gpio_set+0x2c>
    8118:	e2400020 	sub	r0, r0, #32
    811c:	e3a03001 	mov	r3, #1
    8120:	e1a00013 	lsl	r0, r3, r0
    8124:	e3a03000 	mov	r3, #0
    8128:	e3433f20 	movt	r3, #16160	; 0x3f20
    812c:	e5830020 	str	r0, [r3, #32]
    8130:	e12fff1e 	bx	lr
    8134:	e3a03001 	mov	r3, #1
    8138:	e1a00013 	lsl	r0, r3, r0
    813c:	e3a03000 	mov	r3, #0
    8140:	e3433f20 	movt	r3, #16160	; 0x3f20
    8144:	e583001c 	str	r0, [r3, #28]
    8148:	e12fff1e 	bx	lr

0000814c <gpio_clr>:
    814c:	e3500035 	cmp	r0, #53	; 0x35
    8150:	812fff1e 	bxhi	lr
    8154:	e350001f 	cmp	r0, #31
    8158:	9a000006 	bls	8178 <gpio_clr+0x2c>
    815c:	e2400020 	sub	r0, r0, #32
    8160:	e3a03001 	mov	r3, #1
    8164:	e1a00013 	lsl	r0, r3, r0
    8168:	e3a03000 	mov	r3, #0
    816c:	e3433f20 	movt	r3, #16160	; 0x3f20
    8170:	e583002c 	str	r0, [r3, #44]	; 0x2c
    8174:	e12fff1e 	bx	lr
    8178:	e3a03001 	mov	r3, #1
    817c:	e1a00013 	lsl	r0, r3, r0
    8180:	e3a03000 	mov	r3, #0
    8184:	e3433f20 	movt	r3, #16160	; 0x3f20
    8188:	e5830028 	str	r0, [r3, #40]	; 0x28
    818c:	e12fff1e 	bx	lr

00008190 <gpio_set_pull>:
    8190:	e3510002 	cmp	r1, #2
    8194:	93500035 	cmpls	r0, #53	; 0x35
    8198:	812fff1e 	bxhi	lr
    819c:	e92d4038 	push	{r3, r4, r5, lr}
    81a0:	e1a04000 	mov	r4, r0
    81a4:	e3a03000 	mov	r3, #0
    81a8:	e3433f20 	movt	r3, #16160	; 0x3f20
    81ac:	e5831094 	str	r1, [r3, #148]	; 0x94
    81b0:	e3a00096 	mov	r0, #150	; 0x96
    81b4:	eb00052d 	bl	9670 <delay_cycles>
    81b8:	e354001f 	cmp	r4, #31
    81bc:	9a00000a 	bls	81ec <gpio_set_pull+0x5c>
    81c0:	e2440020 	sub	r0, r4, #32
    81c4:	e3a04001 	mov	r4, #1
    81c8:	e1a00014 	lsl	r0, r4, r0
    81cc:	e3a05000 	mov	r5, #0
    81d0:	e3435f20 	movt	r5, #16160	; 0x3f20
    81d4:	e585009c 	str	r0, [r5, #156]	; 0x9c
    81d8:	e3a00096 	mov	r0, #150	; 0x96
    81dc:	eb000523 	bl	9670 <delay_cycles>
    81e0:	e3a03000 	mov	r3, #0
    81e4:	e585309c 	str	r3, [r5, #156]	; 0x9c
    81e8:	e8bd8038 	pop	{r3, r4, r5, pc}
    81ec:	e3a00001 	mov	r0, #1
    81f0:	e1a00410 	lsl	r0, r0, r4
    81f4:	e3a05000 	mov	r5, #0
    81f8:	e3435f20 	movt	r5, #16160	; 0x3f20
    81fc:	e5850098 	str	r0, [r5, #152]	; 0x98
    8200:	e3a00096 	mov	r0, #150	; 0x96
    8204:	eb000519 	bl	9670 <delay_cycles>
    8208:	e3a03000 	mov	r3, #0
    820c:	e5853098 	str	r3, [r5, #152]	; 0x98
    8210:	e8bd8038 	pop	{r3, r4, r5, pc}

00008214 <initialize_priority_map>:
    8214:	e92d4010 	push	{r4, lr}
    8218:	e3a03000 	mov	r3, #0
    821c:	e30d0e84 	movw	r0, #56964	; 0xde84
    8220:	e3400002 	movt	r0, #2
    8224:	e30d1004 	movw	r1, #53252	; 0xd004
    8228:	e3401000 	movt	r1, #0
    822c:	e3014074 	movw	r4, #4212	; 0x1074
    8230:	e301e068 	movw	lr, #4200	; 0x1068
    8234:	e1a0c003 	mov	ip, r3
    8238:	e7803103 	str	r3, [r0, r3, lsl #2]
    823c:	e0221394 	mla	r2, r4, r3, r1
    8240:	e082200e 	add	r2, r2, lr
    8244:	e582c004 	str	ip, [r2, #4]
    8248:	e2833001 	add	r3, r3, #1
    824c:	e3530020 	cmp	r3, #32
    8250:	1afffff8 	bne	8238 <initialize_priority_map+0x24>
    8254:	e8bd8010 	pop	{r4, pc}

00008258 <kernel_main>:
    8258:	e92d4008 	push	{r3, lr}
    825c:	eb000239 	bl	8b48 <uart_init>
    8260:	eb0002d5 	bl	8dbc <adc_init>
    8264:	ebffffea 	bl	8214 <initialize_priority_map>
    8268:	eb000520 	bl	96f0 <install_interrupt_table>
    826c:	eb000506 	bl	968c <disable_interrupts>
    8270:	eb0002bf 	bl	8d74 <timer_stop>
    8274:	eb000554 	bl	97cc <enter_user_mode>
    8278:	e8bd8008 	pop	{r3, pc}

0000827c <scheduler>:
    827c:	e92d47f0 	push	{r4, r5, r6, r7, r8, r9, sl, lr}
    8280:	e30c3000 	movw	r3, #49152	; 0xc000
    8284:	e3403000 	movt	r3, #0
    8288:	e5933000 	ldr	r3, [r3]
    828c:	e3730001 	cmn	r3, #1
    8290:	0a00009e 	beq	8510 <scheduler+0x294>
    8294:	e30c3000 	movw	r3, #49152	; 0xc000
    8298:	e3403000 	movt	r3, #0
    829c:	e5932000 	ldr	r2, [r3]
    82a0:	e30d3e84 	movw	r3, #56964	; 0xde84
    82a4:	e3403002 	movt	r3, #2
    82a8:	e7935102 	ldr	r5, [r3, r2, lsl #2]
    82ac:	e30d2004 	movw	r2, #53252	; 0xd004
    82b0:	e3402000 	movt	r2, #0
    82b4:	e3013074 	movw	r3, #4212	; 0x1074
    82b8:	e0232593 	mla	r3, r3, r5, r2
    82bc:	e2833d41 	add	r3, r3, #4160	; 0x1040
    82c0:	e2833028 	add	r3, r3, #40	; 0x28
    82c4:	e5933004 	ldr	r3, [r3, #4]
    82c8:	e3530000 	cmp	r3, #0
    82cc:	1a000004 	bne	82e4 <scheduler+0x68>
    82d0:	e30b0014 	movw	r0, #45076	; 0xb014
    82d4:	e3400000 	movt	r0, #0
    82d8:	eb0001ac 	bl	8990 <printk>
    82dc:	e3a00001 	mov	r0, #1
    82e0:	eb0002d4 	bl	8e38 <syscall_exit>
    82e4:	e30d2004 	movw	r2, #53252	; 0xd004
    82e8:	e3402000 	movt	r2, #0
    82ec:	e3013074 	movw	r3, #4212	; 0x1074
    82f0:	e0232593 	mla	r3, r3, r5, r2
    82f4:	e5932058 	ldr	r2, [r3, #88]	; 0x58
    82f8:	e2822001 	add	r2, r2, #1
    82fc:	e5832058 	str	r2, [r3, #88]	; 0x58
    8300:	e5932058 	ldr	r2, [r3, #88]	; 0x58
    8304:	e5933050 	ldr	r3, [r3, #80]	; 0x50
    8308:	e1520003 	cmp	r2, r3
    830c:	9a000007 	bls	8330 <scheduler+0xb4>
    8310:	e30c3000 	movw	r3, #49152	; 0xc000
    8314:	e3403000 	movt	r3, #0
    8318:	e5932000 	ldr	r2, [r3]
    831c:	e30d3e84 	movw	r3, #56964	; 0xde84
    8320:	e3403002 	movt	r3, #2
    8324:	e7933102 	ldr	r3, [r3, r2, lsl #2]
    8328:	e353001f 	cmp	r3, #31
    832c:	1a000006 	bne	834c <scheduler+0xd0>
    8330:	e30d2004 	movw	r2, #53252	; 0xd004
    8334:	e3402000 	movt	r2, #0
    8338:	e3013074 	movw	r3, #4212	; 0x1074
    833c:	e0232593 	mla	r3, r3, r5, r2
    8340:	e5d33068 	ldrb	r3, [r3, #104]	; 0x68
    8344:	e31300ff 	tst	r3, #255	; 0xff
    8348:	1a000070 	bne	8510 <scheduler+0x294>
    834c:	e30d3004 	movw	r3, #53252	; 0xd004
    8350:	e3403000 	movt	r3, #0
    8354:	e3014074 	movw	r4, #4212	; 0x1074
    8358:	e0243594 	mla	r4, r4, r5, r3
    835c:	e3a06000 	mov	r6, #0
    8360:	e5846058 	str	r6, [r4, #88]	; 0x58
    8364:	e594c05c 	ldr	ip, [r4, #92]	; 0x5c
    8368:	e30d3f0c 	movw	r3, #57100	; 0xdf0c
    836c:	e3403002 	movt	r3, #2
    8370:	e5931000 	ldr	r1, [r3]
    8374:	e3a02001 	mov	r2, #1
    8378:	e1811c12 	orr	r1, r1, r2, lsl ip
    837c:	e5831000 	str	r1, [r3]
    8380:	e594005c 	ldr	r0, [r4, #92]	; 0x5c
    8384:	e30d3f08 	movw	r3, #57096	; 0xdf08
    8388:	e3403002 	movt	r3, #2
    838c:	e5931000 	ldr	r1, [r3]
    8390:	e1c12012 	bic	r2, r1, r2, lsl r0
    8394:	e5832000 	str	r2, [r3]
    8398:	e5945054 	ldr	r5, [r4, #84]	; 0x54
    839c:	e30d3f04 	movw	r3, #57092	; 0xdf04
    83a0:	e3403002 	movt	r3, #2
    83a4:	e5930000 	ldr	r0, [r3]
    83a8:	e1a01005 	mov	r1, r5
    83ac:	eb000511 	bl	97f8 <__aeabi_uidiv>
    83b0:	e2800001 	add	r0, r0, #1
    83b4:	e0050095 	mul	r5, r5, r0
    83b8:	e5845064 	str	r5, [r4, #100]	; 0x64
    83bc:	e5c46068 	strb	r6, [r4, #104]	; 0x68
    83c0:	e30c3000 	movw	r3, #49152	; 0xc000
    83c4:	e3403000 	movt	r3, #0
    83c8:	e3e02000 	mvn	r2, #0
    83cc:	e5832000 	str	r2, [r3]
    83d0:	ea00004e 	b	8510 <scheduler+0x294>
    83d4:	e5912000 	ldr	r2, [r1]
    83d8:	e1a02332 	lsr	r2, r2, r3
    83dc:	e3120001 	tst	r2, #1
    83e0:	0a000013 	beq	8434 <scheduler+0x1b8>
    83e4:	e022039c 	mla	r2, ip, r3, r0
    83e8:	e082200e 	add	r2, r2, lr
    83ec:	e5922004 	ldr	r2, [r2, #4]
    83f0:	e3520000 	cmp	r2, #0
    83f4:	0a00000e 	beq	8434 <scheduler+0x1b8>
    83f8:	e022039c 	mla	r2, ip, r3, r0
    83fc:	e5928064 	ldr	r8, [r2, #100]	; 0x64
    8400:	e5942000 	ldr	r2, [r4]
    8404:	e1580002 	cmp	r8, r2
    8408:	1a000009 	bne	8434 <scheduler+0x1b8>
    840c:	e028039c 	mla	r8, ip, r3, r0
    8410:	e598a05c 	ldr	sl, [r8, #92]	; 0x5c
    8414:	e5912000 	ldr	r2, [r1]
    8418:	e1c22a16 	bic	r2, r2, r6, lsl sl
    841c:	e5812000 	str	r2, [r1]
    8420:	e598905c 	ldr	r9, [r8, #92]	; 0x5c
    8424:	e5952000 	ldr	r2, [r5]
    8428:	e1822916 	orr	r2, r2, r6, lsl r9
    842c:	e5852000 	str	r2, [r5]
    8430:	e5c87068 	strb	r7, [r8, #104]	; 0x68
    8434:	e2833001 	add	r3, r3, #1
    8438:	e3530020 	cmp	r3, #32
    843c:	1affffe4 	bne	83d4 <scheduler+0x158>
    8440:	e30d3f08 	movw	r3, #57096	; 0xdf08
    8444:	e3403002 	movt	r3, #2
    8448:	e5933000 	ldr	r3, [r3]
    844c:	e6ff3f33 	rbit	r3, r3
    8450:	e16f3f13 	clz	r3, r3
    8454:	e30d2e84 	movw	r2, #56964	; 0xde84
    8458:	e3402002 	movt	r2, #2
    845c:	e7922103 	ldr	r2, [r2, r3, lsl #2]
    8460:	e30c3000 	movw	r3, #49152	; 0xc000
    8464:	e3403000 	movt	r3, #0
    8468:	e5933000 	ldr	r3, [r3]
    846c:	e3730001 	cmn	r3, #1
    8470:	1a00000c 	bne	84a8 <scheduler+0x22c>
    8474:	e30d1004 	movw	r1, #53252	; 0xd004
    8478:	e3401000 	movt	r1, #0
    847c:	e3013074 	movw	r3, #4212	; 0x1074
    8480:	e0231293 	mla	r3, r3, r2, r1
    8484:	e3a01001 	mov	r1, #1
    8488:	e5c31068 	strb	r1, [r3, #104]	; 0x68
    848c:	e5931058 	ldr	r1, [r3, #88]	; 0x58
    8490:	e2811001 	add	r1, r1, #1
    8494:	e5831058 	str	r1, [r3, #88]	; 0x58
    8498:	e30c3000 	movw	r3, #49152	; 0xc000
    849c:	e3403000 	movt	r3, #0
    84a0:	e5832000 	str	r2, [r3]
    84a4:	e8bd87f0 	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
    84a8:	e30c3000 	movw	r3, #49152	; 0xc000
    84ac:	e3403000 	movt	r3, #0
    84b0:	e5933000 	ldr	r3, [r3]
    84b4:	e1520003 	cmp	r2, r3
    84b8:	28bd87f0 	popcs	{r4, r5, r6, r7, r8, r9, sl, pc}
    84bc:	e30c0000 	movw	r0, #49152	; 0xc000
    84c0:	e3400000 	movt	r0, #0
    84c4:	e5903000 	ldr	r3, [r0]
    84c8:	e30d1e84 	movw	r1, #56964	; 0xde84
    84cc:	e3401002 	movt	r1, #2
    84d0:	e791c103 	ldr	ip, [r1, r3, lsl #2]
    84d4:	e30d3004 	movw	r3, #53252	; 0xd004
    84d8:	e3403000 	movt	r3, #0
    84dc:	e301e074 	movw	lr, #4212	; 0x1074
    84e0:	e02c3c9e 	mla	ip, lr, ip, r3
    84e4:	e3a04002 	mov	r4, #2
    84e8:	e5cc4068 	strb	r4, [ip, #104]	; 0x68
    84ec:	e7911102 	ldr	r1, [r1, r2, lsl #2]
    84f0:	e023319e 	mla	r3, lr, r1, r3
    84f4:	e3a01001 	mov	r1, #1
    84f8:	e5c31068 	strb	r1, [r3, #104]	; 0x68
    84fc:	e5931058 	ldr	r1, [r3, #88]	; 0x58
    8500:	e2811001 	add	r1, r1, #1
    8504:	e5831058 	str	r1, [r3, #88]	; 0x58
    8508:	e5802000 	str	r2, [r0]
    850c:	e8bd87f0 	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
    8510:	e3a03000 	mov	r3, #0
    8514:	e30d1f0c 	movw	r1, #57100	; 0xdf0c
    8518:	e3401002 	movt	r1, #2
    851c:	e30d0004 	movw	r0, #53252	; 0xd004
    8520:	e3400000 	movt	r0, #0
    8524:	e301c074 	movw	ip, #4212	; 0x1074
    8528:	e301e068 	movw	lr, #4200	; 0x1068
    852c:	e30d4f04 	movw	r4, #57092	; 0xdf04
    8530:	e3404002 	movt	r4, #2
    8534:	e3a06001 	mov	r6, #1
    8538:	e30d5f08 	movw	r5, #57096	; 0xdf08
    853c:	e3405002 	movt	r5, #2
    8540:	e3a07002 	mov	r7, #2
    8544:	eaffffa2 	b	83d4 <scheduler+0x158>

00008548 <save_context>:
    8548:	e92d4070 	push	{r4, r5, r6, lr}
    854c:	e30c3000 	movw	r3, #49152	; 0xc000
    8550:	e3403000 	movt	r3, #0
    8554:	e5932000 	ldr	r2, [r3]
    8558:	e30d3e84 	movw	r3, #56964	; 0xde84
    855c:	e3403002 	movt	r3, #2
    8560:	e7934102 	ldr	r4, [r3, r2, lsl #2]
    8564:	e2802018 	add	r2, r0, #24
    8568:	e1a0c000 	mov	ip, r0
    856c:	e3a01000 	mov	r1, #0
    8570:	e30d6004 	movw	r6, #53252	; 0xd004
    8574:	e3406000 	movt	r6, #0
    8578:	e0845284 	add	r5, r4, r4, lsl #5
    857c:	e0645185 	rsb	r5, r4, r5, lsl #3
    8580:	e0845105 	add	r5, r4, r5, lsl #2
    8584:	e49ce004 	ldr	lr, [ip], #4
    8588:	e0853001 	add	r3, r5, r1
    858c:	e283300c 	add	r3, r3, #12
    8590:	e0863103 	add	r3, r6, r3, lsl #2
    8594:	e583e008 	str	lr, [r3, #8]
    8598:	e2811001 	add	r1, r1, #1
    859c:	e15c0002 	cmp	ip, r2
    85a0:	1afffff7 	bne	8584 <save_context+0x3c>
    85a4:	e280604c 	add	r6, r0, #76	; 0x4c
    85a8:	e3a01000 	mov	r1, #0
    85ac:	e30d5004 	movw	r5, #53252	; 0xd004
    85b0:	e3405000 	movt	r5, #0
    85b4:	e084e284 	add	lr, r4, r4, lsl #5
    85b8:	e064e18e 	rsb	lr, r4, lr, lsl #3
    85bc:	e084e10e 	add	lr, r4, lr, lsl #2
    85c0:	e492c004 	ldr	ip, [r2], #4
    85c4:	e08e3001 	add	r3, lr, r1
    85c8:	e0853103 	add	r3, r5, r3, lsl #2
    85cc:	e583c004 	str	ip, [r3, #4]
    85d0:	e2811001 	add	r1, r1, #1
    85d4:	e1520006 	cmp	r2, r6
    85d8:	1afffff8 	bne	85c0 <save_context+0x78>
    85dc:	e5b0104c 	ldr	r1, [r0, #76]!	; 0x4c
    85e0:	e30d2004 	movw	r2, #53252	; 0xd004
    85e4:	e3402000 	movt	r2, #0
    85e8:	e3013074 	movw	r3, #4212	; 0x1074
    85ec:	e0040493 	mul	r4, r3, r4
    85f0:	e7821004 	str	r1, [r2, r4]
    85f4:	e8bd8070 	pop	{r4, r5, r6, pc}

000085f8 <restore_context>:
    85f8:	e92d4030 	push	{r4, r5, lr}
    85fc:	e30c3000 	movw	r3, #49152	; 0xc000
    8600:	e3403000 	movt	r3, #0
    8604:	e5932000 	ldr	r2, [r3]
    8608:	e30d3e84 	movw	r3, #56964	; 0xde84
    860c:	e3403002 	movt	r3, #2
    8610:	e793e102 	ldr	lr, [r3, r2, lsl #2]
    8614:	e30d2004 	movw	r2, #53252	; 0xd004
    8618:	e3402000 	movt	r2, #0
    861c:	e3013074 	movw	r3, #4212	; 0x1074
    8620:	e0030e93 	mul	r3, r3, lr
    8624:	e7923003 	ldr	r3, [r2, r3]
    8628:	e1a02000 	mov	r2, r0
    862c:	e4023004 	str	r3, [r2], #-4
    8630:	e2405038 	sub	r5, r0, #56	; 0x38
    8634:	e3a0100c 	mov	r1, #12
    8638:	e30d4004 	movw	r4, #53252	; 0xd004
    863c:	e3404000 	movt	r4, #0
    8640:	e08ec28e 	add	ip, lr, lr, lsl #5
    8644:	e06ec18c 	rsb	ip, lr, ip, lsl #3
    8648:	e08ec10c 	add	ip, lr, ip, lsl #2
    864c:	e08c3001 	add	r3, ip, r1
    8650:	e0843103 	add	r3, r4, r3, lsl #2
    8654:	e5933004 	ldr	r3, [r3, #4]
    8658:	e4023004 	str	r3, [r2], #-4
    865c:	e2411001 	sub	r1, r1, #1
    8660:	e1520005 	cmp	r2, r5
    8664:	1afffff8 	bne	864c <restore_context+0x54>
    8668:	e2401038 	sub	r1, r0, #56	; 0x38
    866c:	e2404050 	sub	r4, r0, #80	; 0x50
    8670:	e3a02005 	mov	r2, #5
    8674:	e30dc004 	movw	ip, #53252	; 0xd004
    8678:	e340c000 	movt	ip, #0
    867c:	e08e328e 	add	r3, lr, lr, lsl #5
    8680:	e06e3183 	rsb	r3, lr, r3, lsl #3
    8684:	e08ee103 	add	lr, lr, r3, lsl #2
    8688:	e08e3002 	add	r3, lr, r2
    868c:	e283300c 	add	r3, r3, #12
    8690:	e08c3103 	add	r3, ip, r3, lsl #2
    8694:	e5933008 	ldr	r3, [r3, #8]
    8698:	e4013004 	str	r3, [r1], #-4
    869c:	e2422001 	sub	r2, r2, #1
    86a0:	e1510004 	cmp	r1, r4
    86a4:	1afffff7 	bne	8688 <restore_context+0x90>
    86a8:	e240004c 	sub	r0, r0, #76	; 0x4c
    86ac:	e8bd8030 	pop	{r4, r5, pc}

000086b0 <irq_c_handler>:
    86b0:	e92d4010 	push	{r4, lr}
    86b4:	e1a04000 	mov	r4, r0
    86b8:	eb0001b5 	bl	8d94 <timer_is_pending>
    86bc:	e3500000 	cmp	r0, #0
    86c0:	0a000017 	beq	8724 <irq_c_handler+0x74>
    86c4:	eb0001b7 	bl	8da8 <timer_clear_pending>
    86c8:	e30d3f04 	movw	r3, #57092	; 0xdf04
    86cc:	e3403002 	movt	r3, #2
    86d0:	e5932000 	ldr	r2, [r3]
    86d4:	e2822001 	add	r2, r2, #1
    86d8:	e5832000 	str	r2, [r3]
    86dc:	e30c3000 	movw	r3, #49152	; 0xc000
    86e0:	e3403000 	movt	r3, #0
    86e4:	e5933004 	ldr	r3, [r3, #4]
    86e8:	e3530000 	cmp	r3, #0
    86ec:	0a000005 	beq	8708 <irq_c_handler+0x58>
    86f0:	e284404c 	add	r4, r4, #76	; 0x4c
    86f4:	e30c3000 	movw	r3, #49152	; 0xc000
    86f8:	e3403000 	movt	r3, #0
    86fc:	e3a02000 	mov	r2, #0
    8700:	e5832004 	str	r2, [r3, #4]
    8704:	ea000002 	b	8714 <irq_c_handler+0x64>
    8708:	e1a00004 	mov	r0, r4
    870c:	ebffff8d 	bl	8548 <save_context>
    8710:	e1a04000 	mov	r4, r0
    8714:	ebfffed8 	bl	827c <scheduler>
    8718:	e1a00004 	mov	r0, r4
    871c:	ebffffb5 	bl	85f8 <restore_context>
    8720:	e8bd8010 	pop	{r4, pc}
    8724:	e1a00004 	mov	r0, r4
    8728:	e8bd8010 	pop	{r4, pc}

0000872c <swi_c_handler>:
    872c:	e52de004 	push	{lr}		; (str lr, [sp, #-4]!)
    8730:	e24dd00c 	sub	sp, sp, #12
    8734:	e1a0c001 	mov	ip, r1
    8738:	e3500011 	cmp	r0, #17
    873c:	979ff100 	ldrls	pc, [pc, r0, lsl #2]
    8740:	ea000057 	b	88a4 <swi_c_handler+0x178>
    8744:	0000878c 	andeq	r8, r0, ip, lsl #15
    8748:	00008798 	muleq	r0, r8, r7
    874c:	000087ac 	andeq	r8, r0, ip, lsr #15
    8750:	000087b8 			; <UNDEFINED> instruction: 0x000087b8
    8754:	000087c8 	andeq	r8, r0, r8, asr #15
    8758:	000087d4 	ldrdeq	r8, [r0], -r4
    875c:	000087e8 	andeq	r8, r0, r8, ror #15
    8760:	000087fc 	strdeq	r8, [r0], -ip
    8764:	0000880c 	andeq	r8, r0, ip, lsl #16
    8768:	00008820 	andeq	r8, r0, r0, lsr #16
    876c:	00008828 	andeq	r8, r0, r8, lsr #16
    8770:	00008838 	andeq	r8, r0, r8, lsr r8
    8774:	00008858 	andeq	r8, r0, r8, asr r8
    8778:	00008868 	andeq	r8, r0, r8, ror #16
    877c:	00008878 	andeq	r8, r0, r8, ror r8
    8780:	00008888 	andeq	r8, r0, r8, lsl #17
    8784:	00008894 	muleq	r0, r4, r8
    8788:	0000889c 	muleq	r0, ip, r8
    878c:	e5910000 	ldr	r0, [r1]
    8790:	eb000398 	bl	95f8 <syscall_sbrk>
    8794:	ea000043 	b	88a8 <swi_c_handler+0x17c>
    8798:	e5910000 	ldr	r0, [r1]
    879c:	e5911004 	ldr	r1, [r1, #4]
    87a0:	e59c2008 	ldr	r2, [ip, #8]
    87a4:	eb0001ab 	bl	8e58 <syscall_write>
    87a8:	ea00003e 	b	88a8 <swi_c_handler+0x17c>
    87ac:	e5910000 	ldr	r0, [r1]
    87b0:	eb0003a6 	bl	9650 <syscall_close>
    87b4:	ea00003b 	b	88a8 <swi_c_handler+0x17c>
    87b8:	e5910000 	ldr	r0, [r1]
    87bc:	e5911004 	ldr	r1, [r1, #4]
    87c0:	eb0003a4 	bl	9658 <syscall_fstat>
    87c4:	ea000037 	b	88a8 <swi_c_handler+0x17c>
    87c8:	e5910000 	ldr	r0, [r1]
    87cc:	eb0003a3 	bl	9660 <syscall_isatty>
    87d0:	ea000034 	b	88a8 <swi_c_handler+0x17c>
    87d4:	e5910000 	ldr	r0, [r1]
    87d8:	e5911004 	ldr	r1, [r1, #4]
    87dc:	e59c2008 	ldr	r2, [ip, #8]
    87e0:	eb0003a0 	bl	9668 <syscall_lseek>
    87e4:	ea00002f 	b	88a8 <swi_c_handler+0x17c>
    87e8:	e5910000 	ldr	r0, [r1]
    87ec:	e5911004 	ldr	r1, [r1, #4]
    87f0:	e59c2008 	ldr	r2, [ip, #8]
    87f4:	eb0001b8 	bl	8edc <syscall_read>
    87f8:	ea00002a 	b	88a8 <swi_c_handler+0x17c>
    87fc:	e5910000 	ldr	r0, [r1]
    8800:	eb00018c 	bl	8e38 <syscall_exit>
    8804:	e3a00000 	mov	r0, #0
    8808:	ea000026 	b	88a8 <swi_c_handler+0x17c>
    880c:	e5910000 	ldr	r0, [r1]
    8810:	e5d11004 	ldrb	r1, [r1, #4]
    8814:	e59c2008 	ldr	r2, [ip, #8]
    8818:	eb0001dd 	bl	8f94 <syscall_sample_adc_start>
    881c:	ea000021 	b	88a8 <swi_c_handler+0x17c>
    8820:	eb0001dd 	bl	8f9c <syscall_sample_adc_stop>
    8824:	ea00001f 	b	88a8 <swi_c_handler+0x17c>
    8828:	e5910000 	ldr	r0, [r1]
    882c:	e5911004 	ldr	r1, [r1, #4]
    8830:	eb0001db 	bl	8fa4 <syscall_thread_init>
    8834:	ea00001b 	b	88a8 <swi_c_handler+0x17c>
    8838:	e5910000 	ldr	r0, [r1]
    883c:	e5911004 	ldr	r1, [r1, #4]
    8840:	e59c2008 	ldr	r2, [ip, #8]
    8844:	e59c300c 	ldr	r3, [ip, #12]
    8848:	e59cc030 	ldr	ip, [ip, #48]	; 0x30
    884c:	e58dc000 	str	ip, [sp]
    8850:	eb0001f9 	bl	903c <syscall_thread_create>
    8854:	ea000013 	b	88a8 <swi_c_handler+0x17c>
    8858:	e5910000 	ldr	r0, [r1]
    885c:	e5911004 	ldr	r1, [r1, #4]
    8860:	eb000226 	bl	9100 <syscall_mutex_init>
    8864:	ea00000f 	b	88a8 <swi_c_handler+0x17c>
    8868:	e5910000 	ldr	r0, [r1]
    886c:	eb000231 	bl	9138 <syscall_mutex_lock>
    8870:	e3a00000 	mov	r0, #0
    8874:	ea00000b 	b	88a8 <swi_c_handler+0x17c>
    8878:	e5910000 	ldr	r0, [r1]
    887c:	eb000269 	bl	9228 <syscall_mutex_unlock>
    8880:	e3a00000 	mov	r0, #0
    8884:	ea000007 	b	88a8 <swi_c_handler+0x17c>
    8888:	eb000307 	bl	94ac <syscall_wait_until_next_period>
    888c:	e3a00000 	mov	r0, #0
    8890:	ea000004 	b	88a8 <swi_c_handler+0x17c>
    8894:	eb000323 	bl	9528 <syscall_get_time>
    8898:	ea000002 	b	88a8 <swi_c_handler+0x17c>
    889c:	eb000325 	bl	9538 <syscall_scheduler_start>
    88a0:	ea000000 	b	88a8 <swi_c_handler+0x17c>
    88a4:	e3a00000 	mov	r0, #0
    88a8:	e28dd00c 	add	sp, sp, #12
    88ac:	e49df004 	pop	{pc}		; (ldr pc, [sp], #4)

000088b0 <printnumk>:
    88b0:	e92d47f0 	push	{r4, r5, r6, r7, r8, r9, sl, lr}
    88b4:	e24dd008 	sub	sp, sp, #8
    88b8:	e1a06002 	mov	r6, r2
    88bc:	e1a07003 	mov	r7, r3
    88c0:	e3500008 	cmp	r0, #8
    88c4:	0a000004 	beq	88dc <printnumk+0x2c>
    88c8:	e30b8028 	movw	r8, #45096	; 0xb028
    88cc:	e3408000 	movt	r8, #0
    88d0:	e3500010 	cmp	r0, #16
    88d4:	13a08000 	movne	r8, #0
    88d8:	ea000001 	b	88e4 <printnumk+0x34>
    88dc:	e30b8024 	movw	r8, #45092	; 0xb024
    88e0:	e3408000 	movt	r8, #0
    88e4:	e28d4007 	add	r4, sp, #7
    88e8:	e1a05000 	mov	r5, r0
    88ec:	e3a09000 	mov	r9, #0
    88f0:	e30ba000 	movw	sl, #45056	; 0xb000
    88f4:	e340a000 	movt	sl, #0
    88f8:	e1a00006 	mov	r0, r6
    88fc:	e1a01007 	mov	r1, r7
    8900:	e1a02005 	mov	r2, r5
    8904:	e1a03009 	mov	r3, r9
    8908:	eb000600 	bl	a110 <__aeabi_uldivmod>
    890c:	e7da3002 	ldrb	r3, [sl, r2]
    8910:	e4443001 	strb	r3, [r4], #-1
    8914:	e1a00006 	mov	r0, r6
    8918:	e1a01007 	mov	r1, r7
    891c:	e1a02005 	mov	r2, r5
    8920:	e1a03009 	mov	r3, r9
    8924:	eb0005f9 	bl	a110 <__aeabi_uldivmod>
    8928:	e1a06000 	mov	r6, r0
    892c:	e1a07001 	mov	r7, r1
    8930:	e1963007 	orrs	r3, r6, r7
    8934:	1affffef 	bne	88f8 <printnumk+0x48>
    8938:	e3580000 	cmp	r8, #0
    893c:	0a000002 	beq	894c <printnumk+0x9c>
    8940:	e5d80000 	ldrb	r0, [r8]
    8944:	e3500000 	cmp	r0, #0
    8948:	1a000004 	bne	8960 <printnumk+0xb0>
    894c:	e2844001 	add	r4, r4, #1
    8950:	e28d3008 	add	r3, sp, #8
    8954:	e1540003 	cmp	r4, r3
    8958:	1a000005 	bne	8974 <printnumk+0xc4>
    895c:	ea000009 	b	8988 <printnumk+0xd8>
    8960:	eb000099 	bl	8bcc <uart_put_byte>
    8964:	e5f80001 	ldrb	r0, [r8, #1]!
    8968:	e3500000 	cmp	r0, #0
    896c:	1afffffb 	bne	8960 <printnumk+0xb0>
    8970:	eafffff5 	b	894c <printnumk+0x9c>
    8974:	e4d40001 	ldrb	r0, [r4], #1
    8978:	eb000093 	bl	8bcc <uart_put_byte>
    897c:	e28d3008 	add	r3, sp, #8
    8980:	e1540003 	cmp	r4, r3
    8984:	1afffffa 	bne	8974 <printnumk+0xc4>
    8988:	e28dd008 	add	sp, sp, #8
    898c:	e8bd87f0 	pop	{r4, r5, r6, r7, r8, r9, sl, pc}

00008990 <printk>:
    8990:	e92d000f 	push	{r0, r1, r2, r3}
    8994:	e92d41f0 	push	{r4, r5, r6, r7, r8, lr}
    8998:	e24dd008 	sub	sp, sp, #8
    899c:	e59d4020 	ldr	r4, [sp, #32]
    89a0:	e28d3024 	add	r3, sp, #36	; 0x24
    89a4:	e58d3004 	str	r3, [sp, #4]
    89a8:	e3a06000 	mov	r6, #0
    89ac:	e3a08008 	mov	r8, #8
    89b0:	e3a07010 	mov	r7, #16
    89b4:	ea00005c 	b	8b2c <printk+0x19c>
    89b8:	e3500025 	cmp	r0, #37	; 0x25
    89bc:	0a000002 	beq	89cc <printk+0x3c>
    89c0:	e2844001 	add	r4, r4, #1
    89c4:	eb000080 	bl	8bcc <uart_put_byte>
    89c8:	ea000057 	b	8b2c <printk+0x19c>
    89cc:	e5d43001 	ldrb	r3, [r4, #1]
    89d0:	e353006f 	cmp	r3, #111	; 0x6f
    89d4:	0a00002c 	beq	8a8c <printk+0xfc>
    89d8:	8a000006 	bhi	89f8 <printk+0x68>
    89dc:	e3530063 	cmp	r3, #99	; 0x63
    89e0:	0a000045 	beq	8afc <printk+0x16c>
    89e4:	e3530064 	cmp	r3, #100	; 0x64
    89e8:	0a00000d 	beq	8a24 <printk+0x94>
    89ec:	e3530025 	cmp	r3, #37	; 0x25
    89f0:	1a00004a 	bne	8b20 <printk+0x190>
    89f4:	ea000046 	b	8b14 <printk+0x184>
    89f8:	e3530073 	cmp	r3, #115	; 0x73
    89fc:	0a000032 	beq	8acc <printk+0x13c>
    8a00:	8a000002 	bhi	8a10 <printk+0x80>
    8a04:	e3530070 	cmp	r3, #112	; 0x70
    8a08:	0a000027 	beq	8aac <printk+0x11c>
    8a0c:	ea000043 	b	8b20 <printk+0x190>
    8a10:	e3530075 	cmp	r3, #117	; 0x75
    8a14:	0a000014 	beq	8a6c <printk+0xdc>
    8a18:	e3530078 	cmp	r3, #120	; 0x78
    8a1c:	0a000022 	beq	8aac <printk+0x11c>
    8a20:	ea00003e 	b	8b20 <printk+0x190>
    8a24:	e59d3004 	ldr	r3, [sp, #4]
    8a28:	e2832004 	add	r2, r3, #4
    8a2c:	e58d2004 	str	r2, [sp, #4]
    8a30:	e5935000 	ldr	r5, [r3]
    8a34:	e3550000 	cmp	r5, #0
    8a38:	aa000006 	bge	8a58 <printk+0xc8>
    8a3c:	e3a0002d 	mov	r0, #45	; 0x2d
    8a40:	eb000061 	bl	8bcc <uart_put_byte>
    8a44:	e2652000 	rsb	r2, r5, #0
    8a48:	e3a0000a 	mov	r0, #10
    8a4c:	e1a03fc2 	asr	r3, r2, #31
    8a50:	ebffff96 	bl	88b0 <printnumk>
    8a54:	ea000033 	b	8b28 <printk+0x198>
    8a58:	e3a0000a 	mov	r0, #10
    8a5c:	e1a02005 	mov	r2, r5
    8a60:	e1a03fc5 	asr	r3, r5, #31
    8a64:	ebffff91 	bl	88b0 <printnumk>
    8a68:	ea00002e 	b	8b28 <printk+0x198>
    8a6c:	e59d3004 	ldr	r3, [sp, #4]
    8a70:	e2832004 	add	r2, r3, #4
    8a74:	e58d2004 	str	r2, [sp, #4]
    8a78:	e3a0000a 	mov	r0, #10
    8a7c:	e5932000 	ldr	r2, [r3]
    8a80:	e1a03006 	mov	r3, r6
    8a84:	ebffff89 	bl	88b0 <printnumk>
    8a88:	ea000026 	b	8b28 <printk+0x198>
    8a8c:	e59d3004 	ldr	r3, [sp, #4]
    8a90:	e2832004 	add	r2, r3, #4
    8a94:	e58d2004 	str	r2, [sp, #4]
    8a98:	e1a00008 	mov	r0, r8
    8a9c:	e5932000 	ldr	r2, [r3]
    8aa0:	e1a03006 	mov	r3, r6
    8aa4:	ebffff81 	bl	88b0 <printnumk>
    8aa8:	ea00001e 	b	8b28 <printk+0x198>
    8aac:	e59d3004 	ldr	r3, [sp, #4]
    8ab0:	e2832004 	add	r2, r3, #4
    8ab4:	e58d2004 	str	r2, [sp, #4]
    8ab8:	e1a00007 	mov	r0, r7
    8abc:	e5932000 	ldr	r2, [r3]
    8ac0:	e1a03006 	mov	r3, r6
    8ac4:	ebffff79 	bl	88b0 <printnumk>
    8ac8:	ea000016 	b	8b28 <printk+0x198>
    8acc:	e59d3004 	ldr	r3, [sp, #4]
    8ad0:	e2832004 	add	r2, r3, #4
    8ad4:	e58d2004 	str	r2, [sp, #4]
    8ad8:	e5935000 	ldr	r5, [r3]
    8adc:	e5d50000 	ldrb	r0, [r5]
    8ae0:	e3500000 	cmp	r0, #0
    8ae4:	0a00000f 	beq	8b28 <printk+0x198>
    8ae8:	eb000037 	bl	8bcc <uart_put_byte>
    8aec:	e5f50001 	ldrb	r0, [r5, #1]!
    8af0:	e3500000 	cmp	r0, #0
    8af4:	1afffffb 	bne	8ae8 <printk+0x158>
    8af8:	ea00000a 	b	8b28 <printk+0x198>
    8afc:	e59d3004 	ldr	r3, [sp, #4]
    8b00:	e2832004 	add	r2, r3, #4
    8b04:	e58d2004 	str	r2, [sp, #4]
    8b08:	e5d30000 	ldrb	r0, [r3]
    8b0c:	eb00002e 	bl	8bcc <uart_put_byte>
    8b10:	ea000004 	b	8b28 <printk+0x198>
    8b14:	e3a00025 	mov	r0, #37	; 0x25
    8b18:	eb00002b 	bl	8bcc <uart_put_byte>
    8b1c:	ea000001 	b	8b28 <printk+0x198>
    8b20:	e3e00000 	mvn	r0, #0
    8b24:	ea000003 	b	8b38 <printk+0x1a8>
    8b28:	e2844002 	add	r4, r4, #2
    8b2c:	e5d40000 	ldrb	r0, [r4]
    8b30:	e3500000 	cmp	r0, #0
    8b34:	1affff9f 	bne	89b8 <printk+0x28>
    8b38:	e28dd008 	add	sp, sp, #8
    8b3c:	e8bd41f0 	pop	{r4, r5, r6, r7, r8, lr}
    8b40:	e28dd010 	add	sp, sp, #16
    8b44:	e12fff1e 	bx	lr

00008b48 <uart_init>:
    8b48:	e92d4010 	push	{r4, lr}
    8b4c:	e3a03a05 	mov	r3, #20480	; 0x5000
    8b50:	e3433f21 	movt	r3, #16161	; 0x3f21
    8b54:	e5932004 	ldr	r2, [r3, #4]
    8b58:	e3822001 	orr	r2, r2, #1
    8b5c:	e5832004 	str	r2, [r3, #4]
    8b60:	e300210e 	movw	r2, #270	; 0x10e
    8b64:	e5832068 	str	r2, [r3, #104]	; 0x68
    8b68:	e3a04000 	mov	r4, #0
    8b6c:	e5834044 	str	r4, [r3, #68]	; 0x44
    8b70:	e593204c 	ldr	r2, [r3, #76]	; 0x4c
    8b74:	e3822003 	orr	r2, r2, #3
    8b78:	e583204c 	str	r2, [r3, #76]	; 0x4c
    8b7c:	e3a02006 	mov	r2, #6
    8b80:	e5832048 	str	r2, [r3, #72]	; 0x48
    8b84:	e3a0000f 	mov	r0, #15
    8b88:	e3a01002 	mov	r1, #2
    8b8c:	ebfffd48 	bl	80b4 <gpio_config>
    8b90:	e3a0000e 	mov	r0, #14
    8b94:	e3a01002 	mov	r1, #2
    8b98:	ebfffd45 	bl	80b4 <gpio_config>
    8b9c:	e3a0000f 	mov	r0, #15
    8ba0:	e1a01004 	mov	r1, r4
    8ba4:	ebfffd79 	bl	8190 <gpio_set_pull>
    8ba8:	e3a0000e 	mov	r0, #14
    8bac:	e1a01004 	mov	r1, r4
    8bb0:	ebfffd76 	bl	8190 <gpio_set_pull>
    8bb4:	e8bd8010 	pop	{r4, pc}

00008bb8 <uart_close>:
    8bb8:	e3a03a05 	mov	r3, #20480	; 0x5000
    8bbc:	e3433f21 	movt	r3, #16161	; 0x3f21
    8bc0:	e3a02000 	mov	r2, #0
    8bc4:	e5832004 	str	r2, [r3, #4]
    8bc8:	e12fff1e 	bx	lr

00008bcc <uart_put_byte>:
    8bcc:	e3a02a05 	mov	r2, #20480	; 0x5000
    8bd0:	e3432f21 	movt	r2, #16161	; 0x3f21
    8bd4:	e5923064 	ldr	r3, [r2, #100]	; 0x64
    8bd8:	e3130002 	tst	r3, #2
    8bdc:	0afffffc 	beq	8bd4 <uart_put_byte+0x8>
    8be0:	e3a03a05 	mov	r3, #20480	; 0x5000
    8be4:	e3433f21 	movt	r3, #16161	; 0x3f21
    8be8:	e5830040 	str	r0, [r3, #64]	; 0x40
    8bec:	e12fff1e 	bx	lr

00008bf0 <uart_get_byte>:
    8bf0:	e3a02a05 	mov	r2, #20480	; 0x5000
    8bf4:	e3432f21 	movt	r2, #16161	; 0x3f21
    8bf8:	e5923054 	ldr	r3, [r2, #84]	; 0x54
    8bfc:	e3130001 	tst	r3, #1
    8c00:	0afffffc 	beq	8bf8 <uart_get_byte+0x8>
    8c04:	e3a03a05 	mov	r3, #20480	; 0x5000
    8c08:	e3433f21 	movt	r3, #16161	; 0x3f21
    8c0c:	e5930040 	ldr	r0, [r3, #64]	; 0x40
    8c10:	e6ef0070 	uxtb	r0, r0
    8c14:	e12fff1e 	bx	lr

00008c18 <spi_master_init>:
    8c18:	e92d4038 	push	{r3, r4, r5, lr}
    8c1c:	e1a05000 	mov	r5, r0
    8c20:	e1a04001 	mov	r4, r1
    8c24:	e3a00007 	mov	r0, #7
    8c28:	e3a01004 	mov	r1, #4
    8c2c:	ebfffd20 	bl	80b4 <gpio_config>
    8c30:	e3a00008 	mov	r0, #8
    8c34:	e3a01004 	mov	r1, #4
    8c38:	ebfffd1d 	bl	80b4 <gpio_config>
    8c3c:	e3a00009 	mov	r0, #9
    8c40:	e3a01004 	mov	r1, #4
    8c44:	ebfffd1a 	bl	80b4 <gpio_config>
    8c48:	e3a0000a 	mov	r0, #10
    8c4c:	e3a01004 	mov	r1, #4
    8c50:	ebfffd17 	bl	80b4 <gpio_config>
    8c54:	e3a0000b 	mov	r0, #11
    8c58:	e3a01004 	mov	r1, #4
    8c5c:	ebfffd14 	bl	80b4 <gpio_config>
    8c60:	e3a03901 	mov	r3, #16384	; 0x4000
    8c64:	e3433f20 	movt	r3, #16160	; 0x3f20
    8c68:	e3a02000 	mov	r2, #0
    8c6c:	e5832000 	str	r2, [r3]
    8c70:	e3a02030 	mov	r2, #48	; 0x30
    8c74:	e5832000 	str	r2, [r3]
    8c78:	e5930000 	ldr	r0, [r3]
    8c7c:	e1800105 	orr	r0, r0, r5, lsl #2
    8c80:	e5830000 	str	r0, [r3]
    8c84:	e5834008 	str	r4, [r3, #8]
    8c88:	e8bd8038 	pop	{r3, r4, r5, pc}

00008c8c <spi_master_chip_sel>:
    8c8c:	e3a03901 	mov	r3, #16384	; 0x4000
    8c90:	e3433f20 	movt	r3, #16160	; 0x3f20
    8c94:	e5932000 	ldr	r2, [r3]
    8c98:	e1821301 	orr	r1, r2, r1, lsl #6
    8c9c:	e5831000 	str	r1, [r3]
    8ca0:	e5932000 	ldr	r2, [r3]
    8ca4:	e1800002 	orr	r0, r0, r2
    8ca8:	e5830000 	str	r0, [r3]
    8cac:	e12fff1e 	bx	lr

00008cb0 <spi_master_transfer_start>:
    8cb0:	e3a03901 	mov	r3, #16384	; 0x4000
    8cb4:	e3433f20 	movt	r3, #16160	; 0x3f20
    8cb8:	e5932000 	ldr	r2, [r3]
    8cbc:	e3822080 	orr	r2, r2, #128	; 0x80
    8cc0:	e5832000 	str	r2, [r3]
    8cc4:	e12fff1e 	bx	lr

00008cc8 <spi_master_transfer_end>:
    8cc8:	e3a03901 	mov	r3, #16384	; 0x4000
    8ccc:	e3433f20 	movt	r3, #16160	; 0x3f20
    8cd0:	e5932000 	ldr	r2, [r3]
    8cd4:	e3c22080 	bic	r2, r2, #128	; 0x80
    8cd8:	e5832000 	str	r2, [r3]
    8cdc:	e12fff1e 	bx	lr

00008ce0 <spi_master_transfer>:
    8ce0:	e3a02901 	mov	r2, #16384	; 0x4000
    8ce4:	e3432f20 	movt	r2, #16160	; 0x3f20
    8ce8:	e5923000 	ldr	r3, [r2]
    8cec:	e3130701 	tst	r3, #262144	; 0x40000
    8cf0:	0afffffc 	beq	8ce8 <spi_master_transfer+0x8>
    8cf4:	e3a03901 	mov	r3, #16384	; 0x4000
    8cf8:	e3433f20 	movt	r3, #16160	; 0x3f20
    8cfc:	e5932004 	ldr	r2, [r3, #4]
    8d00:	e1800002 	orr	r0, r0, r2
    8d04:	e5830004 	str	r0, [r3, #4]
    8d08:	e3a02901 	mov	r2, #16384	; 0x4000
    8d0c:	e3432f20 	movt	r2, #16160	; 0x3f20
    8d10:	e5923000 	ldr	r3, [r2]
    8d14:	e3130801 	tst	r3, #65536	; 0x10000
    8d18:	0afffffc 	beq	8d10 <spi_master_transfer+0x30>
    8d1c:	e3a03901 	mov	r3, #16384	; 0x4000
    8d20:	e3433f20 	movt	r3, #16160	; 0x3f20
    8d24:	e5930004 	ldr	r0, [r3, #4]
    8d28:	e6ef0070 	uxtb	r0, r0
    8d2c:	e12fff1e 	bx	lr

00008d30 <timer_start>:
    8d30:	e92d4010 	push	{r4, lr}
    8d34:	e1a01000 	mov	r1, r0
    8d38:	e3a04a0b 	mov	r4, #45056	; 0xb000
    8d3c:	e3434f00 	movt	r4, #16128	; 0x3f00
    8d40:	e3a03001 	mov	r3, #1
    8d44:	e5843218 	str	r3, [r4, #536]	; 0x218
    8d48:	e5943408 	ldr	r3, [r4, #1032]	; 0x408
    8d4c:	e3c3300c 	bic	r3, r3, #12
    8d50:	e5843408 	str	r3, [r4, #1032]	; 0x408
    8d54:	e5943408 	ldr	r3, [r4, #1032]	; 0x408
    8d58:	e38330a2 	orr	r3, r3, #162	; 0xa2
    8d5c:	e5843408 	str	r3, [r4, #1032]	; 0x408
    8d60:	e3040240 	movw	r0, #16960	; 0x4240
    8d64:	e340000f 	movt	r0, #15
    8d68:	eb0002e7 	bl	990c <__aeabi_idiv>
    8d6c:	e5840400 	str	r0, [r4, #1024]	; 0x400
    8d70:	e8bd8010 	pop	{r4, pc}

00008d74 <timer_stop>:
    8d74:	e3a03a0b 	mov	r3, #45056	; 0xb000
    8d78:	e3433f00 	movt	r3, #16128	; 0x3f00
    8d7c:	e3a02001 	mov	r2, #1
    8d80:	e5832224 	str	r2, [r3, #548]	; 0x224
    8d84:	e5932408 	ldr	r2, [r3, #1032]	; 0x408
    8d88:	e3c220ff 	bic	r2, r2, #255	; 0xff
    8d8c:	e5832408 	str	r2, [r3, #1032]	; 0x408
    8d90:	e12fff1e 	bx	lr

00008d94 <timer_is_pending>:
    8d94:	e3a03a0b 	mov	r3, #45056	; 0xb000
    8d98:	e3433f00 	movt	r3, #16128	; 0x3f00
    8d9c:	e5930410 	ldr	r0, [r3, #1040]	; 0x410
    8da0:	e2000001 	and	r0, r0, #1
    8da4:	e12fff1e 	bx	lr

00008da8 <timer_clear_pending>:
    8da8:	e3a03a0b 	mov	r3, #45056	; 0xb000
    8dac:	e3433f00 	movt	r3, #16128	; 0x3f00
    8db0:	e3a02001 	mov	r2, #1
    8db4:	e583240c 	str	r2, [r3, #1036]	; 0x40c
    8db8:	e12fff1e 	bx	lr

00008dbc <adc_init>:
    8dbc:	e92d4008 	push	{r3, lr}
    8dc0:	e3a00000 	mov	r0, #0
    8dc4:	e3a01c02 	mov	r1, #512	; 0x200
    8dc8:	ebffff92 	bl	8c18 <spi_master_init>
    8dcc:	e3a00000 	mov	r0, #0
    8dd0:	e1a01000 	mov	r1, r0
    8dd4:	ebffffac 	bl	8c8c <spi_master_chip_sel>
    8dd8:	e8bd8008 	pop	{r3, pc}

00008ddc <adc_read>:
    8ddc:	e92d4010 	push	{r4, lr}
    8de0:	e3500000 	cmp	r0, #0
    8de4:	03a04068 	moveq	r4, #104	; 0x68
    8de8:	0a000003 	beq	8dfc <adc_read+0x20>
    8dec:	e3500001 	cmp	r0, #1
    8df0:	13a04000 	movne	r4, #0
    8df4:	03a04078 	moveq	r4, #120	; 0x78
    8df8:	eaffffff 	b	8dfc <adc_read+0x20>
    8dfc:	ebffffab 	bl	8cb0 <spi_master_transfer_start>
    8e00:	e1a00004 	mov	r0, r4
    8e04:	ebffffb5 	bl	8ce0 <spi_master_transfer>
    8e08:	e1a00400 	lsl	r0, r0, #8
    8e0c:	e6ff4070 	uxth	r4, r0
    8e10:	e3a00000 	mov	r0, #0
    8e14:	ebffffb1 	bl	8ce0 <spi_master_transfer>
    8e18:	e1840000 	orr	r0, r4, r0
    8e1c:	e6ff4070 	uxth	r4, r0
    8e20:	ebffffa8 	bl	8cc8 <spi_master_transfer_end>
    8e24:	e1a00004 	mov	r0, r4
    8e28:	e8bd8010 	pop	{r4, pc}

00008e2c <min>:
    8e2c:	e1500001 	cmp	r0, r1
    8e30:	a1a00001 	movge	r0, r1
    8e34:	e12fff1e 	bx	lr

00008e38 <syscall_exit>:
    8e38:	e92d4008 	push	{r3, lr}
    8e3c:	e1a01000 	mov	r1, r0
    8e40:	e30b002c 	movw	r0, #45100	; 0xb02c
    8e44:	e3400000 	movt	r0, #0
    8e48:	ebfffed0 	bl	8990 <printk>
    8e4c:	eb00020e 	bl	968c <disable_interrupts>
    8e50:	ebfffc79 	bl	803c <hang>
    8e54:	e8bd8008 	pop	{r3, pc}

00008e58 <syscall_write>:
    8e58:	e3500001 	cmp	r0, #1
    8e5c:	1a00001c 	bne	8ed4 <syscall_write+0x7c>
    8e60:	e3520000 	cmp	r2, #0
    8e64:	da000015 	ble	8ec0 <syscall_write+0x68>
    8e68:	e5d10000 	ldrb	r0, [r1]
    8e6c:	e3500000 	cmp	r0, #0
    8e70:	1a000009 	bne	8e9c <syscall_write+0x44>
    8e74:	ea000003 	b	8e88 <syscall_write+0x30>
    8e78:	e4d40001 	ldrb	r0, [r4], #1
    8e7c:	e3500000 	cmp	r0, #0
    8e80:	1a000009 	bne	8eac <syscall_write+0x54>
    8e84:	ea000002 	b	8e94 <syscall_write+0x3c>
    8e88:	e3a03000 	mov	r3, #0
    8e8c:	e1a00003 	mov	r0, r3
    8e90:	e12fff1e 	bx	lr
    8e94:	e1a00003 	mov	r0, r3
    8e98:	e8bd8070 	pop	{r4, r5, r6, pc}
    8e9c:	e92d4070 	push	{r4, r5, r6, lr}
    8ea0:	e1a06001 	mov	r6, r1
    8ea4:	e2814001 	add	r4, r1, #1
    8ea8:	e0815002 	add	r5, r1, r2
    8eac:	ebffff46 	bl	8bcc <uart_put_byte>
    8eb0:	e0663004 	rsb	r3, r6, r4
    8eb4:	e1540005 	cmp	r4, r5
    8eb8:	1affffee 	bne	8e78 <syscall_write+0x20>
    8ebc:	ea000002 	b	8ecc <syscall_write+0x74>
    8ec0:	e3a03000 	mov	r3, #0
    8ec4:	e1a00003 	mov	r0, r3
    8ec8:	e12fff1e 	bx	lr
    8ecc:	e1a00003 	mov	r0, r3
    8ed0:	e8bd8070 	pop	{r4, r5, r6, pc}
    8ed4:	e3e00000 	mvn	r0, #0
    8ed8:	e12fff1e 	bx	lr

00008edc <syscall_read>:
    8edc:	e3500000 	cmp	r0, #0
    8ee0:	1a000027 	bne	8f84 <syscall_read+0xa8>
    8ee4:	e92d41f0 	push	{r4, r5, r6, r7, r8, lr}
    8ee8:	e3520000 	cmp	r2, #0
    8eec:	da000021 	ble	8f78 <syscall_read+0x9c>
    8ef0:	e1a05002 	mov	r5, r2
    8ef4:	e1a06001 	mov	r6, r1
    8ef8:	e3a04000 	mov	r4, #0
    8efc:	e1a08004 	mov	r8, r4
    8f00:	e30b7040 	movw	r7, #45120	; 0xb040
    8f04:	e3407000 	movt	r7, #0
    8f08:	ebffff38 	bl	8bf0 <uart_get_byte>
    8f0c:	e3500004 	cmp	r0, #4
    8f10:	0a00001d 	beq	8f8c <syscall_read+0xb0>
    8f14:	e3500008 	cmp	r0, #8
    8f18:	1350007f 	cmpne	r0, #127	; 0x7f
    8f1c:	1a000006 	bne	8f3c <syscall_read+0x60>
    8f20:	e3540000 	cmp	r4, #0
    8f24:	da000010 	ble	8f6c <syscall_read+0x90>
    8f28:	e2444001 	sub	r4, r4, #1
    8f2c:	e7c68004 	strb	r8, [r6, r4]
    8f30:	e1a00007 	mov	r0, r7
    8f34:	ebfffe95 	bl	8990 <printk>
    8f38:	ea00000b 	b	8f6c <syscall_read+0x90>
    8f3c:	e350000a 	cmp	r0, #10
    8f40:	1350000d 	cmpne	r0, #13
    8f44:	1a000005 	bne	8f60 <syscall_read+0x84>
    8f48:	e7c60004 	strb	r0, [r6, r4]
    8f4c:	e30b0088 	movw	r0, #45192	; 0xb088
    8f50:	e3400000 	movt	r0, #0
    8f54:	ebfffe8d 	bl	8990 <printk>
    8f58:	e2840001 	add	r0, r4, #1
    8f5c:	e8bd81f0 	pop	{r4, r5, r6, r7, r8, pc}
    8f60:	e7c60004 	strb	r0, [r6, r4]
    8f64:	ebffff18 	bl	8bcc <uart_put_byte>
    8f68:	e2844001 	add	r4, r4, #1
    8f6c:	e1550004 	cmp	r5, r4
    8f70:	caffffe4 	bgt	8f08 <syscall_read+0x2c>
    8f74:	ea000000 	b	8f7c <syscall_read+0xa0>
    8f78:	e3a04000 	mov	r4, #0
    8f7c:	e1a00004 	mov	r0, r4
    8f80:	e8bd81f0 	pop	{r4, r5, r6, r7, r8, pc}
    8f84:	e3e00000 	mvn	r0, #0
    8f88:	e12fff1e 	bx	lr
    8f8c:	e1a00004 	mov	r0, r4
    8f90:	e8bd81f0 	pop	{r4, r5, r6, r7, r8, pc}

00008f94 <syscall_sample_adc_start>:
    8f94:	e3a00001 	mov	r0, #1
    8f98:	e12fff1e 	bx	lr

00008f9c <syscall_sample_adc_stop>:
    8f9c:	e3a00001 	mov	r0, #1
    8fa0:	e12fff1e 	bx	lr

00008fa4 <syscall_thread_init>:
    8fa4:	e3510000 	cmp	r1, #0
    8fa8:	13500000 	cmpne	r0, #0
    8fac:	0a00001f 	beq	9030 <syscall_thread_init+0x8c>
    8fb0:	e52de004 	push	{lr}		; (str lr, [sp, #-4]!)
    8fb4:	e1a0e001 	mov	lr, r1
    8fb8:	e30d2004 	movw	r2, #53252	; 0xd004
    8fbc:	e3402000 	movt	r2, #0
    8fc0:	e2823a1f 	add	r3, r2, #126976	; 0x1f000
    8fc4:	e5831e44 	str	r1, [r3, #3652]	; 0xe44
    8fc8:	e5830e0c 	str	r0, [r3, #3596]	; 0xe0c
    8fcc:	e3a00000 	mov	r0, #0
    8fd0:	e5830e5c 	str	r0, [r3, #3676]	; 0xe5c
    8fd4:	e5830e60 	str	r0, [r3, #3680]	; 0xe60
    8fd8:	e3a01010 	mov	r1, #16
    8fdc:	e5831e58 	str	r1, [r3, #3672]	; 0xe58
    8fe0:	e3a0101f 	mov	r1, #31
    8fe4:	e5831e68 	str	r1, [r3, #3688]	; 0xe68
    8fe8:	e5831e6c 	str	r1, [r3, #3692]	; 0xe6c
    8fec:	e5830e70 	str	r0, [r3, #3696]	; 0xe70
    8ff0:	e3a01002 	mov	r1, #2
    8ff4:	e5c31e74 	strb	r1, [r3, #3700]	; 0xe74
    8ff8:	e59f1038 	ldr	r1, [pc, #56]	; 9038 <syscall_thread_init+0x94>
    8ffc:	e5831e50 	str	r1, [r3, #3664]	; 0xe50
    9000:	e2822802 	add	r2, r2, #131072	; 0x20000
    9004:	e3a03001 	mov	r3, #1
    9008:	e5823e78 	str	r3, [r2, #3704]	; 0xe78
    900c:	e5820e7c 	str	r0, [r2, #3708]	; 0xe7c
    9010:	e30d3f08 	movw	r3, #57096	; 0xdf08
    9014:	e3403002 	movt	r3, #2
    9018:	e3a02102 	mov	r2, #-2147483648	; 0x80000000
    901c:	e5832000 	str	r2, [r3]
    9020:	e30d3f0c 	movw	r3, #57100	; 0xdf0c
    9024:	e3403002 	movt	r3, #2
    9028:	e5830000 	str	r0, [r3]
    902c:	e49df004 	pop	{pc}		; (ldr pc, [sp], #4)
    9030:	e3e00000 	mvn	r0, #0
    9034:	e12fff1e 	bx	lr
    9038:	0002de78 	andeq	sp, r2, r8, ror lr

0000903c <syscall_thread_create>:
    903c:	e92d4030 	push	{r4, r5, lr}
    9040:	e1a05001 	mov	r5, r1
    9044:	e352001f 	cmp	r2, #31
    9048:	93a0c000 	movls	ip, #0
    904c:	83a0c001 	movhi	ip, #1
    9050:	e3510000 	cmp	r1, #0
    9054:	11a0100c 	movne	r1, ip
    9058:	038c1001 	orreq	r1, ip, #1
    905c:	e1a04000 	mov	r4, r0
    9060:	e3500000 	cmp	r0, #0
    9064:	11a00001 	movne	r0, r1
    9068:	03810001 	orreq	r0, r1, #1
    906c:	e3500000 	cmp	r0, #0
    9070:	1a000020 	bne	90f8 <syscall_thread_create+0xbc>
    9074:	e30dc004 	movw	ip, #53252	; 0xd004
    9078:	e340c000 	movt	ip, #0
    907c:	e301e074 	movw	lr, #4212	; 0x1074
    9080:	e00e029e 	mul	lr, lr, r2
    9084:	e08c100e 	add	r1, ip, lr
    9088:	e3a00010 	mov	r0, #16
    908c:	e581004c 	str	r0, [r1, #76]	; 0x4c
    9090:	e5815038 	str	r5, [r1, #56]	; 0x38
    9094:	e78c400e 	str	r4, [ip, lr]
    9098:	e5813050 	str	r3, [r1, #80]	; 0x50
    909c:	e59d300c 	ldr	r3, [sp, #12]
    90a0:	e5813054 	str	r3, [r1, #84]	; 0x54
    90a4:	e3a00000 	mov	r0, #0
    90a8:	e5810058 	str	r0, [r1, #88]	; 0x58
    90ac:	e581205c 	str	r2, [r1, #92]	; 0x5c
    90b0:	e5812060 	str	r2, [r1, #96]	; 0x60
    90b4:	e5810064 	str	r0, [r1, #100]	; 0x64
    90b8:	e3a03002 	mov	r3, #2
    90bc:	e5c13068 	strb	r3, [r1, #104]	; 0x68
    90c0:	e281cd41 	add	ip, r1, #4160	; 0x1040
    90c4:	e28cc028 	add	ip, ip, #40	; 0x28
    90c8:	e581c044 	str	ip, [r1, #68]	; 0x44
    90cc:	e3013070 	movw	r3, #4208	; 0x1070
    90d0:	e7810003 	str	r0, [r1, r3]
    90d4:	e1a0100c 	mov	r1, ip
    90d8:	e3a0c001 	mov	ip, #1
    90dc:	e581c004 	str	ip, [r1, #4]
    90e0:	e30d3f08 	movw	r3, #57096	; 0xdf08
    90e4:	e3403002 	movt	r3, #2
    90e8:	e5931000 	ldr	r1, [r3]
    90ec:	e181221c 	orr	r2, r1, ip, lsl r2
    90f0:	e5832000 	str	r2, [r3]
    90f4:	e8bd8030 	pop	{r4, r5, pc}
    90f8:	e3e00000 	mvn	r0, #0
    90fc:	e8bd8030 	pop	{r4, r5, pc}

00009100 <syscall_mutex_init>:
    9100:	e1a02000 	mov	r2, r0
    9104:	e351001f 	cmp	r1, #31
    9108:	93a03000 	movls	r3, #0
    910c:	83a03001 	movhi	r3, #1
    9110:	e3500000 	cmp	r0, #0
    9114:	11a00003 	movne	r0, r3
    9118:	03830001 	orreq	r0, r3, #1
    911c:	e3500000 	cmp	r0, #0
    9120:	05821000 	streq	r1, [r2]
    9124:	03e03000 	mvneq	r3, #0
    9128:	05823004 	streq	r3, [r2, #4]
    912c:	05820008 	streq	r0, [r2, #8]
    9130:	13e00000 	mvnne	r0, #0
    9134:	e12fff1e 	bx	lr

00009138 <syscall_mutex_lock>:
    9138:	e92d4010 	push	{r4, lr}
    913c:	e1a04000 	mov	r4, r0
    9140:	eb000151 	bl	968c <disable_interrupts>
    9144:	e30d3e84 	movw	r3, #56964	; 0xde84
    9148:	e3403002 	movt	r3, #2
    914c:	e30c2000 	movw	r2, #49152	; 0xc000
    9150:	e3402000 	movt	r2, #0
    9154:	e5922000 	ldr	r2, [r2]
    9158:	e7933102 	ldr	r3, [r3, r2, lsl #2]
    915c:	e30d1004 	movw	r1, #53252	; 0xd004
    9160:	e3401000 	movt	r1, #0
    9164:	e3012074 	movw	r2, #4212	; 0x1074
    9168:	e0221392 	mla	r2, r2, r3, r1
    916c:	e5922060 	ldr	r2, [r2, #96]	; 0x60
    9170:	e5941000 	ldr	r1, [r4]
    9174:	e1510002 	cmp	r1, r2
    9178:	a1a01002 	movge	r1, r2
    917c:	e5942004 	ldr	r2, [r4, #4]
    9180:	e3720001 	cmn	r2, #1
    9184:	1afffffc 	bne	917c <syscall_mutex_lock+0x44>
    9188:	e30d0004 	movw	r0, #53252	; 0xd004
    918c:	e3400000 	movt	r0, #0
    9190:	e3012074 	movw	r2, #4212	; 0x1074
    9194:	e0220392 	mla	r2, r2, r3, r0
    9198:	e592005c 	ldr	r0, [r2, #92]	; 0x5c
    919c:	e5840004 	str	r0, [r4, #4]
    91a0:	e3010070 	movw	r0, #4208	; 0x1070
    91a4:	e7922000 	ldr	r2, [r2, r0]
    91a8:	e3520000 	cmp	r2, #0
    91ac:	e30d0004 	movw	r0, #53252	; 0xd004
    91b0:	e3400000 	movt	r0, #0
    91b4:	e3012074 	movw	r2, #4212	; 0x1074
    91b8:	e0220392 	mla	r2, r2, r3, r0
    91bc:	e3010070 	movw	r0, #4208	; 0x1070
    91c0:	07824000 	streq	r4, [r2, r0]
    91c4:	03a02000 	moveq	r2, #0
    91c8:	05842008 	streq	r2, [r4, #8]
    91cc:	1792c000 	ldrne	ip, [r2, r0]
    91d0:	1584c008 	strne	ip, [r4, #8]
    91d4:	17824000 	strne	r4, [r2, r0]
    91d8:	e30d2004 	movw	r2, #53252	; 0xd004
    91dc:	e3402000 	movt	r2, #0
    91e0:	e3010074 	movw	r0, #4212	; 0x1074
    91e4:	e0232390 	mla	r3, r0, r3, r2
    91e8:	e5932060 	ldr	r2, [r3, #96]	; 0x60
    91ec:	e30dcf08 	movw	ip, #57096	; 0xdf08
    91f0:	e340c002 	movt	ip, #2
    91f4:	e3a0e001 	mov	lr, #1
    91f8:	e59c0000 	ldr	r0, [ip]
    91fc:	e1c0221e 	bic	r2, r0, lr, lsl r2
    9200:	e182211e 	orr	r2, r2, lr, lsl r1
    9204:	e58c2000 	str	r2, [ip]
    9208:	e5831060 	str	r1, [r3, #96]	; 0x60
    920c:	e5942000 	ldr	r2, [r4]
    9210:	e593105c 	ldr	r1, [r3, #92]	; 0x5c
    9214:	e30d3e84 	movw	r3, #56964	; 0xde84
    9218:	e3403002 	movt	r3, #2
    921c:	e7831102 	str	r1, [r3, r2, lsl #2]
    9220:	eb00011e 	bl	96a0 <enable_interrupts>
    9224:	e8bd8010 	pop	{r4, pc}

00009228 <syscall_mutex_unlock>:
    9228:	e92d4038 	push	{r3, r4, r5, lr}
    922c:	e1a04000 	mov	r4, r0
    9230:	eb000115 	bl	968c <disable_interrupts>
    9234:	e30d3e84 	movw	r3, #56964	; 0xde84
    9238:	e3403002 	movt	r3, #2
    923c:	e30c2000 	movw	r2, #49152	; 0xc000
    9240:	e3402000 	movt	r2, #0
    9244:	e5922000 	ldr	r2, [r2]
    9248:	e7935102 	ldr	r5, [r3, r2, lsl #2]
    924c:	e3e03000 	mvn	r3, #0
    9250:	e5843004 	str	r3, [r4, #4]
    9254:	e30d2004 	movw	r2, #53252	; 0xd004
    9258:	e3402000 	movt	r2, #0
    925c:	e3013074 	movw	r3, #4212	; 0x1074
    9260:	e0232593 	mla	r3, r3, r5, r2
    9264:	e3012070 	movw	r2, #4208	; 0x1070
    9268:	e7933002 	ldr	r3, [r3, r2]
    926c:	e3530000 	cmp	r3, #0
    9270:	1a000004 	bne	9288 <syscall_mutex_unlock+0x60>
    9274:	e30b0044 	movw	r0, #45124	; 0xb044
    9278:	e3400000 	movt	r0, #0
    927c:	ebfffdc3 	bl	8990 <printk>
    9280:	e3a00001 	mov	r0, #1
    9284:	ebfffeeb 	bl	8e38 <syscall_exit>
    9288:	e30d2004 	movw	r2, #53252	; 0xd004
    928c:	e3402000 	movt	r2, #0
    9290:	e3013074 	movw	r3, #4212	; 0x1074
    9294:	e0232593 	mla	r3, r3, r5, r2
    9298:	e3012070 	movw	r2, #4208	; 0x1070
    929c:	e7933002 	ldr	r3, [r3, r2]
    92a0:	e1530004 	cmp	r3, r4
    92a4:	1a000007 	bne	92c8 <syscall_mutex_unlock+0xa0>
    92a8:	e5931008 	ldr	r1, [r3, #8]
    92ac:	e30d2004 	movw	r2, #53252	; 0xd004
    92b0:	e3402000 	movt	r2, #0
    92b4:	e3013074 	movw	r3, #4212	; 0x1074
    92b8:	e0232593 	mla	r3, r3, r5, r2
    92bc:	e3012070 	movw	r2, #4208	; 0x1070
    92c0:	e7831002 	str	r1, [r3, r2]
    92c4:	ea00001a 	b	9334 <syscall_mutex_unlock+0x10c>
    92c8:	e5933008 	ldr	r3, [r3, #8]
    92cc:	e30d2004 	movw	r2, #53252	; 0xd004
    92d0:	e3402000 	movt	r2, #0
    92d4:	e3013074 	movw	r3, #4212	; 0x1074
    92d8:	e0232593 	mla	r3, r3, r5, r2
    92dc:	e3012070 	movw	r2, #4208	; 0x1070
    92e0:	e7930002 	ldr	r0, [r3, r2]
    92e4:	e5901008 	ldr	r1, [r0, #8]
    92e8:	e3510000 	cmp	r1, #0
    92ec:	0a000061 	beq	9478 <syscall_mutex_unlock+0x250>
    92f0:	e5913008 	ldr	r3, [r1, #8]
    92f4:	e1540001 	cmp	r4, r1
    92f8:	1a00000a 	bne	9328 <syscall_mutex_unlock+0x100>
    92fc:	ea000003 	b	9310 <syscall_mutex_unlock+0xe8>
    9300:	e5932008 	ldr	r2, [r3, #8]
    9304:	e1540003 	cmp	r4, r3
    9308:	1a000004 	bne	9320 <syscall_mutex_unlock+0xf8>
    930c:	ea000001 	b	9318 <syscall_mutex_unlock+0xf0>
    9310:	e1a02003 	mov	r2, r3
    9314:	e1a01000 	mov	r1, r0
    9318:	e5812008 	str	r2, [r1, #8]
    931c:	ea000004 	b	9334 <syscall_mutex_unlock+0x10c>
    9320:	e1a01003 	mov	r1, r3
    9324:	e1a03002 	mov	r3, r2
    9328:	e3530000 	cmp	r3, #0
    932c:	1afffff3 	bne	9300 <syscall_mutex_unlock+0xd8>
    9330:	ea000050 	b	9478 <syscall_mutex_unlock+0x250>
    9334:	e30d2004 	movw	r2, #53252	; 0xd004
    9338:	e3402000 	movt	r2, #0
    933c:	e3013074 	movw	r3, #4212	; 0x1074
    9340:	e0232593 	mla	r3, r3, r5, r2
    9344:	e3012070 	movw	r2, #4208	; 0x1070
    9348:	e7933002 	ldr	r3, [r3, r2]
    934c:	e3530000 	cmp	r3, #0
    9350:	0a000011 	beq	939c <syscall_mutex_unlock+0x174>
    9354:	e3e02000 	mvn	r2, #0
    9358:	e3a01000 	mov	r1, #0
    935c:	e3720001 	cmn	r2, #1
    9360:	0a000002 	beq	9370 <syscall_mutex_unlock+0x148>
    9364:	e5930000 	ldr	r0, [r3]
    9368:	e1500002 	cmp	r0, r2
    936c:	aa000000 	bge	9374 <syscall_mutex_unlock+0x14c>
    9370:	e5932000 	ldr	r2, [r3]
    9374:	e593c000 	ldr	ip, [r3]
    9378:	e5940000 	ldr	r0, [r4]
    937c:	e15c0000 	cmp	ip, r0
    9380:	03a01001 	moveq	r1, #1
    9384:	e5933008 	ldr	r3, [r3, #8]
    9388:	e3530000 	cmp	r3, #0
    938c:	1afffff2 	bne	935c <syscall_mutex_unlock+0x134>
    9390:	e3720001 	cmn	r2, #1
    9394:	1a000006 	bne	93b4 <syscall_mutex_unlock+0x18c>
    9398:	ea000000 	b	93a0 <syscall_mutex_unlock+0x178>
    939c:	e3a01000 	mov	r1, #0
    93a0:	e30d2004 	movw	r2, #53252	; 0xd004
    93a4:	e3402000 	movt	r2, #0
    93a8:	e3013074 	movw	r3, #4212	; 0x1074
    93ac:	e0232593 	mla	r3, r3, r5, r2
    93b0:	e593205c 	ldr	r2, [r3, #92]	; 0x5c
    93b4:	e3510000 	cmp	r1, #0
    93b8:	1a000034 	bne	9490 <syscall_mutex_unlock+0x268>
    93bc:	e5940000 	ldr	r0, [r4]
    93c0:	e3a0c001 	mov	ip, #1
    93c4:	e30d3f08 	movw	r3, #57096	; 0xdf08
    93c8:	e3403002 	movt	r3, #2
    93cc:	e5931000 	ldr	r1, [r3]
    93d0:	e1c1101c 	bic	r1, r1, ip, lsl r0
    93d4:	e181021c 	orr	r0, r1, ip, lsl r2
    93d8:	e5830000 	str	r0, [r3]
    93dc:	e5941000 	ldr	r1, [r4]
    93e0:	e594c000 	ldr	ip, [r4]
    93e4:	e30d3e84 	movw	r3, #56964	; 0xde84
    93e8:	e3403002 	movt	r3, #2
    93ec:	e783c101 	str	ip, [r3, r1, lsl #2]
    93f0:	e5941000 	ldr	r1, [r4]
    93f4:	e30d3004 	movw	r3, #53252	; 0xd004
    93f8:	e3403000 	movt	r3, #0
    93fc:	e301c074 	movw	ip, #4212	; 0x1074
    9400:	e023319c 	mla	r3, ip, r1, r3
    9404:	e2833d41 	add	r3, r3, #4160	; 0x1040
    9408:	e2833028 	add	r3, r3, #40	; 0x28
    940c:	e5933004 	ldr	r3, [r3, #4]
    9410:	e3530000 	cmp	r3, #0
    9414:	0a00000d 	beq	9450 <syscall_mutex_unlock+0x228>
    9418:	e5941000 	ldr	r1, [r4]
    941c:	e30d3004 	movw	r3, #53252	; 0xd004
    9420:	e3403000 	movt	r3, #0
    9424:	e023319c 	mla	r3, ip, r1, r3
    9428:	e5d33068 	ldrb	r3, [r3, #104]	; 0x68
    942c:	e6ef3073 	uxtb	r3, r3
    9430:	e3530002 	cmp	r3, #2
    9434:	1a000005 	bne	9450 <syscall_mutex_unlock+0x228>
    9438:	e594c000 	ldr	ip, [r4]
    943c:	e30d3f08 	movw	r3, #57096	; 0xdf08
    9440:	e3403002 	movt	r3, #2
    9444:	e3a01001 	mov	r1, #1
    9448:	e1800c11 	orr	r0, r0, r1, lsl ip
    944c:	e5830000 	str	r0, [r3]
    9450:	e30c3000 	movw	r3, #49152	; 0xc000
    9454:	e3403000 	movt	r3, #0
    9458:	e5832000 	str	r2, [r3]
    945c:	e30d1004 	movw	r1, #53252	; 0xd004
    9460:	e3401000 	movt	r1, #0
    9464:	e3013074 	movw	r3, #4212	; 0x1074
    9468:	e0251593 	mla	r5, r3, r5, r1
    946c:	e5852060 	str	r2, [r5, #96]	; 0x60
    9470:	eb00008a 	bl	96a0 <enable_interrupts>
    9474:	e8bd8038 	pop	{r3, r4, r5, pc}
    9478:	e30b0074 	movw	r0, #45172	; 0xb074
    947c:	e3400000 	movt	r0, #0
    9480:	ebfffd42 	bl	8990 <printk>
    9484:	e3a00001 	mov	r0, #1
    9488:	ebfffe6a 	bl	8e38 <syscall_exit>
    948c:	eaffffa8 	b	9334 <syscall_mutex_unlock+0x10c>
    9490:	e30d3f08 	movw	r3, #57096	; 0xdf08
    9494:	e3403002 	movt	r3, #2
    9498:	e5931000 	ldr	r1, [r3]
    949c:	e3a00001 	mov	r0, #1
    94a0:	e1810210 	orr	r0, r1, r0, lsl r2
    94a4:	e5830000 	str	r0, [r3]
    94a8:	eaffffd0 	b	93f0 <syscall_mutex_unlock+0x1c8>

000094ac <syscall_wait_until_next_period>:
    94ac:	e92d4008 	push	{r3, lr}
    94b0:	e30c3000 	movw	r3, #49152	; 0xc000
    94b4:	e3403000 	movt	r3, #0
    94b8:	e5932000 	ldr	r2, [r3]
    94bc:	e30d3e84 	movw	r3, #56964	; 0xde84
    94c0:	e3403002 	movt	r3, #2
    94c4:	e7933102 	ldr	r3, [r3, r2, lsl #2]
    94c8:	e1520003 	cmp	r2, r3
    94cc:	0a000004 	beq	94e4 <syscall_wait_until_next_period+0x38>
    94d0:	e30b008c 	movw	r0, #45196	; 0xb08c
    94d4:	e3400000 	movt	r0, #0
    94d8:	ebfffd2c 	bl	8990 <printk>
    94dc:	e3a00001 	mov	r0, #1
    94e0:	ebfffe54 	bl	8e38 <syscall_exit>
    94e4:	e30c3000 	movw	r3, #49152	; 0xc000
    94e8:	e3403000 	movt	r3, #0
    94ec:	e5933000 	ldr	r3, [r3]
    94f0:	e30d1004 	movw	r1, #53252	; 0xd004
    94f4:	e3401000 	movt	r1, #0
    94f8:	e3012074 	movw	r2, #4212	; 0x1074
    94fc:	e0221392 	mla	r2, r2, r3, r1
    9500:	e3a01000 	mov	r1, #0
    9504:	e5c21068 	strb	r1, [r2, #104]	; 0x68
    9508:	e30d2004 	movw	r2, #53252	; 0xd004
    950c:	e3402000 	movt	r2, #0
    9510:	e3011074 	movw	r1, #4212	; 0x1074
    9514:	e0222391 	mla	r2, r1, r3, r2
    9518:	e5d23068 	ldrb	r3, [r2, #104]	; 0x68
    951c:	e31300ff 	tst	r3, #255	; 0xff
    9520:	0afffffc 	beq	9518 <syscall_wait_until_next_period+0x6c>
    9524:	e8bd8008 	pop	{r3, pc}

00009528 <syscall_get_time>:
    9528:	e30d3f04 	movw	r3, #57092	; 0xdf04
    952c:	e3403002 	movt	r3, #2
    9530:	e5930000 	ldr	r0, [r3]
    9534:	e12fff1e 	bx	lr

00009538 <syscall_scheduler_start>:
    9538:	e92d47f0 	push	{r4, r5, r6, r7, r8, r9, sl, lr}
    953c:	e30d4004 	movw	r4, #53252	; 0xd004
    9540:	e3404000 	movt	r4, #0
    9544:	e59f80a8 	ldr	r8, [pc, #168]	; 95f4 <syscall_scheduler_start+0xbc>
    9548:	e3a09000 	mov	r9, #0
    954c:	e3a05000 	mov	r5, #0
    9550:	e1a07004 	mov	r7, r4
    9554:	e3016074 	movw	r6, #4212	; 0x1074
    9558:	e0237596 	mla	r3, r6, r5, r7
    955c:	e5d33068 	ldrb	r3, [r3, #104]	; 0x68
    9560:	e6ef3073 	uxtb	r3, r3
    9564:	e3530002 	cmp	r3, #2
    9568:	1a00000b 	bne	959c <syscall_scheduler_start+0x64>
    956c:	e5940050 	ldr	r0, [r4, #80]	; 0x50
    9570:	eb0001aa 	bl	9c20 <__aeabi_ui2f>
    9574:	e1a0a000 	mov	sl, r0
    9578:	e5940054 	ldr	r0, [r4, #84]	; 0x54
    957c:	eb0001a7 	bl	9c20 <__aeabi_ui2f>
    9580:	e1a01000 	mov	r1, r0
    9584:	e1a0000a 	mov	r0, sl
    9588:	eb000243 	bl	9e9c <__aeabi_fdiv>
    958c:	e1a01000 	mov	r1, r0
    9590:	e1a00009 	mov	r0, r9
    9594:	eb000132 	bl	9a64 <__addsf3>
    9598:	e1a09000 	mov	r9, r0
    959c:	e2855001 	add	r5, r5, #1
    95a0:	e0844006 	add	r4, r4, r6
    95a4:	e1540008 	cmp	r4, r8
    95a8:	1affffea 	bne	9558 <syscall_scheduler_start+0x20>
    95ac:	e30d3f08 	movw	r3, #57096	; 0xdf08
    95b0:	e3403002 	movt	r3, #2
    95b4:	e5930000 	ldr	r0, [r3]
    95b8:	eb0002e3 	bl	a14c <__popcountsi2>
    95bc:	e30c3008 	movw	r3, #49160	; 0xc008
    95c0:	e3403000 	movt	r3, #0
    95c4:	e2402001 	sub	r2, r0, #1
    95c8:	e1a00009 	mov	r0, r9
    95cc:	e7931102 	ldr	r1, [r3, r2, lsl #2]
    95d0:	eb0002bc 	bl	a0c8 <__aeabi_fcmple>
    95d4:	e3500000 	cmp	r0, #0
    95d8:	0a000003 	beq	95ec <syscall_scheduler_start+0xb4>
    95dc:	eb00002f 	bl	96a0 <enable_interrupts>
    95e0:	e3a00ffa 	mov	r0, #1000	; 0x3e8
    95e4:	ebfffdd1 	bl	8d30 <timer_start>
    95e8:	eafffffe 	b	95e8 <syscall_scheduler_start+0xb0>
    95ec:	e3e00000 	mvn	r0, #0
    95f0:	e8bd87f0 	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
    95f4:	0002ce10 	andeq	ip, r2, r0, lsl lr

000095f8 <syscall_sbrk>:
    95f8:	e30d3000 	movw	r3, #53248	; 0xd000
    95fc:	e3403000 	movt	r3, #0
    9600:	e5933000 	ldr	r3, [r3]
    9604:	e3530000 	cmp	r3, #0
    9608:	030d3000 	movweq	r3, #53248	; 0xd000
    960c:	03403000 	movteq	r3, #0
    9610:	030e2000 	movweq	r2, #57344	; 0xe000
    9614:	03402002 	movteq	r2, #2
    9618:	05832000 	streq	r2, [r3]
    961c:	e30d3000 	movw	r3, #53248	; 0xd000
    9620:	e3403000 	movt	r3, #0
    9624:	e5933000 	ldr	r3, [r3]
    9628:	e0830000 	add	r0, r3, r0
    962c:	e30e2000 	movw	r2, #57344	; 0xe000
    9630:	e3402012 	movt	r2, #18
    9634:	e1500002 	cmp	r0, r2
    9638:	930d2000 	movwls	r2, #53248	; 0xd000
    963c:	93402000 	movtls	r2, #0
    9640:	95820000 	strls	r0, [r2]
    9644:	91a00003 	movls	r0, r3
    9648:	83e00000 	mvnhi	r0, #0
    964c:	e12fff1e 	bx	lr

00009650 <syscall_close>:
    9650:	e3e00000 	mvn	r0, #0
    9654:	e12fff1e 	bx	lr

00009658 <syscall_fstat>:
    9658:	e3a00000 	mov	r0, #0
    965c:	e12fff1e 	bx	lr

00009660 <syscall_isatty>:
    9660:	e3a00001 	mov	r0, #1
    9664:	e12fff1e 	bx	lr

00009668 <syscall_lseek>:
    9668:	e3a00000 	mov	r0, #0
    966c:	e12fff1e 	bx	lr

00009670 <delay_cycles>:
    9670:	e2500001 	subs	r0, r0, #1
    9674:	1afffffd 	bne	9670 <delay_cycles>
    9678:	e1a0f00e 	mov	pc, lr

0000967c <read_cpsr>:
    967c:	e10f0000 	mrs	r0, CPSR
    9680:	e1a0f00e 	mov	pc, lr

00009684 <write_cpsr>:
    9684:	e129f000 	msr	CPSR_fc, r0
    9688:	e1a0f00e 	mov	pc, lr

0000968c <disable_interrupts>:
    968c:	e10f0000 	mrs	r0, CPSR
    9690:	e3a01d07 	mov	r1, #448	; 0x1c0
    9694:	e1800001 	orr	r0, r0, r1
    9698:	e129f000 	msr	CPSR_fc, r0
    969c:	e1a0f00e 	mov	pc, lr

000096a0 <enable_interrupts>:
    96a0:	e10f0000 	mrs	r0, CPSR
    96a4:	e3a01d07 	mov	r1, #448	; 0x1c0
    96a8:	e1c00001 	bic	r0, r0, r1
    96ac:	e129f000 	msr	CPSR_fc, r0
    96b0:	e1a0f00e 	mov	pc, lr

000096b4 <interrupt_vector_table>:
    96b4:	e59ff018 	ldr	pc, [pc, #24]	; 96d4 <_reset_asm_handler>
    96b8:	e59ff018 	ldr	pc, [pc, #24]	; 96d8 <_undefined_instruction_asm_handler>
    96bc:	e59ff018 	ldr	pc, [pc, #24]	; 96dc <_swi_asm_handler>
    96c0:	e59ff018 	ldr	pc, [pc, #24]	; 96e0 <_prefetch_abort_asm_handler>
    96c4:	e59ff018 	ldr	pc, [pc, #24]	; 96e4 <_data_abort_asm_handler>
    96c8:	e59ff004 	ldr	pc, [pc, #4]	; 96d4 <_reset_asm_handler>
    96cc:	e59ff014 	ldr	pc, [pc, #20]	; 96e8 <_irq_asm_handler>
    96d0:	e59ff014 	ldr	pc, [pc, #20]	; 96ec <_fiq_asm_handler>

000096d4 <_reset_asm_handler>:
    96d4:	000097b8 			; <UNDEFINED> instruction: 0x000097b8

000096d8 <_undefined_instruction_asm_handler>:
    96d8:	000097bc 			; <UNDEFINED> instruction: 0x000097bc

000096dc <_swi_asm_handler>:
    96dc:	00009714 	andeq	r9, r0, r4, lsl r7

000096e0 <_prefetch_abort_asm_handler>:
    96e0:	000097c0 	andeq	r9, r0, r0, asr #15

000096e4 <_data_abort_asm_handler>:
    96e4:	000097c4 	andeq	r9, r0, r4, asr #15

000096e8 <_irq_asm_handler>:
    96e8:	00009750 	andeq	r9, r0, r0, asr r7

000096ec <_fiq_asm_handler>:
    96ec:	000097c8 	andeq	r9, r0, r8, asr #15

000096f0 <install_interrupt_table>:
    96f0:	e92d03f0 	push	{r4, r5, r6, r7, r8, r9}
    96f4:	e59f00f0 	ldr	r0, [pc, #240]	; 97ec <enter_user_mode+0x20>
    96f8:	e3a01000 	mov	r1, #0
    96fc:	e8b003fc 	ldm	r0!, {r2, r3, r4, r5, r6, r7, r8, r9}
    9700:	e8a103fc 	stmia	r1!, {r2, r3, r4, r5, r6, r7, r8, r9}
    9704:	e8b001fc 	ldm	r0!, {r2, r3, r4, r5, r6, r7, r8}
    9708:	e8a101fc 	stmia	r1!, {r2, r3, r4, r5, r6, r7, r8}
    970c:	e8bd03f0 	pop	{r4, r5, r6, r7, r8, r9}
    9710:	e12fff1e 	bx	lr

00009714 <swi_asm_handler>:
    9714:	f1080080 	cpsie	i
    9718:	e24dd004 	sub	sp, sp, #4
    971c:	e92d5fff 	push	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
    9720:	e14f2000 	mrs	r2, SPSR
    9724:	e58d2038 	str	r2, [sp, #56]	; 0x38
    9728:	e1a0100d 	mov	r1, sp
    972c:	e51e0004 	ldr	r0, [lr, #-4]
    9730:	e3c004ff 	bic	r0, r0, #-16777216	; 0xff000000
    9734:	ebfffbfc 	bl	872c <swi_c_handler>
    9738:	e59d2038 	ldr	r2, [sp, #56]	; 0x38
    973c:	e169f002 	msr	SPSR_fc, r2
    9740:	e28dd004 	add	sp, sp, #4
    9744:	e8bd5ffe 	pop	{r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
    9748:	e28dd004 	add	sp, sp, #4
    974c:	e1b0f00e 	movs	pc, lr

00009750 <irq_asm_handler>:
    9750:	e24ee004 	sub	lr, lr, #4
    9754:	e59fd094 	ldr	sp, [pc, #148]	; 97f0 <enter_user_mode+0x24>
    9758:	e92d5fff 	push	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
    975c:	e14f2000 	mrs	r2, SPSR
    9760:	e92d0004 	stmfd	sp!, {r2}
    9764:	e1a0000d 	mov	r0, sp
    9768:	e321f093 	msr	CPSR_c, #147	; 0x93
    976c:	e14f2000 	mrs	r2, SPSR
    9770:	e9206004 	stmdb	r0!, {r2, sp, lr}
    9774:	e321f09f 	msr	CPSR_c, #159	; 0x9f
    9778:	e9206000 	stmdb	r0!, {sp, lr}
    977c:	e321f092 	msr	CPSR_c, #146	; 0x92
    9780:	e1a0d000 	mov	sp, r0
    9784:	ebfffbc9 	bl	86b0 <irq_c_handler>
    9788:	e1a0d000 	mov	sp, r0
    978c:	e321f09f 	msr	CPSR_c, #159	; 0x9f
    9790:	e8b06000 	ldm	r0!, {sp, lr}
    9794:	e321f093 	msr	CPSR_c, #147	; 0x93
    9798:	e8b06004 	ldm	r0!, {r2, sp, lr}
    979c:	e169f002 	msr	SPSR_fc, r2
    97a0:	e321f092 	msr	CPSR_c, #146	; 0x92
    97a4:	e8b00004 	ldm	r0!, {r2}
    97a8:	e169f002 	msr	SPSR_fc, r2
    97ac:	e1a0d000 	mov	sp, r0
    97b0:	e8bd5fff 	pop	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
    97b4:	e1b0f00e 	movs	pc, lr

000097b8 <reset_asm_handler>:
    97b8:	e1200070 	bkpt	0x0000

000097bc <undefined_instruction_asm_handler>:
    97bc:	e1200070 	bkpt	0x0000

000097c0 <prefetch_abort_asm_handler>:
    97c0:	e1200070 	bkpt	0x0000

000097c4 <data_abort_asm_handler>:
    97c4:	e1200070 	bkpt	0x0000

000097c8 <fiq_asm_handler>:
    97c8:	e1200070 	bkpt	0x0000

000097cc <enter_user_mode>:
    97cc:	e24dd004 	sub	sp, sp, #4
    97d0:	e92d5fff 	push	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
    97d4:	e14f2000 	mrs	r2, SPSR
    97d8:	e58d2038 	str	r2, [sp, #56]	; 0x38
    97dc:	e3a02090 	mov	r2, #144	; 0x90
    97e0:	e121f002 	msr	CPSR_c, r2
    97e4:	e59fd008 	ldr	sp, [pc, #8]	; 97f4 <enter_user_mode+0x28>
    97e8:	eb0bda04 	bl	300000 <__user_program>
    97ec:	000096b4 			; <UNDEFINED> instruction: 0x000096b4
    97f0:	0014f000 	andseq	pc, r4, r0
    97f4:	0014e000 	andseq	lr, r4, r0

000097f8 <__aeabi_uidiv>:
    97f8:	e2512001 	subs	r2, r1, #1
    97fc:	012fff1e 	bxeq	lr
    9800:	3a000036 	bcc	98e0 <__aeabi_uidiv+0xe8>
    9804:	e1500001 	cmp	r0, r1
    9808:	9a000022 	bls	9898 <__aeabi_uidiv+0xa0>
    980c:	e1110002 	tst	r1, r2
    9810:	0a000023 	beq	98a4 <__aeabi_uidiv+0xac>
    9814:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    9818:	01a01181 	lsleq	r1, r1, #3
    981c:	03a03008 	moveq	r3, #8
    9820:	13a03001 	movne	r3, #1
    9824:	e3510201 	cmp	r1, #268435456	; 0x10000000
    9828:	31510000 	cmpcc	r1, r0
    982c:	31a01201 	lslcc	r1, r1, #4
    9830:	31a03203 	lslcc	r3, r3, #4
    9834:	3afffffa 	bcc	9824 <__aeabi_uidiv+0x2c>
    9838:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    983c:	31510000 	cmpcc	r1, r0
    9840:	31a01081 	lslcc	r1, r1, #1
    9844:	31a03083 	lslcc	r3, r3, #1
    9848:	3afffffa 	bcc	9838 <__aeabi_uidiv+0x40>
    984c:	e3a02000 	mov	r2, #0
    9850:	e1500001 	cmp	r0, r1
    9854:	20400001 	subcs	r0, r0, r1
    9858:	21822003 	orrcs	r2, r2, r3
    985c:	e15000a1 	cmp	r0, r1, lsr #1
    9860:	204000a1 	subcs	r0, r0, r1, lsr #1
    9864:	218220a3 	orrcs	r2, r2, r3, lsr #1
    9868:	e1500121 	cmp	r0, r1, lsr #2
    986c:	20400121 	subcs	r0, r0, r1, lsr #2
    9870:	21822123 	orrcs	r2, r2, r3, lsr #2
    9874:	e15001a1 	cmp	r0, r1, lsr #3
    9878:	204001a1 	subcs	r0, r0, r1, lsr #3
    987c:	218221a3 	orrcs	r2, r2, r3, lsr #3
    9880:	e3500000 	cmp	r0, #0
    9884:	11b03223 	lsrsne	r3, r3, #4
    9888:	11a01221 	lsrne	r1, r1, #4
    988c:	1affffef 	bne	9850 <__aeabi_uidiv+0x58>
    9890:	e1a00002 	mov	r0, r2
    9894:	e12fff1e 	bx	lr
    9898:	03a00001 	moveq	r0, #1
    989c:	13a00000 	movne	r0, #0
    98a0:	e12fff1e 	bx	lr
    98a4:	e3510801 	cmp	r1, #65536	; 0x10000
    98a8:	21a01821 	lsrcs	r1, r1, #16
    98ac:	23a02010 	movcs	r2, #16
    98b0:	33a02000 	movcc	r2, #0
    98b4:	e3510c01 	cmp	r1, #256	; 0x100
    98b8:	21a01421 	lsrcs	r1, r1, #8
    98bc:	22822008 	addcs	r2, r2, #8
    98c0:	e3510010 	cmp	r1, #16
    98c4:	21a01221 	lsrcs	r1, r1, #4
    98c8:	22822004 	addcs	r2, r2, #4
    98cc:	e3510004 	cmp	r1, #4
    98d0:	82822003 	addhi	r2, r2, #3
    98d4:	908220a1 	addls	r2, r2, r1, lsr #1
    98d8:	e1a00230 	lsr	r0, r0, r2
    98dc:	e12fff1e 	bx	lr
    98e0:	e3500000 	cmp	r0, #0
    98e4:	13e00000 	mvnne	r0, #0
    98e8:	ea000059 	b	9a54 <__aeabi_idiv0>

000098ec <__aeabi_uidivmod>:
    98ec:	e3510000 	cmp	r1, #0
    98f0:	0afffffa 	beq	98e0 <__aeabi_uidiv+0xe8>
    98f4:	e92d4003 	push	{r0, r1, lr}
    98f8:	ebffffbe 	bl	97f8 <__aeabi_uidiv>
    98fc:	e8bd4006 	pop	{r1, r2, lr}
    9900:	e0030092 	mul	r3, r2, r0
    9904:	e0411003 	sub	r1, r1, r3
    9908:	e12fff1e 	bx	lr

0000990c <__aeabi_idiv>:
    990c:	e3510000 	cmp	r1, #0
    9910:	0a000043 	beq	9a24 <.divsi3_skip_div0_test+0x110>

00009914 <.divsi3_skip_div0_test>:
    9914:	e020c001 	eor	ip, r0, r1
    9918:	42611000 	rsbmi	r1, r1, #0
    991c:	e2512001 	subs	r2, r1, #1
    9920:	0a000027 	beq	99c4 <.divsi3_skip_div0_test+0xb0>
    9924:	e1b03000 	movs	r3, r0
    9928:	42603000 	rsbmi	r3, r0, #0
    992c:	e1530001 	cmp	r3, r1
    9930:	9a000026 	bls	99d0 <.divsi3_skip_div0_test+0xbc>
    9934:	e1110002 	tst	r1, r2
    9938:	0a000028 	beq	99e0 <.divsi3_skip_div0_test+0xcc>
    993c:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    9940:	01a01181 	lsleq	r1, r1, #3
    9944:	03a02008 	moveq	r2, #8
    9948:	13a02001 	movne	r2, #1
    994c:	e3510201 	cmp	r1, #268435456	; 0x10000000
    9950:	31510003 	cmpcc	r1, r3
    9954:	31a01201 	lslcc	r1, r1, #4
    9958:	31a02202 	lslcc	r2, r2, #4
    995c:	3afffffa 	bcc	994c <.divsi3_skip_div0_test+0x38>
    9960:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    9964:	31510003 	cmpcc	r1, r3
    9968:	31a01081 	lslcc	r1, r1, #1
    996c:	31a02082 	lslcc	r2, r2, #1
    9970:	3afffffa 	bcc	9960 <.divsi3_skip_div0_test+0x4c>
    9974:	e3a00000 	mov	r0, #0
    9978:	e1530001 	cmp	r3, r1
    997c:	20433001 	subcs	r3, r3, r1
    9980:	21800002 	orrcs	r0, r0, r2
    9984:	e15300a1 	cmp	r3, r1, lsr #1
    9988:	204330a1 	subcs	r3, r3, r1, lsr #1
    998c:	218000a2 	orrcs	r0, r0, r2, lsr #1
    9990:	e1530121 	cmp	r3, r1, lsr #2
    9994:	20433121 	subcs	r3, r3, r1, lsr #2
    9998:	21800122 	orrcs	r0, r0, r2, lsr #2
    999c:	e15301a1 	cmp	r3, r1, lsr #3
    99a0:	204331a1 	subcs	r3, r3, r1, lsr #3
    99a4:	218001a2 	orrcs	r0, r0, r2, lsr #3
    99a8:	e3530000 	cmp	r3, #0
    99ac:	11b02222 	lsrsne	r2, r2, #4
    99b0:	11a01221 	lsrne	r1, r1, #4
    99b4:	1affffef 	bne	9978 <.divsi3_skip_div0_test+0x64>
    99b8:	e35c0000 	cmp	ip, #0
    99bc:	42600000 	rsbmi	r0, r0, #0
    99c0:	e12fff1e 	bx	lr
    99c4:	e13c0000 	teq	ip, r0
    99c8:	42600000 	rsbmi	r0, r0, #0
    99cc:	e12fff1e 	bx	lr
    99d0:	33a00000 	movcc	r0, #0
    99d4:	01a00fcc 	asreq	r0, ip, #31
    99d8:	03800001 	orreq	r0, r0, #1
    99dc:	e12fff1e 	bx	lr
    99e0:	e3510801 	cmp	r1, #65536	; 0x10000
    99e4:	21a01821 	lsrcs	r1, r1, #16
    99e8:	23a02010 	movcs	r2, #16
    99ec:	33a02000 	movcc	r2, #0
    99f0:	e3510c01 	cmp	r1, #256	; 0x100
    99f4:	21a01421 	lsrcs	r1, r1, #8
    99f8:	22822008 	addcs	r2, r2, #8
    99fc:	e3510010 	cmp	r1, #16
    9a00:	21a01221 	lsrcs	r1, r1, #4
    9a04:	22822004 	addcs	r2, r2, #4
    9a08:	e3510004 	cmp	r1, #4
    9a0c:	82822003 	addhi	r2, r2, #3
    9a10:	908220a1 	addls	r2, r2, r1, lsr #1
    9a14:	e35c0000 	cmp	ip, #0
    9a18:	e1a00233 	lsr	r0, r3, r2
    9a1c:	42600000 	rsbmi	r0, r0, #0
    9a20:	e12fff1e 	bx	lr
    9a24:	e3500000 	cmp	r0, #0
    9a28:	c3e00102 	mvngt	r0, #-2147483648	; 0x80000000
    9a2c:	b3a00102 	movlt	r0, #-2147483648	; 0x80000000
    9a30:	ea000007 	b	9a54 <__aeabi_idiv0>

00009a34 <__aeabi_idivmod>:
    9a34:	e3510000 	cmp	r1, #0
    9a38:	0afffff9 	beq	9a24 <.divsi3_skip_div0_test+0x110>
    9a3c:	e92d4003 	push	{r0, r1, lr}
    9a40:	ebffffb3 	bl	9914 <.divsi3_skip_div0_test>
    9a44:	e8bd4006 	pop	{r1, r2, lr}
    9a48:	e0030092 	mul	r3, r2, r0
    9a4c:	e0411003 	sub	r1, r1, r3
    9a50:	e12fff1e 	bx	lr

00009a54 <__aeabi_idiv0>:
    9a54:	e12fff1e 	bx	lr

00009a58 <__aeabi_frsub>:
    9a58:	e2200102 	eor	r0, r0, #-2147483648	; 0x80000000
    9a5c:	ea000000 	b	9a64 <__addsf3>

00009a60 <__aeabi_fsub>:
    9a60:	e2211102 	eor	r1, r1, #-2147483648	; 0x80000000

00009a64 <__addsf3>:
    9a64:	e1b02080 	lsls	r2, r0, #1
    9a68:	11b03081 	lslsne	r3, r1, #1
    9a6c:	11320003 	teqne	r2, r3
    9a70:	11f0cc42 	mvnsne	ip, r2, asr #24
    9a74:	11f0cc43 	mvnsne	ip, r3, asr #24
    9a78:	0a000047 	beq	9b9c <__addsf3+0x138>
    9a7c:	e1a02c22 	lsr	r2, r2, #24
    9a80:	e0723c23 	rsbs	r3, r2, r3, lsr #24
    9a84:	c0822003 	addgt	r2, r2, r3
    9a88:	c0201001 	eorgt	r1, r0, r1
    9a8c:	c0210000 	eorgt	r0, r1, r0
    9a90:	c0201001 	eorgt	r1, r0, r1
    9a94:	b2633000 	rsblt	r3, r3, #0
    9a98:	e3530019 	cmp	r3, #25
    9a9c:	812fff1e 	bxhi	lr
    9aa0:	e3100102 	tst	r0, #-2147483648	; 0x80000000
    9aa4:	e3800502 	orr	r0, r0, #8388608	; 0x800000
    9aa8:	e3c004ff 	bic	r0, r0, #-16777216	; 0xff000000
    9aac:	12600000 	rsbne	r0, r0, #0
    9ab0:	e3110102 	tst	r1, #-2147483648	; 0x80000000
    9ab4:	e3811502 	orr	r1, r1, #8388608	; 0x800000
    9ab8:	e3c114ff 	bic	r1, r1, #-16777216	; 0xff000000
    9abc:	12611000 	rsbne	r1, r1, #0
    9ac0:	e1320003 	teq	r2, r3
    9ac4:	0a00002e 	beq	9b84 <__addsf3+0x120>
    9ac8:	e2422001 	sub	r2, r2, #1
    9acc:	e0900351 	adds	r0, r0, r1, asr r3
    9ad0:	e2633020 	rsb	r3, r3, #32
    9ad4:	e1a01311 	lsl	r1, r1, r3
    9ad8:	e2003102 	and	r3, r0, #-2147483648	; 0x80000000
    9adc:	5a000001 	bpl	9ae8 <__addsf3+0x84>
    9ae0:	e2711000 	rsbs	r1, r1, #0
    9ae4:	e2e00000 	rsc	r0, r0, #0
    9ae8:	e3500502 	cmp	r0, #8388608	; 0x800000
    9aec:	3a00000b 	bcc	9b20 <__addsf3+0xbc>
    9af0:	e3500401 	cmp	r0, #16777216	; 0x1000000
    9af4:	3a000004 	bcc	9b0c <__addsf3+0xa8>
    9af8:	e1b000a0 	lsrs	r0, r0, #1
    9afc:	e1a01061 	rrx	r1, r1
    9b00:	e2822001 	add	r2, r2, #1
    9b04:	e35200fe 	cmp	r2, #254	; 0xfe
    9b08:	2a000038 	bcs	9bf0 <__addsf3+0x18c>
    9b0c:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    9b10:	e0a00b82 	adc	r0, r0, r2, lsl #23
    9b14:	03c00001 	biceq	r0, r0, #1
    9b18:	e1800003 	orr	r0, r0, r3
    9b1c:	e12fff1e 	bx	lr
    9b20:	e1b01081 	lsls	r1, r1, #1
    9b24:	e0a00000 	adc	r0, r0, r0
    9b28:	e3100502 	tst	r0, #8388608	; 0x800000
    9b2c:	e2422001 	sub	r2, r2, #1
    9b30:	1afffff5 	bne	9b0c <__addsf3+0xa8>
    9b34:	e1b0c620 	lsrs	ip, r0, #12
    9b38:	01a00600 	lsleq	r0, r0, #12
    9b3c:	0242200c 	subeq	r2, r2, #12
    9b40:	e31008ff 	tst	r0, #16711680	; 0xff0000
    9b44:	01a00400 	lsleq	r0, r0, #8
    9b48:	02422008 	subeq	r2, r2, #8
    9b4c:	e310060f 	tst	r0, #15728640	; 0xf00000
    9b50:	01a00200 	lsleq	r0, r0, #4
    9b54:	02422004 	subeq	r2, r2, #4
    9b58:	e3100503 	tst	r0, #12582912	; 0xc00000
    9b5c:	01a00100 	lsleq	r0, r0, #2
    9b60:	02422002 	subeq	r2, r2, #2
    9b64:	e3500502 	cmp	r0, #8388608	; 0x800000
    9b68:	31a00080 	lslcc	r0, r0, #1
    9b6c:	e2d22000 	sbcs	r2, r2, #0
    9b70:	a0800b82 	addge	r0, r0, r2, lsl #23
    9b74:	b2622000 	rsblt	r2, r2, #0
    9b78:	a1800003 	orrge	r0, r0, r3
    9b7c:	b1830230 	orrlt	r0, r3, r0, lsr r2
    9b80:	e12fff1e 	bx	lr
    9b84:	e3320000 	teq	r2, #0
    9b88:	e2211502 	eor	r1, r1, #8388608	; 0x800000
    9b8c:	02200502 	eoreq	r0, r0, #8388608	; 0x800000
    9b90:	02822001 	addeq	r2, r2, #1
    9b94:	12433001 	subne	r3, r3, #1
    9b98:	eaffffca 	b	9ac8 <__addsf3+0x64>
    9b9c:	e1a03081 	lsl	r3, r1, #1
    9ba0:	e1f0cc42 	mvns	ip, r2, asr #24
    9ba4:	11f0cc43 	mvnsne	ip, r3, asr #24
    9ba8:	0a000013 	beq	9bfc <__addsf3+0x198>
    9bac:	e1320003 	teq	r2, r3
    9bb0:	0a000002 	beq	9bc0 <__addsf3+0x15c>
    9bb4:	e3320000 	teq	r2, #0
    9bb8:	01a00001 	moveq	r0, r1
    9bbc:	e12fff1e 	bx	lr
    9bc0:	e1300001 	teq	r0, r1
    9bc4:	13a00000 	movne	r0, #0
    9bc8:	112fff1e 	bxne	lr
    9bcc:	e31204ff 	tst	r2, #-16777216	; 0xff000000
    9bd0:	1a000002 	bne	9be0 <__addsf3+0x17c>
    9bd4:	e1b00080 	lsls	r0, r0, #1
    9bd8:	23800102 	orrcs	r0, r0, #-2147483648	; 0x80000000
    9bdc:	e12fff1e 	bx	lr
    9be0:	e2922402 	adds	r2, r2, #33554432	; 0x2000000
    9be4:	32800502 	addcc	r0, r0, #8388608	; 0x800000
    9be8:	312fff1e 	bxcc	lr
    9bec:	e2003102 	and	r3, r0, #-2147483648	; 0x80000000
    9bf0:	e383047f 	orr	r0, r3, #2130706432	; 0x7f000000
    9bf4:	e3800502 	orr	r0, r0, #8388608	; 0x800000
    9bf8:	e12fff1e 	bx	lr
    9bfc:	e1f02c42 	mvns	r2, r2, asr #24
    9c00:	11a00001 	movne	r0, r1
    9c04:	01f03c43 	mvnseq	r3, r3, asr #24
    9c08:	11a01000 	movne	r1, r0
    9c0c:	e1b02480 	lsls	r2, r0, #9
    9c10:	01b03481 	lslseq	r3, r1, #9
    9c14:	01300001 	teqeq	r0, r1
    9c18:	13800501 	orrne	r0, r0, #4194304	; 0x400000
    9c1c:	e12fff1e 	bx	lr

00009c20 <__aeabi_ui2f>:
    9c20:	e3a03000 	mov	r3, #0
    9c24:	ea000001 	b	9c30 <__aeabi_i2f+0x8>

00009c28 <__aeabi_i2f>:
    9c28:	e2103102 	ands	r3, r0, #-2147483648	; 0x80000000
    9c2c:	42600000 	rsbmi	r0, r0, #0
    9c30:	e1b0c000 	movs	ip, r0
    9c34:	012fff1e 	bxeq	lr
    9c38:	e383344b 	orr	r3, r3, #1258291200	; 0x4b000000
    9c3c:	e1a01000 	mov	r1, r0
    9c40:	e3a00000 	mov	r0, #0
    9c44:	ea00000f 	b	9c88 <__aeabi_l2f+0x30>

00009c48 <__aeabi_ul2f>:
    9c48:	e1902001 	orrs	r2, r0, r1
    9c4c:	012fff1e 	bxeq	lr
    9c50:	e3a03000 	mov	r3, #0
    9c54:	ea000005 	b	9c70 <__aeabi_l2f+0x18>

00009c58 <__aeabi_l2f>:
    9c58:	e1902001 	orrs	r2, r0, r1
    9c5c:	012fff1e 	bxeq	lr
    9c60:	e2113102 	ands	r3, r1, #-2147483648	; 0x80000000
    9c64:	5a000001 	bpl	9c70 <__aeabi_l2f+0x18>
    9c68:	e2700000 	rsbs	r0, r0, #0
    9c6c:	e2e11000 	rsc	r1, r1, #0
    9c70:	e1b0c001 	movs	ip, r1
    9c74:	01a0c000 	moveq	ip, r0
    9c78:	01a01000 	moveq	r1, r0
    9c7c:	03a00000 	moveq	r0, #0
    9c80:	e383345b 	orr	r3, r3, #1526726656	; 0x5b000000
    9c84:	02433201 	subeq	r3, r3, #268435456	; 0x10000000
    9c88:	e2433502 	sub	r3, r3, #8388608	; 0x800000
    9c8c:	e3a02017 	mov	r2, #23
    9c90:	e35c0801 	cmp	ip, #65536	; 0x10000
    9c94:	21a0c82c 	lsrcs	ip, ip, #16
    9c98:	22422010 	subcs	r2, r2, #16
    9c9c:	e35c0c01 	cmp	ip, #256	; 0x100
    9ca0:	21a0c42c 	lsrcs	ip, ip, #8
    9ca4:	22422008 	subcs	r2, r2, #8
    9ca8:	e35c0010 	cmp	ip, #16
    9cac:	21a0c22c 	lsrcs	ip, ip, #4
    9cb0:	22422004 	subcs	r2, r2, #4
    9cb4:	e35c0004 	cmp	ip, #4
    9cb8:	22422002 	subcs	r2, r2, #2
    9cbc:	304220ac 	subcc	r2, r2, ip, lsr #1
    9cc0:	e05221ac 	subs	r2, r2, ip, lsr #3
    9cc4:	e0433b82 	sub	r3, r3, r2, lsl #23
    9cc8:	ba000006 	blt	9ce8 <__aeabi_l2f+0x90>
    9ccc:	e0833211 	add	r3, r3, r1, lsl r2
    9cd0:	e1a0c210 	lsl	ip, r0, r2
    9cd4:	e2622020 	rsb	r2, r2, #32
    9cd8:	e35c0102 	cmp	ip, #-2147483648	; 0x80000000
    9cdc:	e0a30230 	adc	r0, r3, r0, lsr r2
    9ce0:	03c00001 	biceq	r0, r0, #1
    9ce4:	e12fff1e 	bx	lr
    9ce8:	e2822020 	add	r2, r2, #32
    9cec:	e1a0c211 	lsl	ip, r1, r2
    9cf0:	e2622020 	rsb	r2, r2, #32
    9cf4:	e190008c 	orrs	r0, r0, ip, lsl #1
    9cf8:	e0a30231 	adc	r0, r3, r1, lsr r2
    9cfc:	01c00fac 	biceq	r0, r0, ip, lsr #31
    9d00:	e12fff1e 	bx	lr

00009d04 <__aeabi_fmul>:
    9d04:	e3a0c0ff 	mov	ip, #255	; 0xff
    9d08:	e01c2ba0 	ands	r2, ip, r0, lsr #23
    9d0c:	101c3ba1 	andsne	r3, ip, r1, lsr #23
    9d10:	1132000c 	teqne	r2, ip
    9d14:	1133000c 	teqne	r3, ip
    9d18:	0a00003e 	beq	9e18 <__aeabi_fmul+0x114>
    9d1c:	e0822003 	add	r2, r2, r3
    9d20:	e020c001 	eor	ip, r0, r1
    9d24:	e1b00480 	lsls	r0, r0, #9
    9d28:	11b01481 	lslsne	r1, r1, #9
    9d2c:	0a000010 	beq	9d74 <__aeabi_fmul+0x70>
    9d30:	e3a03302 	mov	r3, #134217728	; 0x8000000
    9d34:	e18302a0 	orr	r0, r3, r0, lsr #5
    9d38:	e18312a1 	orr	r1, r3, r1, lsr #5
    9d3c:	e0813190 	umull	r3, r1, r0, r1
    9d40:	e20c0102 	and	r0, ip, #-2147483648	; 0x80000000
    9d44:	e3510502 	cmp	r1, #8388608	; 0x800000
    9d48:	31a01081 	lslcc	r1, r1, #1
    9d4c:	31811fa3 	orrcc	r1, r1, r3, lsr #31
    9d50:	31a03083 	lslcc	r3, r3, #1
    9d54:	e1800001 	orr	r0, r0, r1
    9d58:	e2c2207f 	sbc	r2, r2, #127	; 0x7f
    9d5c:	e35200fd 	cmp	r2, #253	; 0xfd
    9d60:	8a00000f 	bhi	9da4 <__aeabi_fmul+0xa0>
    9d64:	e3530102 	cmp	r3, #-2147483648	; 0x80000000
    9d68:	e0a00b82 	adc	r0, r0, r2, lsl #23
    9d6c:	03c00001 	biceq	r0, r0, #1
    9d70:	e12fff1e 	bx	lr
    9d74:	e3300000 	teq	r0, #0
    9d78:	e20cc102 	and	ip, ip, #-2147483648	; 0x80000000
    9d7c:	01a01481 	lsleq	r1, r1, #9
    9d80:	e18c04a0 	orr	r0, ip, r0, lsr #9
    9d84:	e18004a1 	orr	r0, r0, r1, lsr #9
    9d88:	e252207f 	subs	r2, r2, #127	; 0x7f
    9d8c:	c27230ff 	rsbsgt	r3, r2, #255	; 0xff
    9d90:	c1800b82 	orrgt	r0, r0, r2, lsl #23
    9d94:	c12fff1e 	bxgt	lr
    9d98:	e3800502 	orr	r0, r0, #8388608	; 0x800000
    9d9c:	e3a03000 	mov	r3, #0
    9da0:	e2522001 	subs	r2, r2, #1
    9da4:	ca000035 	bgt	9e80 <__aeabi_fmul+0x17c>
    9da8:	e3720019 	cmn	r2, #25
    9dac:	d2000102 	andle	r0, r0, #-2147483648	; 0x80000000
    9db0:	d12fff1e 	bxle	lr
    9db4:	e2622000 	rsb	r2, r2, #0
    9db8:	e1b01080 	lsls	r1, r0, #1
    9dbc:	e1a01231 	lsr	r1, r1, r2
    9dc0:	e2622020 	rsb	r2, r2, #32
    9dc4:	e1a0c210 	lsl	ip, r0, r2
    9dc8:	e1b00061 	rrxs	r0, r1
    9dcc:	e2a00000 	adc	r0, r0, #0
    9dd0:	e193308c 	orrs	r3, r3, ip, lsl #1
    9dd4:	01c00fac 	biceq	r0, r0, ip, lsr #31
    9dd8:	e12fff1e 	bx	lr
    9ddc:	e3320000 	teq	r2, #0
    9de0:	e200c102 	and	ip, r0, #-2147483648	; 0x80000000
    9de4:	01a00080 	lsleq	r0, r0, #1
    9de8:	03100502 	tsteq	r0, #8388608	; 0x800000
    9dec:	02422001 	subeq	r2, r2, #1
    9df0:	0afffffb 	beq	9de4 <__aeabi_fmul+0xe0>
    9df4:	e180000c 	orr	r0, r0, ip
    9df8:	e3330000 	teq	r3, #0
    9dfc:	e201c102 	and	ip, r1, #-2147483648	; 0x80000000
    9e00:	01a01081 	lsleq	r1, r1, #1
    9e04:	03110502 	tsteq	r1, #8388608	; 0x800000
    9e08:	02433001 	subeq	r3, r3, #1
    9e0c:	0afffffb 	beq	9e00 <__aeabi_fmul+0xfc>
    9e10:	e181100c 	orr	r1, r1, ip
    9e14:	eaffffc0 	b	9d1c <__aeabi_fmul+0x18>
    9e18:	e00c3ba1 	and	r3, ip, r1, lsr #23
    9e1c:	e132000c 	teq	r2, ip
    9e20:	1133000c 	teqne	r3, ip
    9e24:	0a000005 	beq	9e40 <__aeabi_fmul+0x13c>
    9e28:	e3d0c102 	bics	ip, r0, #-2147483648	; 0x80000000
    9e2c:	13d1c102 	bicsne	ip, r1, #-2147483648	; 0x80000000
    9e30:	1affffe9 	bne	9ddc <__aeabi_fmul+0xd8>
    9e34:	e0200001 	eor	r0, r0, r1
    9e38:	e2000102 	and	r0, r0, #-2147483648	; 0x80000000
    9e3c:	e12fff1e 	bx	lr
    9e40:	e3300000 	teq	r0, #0
    9e44:	13300102 	teqne	r0, #-2147483648	; 0x80000000
    9e48:	01a00001 	moveq	r0, r1
    9e4c:	13310000 	teqne	r1, #0
    9e50:	13310102 	teqne	r1, #-2147483648	; 0x80000000
    9e54:	0a00000d 	beq	9e90 <__aeabi_fmul+0x18c>
    9e58:	e132000c 	teq	r2, ip
    9e5c:	1a000001 	bne	9e68 <__aeabi_fmul+0x164>
    9e60:	e1b02480 	lsls	r2, r0, #9
    9e64:	1a000009 	bne	9e90 <__aeabi_fmul+0x18c>
    9e68:	e133000c 	teq	r3, ip
    9e6c:	1a000002 	bne	9e7c <__aeabi_fmul+0x178>
    9e70:	e1b03481 	lsls	r3, r1, #9
    9e74:	11a00001 	movne	r0, r1
    9e78:	1a000004 	bne	9e90 <__aeabi_fmul+0x18c>
    9e7c:	e0200001 	eor	r0, r0, r1
    9e80:	e2000102 	and	r0, r0, #-2147483648	; 0x80000000
    9e84:	e380047f 	orr	r0, r0, #2130706432	; 0x7f000000
    9e88:	e3800502 	orr	r0, r0, #8388608	; 0x800000
    9e8c:	e12fff1e 	bx	lr
    9e90:	e380047f 	orr	r0, r0, #2130706432	; 0x7f000000
    9e94:	e3800503 	orr	r0, r0, #12582912	; 0xc00000
    9e98:	e12fff1e 	bx	lr

00009e9c <__aeabi_fdiv>:
    9e9c:	e3a0c0ff 	mov	ip, #255	; 0xff
    9ea0:	e01c2ba0 	ands	r2, ip, r0, lsr #23
    9ea4:	101c3ba1 	andsne	r3, ip, r1, lsr #23
    9ea8:	1132000c 	teqne	r2, ip
    9eac:	1133000c 	teqne	r3, ip
    9eb0:	0a00003a 	beq	9fa0 <__aeabi_fdiv+0x104>
    9eb4:	e0422003 	sub	r2, r2, r3
    9eb8:	e020c001 	eor	ip, r0, r1
    9ebc:	e1b01481 	lsls	r1, r1, #9
    9ec0:	e1a00480 	lsl	r0, r0, #9
    9ec4:	0a00001c 	beq	9f3c <__aeabi_fdiv+0xa0>
    9ec8:	e3a03201 	mov	r3, #268435456	; 0x10000000
    9ecc:	e1831221 	orr	r1, r3, r1, lsr #4
    9ed0:	e1833220 	orr	r3, r3, r0, lsr #4
    9ed4:	e20c0102 	and	r0, ip, #-2147483648	; 0x80000000
    9ed8:	e1530001 	cmp	r3, r1
    9edc:	31a03083 	lslcc	r3, r3, #1
    9ee0:	e2a2207d 	adc	r2, r2, #125	; 0x7d
    9ee4:	e3a0c502 	mov	ip, #8388608	; 0x800000
    9ee8:	e1530001 	cmp	r3, r1
    9eec:	20433001 	subcs	r3, r3, r1
    9ef0:	2180000c 	orrcs	r0, r0, ip
    9ef4:	e15300a1 	cmp	r3, r1, lsr #1
    9ef8:	204330a1 	subcs	r3, r3, r1, lsr #1
    9efc:	218000ac 	orrcs	r0, r0, ip, lsr #1
    9f00:	e1530121 	cmp	r3, r1, lsr #2
    9f04:	20433121 	subcs	r3, r3, r1, lsr #2
    9f08:	2180012c 	orrcs	r0, r0, ip, lsr #2
    9f0c:	e15301a1 	cmp	r3, r1, lsr #3
    9f10:	204331a1 	subcs	r3, r3, r1, lsr #3
    9f14:	218001ac 	orrcs	r0, r0, ip, lsr #3
    9f18:	e1b03203 	lsls	r3, r3, #4
    9f1c:	11b0c22c 	lsrsne	ip, ip, #4
    9f20:	1afffff0 	bne	9ee8 <__aeabi_fdiv+0x4c>
    9f24:	e35200fd 	cmp	r2, #253	; 0xfd
    9f28:	8affff9d 	bhi	9da4 <__aeabi_fmul+0xa0>
    9f2c:	e1530001 	cmp	r3, r1
    9f30:	e0a00b82 	adc	r0, r0, r2, lsl #23
    9f34:	03c00001 	biceq	r0, r0, #1
    9f38:	e12fff1e 	bx	lr
    9f3c:	e20cc102 	and	ip, ip, #-2147483648	; 0x80000000
    9f40:	e18c04a0 	orr	r0, ip, r0, lsr #9
    9f44:	e292207f 	adds	r2, r2, #127	; 0x7f
    9f48:	c27230ff 	rsbsgt	r3, r2, #255	; 0xff
    9f4c:	c1800b82 	orrgt	r0, r0, r2, lsl #23
    9f50:	c12fff1e 	bxgt	lr
    9f54:	e3800502 	orr	r0, r0, #8388608	; 0x800000
    9f58:	e3a03000 	mov	r3, #0
    9f5c:	e2522001 	subs	r2, r2, #1
    9f60:	eaffff8f 	b	9da4 <__aeabi_fmul+0xa0>
    9f64:	e3320000 	teq	r2, #0
    9f68:	e200c102 	and	ip, r0, #-2147483648	; 0x80000000
    9f6c:	01a00080 	lsleq	r0, r0, #1
    9f70:	03100502 	tsteq	r0, #8388608	; 0x800000
    9f74:	02422001 	subeq	r2, r2, #1
    9f78:	0afffffb 	beq	9f6c <__aeabi_fdiv+0xd0>
    9f7c:	e180000c 	orr	r0, r0, ip
    9f80:	e3330000 	teq	r3, #0
    9f84:	e201c102 	and	ip, r1, #-2147483648	; 0x80000000
    9f88:	01a01081 	lsleq	r1, r1, #1
    9f8c:	03110502 	tsteq	r1, #8388608	; 0x800000
    9f90:	02433001 	subeq	r3, r3, #1
    9f94:	0afffffb 	beq	9f88 <__aeabi_fdiv+0xec>
    9f98:	e181100c 	orr	r1, r1, ip
    9f9c:	eaffffc4 	b	9eb4 <__aeabi_fdiv+0x18>
    9fa0:	e00c3ba1 	and	r3, ip, r1, lsr #23
    9fa4:	e132000c 	teq	r2, ip
    9fa8:	1a000005 	bne	9fc4 <__aeabi_fdiv+0x128>
    9fac:	e1b02480 	lsls	r2, r0, #9
    9fb0:	1affffb6 	bne	9e90 <__aeabi_fmul+0x18c>
    9fb4:	e133000c 	teq	r3, ip
    9fb8:	1affffaf 	bne	9e7c <__aeabi_fmul+0x178>
    9fbc:	e1a00001 	mov	r0, r1
    9fc0:	eaffffb2 	b	9e90 <__aeabi_fmul+0x18c>
    9fc4:	e133000c 	teq	r3, ip
    9fc8:	1a000003 	bne	9fdc <__aeabi_fdiv+0x140>
    9fcc:	e1b03481 	lsls	r3, r1, #9
    9fd0:	0affff97 	beq	9e34 <__aeabi_fmul+0x130>
    9fd4:	e1a00001 	mov	r0, r1
    9fd8:	eaffffac 	b	9e90 <__aeabi_fmul+0x18c>
    9fdc:	e3d0c102 	bics	ip, r0, #-2147483648	; 0x80000000
    9fe0:	13d1c102 	bicsne	ip, r1, #-2147483648	; 0x80000000
    9fe4:	1affffde 	bne	9f64 <__aeabi_fdiv+0xc8>
    9fe8:	e3d02102 	bics	r2, r0, #-2147483648	; 0x80000000
    9fec:	1affffa2 	bne	9e7c <__aeabi_fmul+0x178>
    9ff0:	e3d13102 	bics	r3, r1, #-2147483648	; 0x80000000
    9ff4:	1affff8e 	bne	9e34 <__aeabi_fmul+0x130>
    9ff8:	eaffffa4 	b	9e90 <__aeabi_fmul+0x18c>

00009ffc <__gesf2>:
    9ffc:	e3e0c000 	mvn	ip, #0
    a000:	ea000002 	b	a010 <__cmpsf2+0x4>

0000a004 <__lesf2>:
    a004:	e3a0c001 	mov	ip, #1
    a008:	ea000000 	b	a010 <__cmpsf2+0x4>

0000a00c <__cmpsf2>:
    a00c:	e3a0c001 	mov	ip, #1
    a010:	e52dc004 	push	{ip}		; (str ip, [sp, #-4]!)
    a014:	e1a02080 	lsl	r2, r0, #1
    a018:	e1a03081 	lsl	r3, r1, #1
    a01c:	e1f0cc42 	mvns	ip, r2, asr #24
    a020:	11f0cc43 	mvnsne	ip, r3, asr #24
    a024:	0a000007 	beq	a048 <__cmpsf2+0x3c>
    a028:	e28dd004 	add	sp, sp, #4
    a02c:	e192c0a3 	orrs	ip, r2, r3, lsr #1
    a030:	11300001 	teqne	r0, r1
    a034:	50520003 	subspl	r0, r2, r3
    a038:	81a00fc1 	asrhi	r0, r1, #31
    a03c:	31e00fc1 	mvncc	r0, r1, asr #31
    a040:	13800001 	orrne	r0, r0, #1
    a044:	e12fff1e 	bx	lr
    a048:	e1f0cc42 	mvns	ip, r2, asr #24
    a04c:	1a000001 	bne	a058 <__cmpsf2+0x4c>
    a050:	e1b0c480 	lsls	ip, r0, #9
    a054:	1a000003 	bne	a068 <__cmpsf2+0x5c>
    a058:	e1f0cc43 	mvns	ip, r3, asr #24
    a05c:	1afffff1 	bne	a028 <__cmpsf2+0x1c>
    a060:	e1b0c481 	lsls	ip, r1, #9
    a064:	0affffef 	beq	a028 <__cmpsf2+0x1c>
    a068:	e49d0004 	pop	{r0}		; (ldr r0, [sp], #4)
    a06c:	e12fff1e 	bx	lr

0000a070 <__aeabi_cfrcmple>:
    a070:	e1a0c000 	mov	ip, r0
    a074:	e1a00001 	mov	r0, r1
    a078:	e1a0100c 	mov	r1, ip
    a07c:	eaffffff 	b	a080 <__aeabi_cfcmpeq>

0000a080 <__aeabi_cfcmpeq>:
    a080:	e92d400f 	push	{r0, r1, r2, r3, lr}
    a084:	ebffffe0 	bl	a00c <__cmpsf2>
    a088:	e3500000 	cmp	r0, #0
    a08c:	43700000 	cmnmi	r0, #0
    a090:	e8bd400f 	pop	{r0, r1, r2, r3, lr}
    a094:	e12fff1e 	bx	lr

0000a098 <__aeabi_fcmpeq>:
    a098:	e52de008 	str	lr, [sp, #-8]!
    a09c:	ebfffff7 	bl	a080 <__aeabi_cfcmpeq>
    a0a0:	03a00001 	moveq	r0, #1
    a0a4:	13a00000 	movne	r0, #0
    a0a8:	e49de008 	ldr	lr, [sp], #8
    a0ac:	e12fff1e 	bx	lr

0000a0b0 <__aeabi_fcmplt>:
    a0b0:	e52de008 	str	lr, [sp, #-8]!
    a0b4:	ebfffff1 	bl	a080 <__aeabi_cfcmpeq>
    a0b8:	33a00001 	movcc	r0, #1
    a0bc:	23a00000 	movcs	r0, #0
    a0c0:	e49de008 	ldr	lr, [sp], #8
    a0c4:	e12fff1e 	bx	lr

0000a0c8 <__aeabi_fcmple>:
    a0c8:	e52de008 	str	lr, [sp, #-8]!
    a0cc:	ebffffeb 	bl	a080 <__aeabi_cfcmpeq>
    a0d0:	93a00001 	movls	r0, #1
    a0d4:	83a00000 	movhi	r0, #0
    a0d8:	e49de008 	ldr	lr, [sp], #8
    a0dc:	e12fff1e 	bx	lr

0000a0e0 <__aeabi_fcmpge>:
    a0e0:	e52de008 	str	lr, [sp, #-8]!
    a0e4:	ebffffe1 	bl	a070 <__aeabi_cfrcmple>
    a0e8:	93a00001 	movls	r0, #1
    a0ec:	83a00000 	movhi	r0, #0
    a0f0:	e49de008 	ldr	lr, [sp], #8
    a0f4:	e12fff1e 	bx	lr

0000a0f8 <__aeabi_fcmpgt>:
    a0f8:	e52de008 	str	lr, [sp, #-8]!
    a0fc:	ebffffdb 	bl	a070 <__aeabi_cfrcmple>
    a100:	33a00001 	movcc	r0, #1
    a104:	23a00000 	movcs	r0, #0
    a108:	e49de008 	ldr	lr, [sp], #8
    a10c:	e12fff1e 	bx	lr

0000a110 <__aeabi_uldivmod>:
    a110:	e3530000 	cmp	r3, #0
    a114:	03520000 	cmpeq	r2, #0
    a118:	1a000004 	bne	a130 <__aeabi_uldivmod+0x20>
    a11c:	e3510000 	cmp	r1, #0
    a120:	03500000 	cmpeq	r0, #0
    a124:	13e01000 	mvnne	r1, #0
    a128:	13e00000 	mvnne	r0, #0
    a12c:	eafffe48 	b	9a54 <__aeabi_idiv0>
    a130:	e24dd008 	sub	sp, sp, #8
    a134:	e92d6000 	push	{sp, lr}
    a138:	eb000025 	bl	a1d4 <__gnu_uldivmod_helper>
    a13c:	e59de004 	ldr	lr, [sp, #4]
    a140:	e28dd008 	add	sp, sp, #8
    a144:	e8bd000c 	pop	{r2, r3}
    a148:	e12fff1e 	bx	lr

0000a14c <__popcountsi2>:
    a14c:	e59f3030 	ldr	r3, [pc, #48]	; a184 <__popcountsi2+0x38>
    a150:	e59f2030 	ldr	r2, [pc, #48]	; a188 <__popcountsi2+0x3c>
    a154:	e00330a0 	and	r3, r3, r0, lsr #1
    a158:	e0630000 	rsb	r0, r3, r0
    a15c:	e0003002 	and	r3, r0, r2
    a160:	e0022120 	and	r2, r2, r0, lsr #2
    a164:	e0823003 	add	r3, r2, r3
    a168:	e59f001c 	ldr	r0, [pc, #28]	; a18c <__popcountsi2+0x40>
    a16c:	e0833223 	add	r3, r3, r3, lsr #4
    a170:	e0000003 	and	r0, r0, r3
    a174:	e0800400 	add	r0, r0, r0, lsl #8
    a178:	e0800800 	add	r0, r0, r0, lsl #16
    a17c:	e1a00c20 	lsr	r0, r0, #24
    a180:	e12fff1e 	bx	lr
    a184:	55555555 	ldrbpl	r5, [r5, #-1365]	; 0x555
    a188:	33333333 	teqcc	r3, #-872415232	; 0xcc000000
    a18c:	0f0f0f0f 	svceq	0x000f0f0f

0000a190 <__gnu_ldivmod_helper>:
    a190:	e92d47f0 	push	{r4, r5, r6, r7, r8, r9, sl, lr}
    a194:	e59d6020 	ldr	r6, [sp, #32]
    a198:	e1a07002 	mov	r7, r2
    a19c:	e1a0a003 	mov	sl, r3
    a1a0:	e1a04000 	mov	r4, r0
    a1a4:	e1a05001 	mov	r5, r1
    a1a8:	eb000019 	bl	a214 <__divdi3>
    a1ac:	e1a03000 	mov	r3, r0
    a1b0:	e0020197 	mul	r2, r7, r1
    a1b4:	e0898097 	umull	r8, r9, r7, r0
    a1b8:	e023239a 	mla	r3, sl, r3, r2
    a1bc:	e0544008 	subs	r4, r4, r8
    a1c0:	e0839009 	add	r9, r3, r9
    a1c4:	e0c55009 	sbc	r5, r5, r9
    a1c8:	e8860030 	stm	r6, {r4, r5}
    a1cc:	e8bd47f0 	pop	{r4, r5, r6, r7, r8, r9, sl, lr}
    a1d0:	e12fff1e 	bx	lr

0000a1d4 <__gnu_uldivmod_helper>:
    a1d4:	e92d41f0 	push	{r4, r5, r6, r7, r8, lr}
    a1d8:	e59d5018 	ldr	r5, [sp, #24]
    a1dc:	e1a04002 	mov	r4, r2
    a1e0:	e1a08003 	mov	r8, r3
    a1e4:	e1a06000 	mov	r6, r0
    a1e8:	e1a07001 	mov	r7, r1
    a1ec:	eb000066 	bl	a38c <__udivdi3>
    a1f0:	e0080890 	mul	r8, r0, r8
    a1f4:	e0832490 	umull	r2, r3, r0, r4
    a1f8:	e0248491 	mla	r4, r1, r4, r8
    a1fc:	e0566002 	subs	r6, r6, r2
    a200:	e0843003 	add	r3, r4, r3
    a204:	e0c77003 	sbc	r7, r7, r3
    a208:	e88500c0 	stm	r5, {r6, r7}
    a20c:	e8bd41f0 	pop	{r4, r5, r6, r7, r8, lr}
    a210:	e12fff1e 	bx	lr

0000a214 <__divdi3>:
    a214:	e3510000 	cmp	r1, #0
    a218:	e92d4ff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
    a21c:	a1a04000 	movge	r4, r0
    a220:	a1a05001 	movge	r5, r1
    a224:	a3a0a000 	movge	sl, #0
    a228:	ba000053 	blt	a37c <__divdi3+0x168>
    a22c:	e3530000 	cmp	r3, #0
    a230:	a1a08002 	movge	r8, r2
    a234:	a1a09003 	movge	r9, r3
    a238:	ba00004b 	blt	a36c <__divdi3+0x158>
    a23c:	e1550009 	cmp	r5, r9
    a240:	01540008 	cmpeq	r4, r8
    a244:	33a02000 	movcc	r2, #0
    a248:	33a03000 	movcc	r3, #0
    a24c:	3a00003b 	bcc	a340 <__divdi3+0x12c>
    a250:	e1a01009 	mov	r1, r9
    a254:	e1a00008 	mov	r0, r8
    a258:	eb000093 	bl	a4ac <__clzdi2>
    a25c:	e1a01005 	mov	r1, r5
    a260:	e1a0b000 	mov	fp, r0
    a264:	e1a00004 	mov	r0, r4
    a268:	eb00008f 	bl	a4ac <__clzdi2>
    a26c:	e060000b 	rsb	r0, r0, fp
    a270:	e240e020 	sub	lr, r0, #32
    a274:	e1a07019 	lsl	r7, r9, r0
    a278:	e1877e18 	orr	r7, r7, r8, lsl lr
    a27c:	e260c020 	rsb	ip, r0, #32
    a280:	e1877c38 	orr	r7, r7, r8, lsr ip
    a284:	e1550007 	cmp	r5, r7
    a288:	e1a06018 	lsl	r6, r8, r0
    a28c:	01540006 	cmpeq	r4, r6
    a290:	e1a01000 	mov	r1, r0
    a294:	33a02000 	movcc	r2, #0
    a298:	33a03000 	movcc	r3, #0
    a29c:	3a000005 	bcc	a2b8 <__divdi3+0xa4>
    a2a0:	e3a08001 	mov	r8, #1
    a2a4:	e0544006 	subs	r4, r4, r6
    a2a8:	e1a03e18 	lsl	r3, r8, lr
    a2ac:	e1833c38 	orr	r3, r3, r8, lsr ip
    a2b0:	e0c55007 	sbc	r5, r5, r7
    a2b4:	e1a02018 	lsl	r2, r8, r0
    a2b8:	e3500000 	cmp	r0, #0
    a2bc:	0a00001f 	beq	a340 <__divdi3+0x12c>
    a2c0:	e1b070a7 	lsrs	r7, r7, #1
    a2c4:	e1a06066 	rrx	r6, r6
    a2c8:	ea000007 	b	a2ec <__divdi3+0xd8>
    a2cc:	e0544006 	subs	r4, r4, r6
    a2d0:	e0c55007 	sbc	r5, r5, r7
    a2d4:	e0944004 	adds	r4, r4, r4
    a2d8:	e0a55005 	adc	r5, r5, r5
    a2dc:	e2944001 	adds	r4, r4, #1
    a2e0:	e2a55000 	adc	r5, r5, #0
    a2e4:	e2500001 	subs	r0, r0, #1
    a2e8:	0a000006 	beq	a308 <__divdi3+0xf4>
    a2ec:	e1570005 	cmp	r7, r5
    a2f0:	01560004 	cmpeq	r6, r4
    a2f4:	9afffff4 	bls	a2cc <__divdi3+0xb8>
    a2f8:	e0944004 	adds	r4, r4, r4
    a2fc:	e0a55005 	adc	r5, r5, r5
    a300:	e2500001 	subs	r0, r0, #1
    a304:	1afffff8 	bne	a2ec <__divdi3+0xd8>
    a308:	e261c020 	rsb	ip, r1, #32
    a30c:	e1a00134 	lsr	r0, r4, r1
    a310:	e0922004 	adds	r2, r2, r4
    a314:	e241e020 	sub	lr, r1, #32
    a318:	e1800c15 	orr	r0, r0, r5, lsl ip
    a31c:	e1a04135 	lsr	r4, r5, r1
    a320:	e1800e35 	orr	r0, r0, r5, lsr lr
    a324:	e1a07114 	lsl	r7, r4, r1
    a328:	e1877e10 	orr	r7, r7, r0, lsl lr
    a32c:	e1a06110 	lsl	r6, r0, r1
    a330:	e0a33005 	adc	r3, r3, r5
    a334:	e1877c30 	orr	r7, r7, r0, lsr ip
    a338:	e0522006 	subs	r2, r2, r6
    a33c:	e0c33007 	sbc	r3, r3, r7
    a340:	e29a0000 	adds	r0, sl, #0
    a344:	13a00001 	movne	r0, #1
    a348:	e3a01000 	mov	r1, #0
    a34c:	e2704000 	rsbs	r4, r0, #0
    a350:	e2e15000 	rsc	r5, r1, #0
    a354:	e0222004 	eor	r2, r2, r4
    a358:	e0233005 	eor	r3, r3, r5
    a35c:	e0900002 	adds	r0, r0, r2
    a360:	e0a11003 	adc	r1, r1, r3
    a364:	e8bd4ff8 	pop	{r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
    a368:	e12fff1e 	bx	lr
    a36c:	e2728000 	rsbs	r8, r2, #0
    a370:	e1e0a00a 	mvn	sl, sl
    a374:	e2e39000 	rsc	r9, r3, #0
    a378:	eaffffaf 	b	a23c <__divdi3+0x28>
    a37c:	e2704000 	rsbs	r4, r0, #0
    a380:	e2e15000 	rsc	r5, r1, #0
    a384:	e3e0a000 	mvn	sl, #0
    a388:	eaffffa7 	b	a22c <__divdi3+0x18>

0000a38c <__udivdi3>:
    a38c:	e1510003 	cmp	r1, r3
    a390:	01500002 	cmpeq	r0, r2
    a394:	e92d47f0 	push	{r4, r5, r6, r7, r8, r9, sl, lr}
    a398:	e1a04000 	mov	r4, r0
    a39c:	e1a05001 	mov	r5, r1
    a3a0:	e1a08002 	mov	r8, r2
    a3a4:	e1a09003 	mov	r9, r3
    a3a8:	33a00000 	movcc	r0, #0
    a3ac:	33a01000 	movcc	r1, #0
    a3b0:	3a00003b 	bcc	a4a4 <__udivdi3+0x118>
    a3b4:	e1a01003 	mov	r1, r3
    a3b8:	e1a00002 	mov	r0, r2
    a3bc:	eb00003a 	bl	a4ac <__clzdi2>
    a3c0:	e1a01005 	mov	r1, r5
    a3c4:	e1a0a000 	mov	sl, r0
    a3c8:	e1a00004 	mov	r0, r4
    a3cc:	eb000036 	bl	a4ac <__clzdi2>
    a3d0:	e060300a 	rsb	r3, r0, sl
    a3d4:	e243e020 	sub	lr, r3, #32
    a3d8:	e1a07319 	lsl	r7, r9, r3
    a3dc:	e1877e18 	orr	r7, r7, r8, lsl lr
    a3e0:	e263c020 	rsb	ip, r3, #32
    a3e4:	e1877c38 	orr	r7, r7, r8, lsr ip
    a3e8:	e1550007 	cmp	r5, r7
    a3ec:	e1a06318 	lsl	r6, r8, r3
    a3f0:	01540006 	cmpeq	r4, r6
    a3f4:	e1a02003 	mov	r2, r3
    a3f8:	33a00000 	movcc	r0, #0
    a3fc:	33a01000 	movcc	r1, #0
    a400:	3a000005 	bcc	a41c <__udivdi3+0x90>
    a404:	e3a08001 	mov	r8, #1
    a408:	e0544006 	subs	r4, r4, r6
    a40c:	e1a01e18 	lsl	r1, r8, lr
    a410:	e1811c38 	orr	r1, r1, r8, lsr ip
    a414:	e0c55007 	sbc	r5, r5, r7
    a418:	e1a00318 	lsl	r0, r8, r3
    a41c:	e3530000 	cmp	r3, #0
    a420:	0a00001f 	beq	a4a4 <__udivdi3+0x118>
    a424:	e1b070a7 	lsrs	r7, r7, #1
    a428:	e1a06066 	rrx	r6, r6
    a42c:	ea000007 	b	a450 <__udivdi3+0xc4>
    a430:	e0544006 	subs	r4, r4, r6
    a434:	e0c55007 	sbc	r5, r5, r7
    a438:	e0944004 	adds	r4, r4, r4
    a43c:	e0a55005 	adc	r5, r5, r5
    a440:	e2944001 	adds	r4, r4, #1
    a444:	e2a55000 	adc	r5, r5, #0
    a448:	e2533001 	subs	r3, r3, #1
    a44c:	0a000006 	beq	a46c <__udivdi3+0xe0>
    a450:	e1570005 	cmp	r7, r5
    a454:	01560004 	cmpeq	r6, r4
    a458:	9afffff4 	bls	a430 <__udivdi3+0xa4>
    a45c:	e0944004 	adds	r4, r4, r4
    a460:	e0a55005 	adc	r5, r5, r5
    a464:	e2533001 	subs	r3, r3, #1
    a468:	1afffff8 	bne	a450 <__udivdi3+0xc4>
    a46c:	e0948000 	adds	r8, r4, r0
    a470:	e0a59001 	adc	r9, r5, r1
    a474:	e1a03234 	lsr	r3, r4, r2
    a478:	e2621020 	rsb	r1, r2, #32
    a47c:	e2420020 	sub	r0, r2, #32
    a480:	e1833115 	orr	r3, r3, r5, lsl r1
    a484:	e1a0c235 	lsr	ip, r5, r2
    a488:	e1833035 	orr	r3, r3, r5, lsr r0
    a48c:	e1a0721c 	lsl	r7, ip, r2
    a490:	e1877013 	orr	r7, r7, r3, lsl r0
    a494:	e1a06213 	lsl	r6, r3, r2
    a498:	e1877133 	orr	r7, r7, r3, lsr r1
    a49c:	e0580006 	subs	r0, r8, r6
    a4a0:	e0c91007 	sbc	r1, r9, r7
    a4a4:	e8bd47f0 	pop	{r4, r5, r6, r7, r8, r9, sl, lr}
    a4a8:	e12fff1e 	bx	lr

0000a4ac <__clzdi2>:
    a4ac:	e92d4010 	push	{r4, lr}
    a4b0:	e3510000 	cmp	r1, #0
    a4b4:	1a000002 	bne	a4c4 <__clzdi2+0x18>
    a4b8:	eb000005 	bl	a4d4 <__clzsi2>
    a4bc:	e2800020 	add	r0, r0, #32
    a4c0:	ea000001 	b	a4cc <__clzdi2+0x20>
    a4c4:	e1a00001 	mov	r0, r1
    a4c8:	eb000001 	bl	a4d4 <__clzsi2>
    a4cc:	e8bd4010 	pop	{r4, lr}
    a4d0:	e12fff1e 	bx	lr

0000a4d4 <__clzsi2>:
    a4d4:	e3a0101c 	mov	r1, #28
    a4d8:	e3500801 	cmp	r0, #65536	; 0x10000
    a4dc:	21a00820 	lsrcs	r0, r0, #16
    a4e0:	22411010 	subcs	r1, r1, #16
    a4e4:	e3500c01 	cmp	r0, #256	; 0x100
    a4e8:	21a00420 	lsrcs	r0, r0, #8
    a4ec:	22411008 	subcs	r1, r1, #8
    a4f0:	e3500010 	cmp	r0, #16
    a4f4:	21a00220 	lsrcs	r0, r0, #4
    a4f8:	22411004 	subcs	r1, r1, #4
    a4fc:	e28f2008 	add	r2, pc, #8
    a500:	e7d20000 	ldrb	r0, [r2, r0]
    a504:	e0800001 	add	r0, r0, r1
    a508:	e12fff1e 	bx	lr
    a50c:	02020304 	andeq	r0, r2, #4, 6	; 0x10000000
    a510:	01010101 	tsteq	r1, r1, lsl #2
	...

Disassembly of section .rodata:

0000b000 <__rodata_start>:
    b000:	33323130 	teqcc	r2, #48, 2
    b004:	37363534 			; <UNDEFINED> instruction: 0x37363534
    b008:	62613938 	rsbvs	r3, r1, #56, 18	; 0xe0000
    b00c:	66656463 	strbtvs	r6, [r5], -r3, ror #8
	...

Disassembly of section .rodata.str1.4:

0000b014 <.rodata.str1.4>:
    b014:	61766e49 	cmnvs	r6, r9, asr #28
    b018:	2064696c 	rsbcs	r6, r4, ip, ror #18
    b01c:	6b736174 	blvs	1ce35f4 <__user_program+0x19e35f4>
    b020:	00000a20 	andeq	r0, r0, r0, lsr #20
    b024:	00000030 	andeq	r0, r0, r0, lsr r0
    b028:	00007830 	andeq	r7, r0, r0, lsr r8
    b02c:	74697845 	strbtvc	r7, [r9], #-2117	; 0x845
    b030:	61745320 	cmnvs	r4, r0, lsr #6
    b034:	3a737574 	bcc	1ce860c <__user_program+0x19e860c>
    b038:	0a642520 	beq	19144c0 <__user_program+0x16144c0>
    b03c:	00000000 	andeq	r0, r0, r0
    b040:	00082008 	andeq	r2, r8, r8
    b044:	69797254 	ldmdbvs	r9!, {r2, r4, r6, r9, ip, sp, lr}^
    b048:	7420676e 	strtvc	r6, [r0], #-1902	; 0x76e
    b04c:	6572206f 	ldrbvs	r2, [r2, #-111]!	; 0x6f
    b050:	65766f6d 	ldrbvs	r6, [r6, #-3949]!	; 0xf6d
    b054:	6f726620 	svcvs	0x00726620
    b058:	6d65206d 	stclvs	0, cr2, [r5, #-436]!	; 0xfffffe4c
    b05c:	20797470 	rsbscs	r7, r9, r0, ror r4
    b060:	7473696c 	ldrbtvc	r6, [r3], #-2412	; 0x96c
    b064:	20666f20 	rsbcs	r6, r6, r0, lsr #30
    b068:	6574756d 	ldrbvs	r7, [r4, #-1389]!	; 0x56d
    b06c:	20736578 	rsbscs	r6, r3, r8, ror r5
    b070:	0000000a 	andeq	r0, r0, sl
    b074:	20646944 	rsbcs	r6, r4, r4, asr #18
    b078:	20746f6e 	rsbscs	r6, r4, lr, ror #30
    b07c:	656c6564 	strbvs	r6, [ip, #-1380]!	; 0x564
    b080:	6e206574 	mcrvs	5, 1, r6, cr0, cr4, {3}
    b084:	2065646f 	rsbcs	r6, r5, pc, ror #8
    b088:	0000000a 	andeq	r0, r0, sl
    b08c:	65726854 	ldrbvs	r6, [r2, #-2132]!	; 0x854
    b090:	69206461 	stmdbvs	r0!, {r0, r5, r6, sl, sp, lr}
    b094:	6f682073 	svcvs	0x00682073
    b098:	6e69646c 	cdpvs	4, 6, cr6, cr9, cr12, {3}
    b09c:	756d2067 	strbvc	r2, [sp, #-103]!	; 0x67
    b0a0:	20786574 	rsbscs	r6, r8, r4, ror r5
    b0a4:	6c696877 	stclvs	8, cr6, [r9], #-476	; 0xfffffe24
    b0a8:	72742065 	rsbsvc	r2, r4, #101	; 0x65
    b0ac:	676e6979 			; <UNDEFINED> instruction: 0x676e6979
    b0b0:	206f7420 	rsbcs	r7, pc, r0, lsr #8
    b0b4:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xc73
    b0b8:	000a2070 	andeq	r2, sl, r0, ror r0

Disassembly of section .ARM.exidx:

0000b0bc <.ARM.exidx>:
    b0bc:	7ffff158 	svcvc	0x00fff158
    b0c0:	00000001 	andeq	r0, r0, r1

Disassembly of section .data:

0000c000 <__data_start>:
    c000:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000c004 <first_time_flag>:
    c004:	00000001 	andeq	r0, r0, r1

0000c008 <U>:
    c008:	00000000 	andeq	r0, r0, r0
    c00c:	3f800000 	svccc	0x00800000
    c010:	3f541206 	svccc	0x00541206
    c014:	3f47a0f9 	svccc	0x0047a0f9
    c018:	3f41bda5 	svccc	0x0041bda5
    c01c:	3f3e5604 	svccc	0x003e5604
    c020:	3f3c1bda 	svccc	0x003c1bda
    c024:	3f3a8588 	svccc	0x003a8588
    c028:	3f395e9e 	svccc	0x00395e9e
    c02c:	3f3872b0 	svccc	0x003872b0
    c030:	3f37bb30 	svccc	0x0037bb30
    c034:	3f372b02 	svccc	0x00372b02
    c038:	3f36ae7d 	svccc	0x0036ae7d
    c03c:	3f3645a2 	svccc	0x003645a2
    c040:	3f35e9e2 	svccc	0x0035e9e2
    c044:	3f359b3d 	svccc	0x00359b3d
    c048:	3f3559b4 	svccc	0x003559b4
    c04c:	3f351eb8 	svccc	0x00351eb8
    c050:	3f34ea4b 	svccc	0x0034ea4b
    c054:	3f34b5dd 	svccc	0x0034b5dd
    c058:	3f348e8a 	svccc	0x00348e8a
    c05c:	3f346738 	svccc	0x00346738
    c060:	3f344674 	svccc	0x00344674
    c064:	3f3425af 	svccc	0x003425af
    c068:	3f340b78 	svccc	0x00340b78
    c06c:	3f33eab3 	svccc	0x0033eab3
    c070:	3f33d70a 	svccc	0x0033d70a
    c074:	3f33bcd3 	svccc	0x0033bcd3
    c078:	3f33a92a 	svccc	0x0033a92a
    c07c:	3f339581 	svccc	0x00339581
    c080:	3f3381d8 	svccc	0x003381d8
    c084:	3f3374bc 	svccc	0x003374bc
    c088:	3f336113 	svccc	0x00336113

Disassembly of section .bss:

0000d000 <__bss_start>:
    d000:	00000000 	andeq	r0, r0, r0

0000d004 <tcb_array>:
	...

0002de84 <priority_map>:
	...

0002df04 <curr_time>:
   2df04:	00000000 	andeq	r0, r0, r0

0002df08 <runnable_pool>:
   2df08:	00000000 	andeq	r0, r0, r0

0002df0c <waiting_pool>:
   2df0c:	00000000 	andeq	r0, r0, r0

Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	00000175 	andeq	r0, r0, r5, ror r1
       4:	00000004 	andeq	r0, r0, r4
       8:	01040000 	mrseq	r0, (UNDEF: 4)
       c:	0000008e 	andeq	r0, r0, lr, lsl #1
      10:	00007b01 	andeq	r7, r0, r1, lsl #22
      14:	00003a00 	andeq	r3, r0, r0, lsl #20
      18:	00805400 	addeq	r5, r0, r0, lsl #8
      1c:	00006000 	andeq	r6, r0, r0
      20:	00000000 	andeq	r0, r0, r0
      24:	08010200 	stmdaeq	r1, {r9}
      28:	0000011e 	andeq	r0, r0, lr, lsl r1
      2c:	5c050202 	sfmpl	f0, 4, [r5], {2}
      30:	03000001 	movweq	r0, #1
      34:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
      38:	08020074 	stmdaeq	r2, {r2, r4, r5, r6}
      3c:	00000005 	andeq	r0, r0, r5
      40:	010d0400 	tsteq	sp, r0, lsl #8
      44:	16030000 	strne	r0, [r3], -r0
      48:	0000004c 	andeq	r0, r0, ip, asr #32
      4c:	15080102 	strne	r0, [r8, #-258]	; 0x102
      50:	02000001 	andeq	r0, r0, #1
      54:	012f0702 	teqeq	pc, r2, lsl #14
      58:	04020000 	streq	r0, [r2], #-0
      5c:	00006507 	andeq	r6, r0, r7, lsl #10
      60:	07080200 	streq	r0, [r8, -r0, lsl #4]
      64:	0000005b 	andeq	r0, r0, fp, asr r0
      68:	00003105 	andeq	r3, r0, r5, lsl #2
      6c:	54170100 	ldrpl	r0, [r7], #-256	; 0x100
      70:	20000080 	andcs	r0, r0, r0, lsl #1
      74:	01000000 	mrseq	r0, (UNDEF: 0)
      78:	0000ac9c 	muleq	r0, ip, ip
      7c:	80640600 	rsbhi	r0, r4, r0, lsl #12
      80:	01440000 	mrseq	r0, (UNDEF: 68)
      84:	00960000 	addseq	r0, r6, r0
      88:	01070000 	mrseq	r0, (UNDEF: 7)
      8c:	07310151 			; <UNDEFINED> instruction: 0x07310151
      90:	08025001 	stmdaeq	r2, {r0, ip, lr}
      94:	7008002f 	andvc	r0, r8, pc, lsr #32
      98:	44000080 	strmi	r0, [r0], #-128	; 0x80
      9c:	07000001 	streq	r0, [r0, -r1]
      a0:	31015101 	tstcc	r1, r1, lsl #2
      a4:	02500107 	subseq	r0, r0, #-1073741823	; 0xc0000001
      a8:	00002308 	andeq	r2, r0, r8, lsl #6
      ac:	00014205 	andeq	r4, r1, r5, lsl #4
      b0:	741d0100 	ldrvc	r0, [sp], #-256	; 0x100
      b4:	10000080 	andne	r0, r0, r0, lsl #1
      b8:	01000000 	mrseq	r0, (UNDEF: 0)
      bc:	0000d29c 	muleq	r0, ip, r2
      c0:	80800800 	addhi	r0, r0, r0, lsl #16
      c4:	015a0000 	cmpeq	sl, r0
      c8:	01070000 	mrseq	r0, (UNDEF: 7)
      cc:	2f080250 	svccs	0x00080250
      d0:	0e050000 	cdpeq	0, 0, cr0, cr5, cr0, {0}
      d4:	01000000 	mrseq	r0, (UNDEF: 0)
      d8:	00808422 	addeq	r8, r0, r2, lsr #8
      dc:	00001000 	andeq	r1, r0, r0
      e0:	f89c0100 			; <UNDEFINED> instruction: 0xf89c0100
      e4:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
      e8:	00008090 	muleq	r0, r0, r0
      ec:	0000016b 	andeq	r0, r0, fp, ror #2
      f0:	02500107 	subseq	r0, r0, #-1073741823	; 0xc0000001
      f4:	00002f08 	andeq	r2, r0, r8, lsl #30
      f8:	00001c05 	andeq	r1, r0, r5, lsl #24
      fc:	94270100 	strtls	r0, [r7], #-256	; 0x100
     100:	10000080 	andne	r0, r0, r0, lsl #1
     104:	01000000 	mrseq	r0, (UNDEF: 0)
     108:	00011e9c 	muleq	r1, ip, lr
     10c:	80a00800 	adchi	r0, r0, r0, lsl #16
     110:	015a0000 	cmpeq	sl, r0
     114:	01070000 	mrseq	r0, (UNDEF: 7)
     118:	23080250 	movwcs	r0, #33360	; 0x8250
     11c:	23050000 	movwcs	r0, #20480	; 0x5000
     120:	01000001 	tsteq	r0, r1
     124:	0080a42c 	addeq	sl, r0, ip, lsr #8
     128:	00001000 	andeq	r1, r0, r0
     12c:	449c0100 	ldrmi	r0, [ip], #256	; 0x100
     130:	08000001 	stmdaeq	r0, {r0}
     134:	000080b0 	strheq	r8, [r0], -r0
     138:	0000016b 	andeq	r0, r0, fp, ror #2
     13c:	02500107 	subseq	r0, r0, #-1073741823	; 0xc0000001
     140:	00002308 	andeq	r2, r0, r8, lsl #6
     144:	00015009 	andeq	r5, r1, r9
     148:	5a370200 	bpl	dc0950 <__user_program+0xac0950>
     14c:	0a000001 	beq	158 <__start-0x7ea8>
     150:	00000041 	andeq	r0, r0, r1, asr #32
     154:	0000410a 	andeq	r4, r0, sl, lsl #2
     158:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
     15c:	02000000 	andeq	r0, r0, #0
     160:	00016b3d 	andeq	r6, r1, sp, lsr fp
     164:	00410a00 	subeq	r0, r1, r0, lsl #20
     168:	0b000000 	bleq	170 <__start-0x7e90>
     16c:	00000072 	andeq	r0, r0, r2, ror r0
     170:	410a4302 	tstmi	sl, r2, lsl #6
     174:	00000000 	andeq	r0, r0, r0
     178:	0001b100 	andeq	fp, r1, r0, lsl #2
     17c:	a0000400 	andge	r0, r0, r0, lsl #8
     180:	04000000 	streq	r0, [r0], #-0
     184:	00008e01 	andeq	r8, r0, r1, lsl #28
     188:	01960100 	orrseq	r0, r6, r0, lsl #2
     18c:	003a0000 	eorseq	r0, sl, r0
     190:	80b40000 	adcshi	r0, r4, r0
     194:	01600000 	cmneq	r0, r0
     198:	00730000 	rsbseq	r0, r3, r0
     19c:	01020000 	mrseq	r0, (UNDEF: 2)
     1a0:	00011508 	andeq	r1, r1, r8, lsl #10
     1a4:	08010200 	stmdaeq	r1, {r9}
     1a8:	0000011e 	andeq	r0, r0, lr, lsl r1
     1ac:	5c050202 	sfmpl	f0, 4, [r5], {2}
     1b0:	03000001 	movweq	r0, #1
     1b4:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     1b8:	08020074 	stmdaeq	r2, {r2, r4, r5, r6}
     1bc:	00000005 	andeq	r0, r0, r5
     1c0:	010d0400 	tsteq	sp, r0, lsl #8
     1c4:	16020000 	strne	r0, [r2], -r0
     1c8:	00000025 	andeq	r0, r0, r5, lsr #32
     1cc:	2f070202 	svccs	0x00070202
     1d0:	04000001 	streq	r0, [r0], #-1
     1d4:	00000179 	andeq	r0, r0, r9, ror r1
     1d8:	00651a02 	rsbeq	r1, r5, r2, lsl #20
     1dc:	04020000 	streq	r0, [r2], #-0
     1e0:	00006507 	andeq	r6, r0, r7, lsl #10
     1e4:	07080200 	streq	r0, [r8, -r0, lsl #4]
     1e8:	0000005b 	andeq	r0, r0, fp, asr r0
     1ec:	00015005 	andeq	r5, r1, r5
     1f0:	b4520100 	ldrblt	r0, [r2], #-256	; 0x100
     1f4:	54000080 	strpl	r0, [r0], #-128	; 0x80
     1f8:	01000000 	mrseq	r0, (UNDEF: 0)
     1fc:	0000d29c 	muleq	r0, ip, r2
     200:	69700600 	ldmdbvs	r0!, {r9, sl}^
     204:	5201006e 	andpl	r0, r1, #110	; 0x6e
     208:	00000048 	andeq	r0, r0, r8, asr #32
     20c:	00000000 	andeq	r0, r0, r0
     210:	6e756607 	cdpvs	6, 7, cr6, cr5, cr7, {0}
     214:	48520100 	ldmdami	r2, {r8}^
     218:	01000000 	mrseq	r0, (UNDEF: 0)
     21c:	65720851 	ldrbvs	r0, [r2, #-2129]!	; 0x851
     220:	57010067 	strpl	r0, [r1, -r7, rrx]
     224:	0000005a 	andeq	r0, r0, sl, asr r0
     228:	00000021 	andeq	r0, r0, r1, lsr #32
     22c:	00015509 	andeq	r5, r1, r9, lsl #10
     230:	5a590100 	bpl	1640638 <__user_program+0x1340638>
     234:	5a000000 	bpl	23c <__start-0x7dc4>
     238:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     23c:	0000018f 	andeq	r0, r0, pc, lsl #3
     240:	005a5b01 	subseq	r5, sl, r1, lsl #22
     244:	00780000 	rsbseq	r0, r8, r0
     248:	05000000 	streq	r0, [r0, #-0]
     24c:	00000028 	andeq	r0, r0, r8, lsr #32
     250:	81086201 	tsthi	r8, r1, lsl #4
     254:	00440000 	subeq	r0, r4, r0
     258:	9c010000 	stcls	0, cr0, [r1], {-0}
     25c:	000000f7 	strdeq	r0, [r0], -r7
     260:	6e697006 	cdpvs	0, 6, cr7, cr9, cr6, {0}
     264:	48620100 	stmdami	r2!, {r8}^
     268:	8b000000 	blhi	270 <__start-0x7d90>
     26c:	00000000 	andeq	r0, r0, r0
     270:	00007205 	andeq	r7, r0, r5, lsl #4
     274:	4c6e0100 	stfmie	f0, [lr], #-0
     278:	44000081 	strmi	r0, [r0], #-129	; 0x81
     27c:	01000000 	mrseq	r0, (UNDEF: 0)
     280:	00011c9c 	muleq	r1, ip, ip
     284:	69700600 	ldmdbvs	r0!, {r9, sl}^
     288:	6e01006e 	cdpvs	0, 0, cr0, cr1, cr14, {3}
     28c:	00000048 	andeq	r0, r0, r8, asr #32
     290:	000000c5 	andeq	r0, r0, r5, asr #1
     294:	01660500 	cmneq	r6, r0, lsl #10
     298:	7a010000 	bvc	402a0 <__bss_end+0x122a0>
     29c:	00008190 	muleq	r0, r0, r1
     2a0:	00000084 	andeq	r0, r0, r4, lsl #1
     2a4:	01889c01 	orreq	r9, r8, r1, lsl #24
     2a8:	70060000 	andvc	r0, r6, r0
     2ac:	01006e69 	tsteq	r0, r9, ror #28
     2b0:	0000487a 	andeq	r4, r0, sl, ror r8
     2b4:	0000ff00 	andeq	pc, r0, r0, lsl #30
     2b8:	01c60a00 	biceq	r0, r6, r0, lsl #20
     2bc:	7a010000 	bvc	402c4 <__bss_end+0x122c4>
     2c0:	00000048 	andeq	r0, r0, r8, asr #32
     2c4:	00000120 	andeq	r0, r0, r0, lsr #2
     2c8:	0081b80b 	addeq	fp, r1, fp, lsl #16
     2cc:	0001a700 	andeq	sl, r1, r0, lsl #14
     2d0:	00016300 	andeq	r6, r1, r0, lsl #6
     2d4:	50010c00 	andpl	r0, r1, r0, lsl #24
     2d8:	00960802 	addseq	r0, r6, r2, lsl #16
     2dc:	0081e00b 	addeq	lr, r1, fp
     2e0:	0001a700 	andeq	sl, r1, r0, lsl #14
     2e4:	00017700 	andeq	r7, r1, r0, lsl #14
     2e8:	50010c00 	andpl	r0, r1, r0, lsl #24
     2ec:	00960802 	addseq	r0, r6, r2, lsl #16
     2f0:	0082080d 	addeq	r0, r2, sp, lsl #16
     2f4:	0001a700 	andeq	sl, r1, r0, lsl #14
     2f8:	50010c00 	andpl	r0, r1, r0, lsl #24
     2fc:	00960802 	addseq	r0, r6, r2, lsl #16
     300:	01740e00 	cmneq	r4, r0, lsl #28
     304:	4f010000 	svcmi	0x00010000
     308:	00000197 	muleq	r0, r7, r1
     30c:	3f200000 	svccc	0x00200000
     310:	00019c0f 	andeq	r9, r1, pc, lsl #24
     314:	a2041000 	andge	r1, r4, #0
     318:	11000001 	tstne	r0, r1
     31c:	0000005a 	andeq	r0, r0, sl, asr r0
     320:	00018212 	andeq	r8, r1, r2, lsl r2
     324:	13190300 	tstne	r9, #0, 6
     328:	0000005a 	andeq	r0, r0, sl, asr r0
     32c:	085d0000 	ldmdaeq	sp, {}^	; <UNPREDICTABLE>
     330:	00040000 	andeq	r0, r4, r0
     334:	0000019e 	muleq	r0, lr, r1
     338:	008e0104 	addeq	r0, lr, r4, lsl #2
     33c:	9f010000 	svcls	0x00010000
     340:	3a000003 	bcc	354 <__start-0x7cac>
     344:	14000000 	strne	r0, [r0], #-0
     348:	9c000082 	stcls	0, cr0, [r0], {130}	; 0x82
     34c:	f9000006 			; <UNDEFINED> instruction: 0xf9000006
     350:	02000000 	andeq	r0, r0, #0
     354:	011e0801 	tsteq	lr, r1, lsl #16
     358:	02020000 	andeq	r0, r2, #0
     35c:	00015c05 	andeq	r5, r1, r5, lsl #24
     360:	05040300 	streq	r0, [r4, #-768]	; 0x300
     364:	00746e69 	rsbseq	r6, r4, r9, ror #28
     368:	00050802 	andeq	r0, r5, r2, lsl #16
     36c:	04000000 	streq	r0, [r0], #-0
     370:	0000010d 	andeq	r0, r0, sp, lsl #2
     374:	004c1602 	subeq	r1, ip, r2, lsl #12
     378:	01020000 	mrseq	r0, (UNDEF: 2)
     37c:	00011508 	andeq	r1, r1, r8, lsl #10
     380:	04c50400 	strbeq	r0, [r5], #1024	; 0x400
     384:	18020000 	stmdane	r2, {}	; <UNPREDICTABLE>
     388:	0000005e 	andeq	r0, r0, lr, asr r0
     38c:	2f070202 	svccs	0x00070202
     390:	04000001 	streq	r0, [r0], #-1
     394:	00000179 	andeq	r0, r0, r9, ror r1
     398:	00701a02 	rsbseq	r1, r0, r2, lsl #20
     39c:	04020000 	streq	r0, [r2], #-0
     3a0:	00006507 	andeq	r6, r0, r7, lsl #10
     3a4:	07080200 	streq	r0, [r8, -r0, lsl #4]
     3a8:	0000005b 	andeq	r0, r0, fp, asr r0
     3ac:	0004a605 	andeq	sl, r4, r5, lsl #12
     3b0:	0d030c00 	stceq	12, cr0, [r3, #-0]
     3b4:	000000af 	andeq	r0, r0, pc, lsr #1
     3b8:	0002a206 	andeq	sl, r2, r6, lsl #4
     3bc:	af0f0300 	svcge	0x000f0300
     3c0:	00000000 	andeq	r0, r0, r0
     3c4:	0001e706 	andeq	lr, r1, r6, lsl #14
     3c8:	af130300 	svcge	0x00130300
     3cc:	04000000 	streq	r0, [r0], #-0
     3d0:	0001cc06 	andeq	ip, r1, r6, lsl #24
     3d4:	b4150300 	ldrlt	r0, [r5], #-768	; 0x300
     3d8:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     3dc:	00330700 	eorseq	r0, r3, r0, lsl #14
     3e0:	04080000 	streq	r0, [r8], #-0
     3e4:	000000ba 	strheq	r0, [r0], -sl
     3e8:	00007e07 	andeq	r7, r0, r7, lsl #28
     3ec:	01b90400 			; <UNDEFINED> instruction: 0x01b90400
     3f0:	16030000 	strne	r0, [r3], -r0
     3f4:	0000007e 	andeq	r0, r0, lr, ror r0
     3f8:	00035e04 	andeq	r5, r3, r4, lsl #28
     3fc:	d52d0400 	strle	r0, [sp, #-1024]!	; 0x400
     400:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     404:	0000db04 	andeq	sp, r0, r4, lsl #22
     408:	010a0900 	tsteq	sl, r0, lsl #18
     40c:	00f73304 	rscseq	r3, r7, r4, lsl #6
     410:	770b0000 	strvc	r0, [fp, -r0]
     414:	00000004 	andeq	r0, r0, r4
     418:	00050d0b 	andeq	r0, r5, fp, lsl #26
     41c:	d10b0100 	mrsle	r0, (UNDEF: 27)
     420:	02000001 	andeq	r0, r0, #1
     424:	01c10400 	biceq	r0, r1, r0, lsl #8
     428:	33040000 	movwcc	r0, #16384	; 0x4000
     42c:	000000dc 	ldrdeq	r0, [r0], -ip
     430:	00025905 	andeq	r5, r2, r5, lsl #18
     434:	38044c00 	stmdacc	r4, {sl, fp, lr}
     438:	00000127 	andeq	r0, r0, r7, lsr #2
     43c:	0001ff06 	andeq	pc, r1, r6, lsl #30
     440:	273a0400 	ldrcs	r0, [sl, -r0, lsl #8]!
     444:	00000001 	andeq	r0, r0, r1
     448:	00039206 	andeq	r9, r3, r6, lsl #4
     44c:	3e3c0400 	cfabsscc	mvf0, mvf12
     450:	34000001 	strcc	r0, [r0], #-1
     454:	00650c00 	rsbeq	r0, r5, r0, lsl #24
     458:	01370000 	teqeq	r7, r0
     45c:	370d0000 	strcc	r0, [sp, -r0]
     460:	0c000001 	stceq	0, cr0, [r0], {1}
     464:	07040200 	streq	r0, [r4, -r0, lsl #4]
     468:	00000467 	andeq	r0, r0, r7, ror #8
     46c:	0000650c 	andeq	r6, r0, ip, lsl #10
     470:	00014e00 	andeq	r4, r1, r0, lsl #28
     474:	01370d00 	teqeq	r7, r0, lsl #26
     478:	00050000 	andeq	r0, r5, r0
     47c:	00025904 	andeq	r5, r2, r4, lsl #18
     480:	023d0400 	eorseq	r0, sp, #0, 8
     484:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
     488:	000002d9 	ldrdeq	r0, [r0], -r9
     48c:	45041074 	strmi	r1, [r4, #-116]	; 0x74
     490:	000001f4 	strdeq	r0, [r0], -r4
     494:	0063700f 	rsbeq	r7, r3, pc
     498:	00704704 	rsbseq	r4, r0, r4, lsl #14
     49c:	0f000000 	svceq	0x00000000
     4a0:	00787463 	rsbseq	r7, r8, r3, ror #8
     4a4:	014e4904 	cmpeq	lr, r4, lsl #18
     4a8:	0f040000 	svceq	0x00040000
     4ac:	4b040063 	blmi	100640 <__bss_end+0xd2640>
     4b0:	00000070 	andeq	r0, r0, r0, ror r0
     4b4:	00740f50 	rsbseq	r0, r4, r0, asr pc
     4b8:	00704d04 	rsbseq	r4, r0, r4, lsl #26
     4bc:	06540000 	ldrbeq	r0, [r4], -r0
     4c0:	00000325 	andeq	r0, r0, r5, lsr #6
     4c4:	00704f04 	rsbseq	r4, r0, r4, lsl #30
     4c8:	06580000 	ldrbeq	r0, [r8], -r0
     4cc:	000001f6 	strdeq	r0, [r0], -r6
     4d0:	00af5104 	adceq	r5, pc, r4, lsl #2
     4d4:	065c0000 	ldrbeq	r0, [ip], -r0
     4d8:	000002ec 	andeq	r0, r0, ip, ror #5
     4dc:	00af5304 	adceq	r5, pc, r4, lsl #6
     4e0:	06600000 	strbteq	r0, [r0], -r0
     4e4:	0000032c 	andeq	r0, r0, ip, lsr #6
     4e8:	00705504 	rsbseq	r5, r0, r4, lsl #10
     4ec:	06640000 	strbteq	r0, [r4], -r0
     4f0:	000001c6 	andeq	r0, r0, r6, asr #3
     4f4:	01f45804 	mvnseq	r5, r4, lsl #16
     4f8:	06680000 	strbteq	r0, [r8], -r0
     4fc:	00000554 	andeq	r0, r0, r4, asr r5
     500:	01f95a04 	mvnseq	r5, r4, lsl #20
     504:	106c0000 	rsbne	r0, ip, r0
     508:	00000525 	andeq	r0, r0, r5, lsr #10
     50c:	00af5e04 	adceq	r5, pc, r4, lsl #28
     510:	106c0000 	rsbne	r0, ip, r0
     514:	0001a910 	andeq	sl, r1, r0, lsl r9
     518:	0a600400 	beq	1801520 <__user_program+0x1501520>
     51c:	70000002 	andvc	r0, r0, r2
     520:	f7070010 			; <UNDEFINED> instruction: 0xf7070010
     524:	0c000000 	stceq	0, cr0, [r0], {-0}
     528:	00000065 	andeq	r0, r0, r5, rrx
     52c:	0000020a 	andeq	r0, r0, sl, lsl #4
     530:	00013711 	andeq	r3, r1, r1, lsl r7
     534:	0003ff00 	andeq	pc, r3, r0, lsl #30
     538:	02100408 	andseq	r0, r0, #8, 8	; 0x8000000
     53c:	bf070000 	svclt	0x00070000
     540:	12000000 	andne	r0, r0, #0
     544:	00626374 	rsbeq	r6, r2, r4, ror r3
     548:	01596104 	cmpeq	r9, r4, lsl #2
     54c:	e2130000 	ands	r0, r3, #0
     550:	01000003 	tsteq	r0, r3
     554:	0082142e 	addeq	r1, r2, lr, lsr #8
     558:	00004400 	andeq	r4, r0, r0, lsl #8
     55c:	439c0100 	orrsmi	r0, ip, #0, 2
     560:	14000002 	strne	r0, [r0], #-2
     564:	2f010069 	svccs	0x00010069
     568:	00000033 	andeq	r0, r0, r3, lsr r0
     56c:	00000141 	andeq	r0, r0, r1, asr #2
     570:	04d81500 	ldrbeq	r1, [r8], #1280	; 0x500
     574:	3b010000 	blcc	4057c <__bss_end+0x1257c>
     578:	00008258 	andeq	r8, r0, r8, asr r2
     57c:	00000024 	andeq	r0, r0, r4, lsr #32
     580:	02989c01 	addseq	r9, r8, #256	; 0x100
     584:	60160000 	andsvs	r0, r6, r0
     588:	42000082 	andmi	r0, r0, #130	; 0x82
     58c:	16000006 	strne	r0, [r0], -r6
     590:	00008264 	andeq	r8, r0, r4, ror #4
     594:	00000649 	andeq	r0, r0, r9, asr #12
     598:	00826816 	addeq	r6, r2, r6, lsl r8
     59c:	00022000 	andeq	r2, r2, r0
     5a0:	826c1600 	rsbhi	r1, ip, #0, 12
     5a4:	06500000 	ldrbeq	r0, [r0], -r0
     5a8:	70160000 	andsvc	r0, r6, r0
     5ac:	5d000082 	stcpl	0, cr0, [r0, #-520]	; 0xfffffdf8
     5b0:	16000006 	strne	r0, [r0], -r6
     5b4:	00008274 	andeq	r8, r0, r4, ror r2
     5b8:	00000664 	andeq	r0, r0, r4, ror #12
     5bc:	00827816 	addeq	r7, r2, r6, lsl r8
     5c0:	00066b00 	andeq	r6, r6, r0, lsl #22
     5c4:	d8170000 	ldmdale	r7, {}	; <UNPREDICTABLE>
     5c8:	01000003 	tsteq	r0, r3
     5cc:	00827c4f 	addeq	r7, r2, pc, asr #24
     5d0:	0002cc00 	andeq	ip, r2, r0, lsl #24
     5d4:	779c0100 	ldrvc	r0, [ip, r0, lsl #2]
     5d8:	14000003 	strne	r0, [r0], #-3
     5dc:	6d010069 	stcvs	0, cr0, [r1, #-420]	; 0xfffffe5c
     5e0:	00000033 	andeq	r0, r0, r3, lsr r0
     5e4:	00000160 	andeq	r0, r0, r0, ror #2
     5e8:	00048d18 	andeq	r8, r4, r8, lsl sp
     5ec:	33810100 	orrcc	r0, r1, #0, 2
     5f0:	7f000000 	svcvc	0x00000000
     5f4:	19000001 	stmdbne	r0, {r0}
     5f8:	00008294 	muleq	r0, r4, r2
     5fc:	00000140 	andeq	r0, r0, r0, asr #2
     600:	00000327 	andeq	r0, r0, r7, lsr #6
     604:	0004d318 	andeq	sp, r4, r8, lsl r3
     608:	77520100 	ldrbvc	r0, [r2, -r0, lsl #2]
     60c:	9d000003 	stcls	0, cr0, [r0, #-12]
     610:	19000001 	stmdbne	r0, {r0}
     614:	0000834c 	andeq	r8, r0, ip, asr #6
     618:	00000088 	andeq	r0, r0, r8, lsl #1
     61c:	00000300 	andeq	r0, r0, r0, lsl #6
     620:	01007414 	tsteq	r0, r4, lsl r4
     624:	00007064 	andeq	r7, r0, r4, rrx
     628:	0001bc00 	andeq	fp, r1, r0, lsl #24
     62c:	dc1a0000 	ldcle	0, cr0, [sl], {-0}
     630:	7c000082 	stcvc	0, cr0, [r0], {130}	; 0x82
     634:	17000006 	strne	r0, [r0, -r6]
     638:	1b000003 	blne	64c <__start-0x79b4>
     63c:	03055001 	movweq	r5, #20481	; 0x5001
     640:	0000b014 	andeq	fp, r0, r4, lsl r0
     644:	82e41c00 	rschi	r1, r4, #0, 24
     648:	069d0000 	ldreq	r0, [sp], r0
     64c:	011b0000 	tsteq	fp, r0
     650:	00310150 	eorseq	r0, r1, r0, asr r1
     654:	00001d00 	andeq	r1, r0, r0, lsl #26
     658:	03400000 	movteq	r0, #0
     65c:	d3180000 	tstle	r8, #0
     660:	01000004 	tsteq	r0, r4
     664:	00037774 	andeq	r7, r3, r4, ror r7
     668:	0001cf00 	andeq	ip, r1, r0, lsl #30
     66c:	74190000 	ldrvc	r0, [r9], #-0
     670:	30000084 	andcc	r0, r0, r4, lsl #1
     674:	5d000000 	stcpl	0, cr0, [r0, #-0]
     678:	18000003 	stmdane	r0, {r0, r1}
     67c:	000004d3 	ldrdeq	r0, [r0], -r3
     680:	03778801 	cmneq	r7, #65536	; 0x10000
     684:	01ee0000 	mvneq	r0, r0
     688:	1e000000 	cdpne	0, 0, cr0, cr0, cr0, {0}
     68c:	000084bc 			; <UNDEFINED> instruction: 0x000084bc
     690:	00000054 	andeq	r0, r0, r4, asr r0
     694:	0004d318 	andeq	sp, r4, r8, lsl r3
     698:	77920100 	ldrvc	r0, [r2, r0, lsl #2]
     69c:	0d000003 	stceq	0, cr0, [r0, #-12]
     6a0:	00000002 	andeq	r0, r0, r2
     6a4:	7d040800 	stcvc	8, cr0, [r4, #-0]
     6a8:	07000003 	streq	r0, [r0, -r3]
     6ac:	00000215 	andeq	r0, r0, r5, lsl r2
     6b0:	0003cb1f 	andeq	ip, r3, pc, lsl fp
     6b4:	d6a80100 	strtle	r0, [r8], r0, lsl #2
     6b8:	48000003 	stmdami	r0, {r0, r1}
     6bc:	b0000085 	andlt	r0, r0, r5, lsl #1
     6c0:	01000000 	mrseq	r0, (UNDEF: 0)
     6c4:	0003d69c 	muleq	r3, ip, r6
     6c8:	04ce2000 	strbeq	r2, [lr], #0
     6cc:	a8010000 	stmdage	r1, {}	; <UNPREDICTABLE>
     6d0:	000003d6 	ldrdeq	r0, [r0], -r6
     6d4:	00000243 	andeq	r0, r0, r3, asr #4
     6d8:	72747014 	rsbsvc	r7, r4, #20
     6dc:	d6a90100 	strtle	r0, [r9], r0, lsl #2
     6e0:	64000003 	strvs	r0, [r0], #-3
     6e4:	18000002 	stmdane	r0, {r1}
     6e8:	000004d3 	ldrdeq	r0, [r0], -r3
     6ec:	0377aa01 	cmneq	r7, #4096	; 0x1000
     6f0:	02bd0000 	adcseq	r0, sp, #0
     6f4:	69140000 	ldmdbvs	r4, {}	; <UNPREDICTABLE>
     6f8:	33ac0100 			; <UNDEFINED> instruction: 0x33ac0100
     6fc:	dc000000 	stcle	0, cr0, [r0], {-0}
     700:	00000002 	andeq	r0, r0, r2
     704:	00650408 	rsbeq	r0, r5, r8, lsl #8
     708:	511f0000 	tstpl	pc, r0
     70c:	01000002 	tsteq	r0, r2
     710:	0003d6c1 	andeq	sp, r3, r1, asr #13
     714:	0085f800 	addeq	pc, r5, r0, lsl #16
     718:	0000b800 	andeq	fp, r0, r0, lsl #16
     71c:	309c0100 	addscc	r0, ip, r0, lsl #2
     720:	20000004 	andcs	r0, r0, r4
     724:	000004ce 	andeq	r0, r0, lr, asr #9
     728:	03d6c101 	bicseq	ip, r6, #1073741824	; 0x40000000
     72c:	03060000 	movweq	r0, #24576	; 0x6000
     730:	70140000 	andsvc	r0, r4, r0
     734:	01007274 	tsteq	r0, r4, ror r2
     738:	0003d6c2 	andeq	sp, r3, r2, asr #13
     73c:	00032700 	andeq	r2, r3, r0, lsl #14
     740:	04d31800 	ldrbeq	r1, [r3], #2048	; 0x800
     744:	c3010000 	movwgt	r0, #4096	; 0x1000
     748:	00000377 	andeq	r0, r0, r7, ror r3
     74c:	00000369 	andeq	r0, r0, r9, ror #6
     750:	01006914 	tsteq	r0, r4, lsl r9
     754:	000033c5 	andeq	r3, r0, r5, asr #7
     758:	00038800 	andeq	r8, r3, r0, lsl #16
     75c:	941f0000 	ldrls	r0, [pc], #-0	; 764 <__start-0x789c>
     760:	01000002 	tsteq	r0, r2
     764:	0003d6df 	ldrdeq	sp, [r3], -pc	; <UNPREDICTABLE>
     768:	0086b000 	addeq	fp, r6, r0
     76c:	00007c00 	andeq	r7, r0, r0, lsl #24
     770:	b59c0100 	ldrlt	r0, [ip, #256]	; 0x100
     774:	20000004 	andcs	r0, r0, r4
     778:	000004ce 	andeq	r0, r0, lr, asr #9
     77c:	03d6df01 	bicseq	sp, r6, #1, 30
     780:	03b20000 			; <UNDEFINED> instruction: 0x03b20000
     784:	c4190000 	ldrgt	r0, [r9], #-0
     788:	60000086 	andvs	r0, r0, r6, lsl #1
     78c:	ab000000 	blge	794 <__start-0x786c>
     790:	14000004 	strne	r0, [r0], #-4
     794:	00727470 	rsbseq	r7, r2, r0, ror r4
     798:	03d6e201 	bicseq	lr, r6, #268435456	; 0x10000000
     79c:	04020000 	streq	r0, [r2], #-0
     7a0:	c8160000 	ldmdagt	r6, {}	; <UNPREDICTABLE>
     7a4:	ae000086 	cdpge	0, 0, cr0, cr0, cr6, {4}
     7a8:	1a000006 	bne	7c8 <__start-0x7838>
     7ac:	00008710 	andeq	r8, r0, r0, lsl r7
     7b0:	00000382 	andeq	r0, r0, r2, lsl #7
     7b4:	00000491 	muleq	r0, r1, r4
     7b8:	0250011b 	subseq	r0, r0, #-1073741818	; 0xc0000006
     7bc:	16000074 			; <UNDEFINED> instruction: 0x16000074
     7c0:	00008718 	andeq	r8, r0, r8, lsl r7
     7c4:	00000298 	muleq	r0, r8, r2
     7c8:	0087201c 	addeq	r2, r7, ip, lsl r0
     7cc:	0003dc00 	andeq	sp, r3, r0, lsl #24
     7d0:	50011b00 	andpl	r1, r1, r0, lsl #22
     7d4:	00007402 	andeq	r7, r0, r2, lsl #8
     7d8:	86bc1600 	ldrthi	r1, [ip], r0, lsl #12
     7dc:	06b50000 	ldrteq	r0, [r5], r0
     7e0:	1f000000 	svcne	0x00000000
     7e4:	000002fc 	strdeq	r0, [r0], -ip
     7e8:	058ffa01 	streq	pc, [pc, #2561]	; 11f1 <__start-0x6e0f>
     7ec:	872c0000 	strhi	r0, [ip, -r0]!
     7f0:	01840000 	orreq	r0, r4, r0
     7f4:	9c010000 	stcls	0, cr0, [r1], {-0}
     7f8:	0000058f 	andeq	r0, r0, pc, lsl #11
     7fc:	00055b20 	andeq	r5, r5, r0, lsr #22
     800:	33fa0100 	mvnscc	r0, #0, 2
     804:	20000000 	andcs	r0, r0, r0
     808:	20000004 	andcs	r0, r0, r4
     80c:	000004ce 	andeq	r0, r0, lr, asr #9
     810:	0591fa01 	ldreq	pc, [r1, #2561]	; 0xa01
     814:	06030000 	streq	r0, [r3], -r0
     818:	94160000 	ldrls	r0, [r6], #-0
     81c:	c0000087 	andgt	r0, r0, r7, lsl #1
     820:	16000006 	strne	r0, [r0], -r6
     824:	000087a8 	andeq	r8, r0, r8, lsr #15
     828:	000006d5 	ldrdeq	r0, [r0], -r5
     82c:	0087b416 	addeq	fp, r7, r6, lsl r4
     830:	0006fa00 	andeq	pc, r6, r0, lsl #20
     834:	87c41600 	strbhi	r1, [r4, r0, lsl #12]
     838:	070f0000 	streq	r0, [pc, -r0]
     83c:	d0160000 	andsle	r0, r6, r0
     840:	29000087 	stmdbcs	r0, {r0, r1, r2, r7}
     844:	16000007 	strne	r0, [r0], -r7
     848:	000087e4 	andeq	r8, r0, r4, ror #15
     84c:	0000073e 	andeq	r0, r0, lr, lsr r7
     850:	0087f816 	addeq	pc, r7, r6, lsl r8	; <UNPREDICTABLE>
     854:	00075d00 	andeq	r5, r7, r0, lsl #26
     858:	88041600 	stmdahi	r4, {r9, sl, ip}
     85c:	069d0000 	ldreq	r0, [sp], r0
     860:	1c160000 	ldcne	0, cr0, [r6], {-0}
     864:	7c000088 	stcvc	0, cr0, [r0], {136}	; 0x88
     868:	16000007 	strne	r0, [r0], -r7
     86c:	00008824 	andeq	r8, r0, r4, lsr #16
     870:	000007ac 	andeq	r0, r0, ip, lsr #15
     874:	00883416 	addeq	r3, r8, r6, lsl r4
     878:	0007bd00 	andeq	fp, r7, r0, lsl #26
     87c:	88541600 	ldmdahi	r4, {r9, sl, ip}^
     880:	07d70000 	ldrbeq	r0, [r7, r0]
     884:	64160000 	ldrvs	r0, [r6], #-0
     888:	00000088 	andeq	r0, r0, r8, lsl #1
     88c:	16000008 	strne	r0, [r0], -r8
     890:	00008870 	andeq	r8, r0, r0, ror r8
     894:	00000820 	andeq	r0, r0, r0, lsr #16
     898:	00888016 	addeq	r8, r8, r6, lsl r0
     89c:	00083100 	andeq	r3, r8, r0, lsl #2
     8a0:	888c1600 	stmhi	ip, {r9, sl, ip}
     8a4:	08420000 	stmdaeq	r2, {}^	; <UNPREDICTABLE>
     8a8:	98160000 	ldmdals	r6, {}	; <UNPREDICTABLE>
     8ac:	49000088 	stmdbmi	r0, {r3, r7}
     8b0:	16000008 	strne	r0, [r0], -r8
     8b4:	000088a0 	andeq	r8, r0, r0, lsr #17
     8b8:	00000854 	andeq	r0, r0, r4, asr r8
     8bc:	08042100 	stmdaeq	r4, {r8, sp}
     8c0:	00003304 	andeq	r3, r0, r4, lsl #6
     8c4:	02150c00 	andseq	r0, r5, #0, 24
     8c8:	05a70000 	streq	r0, [r7, #0]!
     8cc:	370d0000 	strcc	r0, [sp, -r0]
     8d0:	1f000001 	svcne	0x00000001
     8d4:	02612200 	rsbeq	r2, r1, #0, 4
     8d8:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
     8dc:	000005b8 			; <UNDEFINED> instruction: 0x000005b8
     8e0:	d0040305 	andle	r0, r4, r5, lsl #6
     8e4:	97070000 	strls	r0, [r7, -r0]
     8e8:	0c000005 	stceq	0, cr0, [r0], {5}
     8ec:	00000033 	andeq	r0, r0, r3, lsr r0
     8f0:	000005cd 	andeq	r0, r0, sp, asr #11
     8f4:	0001370d 	andeq	r3, r1, sp, lsl #14
     8f8:	22001f00 	andcs	r1, r0, #0, 30
     8fc:	000003ed 	andeq	r0, r0, sp, ror #7
     900:	05de1d01 	ldrbeq	r1, [lr, #3329]	; 0xd01
     904:	03050000 	movweq	r0, #20480	; 0x5000
     908:	0002de84 	andeq	sp, r2, r4, lsl #29
     90c:	0005bd07 	andeq	fp, r5, r7, lsl #26
     910:	02182200 	andseq	r2, r8, #0, 4
     914:	20010000 	andcs	r0, r1, r0
     918:	000005f4 	strdeq	r0, [r0], -r4
     91c:	c0000305 	andgt	r0, r0, r5, lsl #6
     920:	65070000 	strvs	r0, [r7, #-0]
     924:	22000000 	andcs	r0, r0, #0
     928:	00000538 	andeq	r0, r0, r8, lsr r5
     92c:	060a2301 	streq	r2, [sl], -r1, lsl #6
     930:	03050000 	movweq	r0, #20480	; 0x5000
     934:	0002df08 	andeq	sp, r2, r8, lsl #30
     938:	00007007 	andeq	r7, r0, r7
     93c:	020b2200 	andeq	r2, fp, #0, 4
     940:	25010000 	strcs	r0, [r1, #-0]
     944:	0000060a 	andeq	r0, r0, sl, lsl #12
     948:	df0c0305 	svcle	0x000c0305
     94c:	1b220002 	blne	88095c <__user_program+0x58095c>
     950:	01000004 	tsteq	r0, r4
     954:	00060a27 	andeq	r0, r6, r7, lsr #20
     958:	04030500 	streq	r0, [r3], #-1280	; 0x500
     95c:	220002df 	andcs	r0, r0, #-268435443	; 0xf000000d
     960:	0000034e 	andeq	r0, r0, lr, asr #6
     964:	00af2a01 	adceq	r2, pc, r1, lsl #20
     968:	03050000 	movweq	r0, #20480	; 0x5000
     96c:	0000c004 	andeq	ip, r0, r4
     970:	0002cf23 	andeq	ip, r2, r3, lsr #30
     974:	23170500 	tstcs	r7, #0, 10
     978:	000002c6 	andeq	r0, r0, r6, asr #5
     97c:	f5241206 			; <UNDEFINED> instruction: 0xf5241206
     980:	09000004 	stmdbeq	r0, {r2}
     984:	00065d10 	andeq	r5, r6, r0, lsl sp
     988:	23002500 	movwcs	r2, #1280	; 0x500
     98c:	000002b3 			; <UNDEFINED> instruction: 0x000002b3
     990:	25233007 	strcs	r3, [r3, #-7]!
     994:	08000004 	stmdaeq	r0, {r2}
     998:	05152618 	ldreq	r2, [r5, #-1560]	; 0x618
     99c:	17090000 	strne	r0, [r9, -r0]
     9a0:	00000033 	andeq	r0, r0, r3, lsr r0
     9a4:	0000067c 	andeq	r0, r0, ip, ror r6
     9a8:	70270025 	eorvc	r0, r7, r5, lsr #32
     9ac:	0a000004 	beq	9c4 <__start-0x763c>
     9b0:	00003313 	andeq	r3, r0, r3, lsl r3
     9b4:	00069200 	andeq	r9, r6, r0, lsl #4
     9b8:	06922800 	ldreq	r2, [r2], r0, lsl #16
     9bc:	00250000 	eoreq	r0, r5, r0
     9c0:	06980408 	ldreq	r0, [r8], r8, lsl #8
     9c4:	25290000 	strcs	r0, [r9, #-0]!
     9c8:	2a000000 	bcs	9d0 <__start-0x7630>
     9cc:	00000318 	andeq	r0, r0, r8, lsl r3
     9d0:	06aeaa04 	strteq	sl, [lr], r4, lsl #20
     9d4:	33280000 	teqcc	r8, #0
     9d8:	00000000 	andeq	r0, r0, r0
     9dc:	00036823 	andeq	r6, r3, r3, lsr #16
     9e0:	2b250800 	blcs	9429e8 <__user_program+0x6429e8>
     9e4:	000004e4 	andeq	r0, r0, r4, ror #9
     9e8:	00331f08 	eorseq	r1, r3, r8, lsl #30
     9ec:	da270000 	ble	9c09f4 <__user_program+0x6c09f4>
     9f0:	04000001 	streq	r0, [r0], #-1
     9f4:	00058f69 	andeq	r8, r5, r9, ror #30
     9f8:	0006d500 	andeq	sp, r6, r0, lsl #10
     9fc:	00332800 	eorseq	r2, r3, r0, lsl #16
     a00:	27000000 	strcs	r0, [r0, -r0]
     a04:	0000030a 	andeq	r0, r0, sl, lsl #6
     a08:	00337304 	eorseq	r7, r3, r4, lsl #6
     a0c:	06f40000 	ldrbteq	r0, [r4], r0
     a10:	33280000 	teqcc	r8, #0
     a14:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     a18:	000006f4 	strdeq	r0, [r0], -r4
     a1c:	00003328 	andeq	r3, r0, r8, lsr #6
     a20:	04080000 	streq	r0, [r8], #-0
     a24:	00000025 	andeq	r0, r0, r5, lsr #32
     a28:	00047f27 	andeq	r7, r4, r7, lsr #30
     a2c:	337c0400 	cmncc	ip, #0, 8
     a30:	0f000000 	svceq	0x00000000
     a34:	28000007 	stmdacs	r0, {r0, r1, r2}
     a38:	00000033 	andeq	r0, r0, r3, lsr r0
     a3c:	05462700 	strbeq	r2, [r6, #-1792]	; 0x700
     a40:	86040000 	strhi	r0, [r4], -r0
     a44:	00000033 	andeq	r0, r0, r3, lsr r0
     a48:	00000729 	andeq	r0, r0, r9, lsr #14
     a4c:	00003328 	andeq	r3, r0, r8, lsr #6
     a50:	058f2800 	streq	r2, [pc, #2048]	; 1258 <__start-0x6da8>
     a54:	27000000 	strcs	r0, [r0, -r0]
     a58:	00000242 	andeq	r0, r0, r2, asr #4
     a5c:	00338f04 	eorseq	r8, r3, r4, lsl #30
     a60:	073e0000 	ldreq	r0, [lr, -r0]!
     a64:	33280000 	teqcc	r8, #0
     a68:	00000000 	andeq	r0, r0, r0
     a6c:	00040d27 	andeq	r0, r4, r7, lsr #26
     a70:	339a0400 	orrscc	r0, sl, #0, 8
     a74:	5d000000 	stcpl	0, cr0, [r0, #-0]
     a78:	28000007 	stmdacs	r0, {r0, r1, r2}
     a7c:	00000033 	andeq	r0, r0, r3, lsr r0
     a80:	00003328 	andeq	r3, r0, r8, lsr #6
     a84:	00332800 	eorseq	r2, r3, r0, lsl #16
     a88:	27000000 	strcs	r0, [r0, -r0]
     a8c:	0000052b 	andeq	r0, r0, fp, lsr #10
     a90:	0033a404 	eorseq	sl, r3, r4, lsl #8
     a94:	077c0000 	ldrbeq	r0, [ip, -r0]!
     a98:	33280000 	teqcc	r8, #0
     a9c:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     aa0:	000006f4 	strdeq	r0, [r0], -r4
     aa4:	00003328 	andeq	r3, r0, r8, lsr #6
     aa8:	ac270000 	stcge	0, cr0, [r7], #-0
     aac:	04000004 	streq	r0, [r0], #-4
     ab0:	000033b6 			; <UNDEFINED> instruction: 0x000033b6
     ab4:	00079b00 	andeq	r9, r7, r0, lsl #22
     ab8:	00332800 	eorseq	r2, r3, r0, lsl #16
     abc:	41280000 	teqmi	r8, r0
     ac0:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     ac4:	0000079b 	muleq	r0, fp, r7
     ac8:	a1040800 	tstge	r4, r0, lsl #16
     acc:	2c000007 	stccs	0, cr0, [r0], {7}
     ad0:	000007ac 	andeq	r0, r0, ip, lsr #15
     ad4:	00005328 	andeq	r5, r0, r8, lsr #6
     ad8:	30260000 	eorcc	r0, r6, r0
     adc:	04000004 	streq	r0, [r0], #-4
     ae0:	000033bd 			; <UNDEFINED> instruction: 0x000033bd
     ae4:	0007bd00 	andeq	fp, r7, r0, lsl #26
     ae8:	27002500 	strcs	r2, [r0, -r0, lsl #10]
     aec:	0000026b 	andeq	r0, r0, fp, ror #4
     af0:	0033cc04 	eorseq	ip, r3, r4, lsl #24
     af4:	07d70000 	ldrbeq	r0, [r7, r0]
     af8:	ca280000 	bgt	a00b00 <__user_program+0x700b00>
     afc:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     b00:	000003d6 	ldrdeq	r0, [r0], -r6
     b04:	037c2700 	cmneq	ip, #0, 14
     b08:	d9040000 	stmdble	r4, {}	; <UNPREDICTABLE>
     b0c:	00000033 	andeq	r0, r0, r3, lsr r0
     b10:	00000800 	andeq	r0, r0, r0, lsl #16
     b14:	0000ca28 	andeq	ip, r0, r8, lsr #20
     b18:	03d62800 	bicseq	r2, r6, #0, 16
     b1c:	70280000 	eorvc	r0, r8, r0
     b20:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     b24:	00000070 	andeq	r0, r0, r0, ror r0
     b28:	00007028 	andeq	r7, r0, r8, lsr #32
     b2c:	2f270000 	svccs	0x00270000
     b30:	04000002 	streq	r0, [r0], #-2
     b34:	000033e7 	andeq	r3, r0, r7, ror #7
     b38:	00081a00 	andeq	r1, r8, r0, lsl #20
     b3c:	081a2800 	ldmdaeq	sl, {fp, sp}
     b40:	70280000 	eorvc	r0, r8, r0
     b44:	00000000 	andeq	r0, r0, r0
     b48:	00bf0408 	adcseq	r0, pc, r8, lsl #8
     b4c:	fa2a0000 	blx	a80b54 <__user_program+0x780b54>
     b50:	04000003 	streq	r0, [r0], #-3
     b54:	000831f1 	strdeq	r3, [r8], -r1
     b58:	081a2800 	ldmdaeq	sl, {fp, sp}
     b5c:	2a000000 	bcs	b64 <__start-0x749c>
     b60:	0000027f 	andeq	r0, r0, pc, ror r2
     b64:	0842f704 	stmdaeq	r2, {r2, r8, r9, sl, ip, sp, lr, pc}^
     b68:	1a280000 	bne	a00b70 <__user_program+0x700b70>
     b6c:	00000008 	andeq	r0, r0, r8
     b70:	00044823 	andeq	r4, r4, r3, lsr #16
     b74:	2bfa0400 	blcs	ffe81b7c <__user_program+0xffb81b7c>
     b78:	0000033d 	andeq	r0, r0, sp, lsr r3
     b7c:	0070fd04 	rsbseq	pc, r0, r4, lsl #26
     b80:	b32d0000 	teqlt	sp, #0
     b84:	04000003 	streq	r0, [r0], #-3
     b88:	00330107 	eorseq	r0, r3, r7, lsl #2
     b8c:	f0000000 			; <UNDEFINED> instruction: 0xf0000000
     b90:	04000002 	streq	r0, [r0], #-2
     b94:	00040b00 	andeq	r0, r4, r0, lsl #22
     b98:	8e010400 	cfcpyshi	mvf0, mvf1
     b9c:	01000000 	mrseq	r0, (UNDEF: 0)
     ba0:	00000575 	andeq	r0, r0, r5, ror r5
     ba4:	0000003a 	andeq	r0, r0, sl, lsr r0
     ba8:	000088b0 			; <UNDEFINED> instruction: 0x000088b0
     bac:	00000298 	muleq	r0, r8, r2
     bb0:	000002ab 	andeq	r0, r0, fp, lsr #5
     bb4:	00010e02 	andeq	r0, r1, r2, lsl #28
     bb8:	300e0200 	andcc	r0, lr, r0, lsl #4
     bbc:	03000000 	movweq	r0, #0
     bc0:	011e0801 	tsteq	lr, r1, lsl #16
     bc4:	02030000 	andeq	r0, r3, #0
     bc8:	00015c05 	andeq	r5, r1, r5, lsl #24
     bcc:	017a0200 	cmneq	sl, r0, lsl #4
     bd0:	12020000 	andne	r0, r2, #0
     bd4:	00000049 	andeq	r0, r0, r9, asr #32
     bd8:	69050404 	stmdbvs	r5, {r2, sl}
     bdc:	0300746e 	movweq	r7, #1134	; 0x46e
     be0:	00000508 	andeq	r0, r0, r8, lsl #10
     be4:	0d020000 	stceq	0, cr0, [r2, #-0]
     be8:	02000001 	andeq	r0, r0, #1
     bec:	00006216 	andeq	r6, r0, r6, lsl r2
     bf0:	08010300 	stmdaeq	r1, {r8, r9}
     bf4:	00000115 	andeq	r0, r0, r5, lsl r1
     bf8:	2f070203 	svccs	0x00070203
     bfc:	02000001 	andeq	r0, r0, #1
     c00:	00000179 	andeq	r0, r0, r9, ror r1
     c04:	007b1a02 	rsbseq	r1, fp, r2, lsl #20
     c08:	04030000 	streq	r0, [r3], #-0
     c0c:	00006507 	andeq	r6, r0, r7, lsl #10
     c10:	056c0200 	strbeq	r0, [ip, #-512]!	; 0x200
     c14:	1c020000 	stcne	0, cr0, [r2], {-0}
     c18:	0000008d 	andeq	r0, r0, sp, lsl #1
     c1c:	5b070803 	blpl	1c2c30 <__end+0x73c30>
     c20:	02000000 	andeq	r0, r0, #0
     c24:	0000058b 	andeq	r0, r0, fp, lsl #11
     c28:	009f1303 	addseq	r1, pc, r3, lsl #6
     c2c:	89050000 	stmdbhi	r5, {}	; <UNPREDICTABLE>
     c30:	04000005 	streq	r0, [r0], #-5
     c34:	00b60004 	adcseq	r0, r6, r4
     c38:	be060000 	cdplt	0, 0, cr0, cr6, cr0, {0}
     c3c:	b6000005 	strlt	r0, [r0], -r5
     c40:	00000000 	andeq	r0, r0, r0
     c44:	08040700 	stmdaeq	r4, {r8, r9, sl}
     c48:	000005a1 	andeq	r0, r0, r1, lsr #11
     c4c:	88b02101 	ldmhi	r0!, {r0, r8, sp}
     c50:	00e00000 	rsceq	r0, r0, r0
     c54:	9c010000 	stcls	0, cr0, [r1], {-0}
     c58:	0000012a 	andeq	r0, r0, sl, lsr #2
     c5c:	0005b909 	andeq	fp, r5, r9, lsl #18
     c60:	57210100 	strpl	r0, [r1, -r0, lsl #2]!
     c64:	3e000000 	cdpcc	0, 0, cr0, cr0, cr0, {0}
     c68:	0a000008 	beq	c90 <__start-0x7370>
     c6c:	006d756e 	rsbeq	r7, sp, lr, ror #10
     c70:	00822101 	addeq	r2, r2, r1, lsl #2
     c74:	085f0000 	ldmdaeq	pc, {}^	; <UNPREDICTABLE>
     c78:	b20b0000 	andlt	r0, fp, #0
     c7c:	01000005 	tsteq	r0, r5
     c80:	00012a22 	andeq	r2, r1, r2, lsr #20
     c84:	00089700 	andeq	r9, r8, r0, lsl #14
     c88:	75620c00 	strbvc	r0, [r2, #-3072]!	; 0xc00
     c8c:	23010066 	movwcs	r0, #4198	; 0x1066
     c90:	00000130 	andeq	r0, r0, r0, lsr r1
     c94:	0d589102 	ldfeqp	f1, [r8, #-8]
     c98:	00727470 	rsbseq	r7, r2, r0, ror r4
     c9c:	012a2401 	teqeq	sl, r1, lsl #8
     ca0:	08ce0000 	stmiaeq	lr, {}^	; <UNPREDICTABLE>
     ca4:	640e0000 	strvs	r0, [lr], #-0
     ca8:	e6000089 	str	r0, [r0], -r9, lsl #1
     cac:	0e000002 	cdpeq	0, 0, cr0, cr0, cr2, {0}
     cb0:	0000897c 	andeq	r8, r0, ip, ror r9
     cb4:	000002e6 	andeq	r0, r0, r6, ror #5
     cb8:	25040f00 	strcs	r0, [r4, #-3840]	; 0xf00
     cbc:	10000000 	andne	r0, r0, r0
     cc0:	00000025 	andeq	r0, r0, r5, lsr #32
     cc4:	00000140 	andeq	r0, r0, r0, asr #2
     cc8:	00014011 	andeq	r4, r1, r1, lsl r0
     ccc:	03000700 	movweq	r0, #1792	; 0x700
     cd0:	04670704 	strbteq	r0, [r7], #-1796	; 0x704
     cd4:	70120000 	andsvc	r0, r2, r0
     cd8:	01000004 	tsteq	r0, r4
     cdc:	0000493f 	andeq	r4, r0, pc, lsr r9
     ce0:	00899000 	addeq	r9, r9, r0
     ce4:	0001b800 	andeq	fp, r1, r0, lsl #16
     ce8:	b59c0100 	ldrlt	r0, [ip, #256]	; 0x100
     cec:	0a000002 	beq	cfc <__start-0x7304>
     cf0:	00746d66 	rsbseq	r6, r4, r6, ror #26
     cf4:	02b53f01 	adcseq	r3, r5, #1, 30
     cf8:	09360000 	ldmdbeq	r6!, {}	; <UNPREDICTABLE>
     cfc:	14130000 	ldrne	r0, [r3], #-0
     d00:	000004ce 	andeq	r0, r0, lr, asr #9
     d04:	00944001 	addseq	r4, r4, r1
     d08:	91020000 	mrsls	r0, (UNDEF: 2)
     d0c:	00181554 	andseq	r1, r8, r4, asr r5
     d10:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     d14:	6e0d0000 	cdpvs	0, 0, cr0, cr13, cr0, {0}
     d18:	01006d75 	tsteq	r0, r5, ror sp
     d1c:	00007061 	andeq	r7, r0, r1, rrx
     d20:	00096d00 	andeq	r6, r9, r0, lsl #26
     d24:	8aa81600 	bhi	fea0652c <__user_program+0xfe70652c>
     d28:	00b80000 	adcseq	r0, r8, r0
     d2c:	01170000 	tsteq	r7, r0
     d30:	00780250 	rsbseq	r0, r8, r0, asr r2
     d34:	30150000 	andscc	r0, r5, r0
     d38:	d0000000 	andle	r0, r0, r0
     d3c:	0d000001 	stceq	0, cr0, [r0, #-4]
     d40:	006d756e 	rsbeq	r7, sp, lr, ror #10
     d44:	00706801 	rsbseq	r6, r0, r1, lsl #16
     d48:	098c0000 	stmibeq	ip, {}	; <UNPREDICTABLE>
     d4c:	c8160000 	ldmdagt	r6, {}	; <UNPREDICTABLE>
     d50:	b800008a 	stmdalt	r0, {r1, r3, r7}
     d54:	17000000 	strne	r0, [r0, -r0]
     d58:	77025001 	strvc	r5, [r2, -r1]
     d5c:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     d60:	00008a24 	andeq	r8, r0, r4, lsr #20
     d64:	00000048 	andeq	r0, r0, r8, asr #32
     d68:	00000223 	andeq	r0, r0, r3, lsr #4
     d6c:	6d756e0d 	ldclvs	14, cr6, [r5, #-52]!	; 0xffffffcc
     d70:	3e500100 	rdfccs	f0, f0, f0
     d74:	ab000000 	blge	d7c <__start-0x7284>
     d78:	19000009 	stmdbne	r0, {r0, r3}
     d7c:	00008a44 	andeq	r8, r0, r4, asr #20
     d80:	000002e6 	andeq	r0, r0, r6, ror #5
     d84:	00000200 	andeq	r0, r0, r0, lsl #4
     d88:	02500117 	subseq	r0, r0, #-1073741819	; 0xc0000005
     d8c:	19002d08 	stmdbne	r0, {r3, r8, sl, fp, sp}
     d90:	00008a54 	andeq	r8, r0, r4, asr sl
     d94:	000000b8 	strheq	r0, [r0], -r8
     d98:	00000213 	andeq	r0, r0, r3, lsl r2
     d9c:	01500117 	cmpeq	r0, r7, lsl r1
     da0:	6816003a 	ldmdavs	r6, {r1, r3, r4, r5}
     da4:	b800008a 	stmdalt	r0, {r1, r3, r7}
     da8:	17000000 	strne	r0, [r0, -r0]
     dac:	3a015001 	bcc	54db8 <__bss_end+0x26db8>
     db0:	6c180000 	ldcvs	0, cr0, [r8], {-0}
     db4:	2000008a 	andcs	r0, r0, sl, lsl #1
     db8:	4f000000 	svcmi	0x00000000
     dbc:	0d000002 	stceq	0, cr0, [r0, #-8]
     dc0:	006d756e 	rsbeq	r7, sp, lr, ror #10
     dc4:	00705b01 	rsbseq	r5, r0, r1, lsl #22
     dc8:	09be0000 	ldmibeq	lr!, {}	; <UNPREDICTABLE>
     dcc:	88160000 	ldmdahi	r6, {}	; <UNPREDICTABLE>
     dd0:	b800008a 	stmdalt	r0, {r1, r3, r7}
     dd4:	17000000 	strne	r0, [r0, -r0]
     dd8:	3a015001 	bcc	54de4 <__bss_end+0x26de4>
     ddc:	cc180000 	ldcgt	0, cr0, [r8], {-0}
     de0:	3000008a 	andcc	r0, r0, sl, lsl #1
     de4:	75000000 	strvc	r0, [r0, #-0]
     de8:	0b000002 	bleq	df8 <__start-0x7208>
     dec:	00000563 	andeq	r0, r0, r3, ror #10
     df0:	012a6e01 	teqeq	sl, r1, lsl #28
     df4:	09dd0000 	ldmibeq	sp, {}^	; <UNPREDICTABLE>
     df8:	ec0e0000 	stc	0, cr0, [lr], {-0}
     dfc:	e600008a 	str	r0, [r0], -sl, lsl #1
     e00:	00000002 	andeq	r0, r0, r2
     e04:	008afc18 	addeq	pc, sl, r8, lsl ip	; <UNPREDICTABLE>
     e08:	00001800 	andeq	r1, r0, r0, lsl #16
     e0c:	00029b00 	andeq	r9, r2, r0, lsl #22
     e10:	078d0b00 	streq	r0, [sp, r0, lsl #22]
     e14:	77010000 	strvc	r0, [r1, -r0]
     e18:	0000003e 	andeq	r0, r0, lr, lsr r0
     e1c:	000009fd 	strdeq	r0, [r0], -sp
     e20:	008b100e 	addeq	r1, fp, lr
     e24:	0002e600 	andeq	lr, r2, r0, lsl #12
     e28:	c80e0000 	stmdagt	lr, {}	; <UNPREDICTABLE>
     e2c:	e6000089 	str	r0, [r0], -r9, lsl #1
     e30:	16000002 	strne	r0, [r0], -r2
     e34:	00008b1c 	andeq	r8, r0, ip, lsl fp
     e38:	000002e6 	andeq	r0, r0, r6, ror #5
     e3c:	02500117 	subseq	r0, r0, #-1073741819	; 0xc0000005
     e40:	00002508 	andeq	r2, r0, r8, lsl #10
     e44:	02bb040f 	adcseq	r0, fp, #251658240	; 0xf000000
     e48:	301a0000 	andscc	r0, sl, r0
     e4c:	10000000 	andne	r0, r0, r0
     e50:	00000030 	andeq	r0, r0, r0, lsr r0
     e54:	000002d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     e58:	00014011 	andeq	r4, r1, r1, lsl r0
     e5c:	14001000 	strne	r1, [r0], #-0
     e60:	000005ab 	andeq	r0, r0, fp, lsr #11
     e64:	02e11801 	rsceq	r1, r1, #65536	; 0x10000
     e68:	03050000 	movweq	r0, #20480	; 0x5000
     e6c:	0000b000 	andeq	fp, r0, r0
     e70:	0002c01a 	andeq	ip, r2, sl, lsl r0
     e74:	05931b00 	ldreq	r1, [r3, #2816]	; 0xb00
     e78:	23050000 	movwcs	r0, #20480	; 0x5000
     e7c:	0000571c 	andeq	r5, r0, ip, lsl r7
     e80:	60000000 	andvs	r0, r0, r0
     e84:	04000001 	streq	r0, [r0], #-1
     e88:	00057500 	andeq	r7, r5, r0, lsl #10
     e8c:	8e010400 	cfcpyshi	mvf0, mvf1
     e90:	01000000 	mrseq	r0, (UNDEF: 0)
     e94:	000005d1 	ldrdeq	r0, [r0], -r1
     e98:	0000003a 	andeq	r0, r0, sl, lsr r0
     e9c:	00008b48 	andeq	r8, r0, r8, asr #22
     ea0:	000000d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     ea4:	0000038f 	andeq	r0, r0, pc, lsl #7
     ea8:	1e080102 	adfnee	f0, f0, f2
     eac:	02000001 	andeq	r0, r0, #1
     eb0:	015c0502 	cmpeq	ip, r2, lsl #10
     eb4:	04030000 	streq	r0, [r3], #-0
     eb8:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
     ebc:	05080200 	streq	r0, [r8, #-512]	; 0x200
     ec0:	00000000 	andeq	r0, r0, r0
     ec4:	00010d04 	andeq	r0, r1, r4, lsl #26
     ec8:	4c160200 	lfmmi	f0, 4, [r6], {-0}
     ecc:	02000000 	andeq	r0, r0, #0
     ed0:	01150801 	tsteq	r5, r1, lsl #16
     ed4:	c5040000 	strgt	r0, [r4, #-0]
     ed8:	02000004 	andeq	r0, r0, #4
     edc:	00005e18 	andeq	r5, r0, r8, lsl lr
     ee0:	07020200 	streq	r0, [r2, -r0, lsl #4]
     ee4:	0000012f 	andeq	r0, r0, pc, lsr #2
     ee8:	00017904 	andeq	r7, r1, r4, lsl #18
     eec:	701a0200 	andsvc	r0, sl, r0, lsl #4
     ef0:	02000000 	andeq	r0, r0, #0
     ef4:	00650704 	rsbeq	r0, r5, r4, lsl #14
     ef8:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
     efc:	00005b07 	andeq	r5, r0, r7, lsl #22
     f00:	02cf0500 	sbceq	r0, pc, #0, 10
     f04:	35010000 	strcc	r0, [r1, #-0]
     f08:	00008b48 	andeq	r8, r0, r8, asr #22
     f0c:	00000070 	andeq	r0, r0, r0, ror r0
     f10:	00f29c01 	rscseq	r9, r2, r1, lsl #24
     f14:	90060000 	andls	r0, r6, r0
     f18:	3b00008b 	blcc	114c <__start-0x6eb4>
     f1c:	ab000001 	blge	f28 <__start-0x70d8>
     f20:	07000000 	streq	r0, [r0, -r0]
     f24:	32015101 	andcc	r5, r1, #1073741824	; 0x40000000
     f28:	01500107 	cmpeq	r0, r7, lsl #2
     f2c:	9c06003f 	stcls	0, cr0, [r6], {63}	; 0x3f
     f30:	3b00008b 	blcc	1164 <__start-0x6e9c>
     f34:	c3000001 	movwgt	r0, #1
     f38:	07000000 	streq	r0, [r0, -r0]
     f3c:	32015101 	andcc	r5, r1, #1073741824	; 0x40000000
     f40:	01500107 	cmpeq	r0, r7, lsl #2
     f44:	a806003e 	stmdage	r6, {r1, r2, r3, r4, r5}
     f48:	5100008b 	smlabbpl	r0, fp, r0, r0
     f4c:	dc000001 	stcle	0, cr0, [r0], {1}
     f50:	07000000 	streq	r0, [r0, -r0]
     f54:	74025101 	strvc	r5, [r2], #-257	; 0x101
     f58:	50010700 	andpl	r0, r1, r0, lsl #14
     f5c:	08003f01 	stmdaeq	r0, {r0, r8, r9, sl, fp, ip, sp}
     f60:	00008bb4 			; <UNDEFINED> instruction: 0x00008bb4
     f64:	00000151 	andeq	r0, r0, r1, asr r1
     f68:	02510107 	subseq	r0, r1, #-1073741823	; 0xc0000001
     f6c:	01070074 	tsteq	r7, r4, ror r0
     f70:	003e0150 	eorseq	r0, lr, r0, asr r1
     f74:	05e30900 	strbeq	r0, [r3, #2304]!	; 0x900
     f78:	4f010000 	svcmi	0x00010000
     f7c:	00008bb8 			; <UNDEFINED> instruction: 0x00008bb8
     f80:	00000014 	andeq	r0, r0, r4, lsl r0
     f84:	93059c01 	movwls	r9, #23553	; 0x5c01
     f88:	01000005 	tsteq	r0, r5
     f8c:	008bcc55 	addeq	ip, fp, r5, asr ip
     f90:	00002400 	andeq	r2, r0, r0, lsl #8
     f94:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
     f98:	0a000001 	beq	fa4 <__start-0x705c>
     f9c:	0000078d 	andeq	r0, r0, sp, lsl #15
     fa0:	00415501 	subeq	r5, r1, r1, lsl #10
     fa4:	50010000 	andpl	r0, r1, r0
     fa8:	05c30b00 	strbeq	r0, [r3, #2816]	; 0xb00
     fac:	5c010000 	stcpl	0, cr0, [r1], {-0}
     fb0:	00000041 	andeq	r0, r0, r1, asr #32
     fb4:	00008bf0 	strdeq	r8, [r0], -r0
     fb8:	00000028 	andeq	r0, r0, r8, lsr #32
     fbc:	500c9c01 	andpl	r9, ip, r1, lsl #24
     fc0:	03000001 	movweq	r0, #1
     fc4:	00015137 	andeq	r5, r1, r7, lsr r1
     fc8:	00410d00 	subeq	r0, r1, r0, lsl #26
     fcc:	410d0000 	mrsmi	r0, (UNDEF: 13)
     fd0:	00000000 	andeq	r0, r0, r0
     fd4:	0001660e 	andeq	r6, r1, lr, lsl #12
     fd8:	0d4b0300 	stcleq	3, cr0, [fp, #-0]
     fdc:	00000041 	andeq	r0, r0, r1, asr #32
     fe0:	0000410d 	andeq	r4, r0, sp, lsl #2
     fe4:	a8000000 	stmdage	r0, {}	; <UNPREDICTABLE>
     fe8:	04000001 	streq	r0, [r0], #-1
     fec:	00065600 	andeq	r5, r6, r0, lsl #12
     ff0:	8e010400 	cfcpyshi	mvf0, mvf1
     ff4:	01000000 	mrseq	r0, (UNDEF: 0)
     ff8:	0000060c 	andeq	r0, r0, ip, lsl #12
     ffc:	0000003a 	andeq	r0, r0, sl, lsr r0
    1000:	00008c18 	andeq	r8, r0, r8, lsl ip
    1004:	00000118 	andeq	r0, r0, r8, lsl r1
    1008:	00000417 	andeq	r0, r0, r7, lsl r4
    100c:	1e080102 	adfnee	f0, f0, f2
    1010:	02000001 	andeq	r0, r0, #1
    1014:	015c0502 	cmpeq	ip, r2, lsl #10
    1018:	04030000 	streq	r0, [r3], #-0
    101c:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
    1020:	05080200 	streq	r0, [r8, #-512]	; 0x200
    1024:	00000000 	andeq	r0, r0, r0
    1028:	00010d04 	andeq	r0, r1, r4, lsl #26
    102c:	4c160200 	lfmmi	f0, 4, [r6], {-0}
    1030:	02000000 	andeq	r0, r0, #0
    1034:	01150801 	tsteq	r5, r1, lsl #16
    1038:	02020000 	andeq	r0, r2, #0
    103c:	00012f07 	andeq	r2, r1, r7, lsl #30
    1040:	01790400 	cmneq	r9, r0, lsl #8
    1044:	1a020000 	bne	8104c <__bss_end+0x5304c>
    1048:	00000065 	andeq	r0, r0, r5, rrx
    104c:	65070402 	strvs	r0, [r7, #-1026]	; 0x402
    1050:	02000000 	andeq	r0, r0, #0
    1054:	005b0708 	subseq	r0, fp, r8, lsl #14
    1058:	f3050000 	vhadd.u8	d0, d5, d0
    105c:	01000005 	tsteq	r0, r5
    1060:	008c1826 	addeq	r1, ip, r6, lsr #16
    1064:	00007400 	andeq	r7, r0, r0, lsl #8
    1068:	1b9c0100 	blne	fe701470 <__user_program+0xfe401470>
    106c:	06000001 	streq	r0, [r0], -r1
    1070:	00000520 	andeq	r0, r0, r0, lsr #10
    1074:	005a2601 	subseq	r2, sl, r1, lsl #12
    1078:	0a110000 	beq	441080 <__user_program+0x141080>
    107c:	63070000 	movwvs	r0, #28672	; 0x7000
    1080:	01006b6c 	tsteq	r0, ip, ror #22
    1084:	00005a26 	andeq	r5, r0, r6, lsr #20
    1088:	000a2f00 	andeq	r2, sl, r0, lsl #30
    108c:	8c300800 	ldchi	8, cr0, [r0], #-0
    1090:	01990000 	orrseq	r0, r9, r0
    1094:	00be0000 	adcseq	r0, lr, r0
    1098:	01090000 	mrseq	r0, (UNDEF: 9)
    109c:	09340151 	ldmdbeq	r4!, {r0, r4, r6, r8}
    10a0:	37015001 	strcc	r5, [r1, -r1]
    10a4:	8c3c0800 	ldchi	8, cr0, [ip], #-0
    10a8:	01990000 	orrseq	r0, r9, r0
    10ac:	00d60000 	sbcseq	r0, r6, r0
    10b0:	01090000 	mrseq	r0, (UNDEF: 9)
    10b4:	09340151 	ldmdbeq	r4!, {r0, r4, r6, r8}
    10b8:	38015001 	stmdacc	r1, {r0, ip, lr}
    10bc:	8c480800 	mcrrhi	8, 0, r0, r8, cr0
    10c0:	01990000 	orrseq	r0, r9, r0
    10c4:	00ee0000 	rsceq	r0, lr, r0
    10c8:	01090000 	mrseq	r0, (UNDEF: 9)
    10cc:	09340151 	ldmdbeq	r4!, {r0, r4, r6, r8}
    10d0:	39015001 	stmdbcc	r1, {r0, ip, lr}
    10d4:	8c540800 	mrrchi	8, 0, r0, r4, cr0
    10d8:	01990000 	orrseq	r0, r9, r0
    10dc:	01060000 	mrseq	r0, (UNDEF: 6)
    10e0:	01090000 	mrseq	r0, (UNDEF: 9)
    10e4:	09340151 	ldmdbeq	r4!, {r0, r4, r6, r8}
    10e8:	3a015001 	bcc	550f4 <__bss_end+0x270f4>
    10ec:	8c600a00 	stclhi	10, cr0, [r0], #-0
    10f0:	01990000 	orrseq	r0, r9, r0
    10f4:	01090000 	mrseq	r0, (UNDEF: 9)
    10f8:	09340151 	ldmdbeq	r4!, {r0, r4, r6, r8}
    10fc:	3b015001 	blcc	55108 <__bss_end+0x27108>
    1100:	4b050000 	blmi	141108 <__svc_stack_top+0x3108>
    1104:	01000006 	tsteq	r0, r6
    1108:	008c8c3b 	addeq	r8, ip, fp, lsr ip
    110c:	00002400 	andeq	r2, r0, r0, lsl #8
    1110:	4e9c0100 	fmlmie	f0, f4, f0
    1114:	07000001 	streq	r0, [r0, -r1]
    1118:	01007363 	tsteq	r0, r3, ror #6
    111c:	00005a3b 	andeq	r5, r0, fp, lsr sl
    1120:	000a4d00 	andeq	r4, sl, r0, lsl #26
    1124:	06030600 	streq	r0, [r3], -r0, lsl #12
    1128:	3b010000 	blcc	41130 <__bss_end+0x13130>
    112c:	0000005a 	andeq	r0, r0, sl, asr r0
    1130:	00000a6e 	andeq	r0, r0, lr, ror #20
    1134:	061d0b00 	ldreq	r0, [sp], -r0, lsl #22
    1138:	41010000 	mrsmi	r0, (UNDEF: 1)
    113c:	00008cb0 			; <UNDEFINED> instruction: 0x00008cb0
    1140:	00000018 	andeq	r0, r0, r8, lsl r0
    1144:	5f0b9c01 	svcpl	0x000b9c01
    1148:	01000006 	tsteq	r0, r6
    114c:	008cc847 	addeq	ip, ip, r7, asr #16
    1150:	00001800 	andeq	r1, r0, r0, lsl #16
    1154:	0c9c0100 	ldfeqs	f0, [ip], {0}
    1158:	00000637 	andeq	r0, r0, r7, lsr r6
    115c:	00414c01 	subeq	r4, r1, r1, lsl #24
    1160:	8ce00000 	stclhi	0, cr0, [r0]
    1164:	00500000 	subseq	r0, r0, r0
    1168:	9c010000 	stcls	0, cr0, [r1], {-0}
    116c:	00000199 	muleq	r0, r9, r1
    1170:	0005ee06 	andeq	lr, r5, r6, lsl #28
    1174:	414c0100 	mrsmi	r0, (UNDEF: 92)
    1178:	8f000000 	svchi	0x00000000
    117c:	0000000a 	andeq	r0, r0, sl
    1180:	0001500d 	andeq	r5, r1, sp
    1184:	0e370300 	cdpeq	3, 3, cr0, cr7, cr0, {0}
    1188:	00000041 	andeq	r0, r0, r1, asr #32
    118c:	0000410e 	andeq	r4, r0, lr, lsl #2
    1190:	c1000000 	mrsgt	r0, (UNDEF: 0)
    1194:	04000000 	streq	r0, [r0], #-0
    1198:	00073500 	andeq	r3, r7, r0, lsl #10
    119c:	8e010400 	cfcpyshi	mvf0, mvf1
    11a0:	01000000 	mrseq	r0, (UNDEF: 0)
    11a4:	00000677 	andeq	r0, r0, r7, ror r6
    11a8:	0000003a 	andeq	r0, r0, sl, lsr r0
    11ac:	00008d30 	andeq	r8, r0, r0, lsr sp
    11b0:	0000008c 	andeq	r0, r0, ip, lsl #1
    11b4:	000004a2 	andeq	r0, r0, r2, lsr #9
    11b8:	1e080102 	adfnee	f0, f0, f2
    11bc:	02000001 	andeq	r0, r0, #1
    11c0:	015c0502 	cmpeq	ip, r2, lsl #10
    11c4:	04030000 	streq	r0, [r3], #-0
    11c8:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
    11cc:	05080200 	streq	r0, [r8, #-512]	; 0x200
    11d0:	00000000 	andeq	r0, r0, r0
    11d4:	15080102 	strne	r0, [r8, #-258]	; 0x102
    11d8:	02000001 	andeq	r0, r0, #1
    11dc:	012f0702 	teqeq	pc, r2, lsl #14
    11e0:	79040000 	stmdbvc	r4, {}	; <UNPREDICTABLE>
    11e4:	02000001 	andeq	r0, r0, #1
    11e8:	00005a1a 	andeq	r5, r0, sl, lsl sl
    11ec:	07040200 	streq	r0, [r4, -r0, lsl #4]
    11f0:	00000065 	andeq	r0, r0, r5, rrx
    11f4:	5b070802 	blpl	1c3204 <__end+0x74204>
    11f8:	05000000 	streq	r0, [r0, #-0]
    11fc:	0000068f 	andeq	r0, r0, pc, lsl #13
    1200:	8d303101 	ldfhis	f3, [r0, #-4]!
    1204:	00440000 	subeq	r0, r4, r0
    1208:	9c010000 	stcls	0, cr0, [r1], {-0}
    120c:	0000008d 	andeq	r0, r0, sp, lsl #1
    1210:	00068a06 	andeq	r8, r6, r6, lsl #20
    1214:	33310100 	teqcc	r1, #0, 2
    1218:	b0000000 	andlt	r0, r0, r0
    121c:	0000000a 	andeq	r0, r0, sl
    1220:	00042507 	andeq	r2, r4, r7, lsl #10
    1224:	743f0100 	ldrtvc	r0, [pc], #-256	; 122c <__start-0x6dd4>
    1228:	2000008d 	andcs	r0, r0, sp, lsl #1
    122c:	01000000 	mrseq	r0, (UNDEF: 0)
    1230:	04e4089c 	strbteq	r0, [r4], #2204	; 0x89c
    1234:	48010000 	stmdami	r1, {}	; <UNPREDICTABLE>
    1238:	00000033 	andeq	r0, r0, r3, lsr r0
    123c:	00008d94 	muleq	r0, r4, sp
    1240:	00000014 	andeq	r0, r0, r4, lsl r0
    1244:	68079c01 	stmdavs	r7, {r0, sl, fp, ip, pc}
    1248:	01000003 	tsteq	r0, r3
    124c:	008da84d 	addeq	sl, sp, sp, asr #16
    1250:	00001400 	andeq	r1, r0, r0, lsl #8
    1254:	009c0100 	addseq	r0, ip, r0, lsl #2
    1258:	0000018c 	andeq	r0, r0, ip, lsl #3
    125c:	07c70004 	strbeq	r0, [r7, r4]
    1260:	01040000 	mrseq	r0, (UNDEF: 4)
    1264:	0000008e 	andeq	r0, r0, lr, lsl #1
    1268:	0006b201 	andeq	fp, r6, r1, lsl #4
    126c:	00003a00 	andeq	r3, r0, r0, lsl #20
    1270:	008dbc00 	addeq	fp, sp, r0, lsl #24
    1274:	00007000 	andeq	r7, r0, r0
    1278:	00050d00 	andeq	r0, r5, r0, lsl #26
    127c:	08010200 	stmdaeq	r1, {r9}
    1280:	0000011e 	andeq	r0, r0, lr, lsl r1
    1284:	5c050202 	sfmpl	f0, 4, [r5], {2}
    1288:	03000001 	movweq	r0, #1
    128c:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1290:	08020074 	stmdaeq	r2, {r2, r4, r5, r6}
    1294:	00000005 	andeq	r0, r0, r5
    1298:	010d0400 	tsteq	sp, r0, lsl #8
    129c:	16020000 	strne	r0, [r2], -r0
    12a0:	0000004c 	andeq	r0, r0, ip, asr #32
    12a4:	15080102 	strne	r0, [r8, #-258]	; 0x102
    12a8:	04000001 	streq	r0, [r0], #-1
    12ac:	000004c5 	andeq	r0, r0, r5, asr #9
    12b0:	005e1802 	subseq	r1, lr, r2, lsl #16
    12b4:	02020000 	andeq	r0, r2, #0
    12b8:	00012f07 	andeq	r2, r1, r7, lsl #30
    12bc:	01790400 	cmneq	r9, r0, lsl #8
    12c0:	1a020000 	bne	812c8 <__bss_end+0x532c8>
    12c4:	00000070 	andeq	r0, r0, r0, ror r0
    12c8:	65070402 	strvs	r0, [r7, #-1026]	; 0x402
    12cc:	02000000 	andeq	r0, r0, #0
    12d0:	005b0708 	subseq	r0, fp, r8, lsl #14
    12d4:	c6050000 	strgt	r0, [r5], -r0
    12d8:	01000002 	tsteq	r0, r2
    12dc:	008dbc17 	addeq	fp, sp, r7, lsl ip
    12e0:	00002000 	andeq	r2, r0, r0
    12e4:	c29c0100 	addsgt	r0, ip, #0, 2
    12e8:	06000000 	streq	r0, [r0], -r0
    12ec:	00008dcc 	andeq	r8, r0, ip, asr #27
    12f0:	00000140 	andeq	r0, r0, r0, asr #2
    12f4:	000000ad 	andeq	r0, r0, sp, lsr #1
    12f8:	03510107 	cmpeq	r1, #-1073741823	; 0xc0000001
    12fc:	0702000a 	streq	r0, [r2, -sl]
    1300:	30015001 	andcc	r5, r1, r1
    1304:	8dd80800 	ldclhi	8, cr0, [r8]
    1308:	01560000 	cmpeq	r6, r0
    130c:	01070000 	mrseq	r0, (UNDEF: 7)
    1310:	07300151 			; <UNDEFINED> instruction: 0x07300151
    1314:	30015001 	andcc	r5, r1, r1
    1318:	d2090000 	andle	r0, r9, #0
    131c:	01000006 	tsteq	r0, r6
    1320:	0000531c 	andeq	r5, r0, ip, lsl r3
    1324:	008ddc00 	addeq	sp, sp, r0, lsl #24
    1328:	00005000 	andeq	r5, r0, r0
    132c:	409c0100 	addsmi	r0, ip, r0, lsl #2
    1330:	0a000001 	beq	133c <__start-0x6cc4>
    1334:	000006ca 	andeq	r0, r0, sl, asr #13
    1338:	00411c01 	subeq	r1, r1, r1, lsl #24
    133c:	0adc0000 	beq	ff701344 <__user_program+0xff401344>
    1340:	a60b0000 	strge	r0, [fp], -r0
    1344:	01000006 	tsteq	r0, r6
    1348:	0000411d 	andeq	r4, r0, sp, lsl r1
    134c:	000afd00 	andeq	pc, sl, r0, lsl #26
    1350:	069b0c00 	ldreq	r0, [fp], r0, lsl #24
    1354:	1e010000 	cdpne	0, 0, cr0, cr1, cr0, {0}
    1358:	00000053 	andeq	r0, r0, r3, asr r0
    135c:	000d5401 	andeq	r5, sp, r1, lsl #8
    1360:	6c00008e 	stcvs	0, cr0, [r0], {142}	; 0x8e
    1364:	06000001 	streq	r0, [r0], -r1
    1368:	00008e08 	andeq	r8, r0, r8, lsl #28
    136c:	00000173 	andeq	r0, r0, r3, ror r1
    1370:	00000123 	andeq	r0, r0, r3, lsr #2
    1374:	02500107 	subseq	r0, r0, #-1073741823	; 0xc0000001
    1378:	06000074 			; <UNDEFINED> instruction: 0x06000074
    137c:	00008e18 	andeq	r8, r0, r8, lsl lr
    1380:	00000173 	andeq	r0, r0, r3, ror r1
    1384:	00000136 	andeq	r0, r0, r6, lsr r1
    1388:	01500107 	cmpeq	r0, r7, lsl #2
    138c:	240d0030 	strcs	r0, [sp], #-48	; 0x30
    1390:	8800008e 	stmdahi	r0, {r1, r2, r3, r7}
    1394:	00000001 	andeq	r0, r0, r1
    1398:	0005f30e 	andeq	pc, r5, lr, lsl #6
    139c:	566c0300 	strbtpl	r0, [ip], -r0, lsl #6
    13a0:	0f000001 	svceq	0x00000001
    13a4:	00000065 	andeq	r0, r0, r5, rrx
    13a8:	0000650f 	andeq	r6, r0, pc, lsl #10
    13ac:	4b0e0000 	blmi	3813b4 <__user_program+0x813b4>
    13b0:	03000006 	movweq	r0, #6
    13b4:	00016c75 	andeq	r6, r1, r5, ror ip
    13b8:	00650f00 	rsbeq	r0, r5, r0, lsl #30
    13bc:	650f0000 	strvs	r0, [pc, #-0]	; 13c4 <__start-0x6c3c>
    13c0:	00000000 	andeq	r0, r0, r0
    13c4:	00061d10 	andeq	r1, r6, r0, lsl sp
    13c8:	117b0300 	cmnne	fp, r0, lsl #6
    13cc:	00000637 	andeq	r0, r0, r7, lsr r6
    13d0:	00418903 	subeq	r8, r1, r3, lsl #18
    13d4:	01880000 	orreq	r0, r8, r0
    13d8:	410f0000 	mrsmi	r0, CPSR
    13dc:	00000000 	andeq	r0, r0, r0
    13e0:	00065f10 	andeq	r5, r6, r0, lsl pc
    13e4:	00810300 	addeq	r0, r1, r0, lsl #6
    13e8:	00000972 	andeq	r0, r0, r2, ror r9
    13ec:	08d00004 	ldmeq	r0, {r2}^
    13f0:	01040000 	mrseq	r0, (UNDEF: 4)
    13f4:	0000008e 	andeq	r0, r0, lr, lsl #1
    13f8:	0006e801 	andeq	lr, r6, r1, lsl #16
    13fc:	00003a00 	andeq	r3, r0, r0, lsl #20
    1400:	008e2c00 	addeq	r2, lr, r0, lsl #24
    1404:	00084400 	andeq	r4, r8, r0, lsl #8
    1408:	00059300 	andeq	r9, r5, r0, lsl #6
    140c:	08010200 	stmdaeq	r1, {r9}
    1410:	0000011e 	andeq	r0, r0, lr, lsl r1
    1414:	5c050202 	sfmpl	f0, 4, [r5], {2}
    1418:	03000001 	movweq	r0, #1
    141c:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1420:	08020074 	stmdaeq	r2, {r2, r4, r5, r6}
    1424:	00000005 	andeq	r0, r0, r5
    1428:	010d0400 	tsteq	sp, r0, lsl #8
    142c:	16020000 	strne	r0, [r2], -r0
    1430:	0000004c 	andeq	r0, r0, ip, asr #32
    1434:	15080102 	strne	r0, [r8, #-258]	; 0x102
    1438:	04000001 	streq	r0, [r0], #-1
    143c:	000004c5 	andeq	r0, r0, r5, asr #9
    1440:	005e1802 	subseq	r1, lr, r2, lsl #16
    1444:	02020000 	andeq	r0, r2, #0
    1448:	00012f07 	andeq	r2, r1, r7, lsl #30
    144c:	01790400 	cmneq	r9, r0, lsl #8
    1450:	1a020000 	bne	81458 <__bss_end+0x53458>
    1454:	00000070 	andeq	r0, r0, r0, ror r0
    1458:	65070402 	strvs	r0, [r7, #-1026]	; 0x402
    145c:	02000000 	andeq	r0, r0, #0
    1460:	005b0708 	subseq	r0, fp, r8, lsl #14
    1464:	a6050000 	strge	r0, [r5], -r0
    1468:	0c000004 	stceq	0, cr0, [r0], {4}
    146c:	00af0d03 	adceq	r0, pc, r3, lsl #26
    1470:	a2060000 	andge	r0, r6, #0
    1474:	03000002 	movweq	r0, #2
    1478:	0000af0f 	andeq	sl, r0, pc, lsl #30
    147c:	e7060000 	str	r0, [r6, -r0]
    1480:	03000001 	movweq	r0, #1
    1484:	0000af13 	andeq	sl, r0, r3, lsl pc
    1488:	cc060400 	cfstrsgt	mvf0, [r6], {-0}
    148c:	03000001 	movweq	r0, #1
    1490:	0000b415 	andeq	fp, r0, r5, lsl r4
    1494:	07000800 	streq	r0, [r0, -r0, lsl #16]
    1498:	00000033 	andeq	r0, r0, r3, lsr r0
    149c:	00ba0408 	adcseq	r0, sl, r8, lsl #8
    14a0:	7e070000 	cdpvc	0, 0, cr0, cr7, cr0, {0}
    14a4:	04000000 	streq	r0, [r0], #-0
    14a8:	000001b9 			; <UNDEFINED> instruction: 0x000001b9
    14ac:	007e1603 	rsbseq	r1, lr, r3, lsl #12
    14b0:	5e040000 	cdppl	0, 0, cr0, cr4, cr0, {0}
    14b4:	04000003 	streq	r0, [r0], #-3
    14b8:	0000d52d 	andeq	sp, r0, sp, lsr #10
    14bc:	db040800 	blle	1034c4 <__bss_end+0xd54c4>
    14c0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    14c4:	3304010a 	movwcc	r0, #16650	; 0x410a
    14c8:	000000f7 	strdeq	r0, [r0], -r7
    14cc:	0004770b 	andeq	r7, r4, fp, lsl #14
    14d0:	0d0b0000 	stceq	0, cr0, [fp, #-0]
    14d4:	01000005 	tsteq	r0, r5
    14d8:	0001d10b 	andeq	sp, r1, fp, lsl #2
    14dc:	04000200 	streq	r0, [r0], #-512	; 0x200
    14e0:	000001c1 	andeq	r0, r0, r1, asr #3
    14e4:	00dc3304 	sbcseq	r3, ip, r4, lsl #6
    14e8:	59050000 	stmdbpl	r5, {}	; <UNPREDICTABLE>
    14ec:	4c000002 	stcmi	0, cr0, [r0], {2}
    14f0:	01273804 	teqeq	r7, r4, lsl #16
    14f4:	ff060000 			; <UNDEFINED> instruction: 0xff060000
    14f8:	04000001 	streq	r0, [r0], #-1
    14fc:	0001273a 	andeq	r2, r1, sl, lsr r7
    1500:	92060000 	andls	r0, r6, #0
    1504:	04000003 	streq	r0, [r0], #-3
    1508:	00013e3c 	andeq	r3, r1, ip, lsr lr
    150c:	0c003400 	cfstrseq	mvf3, [r0], {-0}
    1510:	00000065 	andeq	r0, r0, r5, rrx
    1514:	00000137 	andeq	r0, r0, r7, lsr r1
    1518:	0001370d 	andeq	r3, r1, sp, lsl #14
    151c:	02000c00 	andeq	r0, r0, #0, 24
    1520:	04670704 	strbteq	r0, [r7], #-1796	; 0x704
    1524:	650c0000 	strvs	r0, [ip, #-0]
    1528:	4e000000 	cdpmi	0, 0, cr0, cr0, cr0, {0}
    152c:	0d000001 	stceq	0, cr0, [r0, #-4]
    1530:	00000137 	andeq	r0, r0, r7, lsr r1
    1534:	59040005 	stmdbpl	r4, {r0, r2}
    1538:	04000002 	streq	r0, [r0], #-2
    153c:	0001023d 	andeq	r0, r1, sp, lsr r2
    1540:	02d90e00 	sbcseq	r0, r9, #0, 28
    1544:	10740000 	rsbsne	r0, r4, r0
    1548:	01f44504 	mvnseq	r4, r4, lsl #10
    154c:	700f0000 	andvc	r0, pc, r0
    1550:	47040063 	strmi	r0, [r4, -r3, rrx]
    1554:	00000070 	andeq	r0, r0, r0, ror r0
    1558:	74630f00 	strbtvc	r0, [r3], #-3840	; 0xf00
    155c:	49040078 	stmdbmi	r4, {r3, r4, r5, r6}
    1560:	0000014e 	andeq	r0, r0, lr, asr #2
    1564:	00630f04 	rsbeq	r0, r3, r4, lsl #30
    1568:	00704b04 	rsbseq	r4, r0, r4, lsl #22
    156c:	0f500000 	svceq	0x00500000
    1570:	4d040074 	stcmi	0, cr0, [r4, #-464]	; 0xfffffe30
    1574:	00000070 	andeq	r0, r0, r0, ror r0
    1578:	03250654 	teqeq	r5, #84, 12	; 0x5400000
    157c:	4f040000 	svcmi	0x00040000
    1580:	00000070 	andeq	r0, r0, r0, ror r0
    1584:	01f60658 	mvnseq	r0, r8, asr r6
    1588:	51040000 	mrspl	r0, (UNDEF: 4)
    158c:	000000af 	andeq	r0, r0, pc, lsr #1
    1590:	02ec065c 	rsceq	r0, ip, #92, 12	; 0x5c00000
    1594:	53040000 	movwpl	r0, #16384	; 0x4000
    1598:	000000af 	andeq	r0, r0, pc, lsr #1
    159c:	032c0660 	teqeq	ip, #96, 12	; 0x6000000
    15a0:	55040000 	strpl	r0, [r4, #-0]
    15a4:	00000070 	andeq	r0, r0, r0, ror r0
    15a8:	01c60664 	biceq	r0, r6, r4, ror #12
    15ac:	58040000 	stmdapl	r4, {}	; <UNPREDICTABLE>
    15b0:	000001f4 	strdeq	r0, [r0], -r4
    15b4:	05540668 	ldrbeq	r0, [r4, #-1640]	; 0x668
    15b8:	5a040000 	bpl	1015c0 <__bss_end+0xd35c0>
    15bc:	000001f9 	strdeq	r0, [r0], -r9
    15c0:	0525106c 	streq	r1, [r5, #-108]!	; 0x6c
    15c4:	5e040000 	cdppl	0, 0, cr0, cr4, cr0, {0}
    15c8:	000000af 	andeq	r0, r0, pc, lsr #1
    15cc:	a910106c 	ldmdbge	r0, {r2, r3, r5, r6, ip}
    15d0:	04000001 	streq	r0, [r0], #-1
    15d4:	00020a60 	andeq	r0, r2, r0, ror #20
    15d8:	00107000 	andseq	r7, r0, r0
    15dc:	0000f707 	andeq	pc, r0, r7, lsl #14
    15e0:	00650c00 	rsbeq	r0, r5, r0, lsl #24
    15e4:	020a0000 	andeq	r0, sl, #0
    15e8:	37110000 	ldrcc	r0, [r1, -r0]
    15ec:	ff000001 			; <UNDEFINED> instruction: 0xff000001
    15f0:	04080003 	streq	r0, [r8], #-3
    15f4:	00000210 	andeq	r0, r0, r0, lsl r2
    15f8:	0000bf07 	andeq	fp, r0, r7, lsl #30
    15fc:	63741200 	cmnvs	r4, #0, 4
    1600:	61040062 	tstvs	r4, r2, rrx
    1604:	00000159 	andeq	r0, r0, r9, asr r1
    1608:	6e696d13 	mcrvs	13, 3, r6, cr9, cr3, {0}
    160c:	33410100 	movtcc	r0, #4352	; 0x1100
    1610:	03000000 	movweq	r0, #0
    1614:	00000243 	andeq	r0, r0, r3, asr #4
    1618:	01006114 	tsteq	r0, r4, lsl r1
    161c:	00003341 	andeq	r3, r0, r1, asr #6
    1620:	00621400 	rsbeq	r1, r2, r0, lsl #8
    1624:	00334101 	eorseq	r4, r3, r1, lsl #2
    1628:	15000000 	strne	r0, [r0, #-0]
    162c:	00000220 	andeq	r0, r0, r0, lsr #4
    1630:	00008e2c 	andeq	r8, r0, ip, lsr #28
    1634:	0000000c 	andeq	r0, r0, ip
    1638:	02679c01 	rsbeq	r9, r7, #256	; 0x100
    163c:	30160000 	andscc	r0, r6, r0
    1640:	1c000002 	stcne	0, cr0, [r0], {2}
    1644:	1700000b 	strne	r0, [r0, -fp]
    1648:	00000239 	andeq	r0, r0, r9, lsr r2
    164c:	18005101 	stmdane	r0, {r0, r8, ip, lr}
    1650:	00000318 	andeq	r0, r0, r8, lsl r3
    1654:	8e384501 	cdphi	5, 3, cr4, cr8, cr1, {0}
    1658:	00200000 	eoreq	r0, r0, r0
    165c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1660:	000002bc 			; <UNDEFINED> instruction: 0x000002bc
    1664:	00074819 	andeq	r4, r7, r9, lsl r8
    1668:	33450100 	movtcc	r0, #20736	; 0x5100
    166c:	3d000000 	stccc	0, cr0, [r0, #-0]
    1670:	1a00000b 	bne	16a4 <__start-0x695c>
    1674:	00008e4c 	andeq	r8, r0, ip, asr #28
    1678:	00000916 	andeq	r0, r0, r6, lsl r9
    167c:	000002a9 	andeq	r0, r0, r9, lsr #5
    1680:	0351011b 	cmpeq	r1, #-1073741818	; 0xc0000006
    1684:	1b5001f3 	blne	1401e58 <__user_program+0x1101e58>
    1688:	03055001 	movweq	r5, #20481	; 0x5001
    168c:	0000b02c 	andeq	fp, r0, ip, lsr #32
    1690:	8e501c00 	cdphi	12, 5, cr1, cr0, cr0, {0}
    1694:	09370000 	ldmdbeq	r7!, {}	; <UNPREDICTABLE>
    1698:	541c0000 	ldrpl	r0, [ip], #-0
    169c:	3e00008e 	cdpcc	0, 0, cr0, cr0, cr14, {4}
    16a0:	00000009 	andeq	r0, r0, r9
    16a4:	00030a1d 	andeq	r0, r3, sp, lsl sl
    16a8:	334c0100 	movtcc	r0, #49408	; 0xc100
    16ac:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
    16b0:	8400008e 	strhi	r0, [r0], #-142	; 0x8e
    16b4:	01000000 	mrseq	r0, (UNDEF: 0)
    16b8:	00031b9c 	muleq	r3, ip, fp
    16bc:	06fe1900 	ldrbteq	r1, [lr], r0, lsl #18
    16c0:	4c010000 	stcmi	0, cr0, [r1], {-0}
    16c4:	00000033 	andeq	r0, r0, r3, lsr r0
    16c8:	00000b69 	andeq	r0, r0, r9, ror #22
    16cc:	7274701e 	rsbsvc	r7, r4, #30
    16d0:	1b4c0100 	blne	1301ad8 <__user_program+0x1001ad8>
    16d4:	bc000003 	stclt	0, cr0, [r0], {3}
    16d8:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
    16dc:	006e656c 	rsbeq	r6, lr, ip, ror #10
    16e0:	00334c01 	eorseq	r4, r3, r1, lsl #24
    16e4:	0c430000 	mareq	acc0, r0, r3
    16e8:	701f0000 	andsvc	r0, pc, r0
    16ec:	01000007 	tsteq	r0, r7
    16f0:	0000334d 	andeq	r3, r0, sp, asr #6
    16f4:	000cba00 	andeq	fp, ip, r0, lsl #20
    16f8:	8eb01c00 	cdphi	12, 11, cr1, cr0, cr0, {0}
    16fc:	09450000 	stmdbeq	r5, {}^	; <UNPREDICTABLE>
    1700:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    1704:	00002504 	andeq	r2, r0, r4, lsl #10
    1708:	052b1d00 	streq	r1, [fp, #-3328]!	; 0xd00
    170c:	65010000 	strvs	r0, [r1, #-0]
    1710:	00000033 	andeq	r0, r0, r3, lsr r0
    1714:	00008edc 	ldrdeq	r8, [r0], -ip
    1718:	000000b8 	strheq	r0, [r0], -r8
    171c:	03c39c01 	biceq	r9, r3, #256	; 0x100
    1720:	fe190000 	cdp2	0, 1, cr0, cr9, cr0, {0}
    1724:	01000006 	tsteq	r0, r6
    1728:	00003365 	andeq	r3, r0, r5, ror #6
    172c:	000d2f00 	andeq	r2, sp, r0, lsl #30
    1730:	74701e00 	ldrbtvc	r1, [r0], #-3584	; 0xe00
    1734:	65010072 	strvs	r0, [r1, #-114]	; 0x72
    1738:	0000031b 	andeq	r0, r0, fp, lsl r3
    173c:	00000d82 	andeq	r0, r0, r2, lsl #27
    1740:	6e656c1e 	mcrvs	12, 3, r6, cr5, cr14, {0}
    1744:	33650100 	cmncc	r5, #0, 2
    1748:	cf000000 	svcgt	0x00000000
    174c:	1f00000d 	svcne	0x0000000d
    1750:	00000770 	andeq	r0, r0, r0, ror r7
    1754:	00336601 	eorseq	r6, r3, r1, lsl #12
    1758:	0e1c0000 	cdpeq	0, 1, cr0, cr12, cr0, {0}
    175c:	881f0000 	ldmdahi	pc, {}	; <UNPREDICTABLE>
    1760:	01000007 	tsteq	r0, r7
    1764:	00004167 	andeq	r4, r0, r7, ror #2
    1768:	000e5e00 	andeq	r5, lr, r0, lsl #28
    176c:	8f0c1c00 	svchi	0x000c1c00
    1770:	09560000 	ldmdbeq	r6, {}^	; <UNPREDICTABLE>
    1774:	381a0000 	ldmdacc	sl, {}	; <UNPREDICTABLE>
    1778:	1600008f 	strne	r0, [r0], -pc, lsl #1
    177c:	a2000009 	andge	r0, r0, #9
    1780:	1b000003 	blne	1794 <__start-0x686c>
    1784:	77025001 	strvc	r5, [r2, -r1]
    1788:	581a0000 	ldmdapl	sl, {}	; <UNPREDICTABLE>
    178c:	1600008f 	strne	r0, [r0], -pc, lsl #1
    1790:	b9000009 	stmdblt	r0, {r0, r3}
    1794:	1b000003 	blne	17a8 <__start-0x6858>
    1798:	03055001 	movweq	r5, #20481	; 0x5001
    179c:	0000b088 	andeq	fp, r0, r8, lsl #1
    17a0:	8f681c00 	svchi	0x00681c00
    17a4:	09450000 	stmdbeq	r5, {}^	; <UNPREDICTABLE>
    17a8:	1d000000 	stcne	0, cr0, [r0, #-0]
    17ac:	000004ac 	andeq	r0, r0, ip, lsr #9
    17b0:	00338801 	eorseq	r8, r3, r1, lsl #16
    17b4:	8f940000 	svchi	0x00940000
    17b8:	00080000 	andeq	r0, r8, r0
    17bc:	9c010000 	stcls	0, cr0, [r1], {-0}
    17c0:	00000405 	andeq	r0, r0, r5, lsl #8
    17c4:	00068a19 	andeq	r8, r6, r9, lsl sl
    17c8:	33880100 	orrcc	r0, r8, #0, 2
    17cc:	a1000000 	mrsge	r0, (UNDEF: 0)
    17d0:	2000000e 	andcs	r0, r0, lr
    17d4:	000006ca 	andeq	r0, r0, sl, asr #13
    17d8:	00418801 	subeq	r8, r1, r1, lsl #16
    17dc:	51010000 	mrspl	r0, (UNDEF: 1)
    17e0:	006e6621 	rsbeq	r6, lr, r1, lsr #12
    17e4:	04108801 	ldreq	r8, [r0], #-2049	; 0x801
    17e8:	52010000 	andpl	r0, r1, #0
    17ec:	04102200 	ldreq	r2, [r0], #-512	; 0x200
    17f0:	53230000 	teqpl	r3, #0
    17f4:	00000000 	andeq	r0, r0, r0
    17f8:	04050408 	streq	r0, [r5], #-1032	; 0x408
    17fc:	30240000 	eorcc	r0, r4, r0
    1800:	01000004 	tsteq	r0, r4
    1804:	0000338d 	andeq	r3, r0, sp, lsl #7
    1808:	008f9c00 	addeq	r9, pc, r0, lsl #24
    180c:	00000800 	andeq	r0, r0, r0, lsl #16
    1810:	1d9c0100 	ldfnes	f0, [ip]
    1814:	0000026b 	andeq	r0, r0, fp, ror #4
    1818:	00339501 	eorseq	r9, r3, r1, lsl #10
    181c:	8fa40000 	svchi	0x00a40000
    1820:	00980000 	addseq	r0, r8, r0
    1824:	9c010000 	stcls	0, cr0, [r1], {-0}
    1828:	00000463 	andeq	r0, r0, r3, ror #8
    182c:	0006db19 	andeq	sp, r6, r9, lsl fp
    1830:	ca950100 	bgt	fe541c38 <__user_program+0xfe241c38>
    1834:	c2000000 	andgt	r0, r0, #0
    1838:	1900000e 	stmdbne	r0, {r1, r2, r3}
    183c:	00000703 	andeq	r0, r0, r3, lsl #14
    1840:	04639501 	strbteq	r9, [r3], #-1281	; 0x501
    1844:	0f080000 	svceq	0x00080000
    1848:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    184c:	00006504 	andeq	r6, r0, r4, lsl #10
    1850:	037c1d00 	cmneq	ip, #0, 26
    1854:	b0010000 	andlt	r0, r1, r0
    1858:	00000033 	andeq	r0, r0, r3, lsr r0
    185c:	0000903c 	andeq	r9, r0, ip, lsr r0
    1860:	000000c4 	andeq	r0, r0, r4, asr #1
    1864:	04c89c01 	strbeq	r9, [r8], #3073	; 0xc01
    1868:	661e0000 	ldrvs	r0, [lr], -r0
    186c:	b001006e 	andlt	r0, r1, lr, rrx
    1870:	000000ca 	andeq	r0, r0, sl, asr #1
    1874:	00000f31 	andeq	r0, r0, r1, lsr pc
    1878:	00070819 	andeq	r0, r7, r9, lsl r8
    187c:	63b00100 	movsvs	r0, #0, 2
    1880:	4f000004 	svcmi	0x00000004
    1884:	1900000f 	stmdbne	r0, {r0, r1, r2, r3}
    1888:	0000073b 	andeq	r0, r0, fp, lsr r7
    188c:	0070b101 	rsbseq	fp, r0, r1, lsl #2
    1890:	0f6d0000 	svceq	0x006d0000
    1894:	431e0000 	tstmi	lr, #0
    1898:	70b10100 	adcsvc	r0, r1, r0, lsl #2
    189c:	99000000 	stmdbls	r0, {}	; <UNPREDICTABLE>
    18a0:	2100000f 	tstcs	r0, pc
    18a4:	b1010054 	qaddlt	r0, r4, r1
    18a8:	00000070 	andeq	r0, r0, r0, ror r0
    18ac:	00009102 	andeq	r9, r0, r2, lsl #2
    18b0:	00022f1d 	andeq	r2, r2, sp, lsl pc
    18b4:	33e00100 	mvncc	r0, #0, 2
    18b8:	00000000 	andeq	r0, r0, r0
    18bc:	38000091 	stmdacc	r0, {r0, r4, r7}
    18c0:	01000000 	mrseq	r0, (UNDEF: 0)
    18c4:	0004fe9c 	muleq	r4, ip, lr
    18c8:	04a61900 	strteq	r1, [r6], #2304	; 0x900
    18cc:	e0010000 	and	r0, r1, r0
    18d0:	000004fe 	strdeq	r0, [r0], -lr
    18d4:	00000fd1 	ldrdeq	r0, [r0], -r1
    18d8:	00073720 	andeq	r3, r7, r0, lsr #14
    18dc:	70e00100 	rscvc	r0, r0, r0, lsl #2
    18e0:	01000000 	mrseq	r0, (UNDEF: 0)
    18e4:	04080051 	streq	r0, [r8], #-81	; 0x51
    18e8:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    18ec:	0003fa18 	andeq	pc, r3, r8, lsl sl	; <UNPREDICTABLE>
    18f0:	38f80100 	ldmcc	r8!, {r8}^
    18f4:	f0000091 			; <UNDEFINED> instruction: 0xf0000091
    18f8:	01000000 	mrseq	r0, (UNDEF: 0)
    18fc:	0005799c 	muleq	r5, ip, r9
    1900:	04a61900 	strteq	r1, [r6], #2304	; 0x900
    1904:	f8010000 			; <UNDEFINED> instruction: 0xf8010000
    1908:	000004fe 	strdeq	r0, [r0], -lr
    190c:	00000fef 	andeq	r0, r0, pc, ror #31
    1910:	0004d325 	andeq	sp, r4, r5, lsr #6
    1914:	79ff0100 	ldmibvc	pc!, {r8}^	; <UNPREDICTABLE>
    1918:	26000005 	strcs	r0, [r0], -r5
    191c:	00000776 	andeq	r0, r0, r6, ror r7
    1920:	33010501 	movwcc	r0, #5377	; 0x1501
    1924:	27000000 	strcs	r0, [r0, -r0]
    1928:	00000220 	andeq	r0, r0, r0, lsr #4
    192c:	00009174 	andeq	r9, r0, r4, ror r1
    1930:	00000008 	andeq	r0, r0, r8
    1934:	66010501 	strvs	r0, [r1], -r1, lsl #10
    1938:	16000005 	strne	r0, [r0], -r5
    193c:	00000239 	andeq	r0, r0, r9, lsr r2
    1940:	0000100d 	andeq	r1, r0, sp
    1944:	00023016 	andeq	r3, r2, r6, lsl r0
    1948:	00102000 	andseq	r2, r0, r0
    194c:	441c0000 	ldrmi	r0, [ip], #-0
    1950:	37000091 			; <UNDEFINED> instruction: 0x37000091
    1954:	1c000009 	stcne	0, cr0, [r0], {9}
    1958:	00009224 	andeq	r9, r0, r4, lsr #4
    195c:	00000961 	andeq	r0, r0, r1, ror #18
    1960:	7f040800 	svcvc	0x00040800
    1964:	07000005 	streq	r0, [r0, -r5]
    1968:	00000215 	andeq	r0, r0, r5, lsl r2
    196c:	00027f28 	andeq	r7, r2, r8, lsr #30
    1970:	013d0100 	teqeq	sp, r0, lsl #2
    1974:	00009228 	andeq	r9, r0, r8, lsr #4
    1978:	00000284 	andeq	r0, r0, r4, lsl #5
    197c:	06979c01 	ldreq	r9, [r7], r1, lsl #24
    1980:	a6290000 	strtge	r0, [r9], -r0
    1984:	01000004 	tsteq	r0, r4
    1988:	04fe013d 	ldrbteq	r0, [lr], #317	; 0x13d
    198c:	10330000 	eorsne	r0, r3, r0
    1990:	d3260000 	teqle	r6, #0
    1994:	01000004 	tsteq	r0, r4
    1998:	05790145 	ldrbeq	r0, [r9, #-325]!	; 0x145
    199c:	402a0000 	eormi	r0, sl, r0
    19a0:	01000007 	tsteq	r0, r7
    19a4:	020a0151 	andeq	r0, sl, #1073741844	; 0x40000014
    19a8:	10510000 	subsne	r0, r1, r0
    19ac:	832a0000 	teqhi	sl, #0
    19b0:	01000007 	tsteq	r0, r7
    19b4:	020a0152 	andeq	r0, sl, #-2147483628	; 0x80000014
    19b8:	109b0000 	addsne	r0, fp, r0
    19bc:	682a0000 	stmdavs	sl!, {}	; <UNPREDICTABLE>
    19c0:	01000007 	tsteq	r0, r7
    19c4:	00330153 	eorseq	r0, r3, r3, asr r1
    19c8:	10ba0000 	adcsne	r0, sl, r0
    19cc:	592a0000 	stmdbpl	sl!, {}	; <UNPREDICTABLE>
    19d0:	01000003 	tsteq	r0, r3
    19d4:	00330157 	eorseq	r0, r3, r7, asr r1
    19d8:	110a0000 	mrsne	r0, (UNDEF: 10)
    19dc:	762a0000 	strtvc	r0, [sl], -r0
    19e0:	01000007 	tsteq	r0, r7
    19e4:	00330176 	eorseq	r0, r3, r6, ror r1
    19e8:	11410000 	mrsne	r0, (UNDEF: 65)
    19ec:	702b0000 	eorvc	r0, fp, r0
    19f0:	01007274 	tsteq	r0, r4, ror r2
    19f4:	020a0177 	andeq	r0, sl, #-1073741795	; 0xc000001d
    19f8:	11840000 	orrne	r0, r4, r0
    19fc:	c82c0000 	stmdagt	ip!, {}	; <UNPREDICTABLE>
    1a00:	6c000092 	stcvs	0, cr0, [r0], {146}	; 0x92
    1a04:	34000000 	strcc	r0, [r0], #-0
    1a08:	2a000006 	bcs	1a28 <__start-0x65d8>
    1a0c:	000001cc 	andeq	r0, r0, ip, asr #3
    1a10:	0a016001 	beq	59a1c <__bss_end+0x2ba1c>
    1a14:	97000002 	strls	r0, [r0, -r2]
    1a18:	00000011 	andeq	r0, r0, r1, lsl r0
    1a1c:	0092341c 	addseq	r3, r2, ip, lsl r4
    1a20:	00093700 	andeq	r3, r9, r0, lsl #14
    1a24:	92801a00 	addls	r1, r0, #0, 20
    1a28:	09160000 	ldmdbeq	r6, {}	; <UNPREDICTABLE>
    1a2c:	06540000 	ldrbeq	r0, [r4], -r0
    1a30:	011b0000 	tsteq	fp, r0
    1a34:	44030550 	strmi	r0, [r3], #-1360	; 0x550
    1a38:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
    1a3c:	0092881a 	addseq	r8, r2, sl, lsl r8
    1a40:	00026700 	andeq	r6, r2, r0, lsl #14
    1a44:	00066700 	andeq	r6, r6, r0, lsl #14
    1a48:	50011b00 	andpl	r1, r1, r0, lsl #22
    1a4c:	1c003101 	stfnes	f3, [r0], {1}
    1a50:	00009474 	andeq	r9, r0, r4, ror r4
    1a54:	00000961 	andeq	r0, r0, r1, ror #18
    1a58:	0094841a 	addseq	r8, r4, sl, lsl r4
    1a5c:	00091600 	andeq	r1, r9, r0, lsl #12
    1a60:	00068700 	andeq	r8, r6, r0, lsl #14
    1a64:	50011b00 	andpl	r1, r1, r0, lsl #22
    1a68:	b0740305 	rsbslt	r0, r4, r5, lsl #6
    1a6c:	2d000000 	stccs	0, cr0, [r0, #-0]
    1a70:	0000948c 	andeq	r9, r0, ip, lsl #9
    1a74:	00000267 	andeq	r0, r0, r7, ror #4
    1a78:	0150011b 	cmpeq	r0, fp, lsl r1
    1a7c:	28000031 	stmdacs	r0, {r0, r4, r5}
    1a80:	00000448 	andeq	r0, r0, r8, asr #8
    1a84:	ac01b001 	stcge	0, cr11, [r1], {1}
    1a88:	7c000094 	stcvc	0, cr0, [r0], {148}	; 0x94
    1a8c:	01000000 	mrseq	r0, (UNDEF: 0)
    1a90:	0006d49c 	muleq	r6, ip, r4
    1a94:	94dc1a00 	ldrbls	r1, [ip], #2560	; 0xa00
    1a98:	09160000 	ldmdbeq	r6, {}	; <UNPREDICTABLE>
    1a9c:	06c40000 	strbeq	r0, [r4], r0
    1aa0:	011b0000 	tsteq	fp, r0
    1aa4:	8c030550 	cfstr32hi	mvfx0, [r3], {80}	; 0x50
    1aa8:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
    1aac:	0094e42d 	addseq	lr, r4, sp, lsr #8
    1ab0:	00026700 	andeq	r6, r2, r0, lsl #14
    1ab4:	50011b00 	andpl	r1, r1, r0, lsl #22
    1ab8:	00003101 	andeq	r3, r0, r1, lsl #2
    1abc:	00033d2e 	andeq	r3, r3, lr, lsr #26
    1ac0:	01ba0100 			; <UNDEFINED> instruction: 0x01ba0100
    1ac4:	00000070 	andeq	r0, r0, r0, ror r0
    1ac8:	00009528 	andeq	r9, r0, r8, lsr #10
    1acc:	00000010 	andeq	r0, r0, r0, lsl r0
    1ad0:	b32f9c01 	teqlt	pc, #256	; 0x100
    1ad4:	01000003 	tsteq	r0, r3
    1ad8:	003301be 	ldrhteq	r0, [r3], -lr
    1adc:	95380000 	ldrls	r0, [r8, #-0]!
    1ae0:	00c00000 	sbceq	r0, r0, r0
    1ae4:	9c010000 	stcls	0, cr0, [r1], {-0}
    1ae8:	0000073d 	andeq	r0, r0, sp, lsr r7
    1aec:	0100692b 	tsteq	r0, fp, lsr #18
    1af0:	003301c0 	eorseq	r0, r3, r0, asr #3
    1af4:	11d60000 	bicsne	r0, r6, r0
    1af8:	732b0000 	teqvc	fp, #0
    1afc:	01006d75 	tsteq	r0, r5, ror sp
    1b00:	073d01c1 	ldreq	r0, [sp, -r1, asr #3]!
    1b04:	11f50000 	mvnsne	r0, r0
    1b08:	e01c0000 	ands	r0, ip, r0
    1b0c:	61000095 	swpvs	r0, r5, [r0]	; <UNPREDICTABLE>
    1b10:	2d000009 	stccs	0, cr0, [r0, #-36]	; 0xffffffdc
    1b14:	000095e8 	andeq	r9, r0, r8, ror #11
    1b18:	00000968 	andeq	r0, r0, r8, ror #18
    1b1c:	0350011b 	cmpeq	r0, #-1073741818	; 0xc0000006
    1b20:	0003e80a 	andeq	lr, r3, sl, lsl #16
    1b24:	04040200 	streq	r0, [r4], #-512	; 0x200
    1b28:	00000726 	andeq	r0, r0, r6, lsr #14
    1b2c:	0001da30 	andeq	sp, r1, r0, lsr sl
    1b30:	01d90100 	bicseq	r0, r9, r0, lsl #2
    1b34:	00000795 	muleq	r0, r5, r7
    1b38:	000095f8 	strdeq	r9, [r0], -r8
    1b3c:	00000058 	andeq	r0, r0, r8, asr r0
    1b40:	07959c01 	ldreq	r9, [r5, r1, lsl #24]
    1b44:	e3290000 	teq	r9, #0
    1b48:	01000006 	tsteq	r0, r6
    1b4c:	003301d9 	ldrsbteq	r0, [r3], -r9
    1b50:	12180000 	andsne	r0, r8, #0
    1b54:	5d310000 	ldcpl	0, cr0, [r1, #-0]
    1b58:	01000007 	tsteq	r0, r7
    1b5c:	002501da 	ldrdeq	r0, [r5], -sl	; <UNPREDICTABLE>
    1b60:	2c310000 	ldccs	0, cr0, [r1], #-0
    1b64:	01000007 	tsteq	r0, r7
    1b68:	002501db 	ldrdeq	r0, [r5], -fp	; <UNPREDICTABLE>
    1b6c:	4f320000 	svcmi	0x00320000
    1b70:	01000007 	tsteq	r0, r7
    1b74:	031b01dc 	tsteq	fp, #220, 2	; 0x37
    1b78:	53010000 	movwpl	r0, #4096	; 0x1000
    1b7c:	30043300 	andcc	r3, r4, r0, lsl #6
    1b80:	0000047f 	andeq	r0, r0, pc, ror r4
    1b84:	3301ee01 	movwcc	lr, #7681	; 0x1e01
    1b88:	50000000 	andpl	r0, r0, r0
    1b8c:	08000096 	stmdaeq	r0, {r1, r2, r4, r7}
    1b90:	01000000 	mrseq	r0, (UNDEF: 0)
    1b94:	0007c29c 	muleq	r7, ip, r2
    1b98:	06fe2900 	ldrbteq	r2, [lr], r0, lsl #18
    1b9c:	ee010000 	cdp	0, 0, cr0, cr1, cr0, {0}
    1ba0:	00003301 	andeq	r3, r0, r1, lsl #6
    1ba4:	00123900 	andseq	r3, r2, r0, lsl #18
    1ba8:	46300000 	ldrtmi	r0, [r0], -r0
    1bac:	01000005 	tsteq	r0, r5
    1bb0:	003301f2 	ldrshteq	r0, [r3], -r2
    1bb4:	96580000 	ldrbls	r0, [r8], -r0
    1bb8:	00080000 	andeq	r0, r8, r0
    1bbc:	9c010000 	stcls	0, cr0, [r1], {-0}
    1bc0:	000007fa 	strdeq	r0, [r0], -sl
    1bc4:	0006fe29 	andeq	pc, r6, r9, lsr #28
    1bc8:	01f20100 	mvnseq	r0, r0, lsl #2
    1bcc:	00000033 	andeq	r0, r0, r3, lsr r0
    1bd0:	0000125a 	andeq	r1, r0, sl, asr r2
    1bd4:	00747334 	rsbseq	r7, r4, r4, lsr r3
    1bd8:	9501f201 	strls	pc, [r1, #-513]	; 0x201
    1bdc:	01000007 	tsteq	r0, r7
    1be0:	42300051 	eorsmi	r0, r0, #81	; 0x51
    1be4:	01000002 	tsteq	r0, r2
    1be8:	003301f6 	ldrshteq	r0, [r3], -r6
    1bec:	96600000 	strbtls	r0, [r0], -r0
    1bf0:	00080000 	andeq	r0, r8, r0
    1bf4:	9c010000 	stcls	0, cr0, [r1], {-0}
    1bf8:	00000825 	andeq	r0, r0, r5, lsr #16
    1bfc:	0006fe29 	andeq	pc, r6, r9, lsr #28
    1c00:	01f60100 	mvnseq	r0, r0, lsl #2
    1c04:	00000033 	andeq	r0, r0, r3, lsr r0
    1c08:	0000127b 	andeq	r1, r0, fp, ror r2
    1c0c:	040d3000 	streq	r3, [sp], #-0
    1c10:	fa010000 	blx	41c18 <__bss_end+0x13c18>
    1c14:	00003301 	andeq	r3, r0, r1, lsl #6
    1c18:	00966800 	addseq	r6, r6, r0, lsl #16
    1c1c:	00000800 	andeq	r0, r0, r0, lsl #16
    1c20:	6c9c0100 	ldfvss	f0, [ip], {0}
    1c24:	29000008 	stmdbcs	r0, {r3}
    1c28:	000006fe 	strdeq	r0, [r0], -lr
    1c2c:	3301fa01 	movwcc	pc, #6657	; 0x1a01	; <UNPREDICTABLE>
    1c30:	9c000000 	stcls	0, cr0, [r0], {-0}
    1c34:	34000012 	strcc	r0, [r0], #-18
    1c38:	00727470 	rsbseq	r7, r2, r0, ror r4
    1c3c:	3301fa01 	movwcc	pc, #6657	; 0x1a01	; <UNPREDICTABLE>
    1c40:	01000000 	mrseq	r0, (UNDEF: 0)
    1c44:	69643451 	stmdbvs	r4!, {r0, r4, r6, sl, ip, sp}^
    1c48:	fa010072 	blx	41e18 <__bss_end+0x13e18>
    1c4c:	00003301 	andeq	r3, r0, r1, lsl #6
    1c50:	00520100 	subseq	r0, r2, r0, lsl #2
    1c54:	00075435 	andeq	r5, r7, r5, lsr r4
    1c58:	1b2f0100 	blne	bc2060 <__user_program+0x8c2060>
    1c5c:	05000003 	streq	r0, [r0, #-3]
    1c60:	00d00003 	sbcseq	r0, r0, r3
    1c64:	073d0c00 	ldreq	r0, [sp, -r0, lsl #24]!
    1c68:	088d0000 	stmeq	sp, {}	; <UNPREDICTABLE>
    1c6c:	370d0000 	strcc	r0, [sp, -r0]
    1c70:	20000001 	andcs	r0, r0, r1
    1c74:	00553600 	subseq	r3, r5, r0, lsl #12
    1c78:	087d3201 	ldmdaeq	sp!, {r0, r9, ip, sp}^
    1c7c:	03050000 	movweq	r0, #20480	; 0x5000
    1c80:	0000c008 	andeq	ip, r0, r8
    1c84:	00021837 	andeq	r1, r2, r7, lsr r8
    1c88:	65390100 	ldrvs	r0, [r9, #-256]!	; 0x100
    1c8c:	37000000 	strcc	r0, [r0, -r0]
    1c90:	0000041b 	andeq	r0, r0, fp, lsl r4
    1c94:	00703d01 	rsbseq	r3, r0, r1, lsl #26
    1c98:	150c0000 	strne	r0, [ip, #-0]
    1c9c:	c2000002 	andgt	r0, r0, #2
    1ca0:	0d000008 	stceq	0, cr0, [r0, #-32]	; 0xffffffe0
    1ca4:	00000137 	andeq	r0, r0, r7, lsr r1
    1ca8:	6137001f 	teqvs	r7, pc, lsl r0
    1cac:	01000002 	tsteq	r0, r2
    1cb0:	0008b23b 	andeq	fp, r8, fp, lsr r2
    1cb4:	05383700 	ldreq	r3, [r8, #-1792]!	; 0x700
    1cb8:	3c010000 	stccc	0, cr0, [r1], {-0}
    1cbc:	00000070 	andeq	r0, r0, r0, ror r0
    1cc0:	00020b37 	andeq	r0, r2, r7, lsr fp
    1cc4:	703c0100 	eorsvc	r0, ip, r0, lsl #2
    1cc8:	0c000000 	stceq	0, cr0, [r0], {-0}
    1ccc:	00000033 	andeq	r0, r0, r3, lsr r0
    1cd0:	000008f3 	strdeq	r0, [r0], -r3
    1cd4:	0001370d 	andeq	r3, r1, sp, lsl #14
    1cd8:	37001f00 	strcc	r1, [r0, -r0, lsl #30]
    1cdc:	000003ed 	andeq	r0, r0, sp, ror #7
    1ce0:	08e33e01 	stmiaeq	r3!, {r0, r9, sl, fp, ip, sp}^
    1ce4:	5d310000 	ldcpl	0, cr0, [r1, #-0]
    1ce8:	01000007 	tsteq	r0, r7
    1cec:	002501da 	ldrdeq	r0, [r5], -sl	; <UNPREDICTABLE>
    1cf0:	2c310000 	ldccs	0, cr0, [r1], #-0
    1cf4:	01000007 	tsteq	r0, r7
    1cf8:	002501db 	ldrdeq	r0, [r5], -fp	; <UNPREDICTABLE>
    1cfc:	70380000 	eorsvc	r0, r8, r0
    1d00:	06000004 	streq	r0, [r0], -r4
    1d04:	00003313 	andeq	r3, r0, r3, lsl r3
    1d08:	00092c00 	andeq	r2, r9, r0, lsl #24
    1d0c:	092c2300 	stmdbeq	ip!, {r8, r9, sp}
    1d10:	00390000 	eorseq	r0, r9, r0
    1d14:	09320408 	ldmdbeq	r2!, {r3, sl}
    1d18:	253a0000 	ldrcs	r0, [sl, #-0]!
    1d1c:	3b000000 	blcc	1d24 <__start-0x62dc>
    1d20:	000002b3 			; <UNDEFINED> instruction: 0x000002b3
    1d24:	923b3005 	eorsls	r3, fp, #5
    1d28:	05000007 	streq	r0, [r0, #-7]
    1d2c:	05933c12 	ldreq	r3, [r3, #3090]	; 0xc12
    1d30:	23070000 	movwcs	r0, #28672	; 0x7000
    1d34:	00000956 	andeq	r0, r0, r6, asr r9
    1d38:	00004123 	andeq	r4, r0, r3, lsr #2
    1d3c:	c33d0000 	teqgt	sp, #0
    1d40:	07000005 	streq	r0, [r0, -r5]
    1d44:	0000412a 	andeq	r4, r0, sl, lsr #2
    1d48:	07143b00 	ldreq	r3, [r4, -r0, lsl #22]
    1d4c:	2b050000 	blcs	141d54 <__svc_stack_top+0x3d54>
    1d50:	00068f3e 	andeq	r8, r6, lr, lsr pc
    1d54:	23130800 	tstcs	r3, #0, 16
    1d58:	00000033 	andeq	r0, r0, r3, lsr r0
    1d5c:	00580000 	subseq	r0, r8, r0
    1d60:	00020000 	andeq	r0, r2, r0
    1d64:	00000c66 	andeq	r0, r0, r6, ror #24
    1d68:	07850104 	streq	r0, [r5, r4, lsl #2]
    1d6c:	80000000 	andhi	r0, r0, r0
    1d70:	80540000 	subshi	r0, r4, r0
    1d74:	34330000 	ldrtcc	r0, [r3], #-0
    1d78:	62696c39 	rsbvs	r6, r9, #14592	; 0x3900
    1d7c:	72732f6b 	rsbsvc	r2, r3, #428	; 0x1ac
    1d80:	6f622f63 	svcvs	0x00622f63
    1d84:	532e746f 	teqpl	lr, #1862270976	; 0x6f000000
    1d88:	6f682f00 	svcvs	0x00682f00
    1d8c:	6b2f656d 	blvs	bdb348 <__user_program+0x8db348>
    1d90:	68747261 	ldmdavs	r4!, {r0, r5, r6, r9, ip, sp, lr}^
    1d94:	312f6369 	teqcc	pc, r9, ror #6
    1d98:	39343338 	ldmdbcc	r4!, {r3, r4, r5, r8, r9, ip, sp}
    1d9c:	3934332f 	ldmdbcc	r4!, {r0, r1, r2, r3, r5, r8, r9, ip, sp}
    1da0:	3531662d 	ldrcc	r6, [r1, #-1581]!	; 0x62d
    1da4:	646f632f 	strbtvs	r6, [pc], #-815	; 1dac <__start-0x6254>
    1da8:	4e470065 	cdpmi	0, 4, cr0, cr7, cr5, {3}
    1dac:	53412055 	movtpl	r2, #4181	; 0x1055
    1db0:	322e3220 	eorcc	r3, lr, #32, 4
    1db4:	00302e34 	eorseq	r2, r0, r4, lsr lr
    1db8:	00578001 	subseq	r8, r7, r1
    1dbc:	00020000 	andeq	r0, r2, r0
    1dc0:	00000c7a 	andeq	r0, r0, sl, ror ip
    1dc4:	07dd0104 	ldrbeq	r0, [sp, r4, lsl #2]
    1dc8:	96700000 	ldrbtls	r0, [r0], -r0
    1dcc:	96b40000 	ldrtls	r0, [r4], r0
    1dd0:	34330000 	ldrtcc	r0, [r3], #-0
    1dd4:	62696c39 	rsbvs	r6, r9, #14592	; 0x3900
    1dd8:	72732f6b 	rsbsvc	r2, r3, #428	; 0x1ac
    1ddc:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
    1de0:	00532e6d 	subseq	r2, r3, sp, ror #28
    1de4:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 1d30 <__start-0x62d0>
    1de8:	616b2f65 	cmnvs	fp, r5, ror #30
    1dec:	69687472 	stmdbvs	r8!, {r1, r4, r5, r6, sl, ip, sp, lr}^
    1df0:	38312f63 	ldmdacc	r1!, {r0, r1, r5, r6, r8, r9, sl, fp, sp}
    1df4:	2f393433 	svccs	0x00393433
    1df8:	2d393433 	cfldrscs	mvf3, [r9, #-204]!	; 0xffffff34
    1dfc:	2f353166 	svccs	0x00353166
    1e00:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xf63
    1e04:	554e4700 	strbpl	r4, [lr, #-1792]	; 0x700
    1e08:	20534120 	subscs	r4, r3, r0, lsr #2
    1e0c:	34322e32 	ldrtcc	r2, [r2], #-3634	; 0xe32
    1e10:	0100302e 	tsteq	r0, lr, lsr #32
    1e14:	00005d80 	andeq	r5, r0, r0, lsl #27
    1e18:	8e000200 	cdphi	2, 0, cr0, cr0, cr0, {0}
    1e1c:	0400000c 	streq	r0, [r0], #-12
    1e20:	00082e01 	andeq	r2, r8, r1, lsl #28
    1e24:	0096b400 	addseq	fp, r6, r0, lsl #8
    1e28:	0097f800 	addseq	pc, r7, r0, lsl #16
    1e2c:	72656b00 	rsbvc	r6, r5, #0, 22
    1e30:	2f6c656e 	svccs	0x006c656e
    1e34:	2f637273 	svccs	0x00637273
    1e38:	65707573 	ldrbvs	r7, [r0, #-1395]!	; 0x573
    1e3c:	73697672 	cmnvc	r9, #119537664	; 0x7200000
    1e40:	532e726f 	teqpl	lr, #-268435450	; 0xf0000006
    1e44:	6f682f00 	svcvs	0x00682f00
    1e48:	6b2f656d 	blvs	bdb404 <__user_program+0x8db404>
    1e4c:	68747261 	ldmdavs	r4!, {r0, r5, r6, r9, ip, sp, lr}^
    1e50:	312f6369 	teqcc	pc, r9, ror #6
    1e54:	39343338 	ldmdbcc	r4!, {r3, r4, r5, r8, r9, ip, sp}
    1e58:	3934332f 	ldmdbcc	r4!, {r0, r1, r2, r3, r5, r8, r9, ip, sp}
    1e5c:	3531662d 	ldrcc	r6, [r1, #-1581]!	; 0x62d
    1e60:	646f632f 	strbtvs	r6, [pc], #-815	; 1e68 <__start-0x6198>
    1e64:	4e470065 	cdpmi	0, 4, cr0, cr7, cr5, {3}
    1e68:	53412055 	movtpl	r2, #4181	; 0x1055
    1e6c:	322e3220 	eorcc	r3, lr, #32, 4
    1e70:	00302e34 	eorseq	r2, r0, r4, lsr lr
    1e74:	Address 0x00001e74 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	25011101 	strcs	r1, [r1, #-257]	; 0x101
   4:	030b130e 	movweq	r1, #45838	; 0xb30e
   8:	110e1b0e 	tstne	lr, lr, lsl #22
   c:	10061201 	andne	r1, r6, r1, lsl #4
  10:	02000017 	andeq	r0, r0, #23
  14:	0b0b0024 	bleq	2c00ac <__end+0x1710ac>
  18:	0e030b3e 	vmoveq.16	d3[0], r0
  1c:	24030000 	strcs	r0, [r3], #-0
  20:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  24:	0008030b 	andeq	r0, r8, fp, lsl #6
  28:	00160400 	andseq	r0, r6, r0, lsl #8
  2c:	0b3a0e03 	bleq	e83840 <__user_program+0xb83840>
  30:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  34:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
  38:	03193f01 	tsteq	r9, #1, 30
  3c:	3b0b3a0e 	blcc	2ce87c <__end+0x17f87c>
  40:	1119270b 	tstne	r9, fp, lsl #14
  44:	40061201 	andmi	r1, r6, r1, lsl #4
  48:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
  4c:	00001301 	andeq	r1, r0, r1, lsl #6
  50:	01828906 	orreq	r8, r2, r6, lsl #18
  54:	31011101 	tstcc	r1, r1, lsl #2
  58:	00130113 	andseq	r0, r3, r3, lsl r1
  5c:	828a0700 	addhi	r0, sl, #0, 14
  60:	18020001 	stmdane	r2, {r0}
  64:	00184291 	mulseq	r8, r1, r2
  68:	82890800 	addhi	r0, r9, #0, 16
  6c:	01110101 	tsteq	r1, r1, lsl #2
  70:	00001331 	andeq	r1, r0, r1, lsr r3
  74:	3f012e09 	svccc	0x00012e09
  78:	3a0e0319 	bcc	380ce4 <__user_program+0x80ce4>
  7c:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
  80:	01193c19 	tsteq	r9, r9, lsl ip
  84:	0a000013 	beq	d8 <__start-0x7f28>
  88:	13490005 	movtne	r0, #36869	; 0x9005
  8c:	2e0b0000 	cdpcs	0, 0, cr0, cr11, cr0, {0}
  90:	03193f01 	tsteq	r9, #1, 30
  94:	3b0b3a0e 	blcc	2ce8d4 <__end+0x17f8d4>
  98:	3c19270b 	ldccc	7, cr2, [r9], {11}
  9c:	00000019 	andeq	r0, r0, r9, lsl r0
  a0:	25011101 	strcs	r1, [r1, #-257]	; 0x101
  a4:	030b130e 	movweq	r1, #45838	; 0xb30e
  a8:	110e1b0e 	tstne	lr, lr, lsl #22
  ac:	10061201 	andne	r1, r6, r1, lsl #4
  b0:	02000017 	andeq	r0, r0, #23
  b4:	0b0b0024 	bleq	2c014c <__end+0x17114c>
  b8:	0e030b3e 	vmoveq.16	d3[0], r0
  bc:	24030000 	strcs	r0, [r3], #-0
  c0:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  c4:	0008030b 	andeq	r0, r8, fp, lsl #6
  c8:	00160400 	andseq	r0, r6, r0, lsl #8
  cc:	0b3a0e03 	bleq	e838e0 <__user_program+0xb838e0>
  d0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  d4:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
  d8:	03193f01 	tsteq	r9, #1, 30
  dc:	3b0b3a0e 	blcc	2ce91c <__end+0x17f91c>
  e0:	1119270b 	tstne	r9, fp, lsl #14
  e4:	40061201 	andmi	r1, r6, r1, lsl #4
  e8:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
  ec:	00001301 	andeq	r1, r0, r1, lsl #6
  f0:	03000506 	movweq	r0, #1286	; 0x506
  f4:	3b0b3a08 	blcc	2ce91c <__end+0x17f91c>
  f8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  fc:	07000017 	smladeq	r0, r7, r0, r0
 100:	08030005 	stmdaeq	r3, {r0, r2}
 104:	0b3b0b3a 	bleq	ec2df4 <__user_program+0xbc2df4>
 108:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 10c:	34080000 	strcc	r0, [r8], #-0
 110:	3a080300 	bcc	200d18 <__end+0xb1d18>
 114:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 118:	00170213 	andseq	r0, r7, r3, lsl r2
 11c:	00340900 	eorseq	r0, r4, r0, lsl #18
 120:	0b3a0e03 	bleq	e83934 <__user_program+0xb83934>
 124:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 128:	00001702 	andeq	r1, r0, r2, lsl #14
 12c:	0300050a 	movweq	r0, #1290	; 0x50a
 130:	3b0b3a0e 	blcc	2ce970 <__end+0x17f970>
 134:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 138:	0b000017 	bleq	19c <__start-0x7e64>
 13c:	01018289 	smlabbeq	r1, r9, r2, r8
 140:	13310111 	teqne	r1, #1073741828	; 0x40000004
 144:	00001301 	andeq	r1, r0, r1, lsl #6
 148:	01828a0c 	orreq	r8, r2, ip, lsl #20
 14c:	91180200 	tstls	r8, r0, lsl #4
 150:	00001842 	andeq	r1, r0, r2, asr #16
 154:	0182890d 	orreq	r8, r2, sp, lsl #18
 158:	31011101 	tstcc	r1, r1, lsl #2
 15c:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 160:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 164:	0b3b0b3a 	bleq	ec2e54 <__user_program+0xbc2e54>
 168:	061c1349 	ldreq	r1, [ip], -r9, asr #6
 16c:	260f0000 	strcs	r0, [pc], -r0
 170:	00134900 	andseq	r4, r3, r0, lsl #18
 174:	000f1000 	andeq	r1, pc, r0
 178:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 17c:	35110000 	ldrcc	r0, [r1, #-0]
 180:	00134900 	andseq	r4, r3, r0, lsl #18
 184:	012e1200 	teqeq	lr, r0, lsl #4
 188:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 18c:	0b3b0b3a 	bleq	ec2e7c <__user_program+0xbc2e7c>
 190:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
 194:	05130000 	ldreq	r0, [r3, #-0]
 198:	00134900 	andseq	r4, r3, r0, lsl #18
 19c:	11010000 	mrsne	r0, (UNDEF: 1)
 1a0:	130e2501 	movwne	r2, #58625	; 0xe501
 1a4:	1b0e030b 	blne	380dd8 <__user_program+0x80dd8>
 1a8:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 1ac:	00171006 	andseq	r1, r7, r6
 1b0:	00240200 	eoreq	r0, r4, r0, lsl #4
 1b4:	0b3e0b0b 	bleq	f82de8 <__user_program+0xc82de8>
 1b8:	00000e03 	andeq	r0, r0, r3, lsl #28
 1bc:	0b002403 	bleq	91d0 <syscall_mutex_lock+0x98>
 1c0:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 1c4:	04000008 	streq	r0, [r0], #-8
 1c8:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 1cc:	0b3b0b3a 	bleq	ec2ebc <__user_program+0xbc2ebc>
 1d0:	00001349 	andeq	r1, r0, r9, asr #6
 1d4:	03011305 	movweq	r1, #4869	; 0x1305
 1d8:	3a0b0b0e 	bcc	2c2e18 <__end+0x173e18>
 1dc:	010b3b0b 	tsteq	fp, fp, lsl #22
 1e0:	06000013 			; <UNDEFINED> instruction: 0x06000013
 1e4:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 1e8:	0b3b0b3a 	bleq	ec2ed8 <__user_program+0xbc2ed8>
 1ec:	0b381349 	bleq	e04f18 <__user_program+0xb04f18>
 1f0:	35070000 	strcc	r0, [r7, #-0]
 1f4:	00134900 	andseq	r4, r3, r0, lsl #18
 1f8:	000f0800 	andeq	r0, pc, r0, lsl #16
 1fc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 200:	15090000 	strne	r0, [r9, #-0]
 204:	00192700 	andseq	r2, r9, r0, lsl #14
 208:	01040a00 	tsteq	r4, r0, lsl #20
 20c:	0b3a0b0b 	bleq	e82e40 <__user_program+0xb82e40>
 210:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 214:	280b0000 	stmdacs	fp, {}	; <UNPREDICTABLE>
 218:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 21c:	0c00000d 	stceq	0, cr0, [r0], {13}
 220:	13490101 	movtne	r0, #37121	; 0x9101
 224:	00001301 	andeq	r1, r0, r1, lsl #6
 228:	4900210d 	stmdbmi	r0, {r0, r2, r3, r8, sp}
 22c:	000b2f13 	andeq	r2, fp, r3, lsl pc
 230:	01130e00 	tsteq	r3, r0, lsl #28
 234:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
 238:	0b3b0b3a 	bleq	ec2f28 <__user_program+0xbc2f28>
 23c:	00001301 	andeq	r1, r0, r1, lsl #6
 240:	03000d0f 	movweq	r0, #3343	; 0xd0f
 244:	3b0b3a08 	blcc	2cea6c <__end+0x17fa6c>
 248:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 24c:	1000000b 	andne	r0, r0, fp
 250:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 254:	0b3b0b3a 	bleq	ec2f44 <__user_program+0xbc2f44>
 258:	05381349 	ldreq	r1, [r8, #-841]!	; 0x349
 25c:	21110000 	tstcs	r1, r0
 260:	2f134900 	svccs	0x00134900
 264:	12000005 	andne	r0, r0, #5
 268:	08030016 	stmdaeq	r3, {r1, r2, r4}
 26c:	0b3b0b3a 	bleq	ec2f5c <__user_program+0xbc2f5c>
 270:	00001349 	andeq	r1, r0, r9, asr #6
 274:	3f012e13 	svccc	0x00012e13
 278:	3a0e0319 	bcc	380ee4 <__user_program+0x80ee4>
 27c:	110b3b0b 	tstne	fp, fp, lsl #22
 280:	40061201 	andmi	r1, r6, r1, lsl #4
 284:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 288:	00001301 	andeq	r1, r0, r1, lsl #6
 28c:	03003414 	movweq	r3, #1044	; 0x414
 290:	3b0b3a08 	blcc	2ceab8 <__end+0x17fab8>
 294:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 298:	15000017 	strne	r0, [r0, #-23]
 29c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2a0:	0b3a0e03 	bleq	e83ab4 <__user_program+0xb83ab4>
 2a4:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 2a8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2ac:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 2b0:	00130119 	andseq	r0, r3, r9, lsl r1
 2b4:	82891600 	addhi	r1, r9, #0, 12
 2b8:	01110001 	tsteq	r1, r1
 2bc:	00001331 	andeq	r1, r0, r1, lsr r3
 2c0:	3f012e17 	svccc	0x00012e17
 2c4:	3a0e0319 	bcc	380f30 <__user_program+0x80f30>
 2c8:	110b3b0b 	tstne	fp, fp, lsl #22
 2cc:	40061201 	andmi	r1, r6, r1, lsl #4
 2d0:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 2d4:	00001301 	andeq	r1, r0, r1, lsl #6
 2d8:	03003418 	movweq	r3, #1048	; 0x418
 2dc:	3b0b3a0e 	blcc	2ceb1c <__end+0x17fb1c>
 2e0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 2e4:	19000017 	stmdbne	r0, {r0, r1, r2, r4}
 2e8:	0111010b 	tsteq	r1, fp, lsl #2
 2ec:	13010612 	movwne	r0, #5650	; 0x1612
 2f0:	891a0000 	ldmdbhi	sl, {}	; <UNPREDICTABLE>
 2f4:	11010182 	smlabbne	r1, r2, r1, r0
 2f8:	01133101 	tsteq	r3, r1, lsl #2
 2fc:	1b000013 	blne	350 <__start-0x7cb0>
 300:	0001828a 	andeq	r8, r1, sl, lsl #5
 304:	42911802 	addsmi	r1, r1, #131072	; 0x20000
 308:	1c000018 	stcne	0, cr0, [r0], {24}
 30c:	01018289 	smlabbeq	r1, r9, r2, r8
 310:	13310111 	teqne	r1, #1073741828	; 0x40000004
 314:	0b1d0000 	bleq	74031c <__user_program+0x44031c>
 318:	01175501 	tsteq	r7, r1, lsl #10
 31c:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
 320:	0111010b 	tsteq	r1, fp, lsl #2
 324:	00000612 	andeq	r0, r0, r2, lsl r6
 328:	3f012e1f 	svccc	0x00012e1f
 32c:	3a0e0319 	bcc	380f98 <__user_program+0x80f98>
 330:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 334:	11134919 	tstne	r3, r9, lsl r9
 338:	40061201 	andmi	r1, r6, r1, lsl #4
 33c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 340:	00001301 	andeq	r1, r0, r1, lsl #6
 344:	03000520 	movweq	r0, #1312	; 0x520
 348:	3b0b3a0e 	blcc	2ceb88 <__end+0x17fb88>
 34c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 350:	21000017 	tstcs	r0, r7, lsl r0
 354:	0b0b000f 	bleq	2c0398 <__end+0x171398>
 358:	34220000 	strtcc	r0, [r2], #-0
 35c:	3a0e0300 	bcc	380f64 <__user_program+0x80f64>
 360:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 364:	02193f13 	andseq	r3, r9, #19, 30	; 0x4c
 368:	23000018 	movwcs	r0, #24
 36c:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 370:	0b3a0e03 	bleq	e83b84 <__user_program+0xb83b84>
 374:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 378:	0000193c 	andeq	r1, r0, ip, lsr r9
 37c:	3f012e24 	svccc	0x00012e24
 380:	3a0e0319 	bcc	380fec <__user_program+0x80fec>
 384:	3c0b3b0b 	stccc	11, cr3, [fp], {11}
 388:	00130119 	andseq	r0, r3, r9, lsl r1
 38c:	00182500 	andseq	r2, r8, r0, lsl #10
 390:	2e260000 	cdpcs	0, 2, cr0, cr6, cr0, {0}
 394:	03193f01 	tsteq	r9, #1, 30
 398:	3b0b3a0e 	blcc	2cebd8 <__end+0x17fbd8>
 39c:	3c13490b 	ldccc	9, cr4, [r3], {11}
 3a0:	00130119 	andseq	r0, r3, r9, lsl r1
 3a4:	012e2700 	teqeq	lr, r0, lsl #14
 3a8:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 3ac:	0b3b0b3a 	bleq	ec309c <__user_program+0xbc309c>
 3b0:	13491927 	movtne	r1, #39207	; 0x9927
 3b4:	1301193c 	movwne	r1, #6460	; 0x193c
 3b8:	05280000 	streq	r0, [r8, #-0]!
 3bc:	00134900 	andseq	r4, r3, r0, lsl #18
 3c0:	00262900 	eoreq	r2, r6, r0, lsl #18
 3c4:	00001349 	andeq	r1, r0, r9, asr #6
 3c8:	3f012e2a 	svccc	0x00012e2a
 3cc:	3a0e0319 	bcc	381038 <__user_program+0x81038>
 3d0:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 3d4:	01193c19 	tsteq	r9, r9, lsl ip
 3d8:	2b000013 	blcs	42c <__start-0x7bd4>
 3dc:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 3e0:	0b3a0e03 	bleq	e83bf4 <__user_program+0xb83bf4>
 3e4:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 3e8:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 3ec:	152c0000 	strne	r0, [ip, #-0]!
 3f0:	01192701 	tsteq	r9, r1, lsl #14
 3f4:	2d000013 	stccs	0, cr0, [r0, #-76]	; 0xffffffb4
 3f8:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 3fc:	0b3a0e03 	bleq	e83c10 <__user_program+0xb83c10>
 400:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
 404:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 408:	01000000 	mrseq	r0, (UNDEF: 0)
 40c:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 410:	0e030b13 	vmoveq.32	d3[0], r0
 414:	01110e1b 	tsteq	r1, fp, lsl lr
 418:	17100612 			; <UNDEFINED> instruction: 0x17100612
 41c:	16020000 	strne	r0, [r2], -r0
 420:	3a0e0300 	bcc	381028 <__user_program+0x81028>
 424:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 428:	03000013 	movweq	r0, #19
 42c:	0b0b0024 	bleq	2c04c4 <__end+0x1714c4>
 430:	0e030b3e 	vmoveq.16	d3[0], r0
 434:	24040000 	strcs	r0, [r4], #-0
 438:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 43c:	0008030b 	andeq	r0, r8, fp, lsl #6
 440:	01130500 	tsteq	r3, r0, lsl #10
 444:	0b0b0e03 	bleq	2c3c58 <__end+0x174c58>
 448:	0b3b0b3a 	bleq	ec3138 <__user_program+0xbc3138>
 44c:	00001301 	andeq	r1, r0, r1, lsl #6
 450:	03000d06 	movweq	r0, #3334	; 0xd06
 454:	3813490e 	ldmdacc	r3, {r1, r2, r3, r8, fp, lr}
 458:	0019340b 	andseq	r3, r9, fp, lsl #8
 45c:	000f0700 	andeq	r0, pc, r0, lsl #14
 460:	00000b0b 	andeq	r0, r0, fp, lsl #22
 464:	03012e08 	movweq	r2, #7688	; 0x1e08
 468:	3b0b3a0e 	blcc	2ceca8 <__end+0x17fca8>
 46c:	1119270b 	tstne	r9, fp, lsl #14
 470:	40061201 	andmi	r1, r6, r1, lsl #4
 474:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 478:	00001301 	andeq	r1, r0, r1, lsl #6
 47c:	03000509 	movweq	r0, #1289	; 0x509
 480:	3b0b3a0e 	blcc	2cecc0 <__end+0x17fcc0>
 484:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 488:	0a000017 	beq	4ec <__start-0x7b14>
 48c:	08030005 	stmdaeq	r3, {r0, r2}
 490:	0b3b0b3a 	bleq	ec3180 <__user_program+0xbc3180>
 494:	17021349 	strne	r1, [r2, -r9, asr #6]
 498:	340b0000 	strcc	r0, [fp], #-0
 49c:	3a0e0300 	bcc	3810a4 <__user_program+0x810a4>
 4a0:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4a4:	00170213 	andseq	r0, r7, r3, lsl r2
 4a8:	00340c00 	eorseq	r0, r4, r0, lsl #24
 4ac:	0b3a0803 	bleq	e824c0 <__user_program+0xb824c0>
 4b0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 4b4:	00001802 	andeq	r1, r0, r2, lsl #16
 4b8:	0300340d 	movweq	r3, #1037	; 0x40d
 4bc:	3b0b3a08 	blcc	2cece4 <__end+0x17fce4>
 4c0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 4c4:	0e000017 	mcreq	0, 0, r0, cr0, cr7, {0}
 4c8:	00018289 	andeq	r8, r1, r9, lsl #5
 4cc:	13310111 	teqne	r1, #1073741828	; 0x40000004
 4d0:	0f0f0000 	svceq	0x000f0000
 4d4:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 4d8:	10000013 	andne	r0, r0, r3, lsl r0
 4dc:	13490101 	movtne	r0, #37121	; 0x9101
 4e0:	00001301 	andeq	r1, r0, r1, lsl #6
 4e4:	49002111 	stmdbmi	r0, {r0, r4, r8, sp}
 4e8:	000b2f13 	andeq	r2, fp, r3, lsl pc
 4ec:	012e1200 	teqeq	lr, r0, lsl #4
 4f0:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 4f4:	0b3b0b3a 	bleq	ec31e4 <__user_program+0xbc31e4>
 4f8:	13491927 	movtne	r1, #39207	; 0x9927
 4fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 500:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 504:	00130119 	andseq	r0, r3, r9, lsl r1
 508:	00181300 	andseq	r1, r8, r0, lsl #6
 50c:	34140000 	ldrcc	r0, [r4], #-0
 510:	3a0e0300 	bcc	381118 <__user_program+0x81118>
 514:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 518:	00180213 	andseq	r0, r8, r3, lsl r2
 51c:	010b1500 	tsteq	fp, r0, lsl #10
 520:	13011755 	movwne	r1, #5973	; 0x1755
 524:	89160000 	ldmdbhi	r6, {}	; <UNPREDICTABLE>
 528:	11010182 	smlabbne	r1, r2, r1, r0
 52c:	00133101 	andseq	r3, r3, r1, lsl #2
 530:	828a1700 	addhi	r1, sl, #0, 14
 534:	18020001 	stmdane	r2, {r0}
 538:	00184291 	mulseq	r8, r1, r2
 53c:	010b1800 	tsteq	fp, r0, lsl #16
 540:	06120111 			; <UNDEFINED> instruction: 0x06120111
 544:	00001301 	andeq	r1, r0, r1, lsl #6
 548:	01828919 	orreq	r8, r2, r9, lsl r9
 54c:	31011101 	tstcc	r1, r1, lsl #2
 550:	00130113 	andseq	r0, r3, r3, lsl r1
 554:	00261a00 	eoreq	r1, r6, r0, lsl #20
 558:	00001349 	andeq	r1, r0, r9, asr #6
 55c:	3f012e1b 	svccc	0x00012e1b
 560:	3a0e0319 	bcc	3811cc <__user_program+0x811cc>
 564:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 568:	00193c19 	andseq	r3, r9, r9, lsl ip
 56c:	00051c00 	andeq	r1, r5, r0, lsl #24
 570:	00001349 	andeq	r1, r0, r9, asr #6
 574:	01110100 	tsteq	r1, r0, lsl #2
 578:	0b130e25 	bleq	4c3e14 <__user_program+0x1c3e14>
 57c:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 580:	06120111 			; <UNDEFINED> instruction: 0x06120111
 584:	00001710 	andeq	r1, r0, r0, lsl r7
 588:	0b002402 	bleq	9598 <syscall_scheduler_start+0x60>
 58c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 590:	0300000e 	movweq	r0, #14
 594:	0b0b0024 	bleq	2c062c <__end+0x17162c>
 598:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 59c:	16040000 	strne	r0, [r4], -r0
 5a0:	3a0e0300 	bcc	3811a8 <__user_program+0x811a8>
 5a4:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5a8:	05000013 	streq	r0, [r0, #-19]
 5ac:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5b0:	0b3a0e03 	bleq	e83dc4 <__user_program+0xb83dc4>
 5b4:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 5b8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 5bc:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 5c0:	00130119 	andseq	r0, r3, r9, lsl r1
 5c4:	82890600 	addhi	r0, r9, #0, 12
 5c8:	01110101 	tsteq	r1, r1, lsl #2
 5cc:	13011331 	movwne	r1, #4913	; 0x1331
 5d0:	8a070000 	bhi	1c05d8 <__end+0x715d8>
 5d4:	02000182 	andeq	r0, r0, #-2147483616	; 0x80000020
 5d8:	18429118 	stmdane	r2, {r3, r4, r8, ip, pc}^
 5dc:	89080000 	stmdbhi	r8, {}	; <UNPREDICTABLE>
 5e0:	11010182 	smlabbne	r1, r2, r1, r0
 5e4:	00133101 	andseq	r3, r3, r1, lsl #2
 5e8:	002e0900 	eoreq	r0, lr, r0, lsl #18
 5ec:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 5f0:	0b3b0b3a 	bleq	ec32e0 <__user_program+0xbc32e0>
 5f4:	01111927 	tsteq	r1, r7, lsr #18
 5f8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 5fc:	00194297 	mulseq	r9, r7, r2
 600:	00050a00 	andeq	r0, r5, r0, lsl #20
 604:	0b3a0e03 	bleq	e83e18 <__user_program+0xb83e18>
 608:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 60c:	00001802 	andeq	r1, r0, r2, lsl #16
 610:	3f002e0b 	svccc	0x00002e0b
 614:	3a0e0319 	bcc	381280 <__user_program+0x81280>
 618:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 61c:	11134919 	tstne	r3, r9, lsl r9
 620:	40061201 	andmi	r1, r6, r1, lsl #4
 624:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 628:	2e0c0000 	cdpcs	0, 0, cr0, cr12, cr0, {0}
 62c:	03193f01 	tsteq	r9, #1, 30
 630:	3b0b3a0e 	blcc	2cee70 <__end+0x17fe70>
 634:	3c19270b 	ldccc	7, cr2, [r9], {11}
 638:	00130119 	andseq	r0, r3, r9, lsl r1
 63c:	00050d00 	andeq	r0, r5, r0, lsl #26
 640:	00001349 	andeq	r1, r0, r9, asr #6
 644:	3f012e0e 	svccc	0x00012e0e
 648:	3a0e0319 	bcc	3812b4 <__user_program+0x812b4>
 64c:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 650:	00193c19 	andseq	r3, r9, r9, lsl ip
 654:	11010000 	mrsne	r0, (UNDEF: 1)
 658:	130e2501 	movwne	r2, #58625	; 0xe501
 65c:	1b0e030b 	blne	381290 <__user_program+0x81290>
 660:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 664:	00171006 	andseq	r1, r7, r6
 668:	00240200 	eoreq	r0, r4, r0, lsl #4
 66c:	0b3e0b0b 	bleq	f832a0 <__user_program+0xc832a0>
 670:	00000e03 	andeq	r0, r0, r3, lsl #28
 674:	0b002403 	bleq	9688 <write_cpsr+0x4>
 678:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 67c:	04000008 	streq	r0, [r0], #-8
 680:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 684:	0b3b0b3a 	bleq	ec3374 <__user_program+0xbc3374>
 688:	00001349 	andeq	r1, r0, r9, asr #6
 68c:	3f012e05 	svccc	0x00012e05
 690:	3a0e0319 	bcc	3812fc <__user_program+0x812fc>
 694:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 698:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 69c:	97184006 	ldrls	r4, [r8, -r6]
 6a0:	13011942 	movwne	r1, #6466	; 0x1942
 6a4:	05060000 	streq	r0, [r6, #-0]
 6a8:	3a0e0300 	bcc	3812b0 <__user_program+0x812b0>
 6ac:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6b0:	00170213 	andseq	r0, r7, r3, lsl r2
 6b4:	00050700 	andeq	r0, r5, r0, lsl #14
 6b8:	0b3a0803 	bleq	e826cc <__user_program+0xb826cc>
 6bc:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 6c0:	00001702 	andeq	r1, r0, r2, lsl #14
 6c4:	01828908 	orreq	r8, r2, r8, lsl #18
 6c8:	31011101 	tstcc	r1, r1, lsl #2
 6cc:	00130113 	andseq	r0, r3, r3, lsl r1
 6d0:	828a0900 	addhi	r0, sl, #0, 18
 6d4:	18020001 	stmdane	r2, {r0}
 6d8:	00184291 	mulseq	r8, r1, r2
 6dc:	82890a00 	addhi	r0, r9, #0, 20
 6e0:	01110101 	tsteq	r1, r1, lsl #2
 6e4:	00001331 	andeq	r1, r0, r1, lsr r3
 6e8:	3f002e0b 	svccc	0x00002e0b
 6ec:	3a0e0319 	bcc	381358 <__user_program+0x81358>
 6f0:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 6f4:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 6f8:	97184006 	ldrls	r4, [r8, -r6]
 6fc:	00001942 	andeq	r1, r0, r2, asr #18
 700:	3f012e0c 	svccc	0x00012e0c
 704:	3a0e0319 	bcc	381370 <__user_program+0x81370>
 708:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 70c:	11134919 	tstne	r3, r9, lsl r9
 710:	40061201 	andmi	r1, r6, r1, lsl #4
 714:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 718:	00001301 	andeq	r1, r0, r1, lsl #6
 71c:	3f012e0d 	svccc	0x00012e0d
 720:	3a0e0319 	bcc	38138c <__user_program+0x8138c>
 724:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 728:	00193c19 	andseq	r3, r9, r9, lsl ip
 72c:	00050e00 	andeq	r0, r5, r0, lsl #28
 730:	00001349 	andeq	r1, r0, r9, asr #6
 734:	01110100 	tsteq	r1, r0, lsl #2
 738:	0b130e25 	bleq	4c3fd4 <__user_program+0x1c3fd4>
 73c:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 740:	06120111 			; <UNDEFINED> instruction: 0x06120111
 744:	00001710 	andeq	r1, r0, r0, lsl r7
 748:	0b002402 	bleq	9758 <irq_asm_handler+0x8>
 74c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 750:	0300000e 	movweq	r0, #14
 754:	0b0b0024 	bleq	2c07ec <__end+0x1717ec>
 758:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 75c:	16040000 	strne	r0, [r4], -r0
 760:	3a0e0300 	bcc	381368 <__user_program+0x81368>
 764:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 768:	05000013 	streq	r0, [r0, #-19]
 76c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 770:	0b3a0e03 	bleq	e83f84 <__user_program+0xb83f84>
 774:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 778:	06120111 			; <UNDEFINED> instruction: 0x06120111
 77c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 780:	00130119 	andseq	r0, r3, r9, lsl r1
 784:	00050600 	andeq	r0, r5, r0, lsl #12
 788:	0b3a0e03 	bleq	e83f9c <__user_program+0xb83f9c>
 78c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 790:	00001702 	andeq	r1, r0, r2, lsl #14
 794:	3f002e07 	svccc	0x00002e07
 798:	3a0e0319 	bcc	381404 <__user_program+0x81404>
 79c:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 7a0:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 7a4:	97184006 	ldrls	r4, [r8, -r6]
 7a8:	00001942 	andeq	r1, r0, r2, asr #18
 7ac:	3f002e08 	svccc	0x00002e08
 7b0:	3a0e0319 	bcc	38141c <__user_program+0x8141c>
 7b4:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 7b8:	11134919 	tstne	r3, r9, lsl r9
 7bc:	40061201 	andmi	r1, r6, r1, lsl #4
 7c0:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 7c4:	01000000 	mrseq	r0, (UNDEF: 0)
 7c8:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 7cc:	0e030b13 	vmoveq.32	d3[0], r0
 7d0:	01110e1b 	tsteq	r1, fp, lsl lr
 7d4:	17100612 			; <UNDEFINED> instruction: 0x17100612
 7d8:	24020000 	strcs	r0, [r2], #-0
 7dc:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 7e0:	000e030b 	andeq	r0, lr, fp, lsl #6
 7e4:	00240300 	eoreq	r0, r4, r0, lsl #6
 7e8:	0b3e0b0b 	bleq	f8341c <__user_program+0xc8341c>
 7ec:	00000803 	andeq	r0, r0, r3, lsl #16
 7f0:	03001604 	movweq	r1, #1540	; 0x604
 7f4:	3b0b3a0e 	blcc	2cf034 <__end+0x180034>
 7f8:	0013490b 	andseq	r4, r3, fp, lsl #18
 7fc:	012e0500 	teqeq	lr, r0, lsl #10
 800:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 804:	0b3b0b3a 	bleq	ec34f4 <__user_program+0xbc34f4>
 808:	01111927 	tsteq	r1, r7, lsr #18
 80c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 810:	01194297 			; <UNDEFINED> instruction: 0x01194297
 814:	06000013 			; <UNDEFINED> instruction: 0x06000013
 818:	01018289 	smlabbeq	r1, r9, r2, r8
 81c:	13310111 	teqne	r1, #1073741828	; 0x40000004
 820:	00001301 	andeq	r1, r0, r1, lsl #6
 824:	01828a07 	orreq	r8, r2, r7, lsl #20
 828:	91180200 	tstls	r8, r0, lsl #4
 82c:	00001842 	andeq	r1, r0, r2, asr #16
 830:	01828908 	orreq	r8, r2, r8, lsl #18
 834:	31011101 	tstcc	r1, r1, lsl #2
 838:	09000013 	stmdbeq	r0, {r0, r1, r4}
 83c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 840:	0b3a0e03 	bleq	e84054 <__user_program+0xb84054>
 844:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 848:	01111349 	tsteq	r1, r9, asr #6
 84c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 850:	01194297 			; <UNDEFINED> instruction: 0x01194297
 854:	0a000013 	beq	8a8 <__start-0x7758>
 858:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 85c:	0b3b0b3a 	bleq	ec354c <__user_program+0xbc354c>
 860:	17021349 	strne	r1, [r2, -r9, asr #6]
 864:	340b0000 	strcc	r0, [fp], #-0
 868:	3a0e0300 	bcc	381470 <__user_program+0x81470>
 86c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 870:	00170213 	andseq	r0, r7, r3, lsl r2
 874:	00340c00 	eorseq	r0, r4, r0, lsl #24
 878:	0b3a0e03 	bleq	e8408c <__user_program+0xb8408c>
 87c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 880:	00001802 	andeq	r1, r0, r2, lsl #16
 884:	0182890d 	orreq	r8, r2, sp, lsl #18
 888:	31011100 	mrscc	r1, (UNDEF: 17)
 88c:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 890:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 894:	0b3a0e03 	bleq	e840a8 <__user_program+0xb840a8>
 898:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 89c:	1301193c 	movwne	r1, #6460	; 0x193c
 8a0:	050f0000 	streq	r0, [pc, #-0]	; 8a8 <__start-0x7758>
 8a4:	00134900 	andseq	r4, r3, r0, lsl #18
 8a8:	002e1000 	eoreq	r1, lr, r0
 8ac:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 8b0:	0b3b0b3a 	bleq	ec35a0 <__user_program+0xbc35a0>
 8b4:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
 8b8:	2e110000 	cdpcs	0, 1, cr0, cr1, cr0, {0}
 8bc:	03193f01 	tsteq	r9, #1, 30
 8c0:	3b0b3a0e 	blcc	2cf100 <__end+0x180100>
 8c4:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
 8c8:	01193c13 	tsteq	r9, r3, lsl ip
 8cc:	00000013 	andeq	r0, r0, r3, lsl r0
 8d0:	25011101 	strcs	r1, [r1, #-257]	; 0x101
 8d4:	030b130e 	movweq	r1, #45838	; 0xb30e
 8d8:	110e1b0e 	tstne	lr, lr, lsl #22
 8dc:	10061201 	andne	r1, r6, r1, lsl #4
 8e0:	02000017 	andeq	r0, r0, #23
 8e4:	0b0b0024 	bleq	2c097c <__end+0x17197c>
 8e8:	0e030b3e 	vmoveq.16	d3[0], r0
 8ec:	24030000 	strcs	r0, [r3], #-0
 8f0:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 8f4:	0008030b 	andeq	r0, r8, fp, lsl #6
 8f8:	00160400 	andseq	r0, r6, r0, lsl #8
 8fc:	0b3a0e03 	bleq	e84110 <__user_program+0xb84110>
 900:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 904:	13050000 	movwne	r0, #20480	; 0x5000
 908:	0b0e0301 	bleq	381514 <__user_program+0x81514>
 90c:	3b0b3a0b 	blcc	2cf140 <__end+0x180140>
 910:	0013010b 	andseq	r0, r3, fp, lsl #2
 914:	000d0600 	andeq	r0, sp, r0, lsl #12
 918:	0b3a0e03 	bleq	e8412c <__user_program+0xb8412c>
 91c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 920:	00000b38 	andeq	r0, r0, r8, lsr fp
 924:	49003507 	stmdbmi	r0, {r0, r1, r2, r8, sl, ip, sp}
 928:	08000013 	stmdaeq	r0, {r0, r1, r4}
 92c:	0b0b000f 	bleq	2c0970 <__end+0x171970>
 930:	00001349 	andeq	r1, r0, r9, asr #6
 934:	27001509 	strcs	r1, [r0, -r9, lsl #10]
 938:	0a000019 	beq	9a4 <__start-0x765c>
 93c:	0b0b0104 	bleq	2c0d54 <__end+0x171d54>
 940:	0b3b0b3a 	bleq	ec3630 <__user_program+0xbc3630>
 944:	00001301 	andeq	r1, r0, r1, lsl #6
 948:	0300280b 	movweq	r2, #2059	; 0x80b
 94c:	000d1c0e 	andeq	r1, sp, lr, lsl #24
 950:	01010c00 	tsteq	r1, r0, lsl #24
 954:	13011349 	movwne	r1, #4937	; 0x1349
 958:	210d0000 	mrscs	r0, (UNDEF: 13)
 95c:	2f134900 	svccs	0x00134900
 960:	0e00000b 	cdpeq	0, 0, cr0, cr0, cr11, {0}
 964:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 968:	0b3a050b 	bleq	e81d9c <__user_program+0xb81d9c>
 96c:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 970:	0d0f0000 	stceq	0, cr0, [pc, #-0]	; 978 <__start-0x7688>
 974:	3a080300 	bcc	20157c <__end+0xb257c>
 978:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 97c:	000b3813 	andeq	r3, fp, r3, lsl r8
 980:	000d1000 	andeq	r1, sp, r0
 984:	0b3a0e03 	bleq	e84198 <__user_program+0xb84198>
 988:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 98c:	00000538 	andeq	r0, r0, r8, lsr r5
 990:	49002111 	stmdbmi	r0, {r0, r4, r8, sp}
 994:	00052f13 	andeq	r2, r5, r3, lsl pc
 998:	00161200 	andseq	r1, r6, r0, lsl #4
 99c:	0b3a0803 	bleq	e829b0 <__user_program+0xb829b0>
 9a0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 9a4:	2e130000 	cdpcs	0, 1, cr0, cr3, cr0, {0}
 9a8:	03193f01 	tsteq	r9, #1, 30
 9ac:	3b0b3a08 	blcc	2cf1d4 <__end+0x1801d4>
 9b0:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
 9b4:	010b2013 	tsteq	fp, r3, lsl r0
 9b8:	14000013 	strne	r0, [r0], #-19
 9bc:	08030005 	stmdaeq	r3, {r0, r2}
 9c0:	0b3b0b3a 	bleq	ec36b0 <__user_program+0xbc36b0>
 9c4:	00001349 	andeq	r1, r0, r9, asr #6
 9c8:	31012e15 	tstcc	r1, r5, lsl lr
 9cc:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 9d0:	97184006 	ldrls	r4, [r8, -r6]
 9d4:	13011942 	movwne	r1, #6466	; 0x1942
 9d8:	05160000 	ldreq	r0, [r6, #-0]
 9dc:	02133100 	andseq	r3, r3, #0, 2
 9e0:	17000017 	smladne	r0, r7, r0, r0
 9e4:	13310005 	teqne	r1, #5
 9e8:	00001802 	andeq	r1, r0, r2, lsl #16
 9ec:	3f012e18 	svccc	0x00012e18
 9f0:	3a0e0319 	bcc	38165c <__user_program+0x8165c>
 9f4:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 9f8:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 9fc:	97184006 	ldrls	r4, [r8, -r6]
 a00:	13011942 	movwne	r1, #6466	; 0x1942
 a04:	05190000 	ldreq	r0, [r9, #-0]
 a08:	3a0e0300 	bcc	381610 <__user_program+0x81610>
 a0c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 a10:	00170213 	andseq	r0, r7, r3, lsl r2
 a14:	82891a00 	addhi	r1, r9, #0, 20
 a18:	01110101 	tsteq	r1, r1, lsl #2
 a1c:	13011331 	movwne	r1, #4913	; 0x1331
 a20:	8a1b0000 	bhi	6c0a28 <__user_program+0x3c0a28>
 a24:	02000182 	andeq	r0, r0, #-2147483616	; 0x80000020
 a28:	18429118 	stmdane	r2, {r3, r4, r8, ip, pc}^
 a2c:	891c0000 	ldmdbhi	ip, {}	; <UNPREDICTABLE>
 a30:	11000182 	smlabbne	r0, r2, r1, r0
 a34:	00133101 	andseq	r3, r3, r1, lsl #2
 a38:	012e1d00 	teqeq	lr, r0, lsl #26
 a3c:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 a40:	0b3b0b3a 	bleq	ec3730 <__user_program+0xbc3730>
 a44:	13491927 	movtne	r1, #39207	; 0x9927
 a48:	06120111 			; <UNDEFINED> instruction: 0x06120111
 a4c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 a50:	00130119 	andseq	r0, r3, r9, lsl r1
 a54:	00051e00 	andeq	r1, r5, r0, lsl #28
 a58:	0b3a0803 	bleq	e82a6c <__user_program+0xb82a6c>
 a5c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 a60:	00001702 	andeq	r1, r0, r2, lsl #14
 a64:	0300341f 	movweq	r3, #1055	; 0x41f
 a68:	3b0b3a0e 	blcc	2cf2a8 <__end+0x1802a8>
 a6c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 a70:	20000017 	andcs	r0, r0, r7, lsl r0
 a74:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 a78:	0b3b0b3a 	bleq	ec3768 <__user_program+0xbc3768>
 a7c:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 a80:	05210000 	streq	r0, [r1, #-0]!
 a84:	3a080300 	bcc	20168c <__end+0xb268c>
 a88:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 a8c:	00180213 	andseq	r0, r8, r3, lsl r2
 a90:	01152200 	tsteq	r5, r0, lsl #4
 a94:	13011927 	movwne	r1, #6439	; 0x1927
 a98:	05230000 	streq	r0, [r3, #-0]!
 a9c:	00134900 	andseq	r4, r3, r0, lsl #18
 aa0:	002e2400 	eoreq	r2, lr, r0, lsl #8
 aa4:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 aa8:	0b3b0b3a 	bleq	ec3798 <__user_program+0xbc3798>
 aac:	01111349 	tsteq	r1, r9, asr #6
 ab0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 ab4:	00194297 	mulseq	r9, r7, r2
 ab8:	00342500 	eorseq	r2, r4, r0, lsl #10
 abc:	0b3a0e03 	bleq	e842d0 <__user_program+0xb842d0>
 ac0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 ac4:	34260000 	strtcc	r0, [r6], #-0
 ac8:	3a0e0300 	bcc	3816d0 <__user_program+0x816d0>
 acc:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 ad0:	27000013 	smladcs	r0, r3, r0, r0
 ad4:	1331011d 	teqne	r1, #1073741831	; 0x40000007
 ad8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 adc:	05590b58 	ldrbeq	r0, [r9, #-2904]	; 0xb58
 ae0:	00001301 	andeq	r1, r0, r1, lsl #6
 ae4:	3f012e28 	svccc	0x00012e28
 ae8:	3a0e0319 	bcc	381754 <__user_program+0x81754>
 aec:	27053b0b 	strcs	r3, [r5, -fp, lsl #22]
 af0:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 af4:	97184006 	ldrls	r4, [r8, -r6]
 af8:	13011942 	movwne	r1, #6466	; 0x1942
 afc:	05290000 	streq	r0, [r9, #-0]!
 b00:	3a0e0300 	bcc	381708 <__user_program+0x81708>
 b04:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 b08:	00170213 	andseq	r0, r7, r3, lsl r2
 b0c:	00342a00 	eorseq	r2, r4, r0, lsl #20
 b10:	0b3a0e03 	bleq	e84324 <__user_program+0xb84324>
 b14:	1349053b 	movtne	r0, #38203	; 0x953b
 b18:	00001702 	andeq	r1, r0, r2, lsl #14
 b1c:	0300342b 	movweq	r3, #1067	; 0x42b
 b20:	3b0b3a08 	blcc	2cf348 <__end+0x180348>
 b24:	02134905 	andseq	r4, r3, #81920	; 0x14000
 b28:	2c000017 	stccs	0, cr0, [r0], {23}
 b2c:	0111010b 	tsteq	r1, fp, lsl #2
 b30:	13010612 	movwne	r0, #5650	; 0x1612
 b34:	892d0000 	pushhi	{}	; <UNPREDICTABLE>
 b38:	11010182 	smlabbne	r1, r2, r1, r0
 b3c:	00133101 	andseq	r3, r3, r1, lsl #2
 b40:	002e2e00 	eoreq	r2, lr, r0, lsl #28
 b44:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 b48:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 b4c:	13491927 	movtne	r1, #39207	; 0x9927
 b50:	06120111 			; <UNDEFINED> instruction: 0x06120111
 b54:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 b58:	2f000019 	svccs	0x00000019
 b5c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 b60:	0b3a0e03 	bleq	e84374 <__user_program+0xb84374>
 b64:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
 b68:	01111349 	tsteq	r1, r9, asr #6
 b6c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 b70:	01194296 			; <UNDEFINED> instruction: 0x01194296
 b74:	30000013 	andcc	r0, r0, r3, lsl r0
 b78:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 b7c:	0b3a0e03 	bleq	e84390 <__user_program+0xb84390>
 b80:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
 b84:	01111349 	tsteq	r1, r9, asr #6
 b88:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 b8c:	01194297 			; <UNDEFINED> instruction: 0x01194297
 b90:	31000013 	tstcc	r0, r3, lsl r0
 b94:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 b98:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 b9c:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 ba0:	0000193c 	andeq	r1, r0, ip, lsr r9
 ba4:	03003432 	movweq	r3, #1074	; 0x432
 ba8:	3b0b3a0e 	blcc	2cf3e8 <__end+0x1803e8>
 bac:	02134905 	andseq	r4, r3, #81920	; 0x14000
 bb0:	33000018 	movwcc	r0, #24
 bb4:	0b0b000f 	bleq	2c0bf8 <__end+0x171bf8>
 bb8:	05340000 	ldreq	r0, [r4, #-0]!
 bbc:	3a080300 	bcc	2017c4 <__end+0xb27c4>
 bc0:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 bc4:	00180213 	andseq	r0, r8, r3, lsl r2
 bc8:	00343500 	eorseq	r3, r4, r0, lsl #10
 bcc:	0b3a0e03 	bleq	e843e0 <__user_program+0xb843e0>
 bd0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 bd4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 bd8:	34360000 	ldrtcc	r0, [r6], #-0
 bdc:	3a080300 	bcc	2017e4 <__end+0xb27e4>
 be0:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 be4:	02193f13 	andseq	r3, r9, #19, 30	; 0x4c
 be8:	37000018 	smladcc	r0, r8, r0, r0
 bec:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 bf0:	0b3b0b3a 	bleq	ec38e0 <__user_program+0xbc38e0>
 bf4:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 bf8:	0000193c 	andeq	r1, r0, ip, lsr r9
 bfc:	3f012e38 	svccc	0x00012e38
 c00:	3a0e0319 	bcc	38186c <__user_program+0x8186c>
 c04:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 c08:	3c134919 	ldccc	9, cr4, [r3], {25}
 c0c:	00130119 	andseq	r0, r3, r9, lsl r1
 c10:	00183900 	andseq	r3, r8, r0, lsl #18
 c14:	263a0000 	ldrtcs	r0, [sl], -r0
 c18:	00134900 	andseq	r4, r3, r0, lsl #18
 c1c:	002e3b00 	eoreq	r3, lr, r0, lsl #22
 c20:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 c24:	0b3b0b3a 	bleq	ec3914 <__user_program+0xbc3914>
 c28:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
 c2c:	2e3c0000 	cdpcs	0, 3, cr0, cr12, cr0, {0}
 c30:	03193f01 	tsteq	r9, #1, 30
 c34:	3b0b3a0e 	blcc	2cf474 <__end+0x180474>
 c38:	3c19270b 	ldccc	7, cr2, [r9], {11}
 c3c:	00130119 	andseq	r0, r3, r9, lsl r1
 c40:	002e3d00 	eoreq	r3, lr, r0, lsl #26
 c44:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 c48:	0b3b0b3a 	bleq	ec3938 <__user_program+0xbc3938>
 c4c:	13491927 	movtne	r1, #39207	; 0x9927
 c50:	0000193c 	andeq	r1, r0, ip, lsr r9
 c54:	3f012e3e 	svccc	0x00012e3e
 c58:	3a0e0319 	bcc	3818c4 <__user_program+0x818c4>
 c5c:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 c60:	00193c19 	andseq	r3, r9, r9, lsl ip
 c64:	11010000 	mrsne	r0, (UNDEF: 1)
 c68:	11061000 	mrsne	r1, (UNDEF: 6)
 c6c:	03011201 	movweq	r1, #4609	; 0x1201
 c70:	25081b08 	strcs	r1, [r8, #-2824]	; 0xb08
 c74:	00051308 	andeq	r1, r5, r8, lsl #6
 c78:	11010000 	mrsne	r0, (UNDEF: 1)
 c7c:	11061000 	mrsne	r1, (UNDEF: 6)
 c80:	03011201 	movweq	r1, #4609	; 0x1201
 c84:	25081b08 	strcs	r1, [r8, #-2824]	; 0xb08
 c88:	00051308 	andeq	r1, r5, r8, lsl #6
 c8c:	11010000 	mrsne	r0, (UNDEF: 1)
 c90:	11061000 	mrsne	r1, (UNDEF: 6)
 c94:	03011201 	movweq	r1, #4609	; 0x1201
 c98:	25081b08 	strcs	r1, [r8, #-2824]	; 0xb08
 c9c:	00051308 	andeq	r1, r5, r8, lsl #6
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	00008054 	andeq	r8, r0, r4, asr r0
  14:	00000060 	andeq	r0, r0, r0, rrx
	...
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	01790002 	cmneq	r9, r2
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	000080b4 	strheq	r8, [r0], -r4
  34:	00000160 	andeq	r0, r0, r0, ror #2
	...
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
  44:	032e0002 	teqeq	lr, #2
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	00008214 	andeq	r8, r0, r4, lsl r2
  54:	0000069c 	muleq	r0, ip, r6
	...
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	0b8f0002 	bleq	fe3c0074 <__user_program+0xfe0c0074>
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	000088b0 			; <UNDEFINED> instruction: 0x000088b0
  74:	00000298 	muleq	r0, r8, r2
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0e830002 	cdpeq	0, 8, cr0, cr3, cr2, {0}
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008b48 	andeq	r8, r0, r8, asr #22
  94:	000000d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	0fe70002 	svceq	0x00e70002
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008c18 	andeq	r8, r0, r8, lsl ip
  b4:	00000118 	andeq	r0, r0, r8, lsl r1
	...
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	11930002 	orrsne	r0, r3, r2
  c8:	00040000 	andeq	r0, r4, r0
  cc:	00000000 	andeq	r0, r0, r0
  d0:	00008d30 	andeq	r8, r0, r0, lsr sp
  d4:	0000008c 	andeq	r0, r0, ip, lsl #1
	...
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	12580002 	subsne	r0, r8, #2
  e8:	00040000 	andeq	r0, r4, r0
  ec:	00000000 	andeq	r0, r0, r0
  f0:	00008dbc 			; <UNDEFINED> instruction: 0x00008dbc
  f4:	00000070 	andeq	r0, r0, r0, ror r0
	...
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	13e80002 	mvnne	r0, #2
 108:	00040000 	andeq	r0, r4, r0
 10c:	00000000 	andeq	r0, r0, r0
 110:	00008e2c 	andeq	r8, r0, ip, lsr #28
 114:	00000844 	andeq	r0, r0, r4, asr #16
	...
 120:	0000001c 	andeq	r0, r0, ip, lsl r0
 124:	1d5e0002 	ldclne	0, cr0, [lr, #-8]
 128:	00040000 	andeq	r0, r4, r0
 12c:	00000000 	andeq	r0, r0, r0
 130:	00008000 	andeq	r8, r0, r0
 134:	00000054 	andeq	r0, r0, r4, asr r0
	...
 140:	0000001c 	andeq	r0, r0, ip, lsl r0
 144:	1dba0002 	ldcne	0, cr0, [sl, #8]!
 148:	00040000 	andeq	r0, r4, r0
 14c:	00000000 	andeq	r0, r0, r0
 150:	00009670 	andeq	r9, r0, r0, ror r6
 154:	00000044 	andeq	r0, r0, r4, asr #32
	...
 160:	0000001c 	andeq	r0, r0, ip, lsl r0
 164:	1e150002 	cdpne	0, 1, cr0, cr5, cr2, {0}
 168:	00040000 	andeq	r0, r4, r0
 16c:	00000000 	andeq	r0, r0, r0
 170:	000096b4 			; <UNDEFINED> instruction: 0x000096b4
 174:	00000144 	andeq	r0, r0, r4, asr #2
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000006f 	andeq	r0, r0, pc, rrx
   4:	00500002 	subseq	r0, r0, r2
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	33010000 	movwcc	r0, #4096	; 0x1000
  1c:	696c3934 	stmdbvs	ip!, {r2, r4, r5, r8, fp, ip, sp}^
  20:	732f6b62 	teqvc	pc, #100352	; 0x18800
  24:	33006372 	movwcc	r6, #882	; 0x372
  28:	696c3934 	stmdbvs	ip!, {r2, r4, r5, r8, fp, ip, sp}^
  2c:	692f6b62 	stmdbvs	pc!, {r1, r5, r6, r8, r9, fp, sp, lr}	; <UNPREDICTABLE>
  30:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
  34:	00006564 	andeq	r6, r0, r4, ror #10
  38:	7364656c 	cmnvc	r4, #108, 10	; 0x1b000000
  3c:	0100632e 	tsteq	r0, lr, lsr #6
  40:	70670000 	rsbvc	r0, r7, r0
  44:	682e6f69 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}
  48:	00000200 	andeq	r0, r0, r0, lsl #4
  4c:	6474736b 	ldrbtvs	r7, [r4], #-875	; 0x36b
  50:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
  54:	00020068 	andeq	r0, r2, r8, rrx
  58:	05000000 	streq	r0, [r0, #-0]
  5c:	00805402 	addeq	r5, r0, r2, lsl #8
  60:	01160300 	tsteq	r6, r0, lsl #6
  64:	2f86672f 	svccs	0x0086672f
  68:	2f6a2f6a 	svccs	0x006a2f6a
  6c:	06022f6a 	streq	r2, [r2], -sl, ror #30
  70:	82010100 	andhi	r0, r1, #0, 2
  74:	02000000 	andeq	r0, r0, #0
  78:	00004f00 	andeq	r4, r0, r0, lsl #30
  7c:	fb010200 	blx	40886 <__bss_end+0x12886>
  80:	01000d0e 	tsteq	r0, lr, lsl #26
  84:	00010101 	andeq	r0, r1, r1, lsl #2
  88:	00010000 	andeq	r0, r1, r0
  8c:	34330100 	ldrtcc	r0, [r3], #-256	; 0x100
  90:	62696c39 	rsbvs	r6, r9, #14592	; 0x3900
  94:	72732f6b 	rsbsvc	r2, r3, #428	; 0x1ac
  98:	34330063 	ldrtcc	r0, [r3], #-99	; 0x63
  9c:	62696c39 	rsbvs	r6, r9, #14592	; 0x3900
  a0:	6e692f6b 	cdpvs	15, 6, cr2, cr9, cr11, {3}
  a4:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
  a8:	67000065 	strvs	r0, [r0, -r5, rrx]
  ac:	2e6f6970 	mcrcs	9, 3, r6, cr15, cr0, {3}
  b0:	00010063 	andeq	r0, r1, r3, rrx
  b4:	74736b00 	ldrbtvc	r6, [r3], #-2816	; 0xb00
  b8:	746e6964 	strbtvc	r6, [lr], #-2404	; 0x964
  bc:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
  c0:	72610000 	rsbvc	r0, r1, #0
  c4:	00682e6d 	rsbeq	r2, r8, sp, ror #28
  c8:	00000002 	andeq	r0, r0, r2
  cc:	b4020500 	strlt	r0, [r2], #-1280	; 0x500
  d0:	03000080 	movweq	r0, #128	; 0x80
  d4:	130100d1 	movwne	r0, #4305	; 0x10d1
  d8:	8384a06a 	orrhi	sl, r4, #106	; 0x6a
  dc:	134e2f4b 	movtne	r2, #61259	; 0xef4b
  e0:	bfd84b4d 	svclt	0x00d84b4d
  e4:	d84b4d13 	stmdale	fp, {r0, r1, r4, r8, sl, fp, lr}^
  e8:	4f6513bf 	svcmi	0x006513bf
  ec:	bb4b4b67 	bllt	12d2e90 <__user_program+0xfd2e90>
  f0:	4b9f684b 	blmi	fe7da224 <__user_program+0xfe4da224>
  f4:	01000602 	tsteq	r0, r2, lsl #12
  f8:	0001ae01 	andeq	sl, r1, r1, lsl #28
  fc:	be000200 	cdplt	2, 0, cr0, cr0, cr0, {0}
 100:	02000000 	andeq	r0, r0, #0
 104:	0d0efb01 	vstreq	d15, [lr, #-4]
 108:	01010100 	mrseq	r0, (UNDEF: 17)
 10c:	00000001 	andeq	r0, r0, r1
 110:	01000001 	tsteq	r0, r1
 114:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 118:	732f6c65 	teqvc	pc, #25856	; 0x6500
 11c:	33006372 	movwcc	r6, #882	; 0x372
 120:	696c3934 	stmdbvs	ip!, {r2, r4, r5, r8, fp, ip, sp}^
 124:	692f6b62 	stmdbvs	pc!, {r1, r5, r6, r8, r9, fp, sp, lr}	; <UNPREDICTABLE>
 128:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 12c:	6b006564 	blvs	196c4 <tcb_array+0xc6c0>
 130:	656e7265 	strbvs	r7, [lr, #-613]!	; 0x265
 134:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 138:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 13c:	6b000065 	blvs	2d8 <__start-0x7d28>
 140:	656e7265 	strbvs	r7, [lr, #-613]!	; 0x265
 144:	00632e6c 	rsbeq	r2, r3, ip, ror #28
 148:	6b000001 	blvs	154 <__start-0x7eac>
 14c:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 150:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 154:	00000200 	andeq	r0, r0, r0, lsl #4
 158:	6574756d 	ldrbvs	r7, [r4, #-1389]!	; 0x56d
 15c:	79745f78 	ldmdbvc	r4!, {r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 160:	682e6570 	stmdavs	lr!, {r4, r5, r6, r8, sl, sp, lr}
 164:	00000300 	andeq	r0, r0, r0, lsl #6
 168:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 16c:	736c6c61 	cmnvc	ip, #24832	; 0x6100
 170:	0300682e 	movweq	r6, #2094	; 0x82e
 174:	61750000 	cmnvs	r5, r0
 178:	682e7472 	stmdavs	lr!, {r1, r4, r5, r6, sl, ip, sp, lr}
 17c:	00000300 	andeq	r0, r0, r0, lsl #6
 180:	5f636461 	svcpl	0x00636461
 184:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 188:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 18c:	00000300 	andeq	r0, r0, r0, lsl #6
 190:	2e6d7261 	cdpcs	2, 6, cr7, cr13, cr1, {3}
 194:	00020068 	andeq	r0, r2, r8, rrx
 198:	6d697400 	cfstrdvs	mvd7, [r9, #-0]
 19c:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 1a0:	00000300 	andeq	r0, r0, r0, lsl #6
 1a4:	65707573 	ldrbvs	r7, [r0, #-1395]!	; 0x573
 1a8:	73697672 	cmnvc	r9, #119537664	; 0x7200000
 1ac:	682e726f 	stmdavs	lr!, {r0, r1, r2, r3, r5, r6, r9, ip, sp, lr}
 1b0:	00000300 	andeq	r0, r0, r0, lsl #6
 1b4:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
 1b8:	682e6b74 	stmdavs	lr!, {r2, r4, r5, r6, r8, r9, fp, sp, lr}
 1bc:	00000300 	andeq	r0, r0, r0, lsl #6
 1c0:	02050000 	andeq	r0, r5, #0
 1c4:	00008214 	andeq	r8, r0, r4, lsl r2
 1c8:	30012d03 	andcc	r2, r1, r3, lsl #26
 1cc:	02004c30 	andeq	r4, r0, #48, 24	; 0x3000
 1d0:	009c0304 	addseq	r0, ip, r4, lsl #6
 1d4:	30030402 	andcc	r0, r3, r2, lsl #8
 1d8:	03040200 	movweq	r0, #16896	; 0x4200
 1dc:	2f336c62 	svccs	0x00336c62
 1e0:	312f2f2f 	teqcc	pc, pc, lsr #30
 1e4:	0a03302f 	beq	cc2a8 <__bss_end+0x9e2a8>
 1e8:	bc9f304a 	ldclt	0, cr3, [pc], {74}	; 0x4a
 1ec:	4d672108 	stfmie	f2, [r7, #-32]!	; 0xffffffe0
 1f0:	040200db 	streq	r0, [r2], #-219	; 0xdb
 1f4:	02008301 	andeq	r8, r0, #67108864	; 0x4000000
 1f8:	4cb90104 	ldfmis	f0, [r9], #16
 1fc:	d7bb4c9d 			; <UNDEFINED> instruction: 0xd7bb4c9d
 200:	30f32fbb 	ldrhtcc	r2, [r3], #251	; 0xfb
 204:	9f9f89a5 	svcls	0x009f89a5
 208:	0200839f 	andeq	r8, r0, #2080374786	; 0x7c000002
 20c:	74030204 	strvc	r0, [r3], #-516	; 0x204
 210:	6613032e 	ldrvs	r0, [r3], -lr, lsr #6
 214:	bba06b9f 	bllt	fe81b098 <__user_program+0xfe51b098>
 218:	bb9f8669 	bllt	fe7e1bc4 <__user_program+0xfe4e1bc4>
 21c:	69672fbc 	stmdbvs	r7!, {r2, r3, r4, r5, r7, r8, r9, sl, fp, sp}^
 220:	4a7fb503 	bmi	1fed634 <__user_program+0x1ced634>
 224:	512e2003 	teqpl	lr, r3
 228:	4b2f4b83 	blmi	bd303c <__user_program+0x8d303c>
 22c:	304a2e03 	subcc	r2, sl, r3, lsl #28
 230:	002f32d5 	ldrdeq	r3, [pc], -r5	; <UNPREDICTABLE>
 234:	06030402 	streq	r0, [r3], -r2, lsl #8
 238:	0402009e 	streq	r0, [r2], #-158	; 0x9e
 23c:	069d0603 	ldreq	r0, [sp], r3, lsl #12
 240:	00330682 	eorseq	r0, r3, r2, lsl #13
 244:	06030402 	streq	r0, [r3], -r2, lsl #8
 248:	0402009e 	streq	r0, [r2], #-158	; 0x9e
 24c:	6b810603 	blvs	fe041a60 <__user_program+0xfdd41a60>
 250:	2e0903bc 	mcrcs	3, 0, r0, cr9, cr12, {5}
 254:	2ff5bf30 	svccs	0x00f5bf30
 258:	03040200 	movweq	r0, #16896	; 0x4200
 25c:	02009e06 	andeq	r9, r0, #6, 28	; 0x60
 260:	81060304 	tsthi	r6, r4, lsl #6
 264:	33069e06 	movwcc	r9, #28166	; 0x6e06
 268:	03040200 	movweq	r0, #16896	; 0x4200
 26c:	02009e06 	andeq	r9, r0, #6, 28	; 0x60
 270:	9d060304 	stcls	3, cr0, [r6, #-16]
 274:	4a0a036c 	bmi	28102c <__end+0x13202c>
 278:	9f30674b 	svcls	0x0030674b
 27c:	67a12fa0 	strvs	r2, [r1, r0, lsr #31]!
 280:	032f682f 	teqeq	pc, #3080192	; 0x2f0000
 284:	02672e0b 	rsbeq	r2, r7, #11, 28	; 0xb0
 288:	a068142a 	rsbge	r1, r8, sl, lsr #8
 28c:	a0688468 	rsbge	r8, r8, r8, ror #8
 290:	4a2103a0 	bmi	841118 <__user_program+0x541118>
 294:	302e6003 	eorcc	r6, lr, r3
 298:	f5874ca1 			; <UNDEFINED> instruction: 0xf5874ca1
 29c:	4b4c4b84 	blmi	13130b4 <__user_program+0x10130b4>
 2a0:	4c4c2f4c 	mcrrmi	15, 4, r2, ip, cr12
 2a4:	04022f4e 	streq	r2, [r2], #-3918	; 0xf4e
 2a8:	e0010100 	and	r0, r1, r0, lsl #2
 2ac:	02000000 	andeq	r0, r0, #0
 2b0:	00007b00 	andeq	r7, r0, r0, lsl #22
 2b4:	fb010200 	blx	40abe <__bss_end+0x12abe>
 2b8:	01000d0e 	tsteq	r0, lr, lsl #26
 2bc:	00010101 	andeq	r0, r1, r1, lsl #2
 2c0:	00010000 	andeq	r0, r1, r0
 2c4:	656b0100 	strbvs	r0, [fp, #-256]!	; 0x100
 2c8:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 2cc:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 2d0:	39343300 	ldmdbcc	r4!, {r8, r9, ip, sp}
 2d4:	6b62696c 	blvs	189a88c <__user_program+0x159a88c>
 2d8:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 2dc:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 2e0:	72656b00 	rsbvc	r6, r5, #0, 22
 2e4:	2f6c656e 	svccs	0x006c656e
 2e8:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 2ec:	00656475 	rsbeq	r6, r5, r5, ror r4
 2f0:	69727000 	ldmdbvs	r2!, {ip, sp, lr}^
 2f4:	2e6b746e 	cdpcs	4, 6, cr7, cr11, cr14, {3}
 2f8:	00010063 	andeq	r0, r1, r3, rrx
 2fc:	74736b00 	ldrbtvc	r6, [r3], #-2816	; 0xb00
 300:	746e6964 	strbtvc	r6, [lr], #-2404	; 0x964
 304:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 308:	736b0000 	cmnvc	fp, #0
 30c:	72616474 	rsbvc	r6, r1, #116, 8	; 0x74000000
 310:	00682e67 	rsbeq	r2, r8, r7, ror #28
 314:	3c000002 	stccc	0, cr0, [r0], {2}
 318:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 31c:	6e692d74 	mcrvs	13, 3, r2, cr9, cr4, {3}
 320:	0000003e 	andeq	r0, r0, lr, lsr r0
 324:	72617500 	rsbvc	r7, r1, #0, 10
 328:	00682e74 	rsbeq	r2, r8, r4, ror lr
 32c:	00000003 	andeq	r0, r0, r3
 330:	b0020500 	andlt	r0, r2, r0, lsl #10
 334:	03000088 	movweq	r0, #136	; 0x88
 338:	4d880120 	stfmis	f0, [r8, #128]	; 0x80
 33c:	0402009c 	streq	r0, [r2], #-156	; 0x9c
 340:	02004c01 	andeq	r4, r0, #256	; 0x100
 344:	00330104 	eorseq	r0, r3, r4, lsl #2
 348:	08010402 	stmdaeq	r1, {r1, sl}
 34c:	04020059 	streq	r0, [r2], #-89	; 0x59
 350:	4b4dd701 	blmi	1375f5c <__user_program+0x1075f5c>
 354:	872d9b6a 	strhi	r9, [sp, -sl, ror #22]!
 358:	854d6949 	strbhi	r6, [sp, #-2377]	; 0x949
 35c:	514a2003 	cmppl	sl, r3
 360:	302e5c03 	eorcc	r5, lr, r3, lsl #24
 364:	02324b4b 	eorseq	r4, r2, #76800	; 0x12c00
 368:	4b83152c 	blmi	fe0c5820 <__user_program+0xfddc5820>
 36c:	67a4a04b 	strvs	sl, [r4, fp, asr #32]!
 370:	83673283 	cmnhi	r7, #805306376	; 0x30000008
 374:	32836733 	addcc	r6, r3, #13369344	; 0xcc0000
 378:	8a2d6783 	bhi	b5a18c <__user_program+0x85a18c>
 37c:	4b324b67 	blmi	c93120 <__user_program+0x993120>
 380:	bf034d33 	svclt	0x00034d33
 384:	c6032e7f 			; <UNDEFINED> instruction: 0xc6032e7f
 388:	08026600 	stmdaeq	r2, {r9, sl, sp, lr}
 38c:	84010100 	strhi	r0, [r1], #-256	; 0x100
 390:	02000000 	andeq	r0, r0, #0
 394:	00004f00 	andeq	r4, r0, r0, lsl #30
 398:	fb010200 	blx	40ba2 <__bss_end+0x12ba2>
 39c:	01000d0e 	tsteq	r0, lr, lsl #26
 3a0:	00010101 	andeq	r0, r1, r1, lsl #2
 3a4:	00010000 	andeq	r0, r1, r0
 3a8:	656b0100 	strbvs	r0, [fp, #-256]!	; 0x100
 3ac:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 3b0:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 3b4:	39343300 	ldmdbcc	r4!, {r8, r9, ip, sp}
 3b8:	6b62696c 	blvs	189a970 <__user_program+0x159a970>
 3bc:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 3c0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 3c4:	61750000 	cmnvs	r5, r0
 3c8:	632e7472 	teqvs	lr, #1912602624	; 0x72000000
 3cc:	00000100 	andeq	r0, r0, r0, lsl #2
 3d0:	6474736b 	ldrbtvs	r7, [r4], #-875	; 0x36b
 3d4:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
 3d8:	00020068 	andeq	r0, r2, r8, rrx
 3dc:	69706700 	ldmdbvs	r0!, {r8, r9, sl, sp, lr}^
 3e0:	00682e6f 	rsbeq	r2, r8, pc, ror #28
 3e4:	00000002 	andeq	r0, r0, r2
 3e8:	48020500 	stmdami	r2, {r8, sl}
 3ec:	0300008b 	movweq	r0, #139	; 0x8b
 3f0:	a1300134 	teqge	r0, r4, lsr r1
 3f4:	4d694d4d 	stclmi	13, cr4, [r9, #-308]!	; 0xfffffecc
 3f8:	86676967 	strbthi	r6, [r7], -r7, ror #18
 3fc:	0014a214 	andseq	sl, r4, r4, lsl r2
 400:	06010402 	streq	r0, [r1], -r2, lsl #8
 404:	8667064a 	strbthi	r0, [r7], -sl, asr #12
 408:	04020014 	streq	r0, [r2], #-20
 40c:	064a0601 	strbeq	r0, [sl], -r1, lsl #12
 410:	04026767 	streq	r6, [r2], #-1895	; 0x767
 414:	87010100 	strhi	r0, [r1, -r0, lsl #2]
 418:	02000000 	andeq	r0, r0, #0
 41c:	00004e00 	andeq	r4, r0, r0, lsl #28
 420:	fb010200 	blx	40c2a <__bss_end+0x12c2a>
 424:	01000d0e 	tsteq	r0, lr, lsl #26
 428:	00010101 	andeq	r0, r1, r1, lsl #2
 42c:	00010000 	andeq	r0, r1, r0
 430:	656b0100 	strbvs	r0, [fp, #-256]!	; 0x100
 434:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 438:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 43c:	39343300 	ldmdbcc	r4!, {r8, r9, ip, sp}
 440:	6b62696c 	blvs	189a9f8 <__user_program+0x159a9f8>
 444:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 448:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 44c:	70730000 	rsbsvc	r0, r3, r0
 450:	00632e69 	rsbeq	r2, r3, r9, ror #28
 454:	6b000001 	blvs	460 <__start-0x7ba0>
 458:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 45c:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 460:	00000200 	andeq	r0, r0, r0, lsl #4
 464:	6f697067 	svcvs	0x00697067
 468:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 46c:	00000000 	andeq	r0, r0, r0
 470:	8c180205 	lfmhi	f0, 4, [r8], {5}
 474:	25030000 	strcs	r0, [r3, #-0]
 478:	67676701 	strbvs	r6, [r7, -r1, lsl #14]!
 47c:	85696767 	strbhi	r6, [r9, #-1895]!	; 0x767
 480:	134e694d 	movtne	r6, #59725	; 0xe94d
 484:	be14869f 	mrclt	6, 0, r8, cr4, cr15, {4}
 488:	0014bd14 	andseq	fp, r4, r4, lsl sp
 48c:	06010402 	streq	r0, [r1], -r2, lsl #8
 490:	a167064a 	cmnge	r7, sl, asr #12
 494:	01040200 	mrseq	r0, R12_usr
 498:	67064a06 	strvs	r4, [r6, -r6, lsl #20]
 49c:	00040267 	andeq	r0, r4, r7, ror #4
 4a0:	00670101 	rsbeq	r0, r7, r1, lsl #2
 4a4:	00020000 	andeq	r0, r2, r0
 4a8:	00000046 	andeq	r0, r0, r6, asr #32
 4ac:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 4b0:	0101000d 	tsteq	r1, sp
 4b4:	00000101 	andeq	r0, r0, r1, lsl #2
 4b8:	00000100 	andeq	r0, r0, r0, lsl #2
 4bc:	72656b01 	rsbvc	r6, r5, #1024	; 0x400
 4c0:	2f6c656e 	svccs	0x006c656e
 4c4:	00637273 	rsbeq	r7, r3, r3, ror r2
 4c8:	6c393433 	cfldrsvs	mvf3, [r9], #-204	; 0xffffff34
 4cc:	2f6b6269 	svccs	0x006b6269
 4d0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 4d4:	00656475 	rsbeq	r6, r5, r5, ror r4
 4d8:	6d697400 	cfstrdvs	mvd7, [r9, #-0]
 4dc:	632e7265 	teqvs	lr, #1342177286	; 0x50000006
 4e0:	00000100 	andeq	r0, r0, r0, lsl #2
 4e4:	6474736b 	ldrbtvs	r7, [r4], #-875	; 0x36b
 4e8:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
 4ec:	00020068 	andeq	r0, r2, r8, rrx
 4f0:	05000000 	streq	r0, [r0, #-0]
 4f4:	008d3002 	addeq	r3, sp, r2
 4f8:	01300300 	teqeq	r0, r0, lsl #6
 4fc:	6969854c 	stmdbvs	r9!, {r2, r3, r6, r8, sl, pc}^
 500:	868514a1 	strhi	r1, [r5], r1, lsr #9
 504:	134d6713 	movtne	r6, #55059	; 0xd713
 508:	01000a02 	tsteq	r0, r2, lsl #20
 50c:	00008201 	andeq	r8, r0, r1, lsl #4
 510:	63000200 	movwvs	r0, #512	; 0x200
 514:	02000000 	andeq	r0, r0, #0
 518:	0d0efb01 	vstreq	d15, [lr, #-4]
 51c:	01010100 	mrseq	r0, (UNDEF: 17)
 520:	00000001 	andeq	r0, r0, r1
 524:	01000001 	tsteq	r0, r1
 528:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 52c:	732f6c65 	teqvc	pc, #25856	; 0x6500
 530:	33006372 	movwcc	r6, #882	; 0x372
 534:	696c3934 	stmdbvs	ip!, {r2, r4, r5, r8, fp, ip, sp}^
 538:	692f6b62 	stmdbvs	pc!, {r1, r5, r6, r8, r9, fp, sp, lr}	; <UNPREDICTABLE>
 53c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 540:	6b006564 	blvs	19ad8 <tcb_array+0xcad4>
 544:	656e7265 	strbvs	r7, [lr, #-613]!	; 0x265
 548:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 54c:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 550:	61000065 	tstvs	r0, r5, rrx
 554:	645f6364 	ldrbvs	r6, [pc], #-868	; 55c <__start-0x7aa4>
 558:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0x972
 55c:	00632e72 	rsbeq	r2, r3, r2, ror lr
 560:	6b000001 	blvs	56c <__start-0x7a94>
 564:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 568:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 56c:	00000200 	andeq	r0, r0, r0, lsl #4
 570:	2e697073 	mcrcs	0, 3, r7, cr9, cr3, {3}
 574:	00030068 	andeq	r0, r3, r8, rrx
 578:	05000000 	streq	r0, [r0, #-0]
 57c:	008dbc02 	addeq	fp, sp, r2, lsl #24
 580:	01160300 	tsteq	r6, r0, lsl #6
 584:	3285672f 	addcc	r6, r5, #12320768	; 0xbc0000
 588:	83318467 	teqhi	r1, #1728053248	; 0x67000000
 58c:	04023185 	streq	r3, [r2], #-389	; 0x185
 590:	ee010100 	adfs	f0, f1, f0
 594:	02000001 	andeq	r0, r0, #1
 598:	0000a000 	andeq	sl, r0, r0
 59c:	fb010200 	blx	40da6 <__bss_end+0x12da6>
 5a0:	01000d0e 	tsteq	r0, lr, lsl #26
 5a4:	00010101 	andeq	r0, r1, r1, lsl #2
 5a8:	00010000 	andeq	r0, r1, r0
 5ac:	656b0100 	strbvs	r0, [fp, #-256]!	; 0x100
 5b0:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 5b4:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 5b8:	39343300 	ldmdbcc	r4!, {r8, r9, ip, sp}
 5bc:	6b62696c 	blvs	189ab74 <__user_program+0x159ab74>
 5c0:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 5c4:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 5c8:	72656b00 	rsbvc	r6, r5, #0, 22
 5cc:	2f6c656e 	svccs	0x006c656e
 5d0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 5d4:	00656475 	rsbeq	r6, r5, r5, ror r4
 5d8:	73797300 	cmnvc	r9, #0, 6
 5dc:	6c6c6163 	stfvse	f6, [ip], #-396	; 0xfffffe74
 5e0:	00632e73 	rsbeq	r2, r3, r3, ror lr
 5e4:	6b000001 	blvs	5f0 <__start-0x7a10>
 5e8:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 5ec:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 5f0:	00000200 	andeq	r0, r0, r0, lsl #4
 5f4:	6574756d 	ldrbvs	r7, [r4, #-1389]!	; 0x56d
 5f8:	79745f78 	ldmdbvc	r4!, {r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 5fc:	682e6570 	stmdavs	lr!, {r4, r5, r6, r8, sl, sp, lr}
 600:	00000300 	andeq	r0, r0, r0, lsl #6
 604:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 608:	736c6c61 	cmnvc	ip, #24832	; 0x6100
 60c:	0300682e 	movweq	r6, #2094	; 0x82e
 610:	72610000 	rsbvc	r0, r1, #0
 614:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 618:	70000002 	andvc	r0, r0, r2
 61c:	746e6972 	strbtvc	r6, [lr], #-2418	; 0x972
 620:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 624:	75000003 	strvc	r0, [r0, #-3]
 628:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
 62c:	00030068 	andeq	r0, r3, r8, rrx
 630:	6d697400 	cfstrdvs	mvd7, [r9, #-0]
 634:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 638:	00000300 	andeq	r0, r0, r0, lsl #6
 63c:	02050000 	andeq	r0, r5, #0
 640:	00008e2c 	andeq	r8, r0, ip, lsr #28
 644:	0100c003 	tsteq	r0, r3
 648:	674b6814 	smlaldvs	r6, fp, r4, r8
 64c:	00154e2f 	andseq	r4, r5, pc, lsr #28
 650:	4d010402 	cfstrsmi	mvf0, [r1, #-8]
 654:	3421084b 	strtcc	r0, [r1], #-2123	; 0x84b
 658:	032e7a03 	teqeq	lr, #12288	; 0x3000
 65c:	02004a78 	andeq	r4, r0, #120, 20	; 0x78000
 660:	09030204 	stmdbeq	r3, {r2, r9}
 664:	04020082 	streq	r0, [r2], #-130	; 0x82
 668:	66064702 	strvs	r4, [r6], -r2, lsl #14
 66c:	2d2f3506 	cfstr32cs	mvfx3, [pc, #-24]!	; 65c <__start-0x79a4>
 670:	034a7703 	movteq	r7, #42755	; 0xa703
 674:	46164a15 			; <UNDEFINED> instruction: 0x46164a15
 678:	9e090335 	mcrls	3, 0, r0, cr9, cr5, {1}
 67c:	4a77032f 	bmi	1dc1340 <__user_program+0x1ac1340>
 680:	4b684c30 	blmi	1a13748 <__user_program+0x1713748>
 684:	676a2f2f 	strbvs	r2, [sl, -pc, lsr #30]!
 688:	2f4d672f 	svccs	0x004d672f
 68c:	2e6a032f 	cdpcs	3, 6, cr0, cr10, cr15, {1}
 690:	03821903 	orreq	r1, r2, #49152	; 0xc000
 694:	1c034a65 	stcne	10, cr4, [r3], {101}	; 0x65
 698:	4d14682e 	ldcmi	8, cr6, [r4, #-184]	; 0xffffff48
 69c:	65135014 	ldrvs	r5, [r3, #-20]
 6a0:	4b2f834d 	blmi	be13dc <__user_program+0x8e13dc>
 6a4:	2f4b4b2f 	svccs	0x004b4b2f
 6a8:	684c4c2f 	stmdavs	ip, {r0, r1, r2, r3, r5, sl, fp, lr}^
 6ac:	03688331 	cmneq	r8, #-1006632960	; 0xc4000000
 6b0:	1a032e6b 	bne	cc064 <__bss_end+0x9e064>
 6b4:	92083066 	andls	r3, r8, #102	; 0x66
 6b8:	2f2f2fd7 	svccs	0x002f2fd7
 6bc:	332f4b4b 	teqcc	pc, #76800	; 0x12c00
 6c0:	32494c2f 	subcc	r4, r9, #12032	; 0x2f00
 6c4:	03a0684c 	moveq	r6, #76, 16	; 0x4c0000
 6c8:	1a032e67 	bne	cc06c <__bss_end+0x9e06c>
 6cc:	2e12032e 	cdpcs	3, 1, cr0, cr2, cr14, {1}
 6d0:	4c2ff413 	cfstrsmi	mvf15, [pc], #-76	; 68c <__start-0x7974>
 6d4:	1003342a 	andne	r3, r3, sl, lsr #8
 6d8:	c0304f2e 	eorsgt	r4, r0, lr, lsr #30
 6dc:	ba7ebd03 	blt	1fafaf0 <__user_program+0x1cafaf0>
 6e0:	4a01c603 	bmi	71ef4 <__bss_end+0x43ef4>
 6e4:	bb67bd6b 	bllt	19efc98 <__user_program+0x16efc98>
 6e8:	0b034b4e 	bleq	d3428 <__bss_end+0xa5428>
 6ec:	67499f2e 	strbvs	r9, [r9, -lr, lsr #30]
 6f0:	03a0344d 	moveq	r3, #1291845632	; 0x4d000000
 6f4:	30504a0f 	subscc	r4, r0, pc, lsl #20
 6f8:	67f34dbd 			; <UNDEFINED> instruction: 0x67f34dbd
 6fc:	ba09034e 	blt	24143c <__end+0xf243c>
 700:	bb2ff74b 	bllt	bfe434 <__user_program+0x8fe434>
 704:	652f4b2f 	strvs	r4, [pc, #-2863]!	; fffffbdd <__user_program+0xffcffbdd>
 708:	332b652f 	teqcc	fp, #197132288	; 0xbc00000
 70c:	032d4630 	teqeq	sp, #48, 12	; 0x3000000
 710:	83bb6614 			; <UNDEFINED> instruction: 0x83bb6614
 714:	01040200 	mrseq	r0, R12_usr
 718:	67064a06 	strvs	r4, [r6, -r6, lsl #20]
 71c:	034b4b33 	movteq	r4, #47923	; 0xbb33
 720:	0f032e77 	svceq	0x00032e77
 724:	6650034a 	ldrbvs	r0, [r0], -sl, asr #6
 728:	a42e3103 	strtge	r3, [lr], #-259	; 0x103
 72c:	a352c04b 	cmpge	r2, #75	; 0x4b
 730:	01040200 	mrseq	r0, R12_usr
 734:	02003d08 	andeq	r3, r0, #8, 26	; 0x200
 738:	4cb90104 	ldfmis	f0, [r9], #16
 73c:	03a067bf 	moveq	r6, #50069504	; 0x2fc0000
 740:	03674a45 	cmneq	r7, #282624	; 0x45000
 744:	1b036623 	blne	d9fd8 <__bss_end+0xabfd8>
 748:	67f330d6 	ubfxvs	r3, r6, #1, #20
 74c:	0021084c 	eoreq	r0, r1, ip, asr #16
 750:	06010402 	streq	r0, [r1], -r2, lsl #8
 754:	30670682 	rsbcc	r0, r7, r2, lsl #13
 758:	854c4b13 	strbhi	r4, [ip, #-2835]	; 0xb13
 75c:	00d72f31 	sbcseq	r2, r7, r1, lsr pc
 760:	08020402 	stmdaeq	r2, {r1, sl}
 764:	77088872 	smlsdxvc	r8, r2, r8, r8
 768:	0402002f 	streq	r0, [r2], #-47	; 0x2f
 76c:	6c314c01 	ldcvs	12, cr4, [r1], #-4
 770:	67a18417 			; <UNDEFINED> instruction: 0x67a18417
 774:	34296788 	strtcc	r6, [r9], #-1928	; 0x788
 778:	144c1430 	strbne	r1, [ip], #-1072	; 0x430
 77c:	144c144c 	strbne	r1, [ip], #-1100	; 0x44c
 780:	01000402 	tsteq	r0, r2, lsl #8
 784:	00005401 	andeq	r5, r0, r1, lsl #8
 788:	29000200 	stmdbcs	r0, {r9}
 78c:	02000000 	andeq	r0, r0, #0
 790:	0d0efb01 	vstreq	d15, [lr, #-4]
 794:	01010100 	mrseq	r0, (UNDEF: 17)
 798:	00000001 	andeq	r0, r0, r1
 79c:	01000001 	tsteq	r0, r1
 7a0:	6c393433 	cfldrsvs	mvf3, [r9], #-204	; 0xffffff34
 7a4:	2f6b6269 	svccs	0x006b6269
 7a8:	00637273 	rsbeq	r7, r3, r3, ror r2
 7ac:	6f6f6200 	svcvs	0x006f6200
 7b0:	00532e74 	subseq	r2, r3, r4, ror lr
 7b4:	00000001 	andeq	r0, r0, r1
 7b8:	00020500 	andeq	r0, r2, r0, lsl #10
 7bc:	03000080 	movweq	r0, #128	; 0x80
 7c0:	2f2f011b 	svccs	0x002f011b
 7c4:	2f2f302f 	svccs	0x002f302f
 7c8:	2f2f2f2f 	svccs	0x002f2f2f
 7cc:	312f2f31 	teqcc	pc, r1, lsr pc	; <UNPREDICTABLE>
 7d0:	69032f33 	stmdbvs	r3, {r0, r1, r4, r5, r8, r9, sl, fp, sp}
 7d4:	2f2f312e 	svccs	0x002f312e
 7d8:	01000202 	tsteq	r0, r2, lsl #4
 7dc:	00004d01 	andeq	r4, r0, r1, lsl #26
 7e0:	28000200 	stmdacs	r0, {r9}
 7e4:	02000000 	andeq	r0, r0, #0
 7e8:	0d0efb01 	vstreq	d15, [lr, #-4]
 7ec:	01010100 	mrseq	r0, (UNDEF: 17)
 7f0:	00000001 	andeq	r0, r0, r1
 7f4:	01000001 	tsteq	r0, r1
 7f8:	6c393433 	cfldrsvs	mvf3, [r9], #-204	; 0xffffff34
 7fc:	2f6b6269 	svccs	0x006b6269
 800:	00637273 	rsbeq	r7, r3, r3, ror r2
 804:	6d726100 	ldfvse	f6, [r2, #-0]
 808:	0100532e 	tsteq	r0, lr, lsr #6
 80c:	00000000 	andeq	r0, r0, r0
 810:	96700205 	ldrbtls	r0, [r0], -r5, lsl #4
 814:	10030000 	andne	r0, r3, r0
 818:	332f2f01 	teqcc	pc, #1, 30
 81c:	332f332f 	teqcc	pc, #-1140850688	; 0xbc000000
 820:	2f2f2f2f 	svccs	0x002f2f2f
 824:	2f2f2f33 	svccs	0x002f2f33
 828:	0002022f 	andeq	r0, r2, pc, lsr #4
 82c:	00980101 	addseq	r0, r8, r1, lsl #2
 830:	00020000 	andeq	r0, r2, r0
 834:	0000002e 	andeq	r0, r0, lr, lsr #32
 838:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 83c:	0101000d 	tsteq	r1, sp
 840:	00000101 	andeq	r0, r0, r1, lsl #2
 844:	00000100 	andeq	r0, r0, r0, lsl #2
 848:	72656b01 	rsbvc	r6, r5, #1024	; 0x400
 84c:	2f6c656e 	svccs	0x006c656e
 850:	00637273 	rsbeq	r7, r3, r3, ror r2
 854:	70757300 	rsbsvc	r7, r5, r0, lsl #6
 858:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 85c:	2e726f73 	mrccs	15, 3, r6, cr2, cr3, {3}
 860:	00010053 	andeq	r0, r1, r3, asr r0
 864:	05000000 	streq	r0, [r0, #-0]
 868:	0096b402 	addseq	fp, r6, r2, lsl #8
 86c:	01180300 	tsteq	r8, r0, lsl #6
 870:	2f2f2f2f 	svccs	0x002f2f2f
 874:	032f2f2f 	teqeq	pc, #47, 30	; 0xbc
 878:	2f2ff216 	svccs	0x002ff216
 87c:	2f302f30 	svccs	0x00302f30
 880:	30352f30 	eorscc	r2, r5, r0, lsr pc
 884:	302f2f30 	eorcc	r2, pc, r0, lsr pc	; <UNPREDICTABLE>
 888:	302f2f30 	eorcc	r2, pc, r0, lsr pc	; <UNPREDICTABLE>
 88c:	302f312f 	eorcc	r3, pc, pc, lsr #2
 890:	3131322f 	teqcc	r1, pc, lsr #4
 894:	31322f2f 	teqcc	r2, pc, lsr #30
 898:	2f322f2f 	svccs	0x00322f2f
 89c:	30303031 	eorscc	r3, r0, r1, lsr r0
 8a0:	2f322f31 	svccs	0x00322f31
 8a4:	302f322f 	eorcc	r3, pc, pc, lsr #4
 8a8:	31322f2f 	teqcc	r2, pc, lsr #30
 8ac:	31313135 	teqcc	r1, r5, lsr r1
 8b0:	2f2e0903 	svccs	0x002e0903
 8b4:	2f312f2f 	svccs	0x00312f2f
 8b8:	f6033131 			; <UNDEFINED> instruction: 0xf6033131
 8bc:	2e032e7e 	mcrcs	14, 0, r2, cr3, cr14, {3}
 8c0:	00d9032e 	sbcseq	r0, r9, lr, lsr #6
 8c4:	0002022e 	andeq	r0, r2, lr, lsr #4
 8c8:	Address 0x000008c8 is out of bounds.


Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
   4:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
   8:	6e692067 	cdpvs	0, 6, cr2, cr9, cr7, {3}
   c:	656c0074 	strbvs	r0, [ip, #-116]!	; 0x74
  10:	6c635f64 	stclvs	15, cr5, [r3], #-400	; 0xfffffe70
  14:	72675f72 	rsbvc	r5, r7, #456	; 0x1c8
  18:	006e6565 	rsbeq	r6, lr, r5, ror #10
  1c:	5f64656c 	svcpl	0x0064656c
  20:	5f746573 	svcpl	0x00746573
  24:	00646572 	rsbeq	r6, r4, r2, ror r5
  28:	6f697067 	svcvs	0x00697067
  2c:	7465735f 	strbtvc	r7, [r5], #-863	; 0x35f
  30:	64656c00 	strbtvs	r6, [r5], #-3072	; 0xc00
  34:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
  38:	682f0074 	stmdavs	pc!, {r2, r4, r5, r6}	; <UNPREDICTABLE>
  3c:	2f656d6f 	svccs	0x00656d6f
  40:	7472616b 	ldrbtvc	r6, [r2], #-363	; 0x16b
  44:	2f636968 	svccs	0x00636968
  48:	34333831 	ldrtcc	r3, [r3], #-2097	; 0x831
  4c:	34332f39 	ldrtcc	r2, [r3], #-3897	; 0xf39
  50:	31662d39 	cmncc	r6, r9, lsr sp
  54:	6f632f35 	svcvs	0x00632f35
  58:	6c006564 	cfstr32vs	mvfx6, [r0], {100}	; 0x64
  5c:	20676e6f 	rsbcs	r6, r7, pc, ror #28
  60:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
  64:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
  68:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0x769
  6c:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
  70:	70670074 	rsbvc	r0, r7, r4, ror r0
  74:	635f6f69 	cmpvs	pc, #420	; 0x1a4
  78:	3300726c 	movwcc	r7, #620	; 0x26c
  7c:	696c3934 	stmdbvs	ip!, {r2, r4, r5, r8, fp, ip, sp}^
  80:	732f6b62 	teqvc	pc, #100352	; 0x18800
  84:	6c2f6372 	stcvs	3, cr6, [pc], #-456	; fffffec4 <__user_program+0xffcffec4>
  88:	2e736465 	cdpcs	4, 7, cr6, cr3, cr5, {3}
  8c:	4e470063 	cdpmi	0, 4, cr0, cr7, cr3, {3}
  90:	20432055 	subcs	r2, r3, r5, asr r0
  94:	2e392e34 	mrccs	14, 1, r2, cr9, cr4, {1}
  98:	30322033 	eorscc	r2, r2, r3, lsr r0
  9c:	35303531 	ldrcc	r3, [r0, #-1329]!	; 0x531
  a0:	28203932 	stmdacs	r0!, {r1, r4, r5, r8, fp, ip, sp}
  a4:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0x572
  a8:	29657361 	stmdbcs	r5!, {r0, r5, r6, r8, r9, ip, sp, lr}^
  ac:	52415b20 	subpl	r5, r1, #32, 22	; 0x8000
  b0:	6d652f4d 	stclvs	15, cr2, [r5, #-308]!	; 0xfffffecc
  b4:	64646562 	strbtvs	r6, [r4], #-1378	; 0x562
  b8:	342d6465 	strtcc	r6, [sp], #-1125	; 0x465
  bc:	622d395f 	eorvs	r3, sp, #1556480	; 0x17c000
  c0:	636e6172 	cmnvs	lr, #-2147483620	; 0x8000001c
  c4:	65722068 	ldrbvs	r2, [r2, #-104]!	; 0x68
  c8:	69736976 	ldmdbvs	r3!, {r1, r2, r4, r5, r6, r8, fp, sp, lr}^
  cc:	32206e6f 	eorcc	r6, r0, #1776	; 0x6f0
  d0:	38323432 	ldmdacc	r2!, {r1, r4, r5, sl, ip, sp}
  d4:	2d205d38 	stccs	13, cr5, [r0, #-224]!	; 0xffffff20
  d8:	6f6c666d 	svcvs	0x006c666d
  dc:	612d7461 	teqvs	sp, r1, ror #8
  e0:	733d6962 	teqvc	sp, #1605632	; 0x188000
  e4:	2074666f 	rsbscs	r6, r4, pc, ror #12
  e8:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
  ec:	613d6863 	teqvs	sp, r3, ror #16
  f0:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
  f4:	2d20612d 	stfcss	f6, [r0, #-180]!	; 0xffffff4c
  f8:	4f2d2067 	svcmi	0x002d2067
  fc:	662d2031 			; <UNDEFINED> instruction: 0x662d2031
 100:	65657266 	strbvs	r7, [r5, #-614]!	; 0x266
 104:	6e617473 	mcrvs	4, 3, r7, cr1, cr3, {3}
 108:	676e6964 	strbvs	r6, [lr, -r4, ror #18]!
 10c:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
 110:	745f3874 	ldrbvc	r3, [pc], #-2164	; 118 <__start-0x7ee8>
 114:	736e7500 	cmnvc	lr, #0, 10
 118:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0x769
 11c:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
 120:	6c007261 	sfmvs	f7, 4, [r0], {97}	; 0x61
 124:	635f6465 	cmpvs	pc, #1694498816	; 0x65000000
 128:	725f726c 	subsvc	r7, pc, #108, 4	; 0xc0000006
 12c:	73006465 	movwvc	r6, #1125	; 0x465
 130:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xf68
 134:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
 138:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0x769
 13c:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
 140:	656c0074 	strbvs	r0, [ip, #-116]!	; 0x74
 144:	65735f64 	ldrbvs	r5, [r3, #-3940]!	; 0xf64
 148:	72675f74 	rsbvc	r5, r7, #116, 30	; 0x1d0
 14c:	006e6565 	rsbeq	r6, lr, r5, ror #10
 150:	6f697067 	svcvs	0x00697067
 154:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
 158:	00676966 	rsbeq	r6, r7, r6, ror #18
 15c:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
 160:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
 164:	70670074 	rsbvc	r0, r7, r4, ror r0
 168:	735f6f69 	cmpvc	pc, #420	; 0x1a4
 16c:	705f7465 	subsvc	r7, pc, r5, ror #8
 170:	006c6c75 	rsbeq	r6, ip, r5, ror ip
 174:	6f697067 	svcvs	0x00697067
 178:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
 17c:	5f323374 	svcpl	0x00323374
 180:	65640074 	strbvs	r0, [r4, #-116]!	; 0x74
 184:	5f79616c 	svcpl	0x0079616c
 188:	6c637963 	stclvs	9, cr7, [r3], #-396	; 0xfffffe74
 18c:	6f007365 	svcvs	0x00007365
 190:	65736666 	ldrbvs	r6, [r3, #-1638]!	; 0x666
 194:	34330074 	ldrtcc	r0, [r3], #-116	; 0x74
 198:	62696c39 	rsbvs	r6, r9, #14592	; 0x3900
 19c:	72732f6b 	rsbsvc	r2, r3, #428	; 0x1ac
 1a0:	70672f63 	rsbvc	r2, r7, r3, ror #30
 1a4:	632e6f69 	teqvs	lr, #420	; 0x1a4
 1a8:	74756d00 	ldrbtvc	r6, [r5], #-3328	; 0xd00
 1ac:	6c5f7865 	mrrcvs	8, 6, r7, pc, cr5	; <UNPREDICTABLE>
 1b0:	5f747369 	svcpl	0x00747369
 1b4:	64616568 	strbtvs	r6, [r1], #-1384	; 0x568
 1b8:	74756d00 	ldrbtvc	r6, [r5], #-3328	; 0xd00
 1bc:	745f7865 	ldrbvc	r7, [pc], #-2149	; 1c4 <__start-0x7e3c>
 1c0:	73617400 	cmnvc	r1, #0, 8
 1c4:	74735f6b 	ldrbtvc	r5, [r3], #-3947	; 0xf6b
 1c8:	00657461 	rsbeq	r7, r5, r1, ror #8
 1cc:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0x56e
 1d0:	4e555200 	cdpmi	2, 5, cr5, cr5, cr0, {0}
 1d4:	4c42414e 	stfmie	f4, [r2], {78}	; 0x4e
 1d8:	79730045 	ldmdbvc	r3!, {r0, r2, r6}^
 1dc:	6c616373 	stclvs	3, cr6, [r1], #-460	; 0xfffffe34
 1e0:	62735f6c 	rsbsvs	r5, r3, #108, 30	; 0x1b0
 1e4:	68006b72 	stmdavs	r0, {r1, r4, r5, r6, r8, r9, fp, sp, lr}
 1e8:	69646c6f 	stmdbvs	r4!, {r0, r1, r2, r3, r5, r6, sl, fp, sp, lr}^
 1ec:	745f676e 	ldrbvc	r6, [pc], #-1902	; 1f4 <__start-0x7e0c>
 1f0:	61657268 	cmnvs	r5, r8, ror #4
 1f4:	72705f64 	rsbsvc	r5, r0, #100, 30	; 0x190
 1f8:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
 1fc:	63007974 	movwvs	r7, #2420	; 0x974
 200:	6f6d6d6f 	svcvs	0x006d6d6f
 204:	65725f6e 	ldrbvs	r5, [r2, #-3950]!	; 0xf6e
 208:	77007367 	strvc	r7, [r0, -r7, ror #6]
 20c:	69746961 	ldmdbvs	r4!, {r0, r5, r6, r8, fp, sp, lr}^
 210:	705f676e 	subsvc	r6, pc, lr, ror #14
 214:	006c6f6f 	rsbeq	r6, ip, pc, ror #30
 218:	6e6e7572 	mcrvs	5, 3, r7, cr14, cr2, {3}
 21c:	5f676e69 	svcpl	0x00676e69
 220:	6b736174 	blvs	1cd87f8 <__user_program+0x19d87f8>
 224:	6263745f 	rsbvs	r7, r3, #1593835520	; 0x5f000000
 228:	646e695f 	strbtvs	r6, [lr], #-2399	; 0x95f
 22c:	73007865 	movwvc	r7, #2149	; 0x865
 230:	61637379 	smcvs	14137	; 0x3739
 234:	6d5f6c6c 	ldclvs	12, cr6, [pc, #-432]	; 8c <__start-0x7f74>
 238:	78657475 	stmdavc	r5!, {r0, r2, r4, r5, r6, sl, ip, sp, lr}^
 23c:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
 240:	79730074 	ldmdbvc	r3!, {r2, r4, r5, r6}^
 244:	6c616373 	stclvs	3, cr6, [r1], #-460	; 0xfffffe34
 248:	73695f6c 	cmnvc	r9, #108, 30	; 0x1b0
 24c:	79747461 	ldmdbvc	r4!, {r0, r5, r6, sl, ip, sp, lr}^
 250:	73657200 	cmnvc	r5, #0, 4
 254:	65726f74 	ldrbvs	r6, [r2, #-3956]!	; 0xf74
 258:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
 25c:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0x574
 260:	62637400 	rsbvs	r7, r3, #0, 8
 264:	7272615f 	rsbsvc	r6, r2, #-1073741801	; 0xc0000017
 268:	73007961 	movwvc	r7, #2401	; 0x961
 26c:	61637379 	smcvs	14137	; 0x3739
 270:	745f6c6c 	ldrbvc	r6, [pc], #-3180	; 278 <__start-0x7d88>
 274:	61657268 	cmnvs	r5, r8, ror #4
 278:	6e695f64 	cdpvs	15, 6, cr5, cr9, cr4, {3}
 27c:	73007469 	movwvc	r7, #1129	; 0x469
 280:	61637379 	smcvs	14137	; 0x3739
 284:	6d5f6c6c 	ldclvs	12, cr6, [pc, #-432]	; dc <__start-0x7f24>
 288:	78657475 	stmdavc	r5!, {r0, r2, r4, r5, r6, sl, ip, sp, lr}^
 28c:	6c6e755f 	cfstr64vs	mvdx7, [lr], #-380	; 0xfffffe84
 290:	006b636f 	rsbeq	r6, fp, pc, ror #6
 294:	5f717269 	svcpl	0x00717269
 298:	61685f63 	cmnvs	r8, r3, ror #30
 29c:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0x46e
 2a0:	65630072 	strbvs	r0, [r3, #-114]!	; 0x72
 2a4:	6e696c69 	cdpvs	12, 6, cr6, cr9, cr9, {3}
 2a8:	72705f67 	rsbsvc	r5, r0, #412	; 0x19c
 2ac:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
 2b0:	64007974 	strvs	r7, [r0], #-2420	; 0x974
 2b4:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
 2b8:	695f656c 	ldmdbvs	pc, {r2, r3, r5, r6, r8, sl, sp, lr}^	; <UNPREDICTABLE>
 2bc:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 2c0:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0x572
 2c4:	64610073 	strbtvs	r0, [r1], #-115	; 0x73
 2c8:	6e695f63 	cdpvs	15, 6, cr5, cr9, cr3, {3}
 2cc:	75007469 	strvc	r7, [r0, #-1129]	; 0x469
 2d0:	5f747261 	svcpl	0x00747261
 2d4:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xe69
 2d8:	73617400 	cmnvc	r1, #0, 8
 2dc:	6f635f6b 	svcvs	0x00635f6b
 2e0:	6f72746e 	svcvs	0x0072746e
 2e4:	6c625f6c 	stclvs	15, cr5, [r2], #-432	; 0xfffffe50
 2e8:	006b636f 	rsbeq	r6, fp, pc, ror #6
 2ec:	75746361 	ldrbvc	r6, [r4, #-865]!	; 0x361
 2f0:	705f6c61 	subsvc	r6, pc, r1, ror #24
 2f4:	726f6972 	rsbvc	r6, pc, #1867776	; 0x1c8000
 2f8:	00797469 	rsbseq	r7, r9, r9, ror #8
 2fc:	5f697773 	svcpl	0x00697773
 300:	61685f63 	cmnvs	r8, r3, ror #30
 304:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0x46e
 308:	79730072 	ldmdbvc	r3!, {r1, r4, r5, r6}^
 30c:	6c616373 	stclvs	3, cr6, [r1], #-460	; 0xfffffe34
 310:	72775f6c 	rsbsvc	r5, r7, #108, 30	; 0x1b0
 314:	00657469 	rsbeq	r7, r5, r9, ror #8
 318:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 31c:	5f6c6c61 	svcpl	0x006c6c61
 320:	74697865 	strbtvc	r7, [r9], #-2149	; 0x865
 324:	755f6300 	ldrbvc	r6, [pc, #-768]	; 2c <__start-0x7fd4>
 328:	00646573 	rsbeq	r6, r4, r3, ror r5
 32c:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0x56e
 330:	6b61775f 	blvs	185e0b4 <__user_program+0x155e0b4>
 334:	5f707565 	svcpl	0x00707565
 338:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 33c:	73797300 	cmnvc	r9, #0, 6
 340:	6c6c6163 	stfvse	f6, [ip], #-396	; 0xfffffe74
 344:	7465675f 	strbtvc	r6, [r5], #-1887	; 0x75f
 348:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
 34c:	69660065 	stmdbvs	r6!, {r0, r2, r5, r6}^
 350:	5f747372 	svcpl	0x00747372
 354:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 358:	616c665f 	cmnvs	ip, pc, asr r6
 35c:	68740067 	ldmdavs	r4!, {r0, r1, r2, r5, r6}^
 360:	64616572 	strbtvs	r6, [r1], #-1394	; 0x572
 364:	006e665f 	rsbeq	r6, lr, pc, asr r6
 368:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 36c:	6c635f72 	stclvs	15, cr5, [r3], #-456	; 0xfffffe38
 370:	5f726165 	svcpl	0x00726165
 374:	646e6570 	strbtvs	r6, [lr], #-1392	; 0x570
 378:	00676e69 	rsbeq	r6, r7, r9, ror #28
 37c:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 380:	5f6c6c61 	svcpl	0x006c6c61
 384:	65726874 	ldrbvs	r6, [r2, #-2164]!	; 0x874
 388:	635f6461 	cmpvs	pc, #1627389952	; 0x61000000
 38c:	74616572 	strbtvc	r6, [r1], #-1394	; 0x572
 390:	70730065 	rsbsvc	r0, r3, r5, rrx
 394:	61696365 	cmnvs	r9, r5, ror #6
 398:	65725f6c 	ldrbvs	r5, [r2, #-3948]!	; 0xf6c
 39c:	6b007367 	blvs	1d140 <tcb_array+0x1013c>
 3a0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0x265
 3a4:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
 3a8:	656b2f63 	strbvs	r2, [fp, #-3939]!	; 0xf63
 3ac:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 3b0:	7300632e 	movwvc	r6, #814	; 0x32e
 3b4:	61637379 	smcvs	14137	; 0x3739
 3b8:	735f6c6c 	cmpvc	pc, #108, 24	; 0x6c00
 3bc:	64656863 	strbtvs	r6, [r5], #-2147	; 0x863
 3c0:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
 3c4:	6174735f 	cmnvs	r4, pc, asr r3
 3c8:	73007472 	movwvc	r7, #1138	; 0x472
 3cc:	5f657661 	svcpl	0x00657661
 3d0:	746e6f63 	strbtvc	r6, [lr], #-3939	; 0xf63
 3d4:	00747865 	rsbseq	r7, r4, r5, ror #16
 3d8:	65686373 	strbvs	r6, [r8, #-883]!	; 0x373
 3dc:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0x564
 3e0:	6e690072 	mcrvs	0, 3, r0, cr9, cr2, {3}
 3e4:	61697469 	cmnvs	r9, r9, ror #8
 3e8:	657a696c 	ldrbvs	r6, [sl, #-2412]!	; 0x96c
 3ec:	6972705f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, ip, sp, lr}^
 3f0:	7469726f 	strbtvc	r7, [r9], #-623	; 0x26f
 3f4:	616d5f79 	smcvs	54777	; 0xd5f9
 3f8:	79730070 	ldmdbvc	r3!, {r4, r5, r6}^
 3fc:	6c616373 	stclvs	3, cr6, [r1], #-460	; 0xfffffe34
 400:	756d5f6c 	strbvc	r5, [sp, #-3948]!	; 0xf6c
 404:	5f786574 	svcpl	0x00786574
 408:	6b636f6c 	blvs	18dc1c0 <__user_program+0x15dc1c0>
 40c:	73797300 	cmnvc	r9, #0, 6
 410:	6c6c6163 	stfvse	f6, [ip], #-396	; 0xfffffe74
 414:	65736c5f 	ldrbvs	r6, [r3, #-3167]!	; 0xc5f
 418:	63006b65 	movwvs	r6, #2917	; 0xb65
 41c:	5f727275 	svcpl	0x00727275
 420:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 424:	6d697400 	cfstrdvs	mvd7, [r9, #-0]
 428:	735f7265 	cmpvc	pc, #1342177286	; 0x50000006
 42c:	00706f74 	rsbseq	r6, r0, r4, ror pc
 430:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 434:	5f6c6c61 	svcpl	0x006c6c61
 438:	706d6173 	rsbvc	r6, sp, r3, ror r1
 43c:	615f656c 	cmpvs	pc, ip, ror #10
 440:	735f6364 	cmpvc	pc, #100, 6	; 0x90000001
 444:	00706f74 	rsbseq	r6, r0, r4, ror pc
 448:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 44c:	5f6c6c61 	svcpl	0x006c6c61
 450:	74696177 	strbtvc	r6, [r9], #-375	; 0x177
 454:	746e755f 	strbtvc	r7, [lr], #-1375	; 0x55f
 458:	6e5f6c69 	cdpvs	12, 5, cr6, cr15, cr9, {3}
 45c:	5f747865 	svcpl	0x00747865
 460:	69726570 	ldmdbvs	r2!, {r4, r5, r6, r8, sl, sp, lr}^
 464:	7300646f 	movwvc	r6, #1135	; 0x46f
 468:	74657a69 	strbtvc	r7, [r5], #-2665	; 0xa69
 46c:	00657079 	rsbeq	r7, r5, r9, ror r0
 470:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
 474:	57006b74 	smlsdxpl	r0, r4, fp, r6
 478:	49544941 	ldmdbmi	r4, {r0, r6, r8, fp, lr}^
 47c:	7300474e 	movwvc	r4, #1870	; 0x74e
 480:	61637379 	smcvs	14137	; 0x3739
 484:	635f6c6c 	cmpvs	pc, #108, 24	; 0x6c00
 488:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xf6c
 48c:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
 490:	75725f74 	ldrbvc	r5, [r2, #-3956]!	; 0xf74
 494:	62616e6e 	rsbvs	r6, r1, #1760	; 0x6e0
 498:	745f656c 	ldrbvc	r6, [pc], #-1388	; 4a0 <__start-0x7b60>
 49c:	5f6b7361 	svcpl	0x006b7361
 4a0:	65646e69 	strbvs	r6, [r4, #-3689]!	; 0xe69
 4a4:	756d0078 	strbvc	r0, [sp, #-120]!	; 0x78
 4a8:	00786574 	rsbseq	r6, r8, r4, ror r5
 4ac:	63737973 	cmnvs	r3, #1884160	; 0x1cc000
 4b0:	5f6c6c61 	svcpl	0x006c6c61
 4b4:	706d6173 	rsbvc	r6, sp, r3, ror r1
 4b8:	615f656c 	cmpvs	pc, ip, ror #10
 4bc:	735f6364 	cmpvc	pc, #100, 6	; 0x90000001
 4c0:	74726174 	ldrbtvc	r6, [r2], #-372	; 0x174
 4c4:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
 4c8:	5f363174 	svcpl	0x00363174
 4cc:	72610074 	rsbvc	r0, r1, #116	; 0x74
 4d0:	74007367 	strvc	r7, [r0], #-871	; 0x367
 4d4:	006b7361 	rsbeq	r7, fp, r1, ror #6
 4d8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 4dc:	6d5f6c65 	ldclvs	12, cr6, [pc, #-404]	; 350 <__start-0x7cb0>
 4e0:	006e6961 	rsbeq	r6, lr, r1, ror #18
 4e4:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 4e8:	73695f72 	cmnvc	r9, #456	; 0x1c8
 4ec:	6e65705f 	mcrvs	0, 3, r7, cr5, cr15, {2}
 4f0:	676e6964 	strbvs	r6, [lr, -r4, ror #18]!
 4f4:	736e6900 	cmnvc	lr, #0, 18
 4f8:	6c6c6174 	stfvse	f6, [ip], #-464	; 0xfffffe30
 4fc:	746e695f 	strbtvc	r6, [lr], #-2399	; 0x95f
 500:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0x265
 504:	745f7470 	ldrbvc	r7, [pc], #-1136	; 50c <__start-0x7af4>
 508:	656c6261 	strbvs	r6, [ip, #-609]!	; 0x261
 50c:	4e555200 	cdpmi	2, 5, cr5, cr5, cr0, {0}
 510:	474e494e 	strbmi	r4, [lr, -lr, asr #18]
 514:	746e6500 	strbtvc	r6, [lr], #-1280	; 0x500
 518:	755f7265 	ldrbvc	r7, [pc, #-613]	; 2bb <__start-0x7d45>
 51c:	5f726573 	svcpl	0x00726573
 520:	65646f6d 	strbvs	r6, [r4, #-3949]!	; 0xf6d
 524:	696c6100 	stmdbvs	ip!, {r8, sp, lr}^
 528:	73006576 	movwvc	r6, #1398	; 0x576
 52c:	61637379 	smcvs	14137	; 0x3739
 530:	725f6c6c 	subsvc	r6, pc, #108, 24	; 0x6c00
 534:	00646165 	rsbeq	r6, r4, r5, ror #2
 538:	6e6e7572 	mcrvs	5, 3, r7, cr14, cr2, {3}
 53c:	656c6261 	strbvs	r6, [ip, #-609]!	; 0x261
 540:	6f6f705f 	svcvs	0x006f705f
 544:	7973006c 	ldmdbvc	r3!, {r2, r3, r5, r6}^
 548:	6c616373 	stclvs	3, cr6, [r1], #-460	; 0xfffffe34
 54c:	73665f6c 	cmnvc	r6, #108, 30	; 0x1b0
 550:	00746174 	rsbseq	r6, r4, r4, ror r1
 554:	6174736b 	cmnvs	r4, fp, ror #6
 558:	73006b63 	movwvc	r6, #2915	; 0xb63
 55c:	6e5f6977 	mrcvs	9, 2, r6, cr15, cr7, {3}
 560:	62006d75 	andvs	r6, r0, #7488	; 0x1d40
 564:	5f657479 	svcpl	0x00657479
 568:	00727470 	rsbseq	r7, r2, r0, ror r4
 56c:	746e6975 	strbtvc	r6, [lr], #-2421	; 0x975
 570:	745f3436 	ldrbvc	r3, [pc], #-1078	; 578 <__start-0x7a88>
 574:	72656b00 	rsbvc	r6, r5, #0, 22
 578:	2f6c656e 	svccs	0x006c656e
 57c:	2f637273 	svccs	0x00637273
 580:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
 584:	632e6b74 	teqvs	lr, #116, 22	; 0x1d000
 588:	765f5f00 	ldrbvc	r5, [pc], -r0, lsl #30
 58c:	696c5f61 	stmdbvs	ip!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 590:	75007473 	strvc	r7, [r0, #-1139]	; 0x473
 594:	5f747261 	svcpl	0x00747261
 598:	5f747570 	svcpl	0x00747570
 59c:	65747962 	ldrbvs	r7, [r4, #-2402]!	; 0x962
 5a0:	69727000 	ldmdbvs	r2!, {ip, sp, lr}^
 5a4:	756e746e 	strbvc	r7, [lr, #-1134]!	; 0x46e
 5a8:	64006b6d 	strvs	r6, [r0], #-2925	; 0xb6d
 5ac:	74696769 	strbtvc	r6, [r9], #-1897	; 0x769
 5b0:	72700073 	rsbsvc	r0, r0, #115	; 0x73
 5b4:	78696665 	stmdavc	r9!, {r0, r2, r5, r6, r9, sl, sp, lr}^
 5b8:	73616200 	cmnvc	r1, #0, 4
 5bc:	5f5f0065 	svcpl	0x005f0065
 5c0:	75007061 	strvc	r7, [r0, #-97]	; 0x61
 5c4:	5f747261 	svcpl	0x00747261
 5c8:	5f746567 	svcpl	0x00746567
 5cc:	65747962 	ldrbvs	r7, [r4, #-2402]!	; 0x962
 5d0:	72656b00 	rsbvc	r6, r5, #0, 22
 5d4:	2f6c656e 	svccs	0x006c656e
 5d8:	2f637273 	svccs	0x00637273
 5dc:	74726175 	ldrbtvc	r6, [r2], #-373	; 0x175
 5e0:	7500632e 	strvc	r6, [r0, #-814]	; 0x32e
 5e4:	5f747261 	svcpl	0x00747261
 5e8:	736f6c63 	cmnvc	pc, #25344	; 0x6300
 5ec:	61640065 	cmnvs	r4, r5, rrx
 5f0:	73006174 	movwvc	r6, #372	; 0x174
 5f4:	6d5f6970 	ldclvs	9, cr6, [pc, #-448]	; 43c <__start-0x7bc4>
 5f8:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0x361
 5fc:	6e695f72 	mcrvs	15, 3, r5, cr9, cr2, {3}
 600:	70007469 	andvc	r7, r0, r9, ror #8
 604:	72616c6f 	rsbvc	r6, r1, #28416	; 0x6f00
 608:	00797469 	rsbseq	r7, r9, r9, ror #8
 60c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 610:	732f6c65 	teqvc	pc, #25856	; 0x6500
 614:	732f6372 	teqvc	pc, #-939524095	; 0xc8000001
 618:	632e6970 	teqvs	lr, #112, 18	; 0x1c0000
 61c:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 620:	73616d5f 	cmnvc	r1, #6080	; 0x17c0
 624:	5f726574 	svcpl	0x00726574
 628:	6e617274 	mcrvs	2, 3, r7, cr1, cr4, {3}
 62c:	72656673 	rsbvc	r6, r5, #120586240	; 0x7300000
 630:	6174735f 	cmnvs	r4, pc, asr r3
 634:	73007472 	movwvc	r7, #1138	; 0x472
 638:	6d5f6970 	ldclvs	9, cr6, [pc, #-448]	; 480 <__start-0x7b80>
 63c:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0x361
 640:	72745f72 	rsbsvc	r5, r4, #456	; 0x1c8
 644:	66736e61 	ldrbtvs	r6, [r3], -r1, ror #28
 648:	73007265 	movwvc	r7, #613	; 0x265
 64c:	6d5f6970 	ldclvs	9, cr6, [pc, #-448]	; 494 <__start-0x7b6c>
 650:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0x361
 654:	68635f72 	stmdavs	r3!, {r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 658:	735f7069 	cmpvc	pc, #105	; 0x69
 65c:	73006c65 	movwvc	r6, #3173	; 0xc65
 660:	6d5f6970 	ldclvs	9, cr6, [pc, #-448]	; 4a8 <__start-0x7b58>
 664:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0x361
 668:	72745f72 	rsbsvc	r5, r4, #456	; 0x1c8
 66c:	66736e61 	ldrbtvs	r6, [r3], -r1, ror #28
 670:	655f7265 	ldrbvs	r7, [pc, #-613]	; 413 <__start-0x7bed>
 674:	6b00646e 	blvs	19834 <tcb_array+0xc830>
 678:	656e7265 	strbvs	r7, [lr, #-613]!	; 0x265
 67c:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
 680:	69742f63 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, r9, sl, fp, sp}^
 684:	2e72656d 	cdpcs	5, 7, cr6, cr2, cr13, {3}
 688:	72660063 	rsbvc	r0, r6, #99	; 0x63
 68c:	74007165 	strvc	r7, [r0], #-357	; 0x165
 690:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
 694:	6174735f 	cmnvs	r4, pc, asr r3
 698:	61007472 	tstvs	r0, r2, ror r4
 69c:	725f6364 	subsvc	r6, pc, #100, 6	; 0x90000001
 6a0:	72757465 	rsbsvc	r7, r5, #1694498816	; 0x65000000
 6a4:	6f63006e 	svcvs	0x0063006e
 6a8:	6769666e 	strbvs	r6, [r9, -lr, ror #12]!
 6ac:	7469625f 	strbtvc	r6, [r9], #-607	; 0x25f
 6b0:	656b0073 	strbvs	r0, [fp, #-115]!	; 0x73
 6b4:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 6b8:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 6bc:	6364612f 	cmnvs	r4, #-1073741813	; 0xc000000b
 6c0:	6972645f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, sl, sp, lr}^
 6c4:	2e726576 	mrccs	5, 3, r6, cr2, cr6, {3}
 6c8:	68630063 	stmdavs	r3!, {r0, r1, r5, r6}^
 6cc:	656e6e61 	strbvs	r6, [lr, #-3681]!	; 0xe61
 6d0:	6461006c 	strbtvs	r0, [r1], #-108	; 0x6c
 6d4:	65725f63 	ldrbvs	r5, [r2, #-3939]!	; 0xf63
 6d8:	69006461 	stmdbvs	r0, {r0, r5, r6, sl, sp, lr}
 6dc:	5f656c64 	svcpl	0x00656c64
 6e0:	69006e66 	stmdbvs	r0, {r1, r2, r5, r6, r9, sl, fp, sp, lr}
 6e4:	0072636e 	rsbseq	r6, r2, lr, ror #6
 6e8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 6ec:	732f6c65 	teqvc	pc, #25856	; 0x6500
 6f0:	732f6372 	teqvc	pc, #-939524095	; 0xc8000001
 6f4:	61637379 	smcvs	14137	; 0x3739
 6f8:	2e736c6c 	cdpcs	12, 7, cr6, cr3, cr12, {3}
 6fc:	69660063 	stmdbvs	r6!, {r0, r1, r5, r6}^
 700:	6900656c 	stmdbvs	r0, {r2, r3, r5, r6, r8, sl, sp, lr}
 704:	5f656c64 	svcpl	0x00656c64
 708:	63617473 	cmnvs	r1, #1929379840	; 0x73000000
 70c:	74735f6b 	ldrbtvc	r5, [r3], #-3947	; 0xf6b
 710:	00747261 	rsbseq	r7, r4, r1, ror #4
 714:	62616e65 	rsbvs	r6, r1, #1616	; 0x650
 718:	695f656c 	ldmdbvs	pc, {r2, r3, r5, r6, r8, sl, sp, lr}^	; <UNPREDICTABLE>
 71c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 720:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0x572
 724:	6c660073 	stclvs	0, cr0, [r6], #-460	; 0xfffffe34
 728:	0074616f 	rsbseq	r6, r4, pc, ror #2
 72c:	65685f5f 	strbvs	r5, [r8, #-3935]!	; 0xf5f
 730:	745f7061 	ldrbvc	r7, [pc], #-97	; 738 <__start-0x78c8>
 734:	6d00706f 	stcvs	0, cr7, [r0, #-444]	; 0xfffffe44
 738:	705f7861 	subsvc	r7, pc, r1, ror #16
 73c:	006f6972 	rsbeq	r6, pc, r2, ror r9	; <UNPREDICTABLE>
 740:	72727563 	rsbsvc	r7, r2, #415236096	; 0x18c00000
 744:	00746e65 	rsbseq	r6, r4, r5, ror #28
 748:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
 74c:	70007375 	andvc	r7, r0, r5, ror r3
 750:	5f766572 	svcpl	0x00766572
 754:	70616568 	rsbvc	r6, r1, r8, ror #10
 758:	646e655f 	strbtvs	r6, [lr], #-1375	; 0x55f
 75c:	685f5f00 	ldmdavs	pc, {r8, r9, sl, fp, ip, lr}^	; <UNPREDICTABLE>
 760:	5f706165 	svcpl	0x00706165
 764:	00776f6c 	rsbseq	r6, r7, ip, ror #30
 768:	656c6564 	strbvs	r6, [ip, #-1380]!	; 0x564
 76c:	00646574 	rsbeq	r6, r4, r4, ror r5
 770:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
 774:	656e0074 	strbvs	r0, [lr, #-116]!	; 0x74
 778:	72705f77 	rsbsvc	r5, r0, #476	; 0x1dc
 77c:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
 780:	70007974 	andvc	r7, r0, r4, ror r9
 784:	00766572 	rsbseq	r6, r6, r2, ror r5
 788:	64616572 	strbtvs	r6, [r1], #-1394	; 0x572
 78c:	7479625f 	ldrbtvc	r6, [r9], #-607	; 0x25f
 790:	61680065 	cmnvs	r8, r5, rrx
 794:	Address 0x00000794 is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__user_program+0xdd0d24>
   4:	4e472820 	cdpmi	8, 4, cr2, cr7, cr0, {1}
   8:	6f542055 	svcvs	0x00542055
   c:	20736c6f 	rsbscs	r6, r3, pc, ror #24
  10:	20726f66 	rsbscs	r6, r2, r6, ror #30
  14:	204d5241 	subcs	r5, sp, r1, asr #4
  18:	65626d45 	strbvs	r6, [r2, #-3397]!	; 0xd45
  1c:	64656464 	strbtvs	r6, [r5], #-1124	; 0x464
  20:	6f725020 	svcvs	0x00725020
  24:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
  28:	2973726f 	ldmdbcs	r3!, {r0, r1, r2, r3, r5, r6, r9, ip, sp, lr}^
  2c:	392e3420 	stmdbcc	lr!, {r5, sl, ip, sp}
  30:	3220332e 	eorcc	r3, r0, #-1207959552	; 0xb8000000
  34:	30353130 	eorscc	r3, r5, r0, lsr r1
  38:	20393235 	eorscs	r3, r9, r5, lsr r2
  3c:	6c657228 	sfmvs	f7, 2, [r5], #-160	; 0xffffff60
  40:	65736165 	ldrbvs	r6, [r3, #-357]!	; 0x165
  44:	415b2029 	cmpmi	fp, r9, lsr #32
  48:	652f4d52 	strvs	r4, [pc, #-3410]!	; fffff2fe <__user_program+0xffcff2fe>
  4c:	6465626d 	strbtvs	r6, [r5], #-621	; 0x26d
  50:	2d646564 	cfstr64cs	mvdx6, [r4, #-400]!	; 0xfffffe70
  54:	2d395f34 	ldccs	15, cr5, [r9, #-208]!	; 0xffffff30
  58:	6e617262 	cdpvs	2, 6, cr7, cr1, cr2, {3}
  5c:	72206863 	eorvc	r6, r0, #6488064	; 0x630000
  60:	73697665 	cmnvc	r9, #105906176	; 0x6500000
  64:	206e6f69 	rsbcs	r6, lr, r9, ror #30
  68:	32343232 	eorscc	r3, r4, #536870915	; 0x20000003
  6c:	005d3838 	subseq	r3, sp, r8, lsr r8

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002c41 	andeq	r2, r0, r1, asr #24
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000022 	andeq	r0, r0, r2, lsr #32
  10:	412d3705 	teqmi	sp, r5, lsl #14
  14:	070a0600 	streq	r0, [sl, -r0, lsl #12]
  18:	09010841 	stmdbeq	r1, {r0, r6, fp}
  1c:	14041202 	strne	r1, [r4], #-514	; 0x202
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x18038>
  28:	22011e01 	andcs	r1, r1, #1, 28
  2c:	Address 0x0000002c is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	00000014 	andeq	r0, r0, r4, lsl r0
  14:	00000000 	andeq	r0, r0, r0
  18:	00008054 	andeq	r8, r0, r4, asr r0
  1c:	00000020 	andeq	r0, r0, r0, lsr #32
  20:	83080e42 	movwhi	r0, #36418	; 0x8e42
  24:	00018e02 	andeq	r8, r1, r2, lsl #28
  28:	00000014 	andeq	r0, r0, r4, lsl r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	00008074 	andeq	r8, r0, r4, ror r0
  34:	00000010 	andeq	r0, r0, r0, lsl r0
  38:	83080e42 	movwhi	r0, #36418	; 0x8e42
  3c:	00018e02 	andeq	r8, r1, r2, lsl #28
  40:	00000014 	andeq	r0, r0, r4, lsl r0
  44:	00000000 	andeq	r0, r0, r0
  48:	00008084 	andeq	r8, r0, r4, lsl #1
  4c:	00000010 	andeq	r0, r0, r0, lsl r0
  50:	83080e42 	movwhi	r0, #36418	; 0x8e42
  54:	00018e02 	andeq	r8, r1, r2, lsl #28
  58:	00000014 	andeq	r0, r0, r4, lsl r0
  5c:	00000000 	andeq	r0, r0, r0
  60:	00008094 	muleq	r0, r4, r0
  64:	00000010 	andeq	r0, r0, r0, lsl r0
  68:	83080e42 	movwhi	r0, #36418	; 0x8e42
  6c:	00018e02 	andeq	r8, r1, r2, lsl #28
  70:	00000014 	andeq	r0, r0, r4, lsl r0
  74:	00000000 	andeq	r0, r0, r0
  78:	000080a4 	andeq	r8, r0, r4, lsr #1
  7c:	00000010 	andeq	r0, r0, r0, lsl r0
  80:	83080e42 	movwhi	r0, #36418	; 0x8e42
  84:	00018e02 	andeq	r8, r1, r2, lsl #28
  88:	0000000c 	andeq	r0, r0, ip
  8c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  90:	7c020001 	stcvc	0, cr0, [r2], {1}
  94:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  98:	0000000c 	andeq	r0, r0, ip
  9c:	00000088 	andeq	r0, r0, r8, lsl #1
  a0:	000080b4 	strheq	r8, [r0], -r4
  a4:	00000054 	andeq	r0, r0, r4, asr r0
  a8:	0000000c 	andeq	r0, r0, ip
  ac:	00000088 	andeq	r0, r0, r8, lsl #1
  b0:	00008108 	andeq	r8, r0, r8, lsl #2
  b4:	00000044 	andeq	r0, r0, r4, asr #32
  b8:	0000000c 	andeq	r0, r0, ip
  bc:	00000088 	andeq	r0, r0, r8, lsl #1
  c0:	0000814c 	andeq	r8, r0, ip, asr #2
  c4:	00000044 	andeq	r0, r0, r4, asr #32
  c8:	00000018 	andeq	r0, r0, r8, lsl r0
  cc:	00000088 	andeq	r0, r0, r8, lsl #1
  d0:	00008190 	muleq	r0, r0, r1
  d4:	00000084 	andeq	r0, r0, r4, lsl #1
  d8:	83100e48 	tsthi	r0, #72, 28	; 0x480
  dc:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
  e0:	00018e02 	andeq	r8, r1, r2, lsl #28
  e4:	0000000c 	andeq	r0, r0, ip
  e8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  ec:	7c020001 	stcvc	0, cr0, [r2], {1}
  f0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  f4:	00000014 	andeq	r0, r0, r4, lsl r0
  f8:	000000e4 	andeq	r0, r0, r4, ror #1
  fc:	00008214 	andeq	r8, r0, r4, lsl r2
 100:	00000044 	andeq	r0, r0, r4, asr #32
 104:	84080e42 	strhi	r0, [r8], #-3650	; 0xe42
 108:	00018e02 	andeq	r8, r1, r2, lsl #28
 10c:	00000014 	andeq	r0, r0, r4, lsl r0
 110:	000000e4 	andeq	r0, r0, r4, ror #1
 114:	00008258 	andeq	r8, r0, r8, asr r2
 118:	00000024 	andeq	r0, r0, r4, lsr #32
 11c:	83080e42 	movwhi	r0, #36418	; 0x8e42
 120:	00018e02 	andeq	r8, r1, r2, lsl #28
 124:	00000020 	andeq	r0, r0, r0, lsr #32
 128:	000000e4 	andeq	r0, r0, r4, ror #1
 12c:	0000827c 	andeq	r8, r0, ip, ror r2
 130:	000002cc 	andeq	r0, r0, ip, asr #5
 134:	84200e42 	strthi	r0, [r0], #-3650	; 0xe42
 138:	86078508 	strhi	r8, [r7], -r8, lsl #10
 13c:	88058706 	stmdahi	r5, {r1, r2, r8, r9, sl, pc}
 140:	8a038904 	bhi	e2558 <__bss_end+0xb4558>
 144:	00018e02 	andeq	r8, r1, r2, lsl #28
 148:	00000018 	andeq	r0, r0, r8, lsl r0
 14c:	000000e4 	andeq	r0, r0, r4, ror #1
 150:	00008548 	andeq	r8, r0, r8, asr #10
 154:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 158:	84100e42 	ldrhi	r0, [r0], #-3650	; 0xe42
 15c:	86038504 	strhi	r8, [r3], -r4, lsl #10
 160:	00018e02 	andeq	r8, r1, r2, lsl #28
 164:	00000018 	andeq	r0, r0, r8, lsl r0
 168:	000000e4 	andeq	r0, r0, r4, ror #1
 16c:	000085f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 170:	000000b8 	strheq	r0, [r0], -r8
 174:	840c0e42 	strhi	r0, [ip], #-3650	; 0xe42
 178:	8e028503 	cfsh32hi	mvfx8, mvfx2, #3
 17c:	00000001 	andeq	r0, r0, r1
 180:	00000014 	andeq	r0, r0, r4, lsl r0
 184:	000000e4 	andeq	r0, r0, r4, ror #1
 188:	000086b0 			; <UNDEFINED> instruction: 0x000086b0
 18c:	0000007c 	andeq	r0, r0, ip, ror r0
 190:	84080e42 	strhi	r0, [r8], #-3650	; 0xe42
 194:	00018e02 	andeq	r8, r1, r2, lsl #28
 198:	00000018 	andeq	r0, r0, r8, lsl r0
 19c:	000000e4 	andeq	r0, r0, r4, ror #1
 1a0:	0000872c 	andeq	r8, r0, ip, lsr #14
 1a4:	00000184 	andeq	r0, r0, r4, lsl #3
 1a8:	8e040e42 	cdphi	14, 0, cr0, cr4, cr2, {2}
 1ac:	100e4201 	andne	r4, lr, r1, lsl #4
 1b0:	040ebc02 	streq	fp, [lr], #-3074	; 0xc02
 1b4:	0000000c 	andeq	r0, r0, ip
 1b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1bc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1c4:	00000028 	andeq	r0, r0, r8, lsr #32
 1c8:	000001b4 			; <UNDEFINED> instruction: 0x000001b4
 1cc:	000088b0 			; <UNDEFINED> instruction: 0x000088b0
 1d0:	000000e0 	andeq	r0, r0, r0, ror #1
 1d4:	84200e42 	strthi	r0, [r0], #-3650	; 0xe42
 1d8:	86078508 	strhi	r8, [r7], -r8, lsl #10
 1dc:	88058706 	stmdahi	r5, {r1, r2, r8, r9, sl, pc}
 1e0:	8a038904 	bhi	e25f8 <__bss_end+0xb45f8>
 1e4:	42018e02 	andmi	r8, r1, #2, 28
 1e8:	6a02280e 	bvs	8a228 <__bss_end+0x5c228>
 1ec:	0000200e 	andeq	r2, r0, lr
 1f0:	00000040 	andeq	r0, r0, r0, asr #32
 1f4:	000001b4 			; <UNDEFINED> instruction: 0x000001b4
 1f8:	00008990 	muleq	r0, r0, r9
 1fc:	000001b8 			; <UNDEFINED> instruction: 0x000001b8
 200:	80100e42 	andshi	r0, r0, r2, asr #28
 204:	82038104 	andhi	r8, r3, #4, 2
 208:	42018302 	andmi	r8, r1, #134217728	; 0x8000000
 20c:	0a84280e 	beq	fe10a24c <__user_program+0xfde0a24c>
 210:	08860985 	stmeq	r6, {r0, r2, r7, r8, fp}
 214:	06880787 	streq	r0, [r8], r7, lsl #15
 218:	0e42058e 	cdpeq	5, 4, cr0, cr2, cr14, {4}
 21c:	0ed00230 	mrceq	2, 6, r0, cr0, cr0, {1}
 220:	c8ce4228 	stmiagt	lr, {r3, r5, r9, lr}^
 224:	c4c5c6c7 	strbgt	ip, [r5], #1735	; 0x6c7
 228:	c342100e 	movtgt	r1, #8206	; 0x200e
 22c:	0ec0c1c2 	acseqdm	f4, f2
 230:	00000000 	andeq	r0, r0, r0
 234:	0000000c 	andeq	r0, r0, ip
 238:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 23c:	7c020001 	stcvc	0, cr0, [r2], {1}
 240:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 244:	00000014 	andeq	r0, r0, r4, lsl r0
 248:	00000234 	andeq	r0, r0, r4, lsr r2
 24c:	00008b48 	andeq	r8, r0, r8, asr #22
 250:	00000070 	andeq	r0, r0, r0, ror r0
 254:	84080e42 	strhi	r0, [r8], #-3650	; 0xe42
 258:	00018e02 	andeq	r8, r1, r2, lsl #28
 25c:	0000000c 	andeq	r0, r0, ip
 260:	00000234 	andeq	r0, r0, r4, lsr r2
 264:	00008bb8 			; <UNDEFINED> instruction: 0x00008bb8
 268:	00000014 	andeq	r0, r0, r4, lsl r0
 26c:	0000000c 	andeq	r0, r0, ip
 270:	00000234 	andeq	r0, r0, r4, lsr r2
 274:	00008bcc 	andeq	r8, r0, ip, asr #23
 278:	00000024 	andeq	r0, r0, r4, lsr #32
 27c:	0000000c 	andeq	r0, r0, ip
 280:	00000234 	andeq	r0, r0, r4, lsr r2
 284:	00008bf0 	strdeq	r8, [r0], -r0
 288:	00000028 	andeq	r0, r0, r8, lsr #32
 28c:	0000000c 	andeq	r0, r0, ip
 290:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 294:	7c020001 	stcvc	0, cr0, [r2], {1}
 298:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 29c:	00000018 	andeq	r0, r0, r8, lsl r0
 2a0:	0000028c 	andeq	r0, r0, ip, lsl #5
 2a4:	00008c18 	andeq	r8, r0, r8, lsl ip
 2a8:	00000074 	andeq	r0, r0, r4, ror r0
 2ac:	83100e42 	tsthi	r0, #1056	; 0x420
 2b0:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
 2b4:	00018e02 	andeq	r8, r1, r2, lsl #28
 2b8:	0000000c 	andeq	r0, r0, ip
 2bc:	0000028c 	andeq	r0, r0, ip, lsl #5
 2c0:	00008c8c 	andeq	r8, r0, ip, lsl #25
 2c4:	00000024 	andeq	r0, r0, r4, lsr #32
 2c8:	0000000c 	andeq	r0, r0, ip
 2cc:	0000028c 	andeq	r0, r0, ip, lsl #5
 2d0:	00008cb0 			; <UNDEFINED> instruction: 0x00008cb0
 2d4:	00000018 	andeq	r0, r0, r8, lsl r0
 2d8:	0000000c 	andeq	r0, r0, ip
 2dc:	0000028c 	andeq	r0, r0, ip, lsl #5
 2e0:	00008cc8 	andeq	r8, r0, r8, asr #25
 2e4:	00000018 	andeq	r0, r0, r8, lsl r0
 2e8:	0000000c 	andeq	r0, r0, ip
 2ec:	0000028c 	andeq	r0, r0, ip, lsl #5
 2f0:	00008ce0 	andeq	r8, r0, r0, ror #25
 2f4:	00000050 	andeq	r0, r0, r0, asr r0
 2f8:	0000000c 	andeq	r0, r0, ip
 2fc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 300:	7c020001 	stcvc	0, cr0, [r2], {1}
 304:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 308:	00000014 	andeq	r0, r0, r4, lsl r0
 30c:	000002f8 	strdeq	r0, [r0], -r8
 310:	00008d30 	andeq	r8, r0, r0, lsr sp
 314:	00000044 	andeq	r0, r0, r4, asr #32
 318:	84080e42 	strhi	r0, [r8], #-3650	; 0xe42
 31c:	00018e02 	andeq	r8, r1, r2, lsl #28
 320:	0000000c 	andeq	r0, r0, ip
 324:	000002f8 	strdeq	r0, [r0], -r8
 328:	00008d74 	andeq	r8, r0, r4, ror sp
 32c:	00000020 	andeq	r0, r0, r0, lsr #32
 330:	0000000c 	andeq	r0, r0, ip
 334:	000002f8 	strdeq	r0, [r0], -r8
 338:	00008d94 	muleq	r0, r4, sp
 33c:	00000014 	andeq	r0, r0, r4, lsl r0
 340:	0000000c 	andeq	r0, r0, ip
 344:	000002f8 	strdeq	r0, [r0], -r8
 348:	00008da8 	andeq	r8, r0, r8, lsr #27
 34c:	00000014 	andeq	r0, r0, r4, lsl r0
 350:	0000000c 	andeq	r0, r0, ip
 354:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 358:	7c020001 	stcvc	0, cr0, [r2], {1}
 35c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 360:	00000014 	andeq	r0, r0, r4, lsl r0
 364:	00000350 	andeq	r0, r0, r0, asr r3
 368:	00008dbc 			; <UNDEFINED> instruction: 0x00008dbc
 36c:	00000020 	andeq	r0, r0, r0, lsr #32
 370:	83080e42 	movwhi	r0, #36418	; 0x8e42
 374:	00018e02 	andeq	r8, r1, r2, lsl #28
 378:	00000014 	andeq	r0, r0, r4, lsl r0
 37c:	00000350 	andeq	r0, r0, r0, asr r3
 380:	00008ddc 	ldrdeq	r8, [r0], -ip
 384:	00000050 	andeq	r0, r0, r0, asr r0
 388:	84080e42 	strhi	r0, [r8], #-3650	; 0xe42
 38c:	00018e02 	andeq	r8, r1, r2, lsl #28
 390:	0000000c 	andeq	r0, r0, ip
 394:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 398:	7c020001 	stcvc	0, cr0, [r2], {1}
 39c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3a0:	0000000c 	andeq	r0, r0, ip
 3a4:	00000390 	muleq	r0, r0, r3
 3a8:	00008e2c 	andeq	r8, r0, ip, lsr #28
 3ac:	0000000c 	andeq	r0, r0, ip
 3b0:	00000014 	andeq	r0, r0, r4, lsl r0
 3b4:	00000390 	muleq	r0, r0, r3
 3b8:	00008e38 	andeq	r8, r0, r8, lsr lr
 3bc:	00000020 	andeq	r0, r0, r0, lsr #32
 3c0:	83080e42 	movwhi	r0, #36418	; 0x8e42
 3c4:	00018e02 	andeq	r8, r1, r2, lsl #28
 3c8:	00000054 	andeq	r0, r0, r4, asr r0
 3cc:	00000390 	muleq	r0, r0, r3
 3d0:	00008e58 	andeq	r8, r0, r8, asr lr
 3d4:	00000084 	andeq	r0, r0, r4, lsl #1
 3d8:	84100e50 	ldrhi	r0, [r0], #-3664	; 0xe50
 3dc:	86038504 	strhi	r8, [r3], -r4, lsl #10
 3e0:	48018e02 	stmdami	r1, {r1, r9, sl, fp, pc}
 3e4:	c5c4000e 	strbgt	r0, [r4, #14]
 3e8:	0e46cec6 	cdpeq	14, 4, cr12, cr6, cr6, {6}
 3ec:	85048410 	strhi	r8, [r4, #-1040]	; 0x410
 3f0:	8e028603 	cfmadd32hi	mvax0, mvfx8, mvfx2, mvfx3
 3f4:	000e4401 	andeq	r4, lr, r1, lsl #8
 3f8:	cec6c5c4 	cdpgt	5, 12, cr12, cr6, cr4, {6}
 3fc:	84100e42 	ldrhi	r0, [r0], #-3650	; 0xe42
 400:	86038504 	strhi	r8, [r3], -r4, lsl #10
 404:	50018e02 	andpl	r8, r1, r2, lsl #28
 408:	c5c4000e 	strbgt	r0, [r4, #14]
 40c:	0e46cec6 	cdpeq	14, 4, cr12, cr6, cr6, {6}
 410:	85048410 	strhi	r8, [r4, #-1040]	; 0x410
 414:	8e028603 	cfmadd32hi	mvax0, mvfx8, mvfx2, mvfx3
 418:	000e4401 	andeq	r4, lr, r1, lsl #8
 41c:	cec6c5c4 	cdpgt	5, 12, cr12, cr6, cr4, {6}
 420:	00000034 	andeq	r0, r0, r4, lsr r0
 424:	00000390 	muleq	r0, r0, r3
 428:	00008edc 	ldrdeq	r8, [r0], -ip
 42c:	000000b8 	strheq	r0, [r0], -r8
 430:	84180e46 	ldrhi	r0, [r8], #-3654	; 0xe46
 434:	86058506 	strhi	r8, [r5], -r6, lsl #10
 438:	88038704 	stmdahi	r3, {r2, r8, r9, sl, pc}
 43c:	02018e02 	andeq	r8, r1, #2, 28
 440:	c4000e4e 	strgt	r0, [r0], #-3662	; 0xe4e
 444:	c8c7c6c5 	stmiagt	r7, {r0, r2, r6, r7, r9, sl, lr, pc}^
 448:	180e44ce 	stmdane	lr, {r1, r2, r3, r6, r7, sl, lr}
 44c:	05850684 	streq	r0, [r5, #1668]	; 0x684
 450:	03870486 	orreq	r0, r7, #-2046820352	; 0x86000000
 454:	018e0288 	orreq	r0, lr, r8, lsl #5
 458:	0000000c 	andeq	r0, r0, ip
 45c:	00000390 	muleq	r0, r0, r3
 460:	00008f94 	muleq	r0, r4, pc	; <UNPREDICTABLE>
 464:	00000008 	andeq	r0, r0, r8
 468:	0000000c 	andeq	r0, r0, ip
 46c:	00000390 	muleq	r0, r0, r3
 470:	00008f9c 	muleq	r0, ip, pc	; <UNPREDICTABLE>
 474:	00000008 	andeq	r0, r0, r8
 478:	00000018 	andeq	r0, r0, r8, lsl r0
 47c:	00000390 	muleq	r0, r0, r3
 480:	00008fa4 	andeq	r8, r0, r4, lsr #31
 484:	00000098 	muleq	r0, r8, r0
 488:	8e040e48 	cdphi	14, 0, cr0, cr4, cr8, {2}
 48c:	000e7e01 	andeq	r7, lr, r1, lsl #28
 490:	000000ce 	andeq	r0, r0, lr, asr #1
 494:	00000018 	andeq	r0, r0, r8, lsl r0
 498:	00000390 	muleq	r0, r0, r3
 49c:	0000903c 	andeq	r9, r0, ip, lsr r0
 4a0:	000000c4 	andeq	r0, r0, r4, asr #1
 4a4:	840c0e42 	strhi	r0, [ip], #-3650	; 0xe42
 4a8:	8e028503 	cfsh32hi	mvfx8, mvfx2, #3
 4ac:	00000001 	andeq	r0, r0, r1
 4b0:	0000000c 	andeq	r0, r0, ip
 4b4:	00000390 	muleq	r0, r0, r3
 4b8:	00009100 	andeq	r9, r0, r0, lsl #2
 4bc:	00000038 	andeq	r0, r0, r8, lsr r0
 4c0:	00000014 	andeq	r0, r0, r4, lsl r0
 4c4:	00000390 	muleq	r0, r0, r3
 4c8:	00009138 	andeq	r9, r0, r8, lsr r1
 4cc:	000000f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 4d0:	84080e42 	strhi	r0, [r8], #-3650	; 0xe42
 4d4:	00018e02 	andeq	r8, r1, r2, lsl #28
 4d8:	00000018 	andeq	r0, r0, r8, lsl r0
 4dc:	00000390 	muleq	r0, r0, r3
 4e0:	00009228 	andeq	r9, r0, r8, lsr #4
 4e4:	00000284 	andeq	r0, r0, r4, lsl #5
 4e8:	83100e42 	tsthi	r0, #1056	; 0x420
 4ec:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
 4f0:	00018e02 	andeq	r8, r1, r2, lsl #28
 4f4:	00000014 	andeq	r0, r0, r4, lsl r0
 4f8:	00000390 	muleq	r0, r0, r3
 4fc:	000094ac 	andeq	r9, r0, ip, lsr #9
 500:	0000007c 	andeq	r0, r0, ip, ror r0
 504:	83080e42 	movwhi	r0, #36418	; 0x8e42
 508:	00018e02 	andeq	r8, r1, r2, lsl #28
 50c:	0000000c 	andeq	r0, r0, ip
 510:	00000390 	muleq	r0, r0, r3
 514:	00009528 	andeq	r9, r0, r8, lsr #10
 518:	00000010 	andeq	r0, r0, r0, lsl r0
 51c:	00000020 	andeq	r0, r0, r0, lsr #32
 520:	00000390 	muleq	r0, r0, r3
 524:	00009538 	andeq	r9, r0, r8, lsr r5
 528:	000000c0 	andeq	r0, r0, r0, asr #1
 52c:	84200e42 	strthi	r0, [r0], #-3650	; 0xe42
 530:	86078508 	strhi	r8, [r7], -r8, lsl #10
 534:	88058706 	stmdahi	r5, {r1, r2, r8, r9, sl, pc}
 538:	8a038904 	bhi	e2950 <__bss_end+0xb4950>
 53c:	00018e02 	andeq	r8, r1, r2, lsl #28
 540:	0000000c 	andeq	r0, r0, ip
 544:	00000390 	muleq	r0, r0, r3
 548:	000095f8 	strdeq	r9, [r0], -r8
 54c:	00000058 	andeq	r0, r0, r8, asr r0
 550:	0000000c 	andeq	r0, r0, ip
 554:	00000390 	muleq	r0, r0, r3
 558:	00009650 	andeq	r9, r0, r0, asr r6
 55c:	00000008 	andeq	r0, r0, r8
 560:	0000000c 	andeq	r0, r0, ip
 564:	00000390 	muleq	r0, r0, r3
 568:	00009658 	andeq	r9, r0, r8, asr r6
 56c:	00000008 	andeq	r0, r0, r8
 570:	0000000c 	andeq	r0, r0, ip
 574:	00000390 	muleq	r0, r0, r3
 578:	00009660 	andeq	r9, r0, r0, ror #12
 57c:	00000008 	andeq	r0, r0, r8
 580:	0000000c 	andeq	r0, r0, ip
 584:	00000390 	muleq	r0, r0, r3
 588:	00009668 	andeq	r9, r0, r8, ror #12
 58c:	00000008 	andeq	r0, r0, r8
 590:	0000000c 	andeq	r0, r0, ip
 594:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 598:	7c010001 	stcvc	0, cr0, [r1], {1}
 59c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5a0:	0000000c 	andeq	r0, r0, ip
 5a4:	00000590 	muleq	r0, r0, r5
 5a8:	000097f8 	strdeq	r9, [r0], -r8
 5ac:	000000f4 	strdeq	r0, [r0], -r4
 5b0:	0000000c 	andeq	r0, r0, ip
 5b4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5b8:	7c010001 	stcvc	0, cr0, [r1], {1}
 5bc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5c0:	0000000c 	andeq	r0, r0, ip
 5c4:	000005b0 			; <UNDEFINED> instruction: 0x000005b0
 5c8:	0000990c 	andeq	r9, r0, ip, lsl #18
 5cc:	00000128 	andeq	r0, r0, r8, lsr #2
 5d0:	0000000c 	andeq	r0, r0, ip
 5d4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5d8:	7c010001 	stcvc	0, cr0, [r1], {1}
 5dc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5e0:	00000014 	andeq	r0, r0, r4, lsl r0
 5e4:	000005d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 5e8:	0000a110 	andeq	sl, r0, r0, lsl r1
 5ec:	0000003c 	andeq	r0, r0, ip, lsr r0
 5f0:	0e038e68 	cdpeq	14, 0, cr8, cr3, cr8, {3}
 5f4:	00000010 	andeq	r0, r0, r0, lsl r0
 5f8:	0000000c 	andeq	r0, r0, ip
 5fc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 600:	7c020001 	stcvc	0, cr0, [r2], {1}
 604:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 608:	0000000c 	andeq	r0, r0, ip
 60c:	000005f8 	strdeq	r0, [r0], -r8
 610:	0000a14c 	andeq	sl, r0, ip, asr #2
 614:	00000044 	andeq	r0, r0, r4, asr #32
 618:	0000000c 	andeq	r0, r0, ip
 61c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 620:	7c020001 	stcvc	0, cr0, [r2], {1}
 624:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 628:	0000002c 	andeq	r0, r0, ip, lsr #32
 62c:	00000618 	andeq	r0, r0, r8, lsl r6
 630:	0000a190 	muleq	r0, r0, r1
 634:	00000044 	andeq	r0, r0, r4, asr #32
 638:	84200e42 	strthi	r0, [r0], #-3650	; 0xe42
 63c:	86078508 	strhi	r8, [r7], -r8, lsl #10
 640:	88058706 	stmdahi	r5, {r1, r2, r8, r9, sl, pc}
 644:	8a038904 	bhi	e2a5c <__bss_end+0xb4a5c>
 648:	5e018e02 	cdppl	14, 0, cr8, cr1, cr2, {0}
 64c:	c8c9cace 	stmiagt	r9, {r1, r2, r3, r6, r7, r9, fp, lr, pc}^
 650:	c4c5c6c7 	strbgt	ip, [r5], #1735	; 0x6c7
 654:	0000000e 	andeq	r0, r0, lr
 658:	00000024 	andeq	r0, r0, r4, lsr #32
 65c:	00000618 	andeq	r0, r0, r8, lsl r6
 660:	0000a1d4 	ldrdeq	sl, [r0], -r4
 664:	00000040 	andeq	r0, r0, r0, asr #32
 668:	84180e42 	ldrhi	r0, [r8], #-3650	; 0xe42
 66c:	86058506 	strhi	r8, [r5], -r6, lsl #10
 670:	88038704 	stmdahi	r3, {r2, r8, r9, sl, pc}
 674:	5c018e02 	stcpl	14, cr8, [r1], {2}
 678:	c6c7c8ce 	strbgt	ip, [r7], lr, asr #17
 67c:	000ec4c5 	andeq	ip, lr, r5, asr #9
 680:	0000000c 	andeq	r0, r0, ip
 684:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 688:	7c020001 	stcvc	0, cr0, [r2], {1}
 68c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 690:	00000034 	andeq	r0, r0, r4, lsr r0
 694:	00000680 	andeq	r0, r0, r0, lsl #13
 698:	0000a214 	andeq	sl, r0, r4, lsl r2
 69c:	00000178 	andeq	r0, r0, r8, ror r1
 6a0:	83280e44 	teqhi	r8, #68, 28	; 0x440
 6a4:	8509840a 	strhi	r8, [r9, #-1034]	; 0x40a
 6a8:	87078608 	strhi	r8, [r7, -r8, lsl #12]
 6ac:	89058806 	stmdbhi	r5, {r1, r2, fp, pc}
 6b0:	8b038a04 	blhi	e2ec8 <__bss_end+0xb4ec8>
 6b4:	02018e02 	andeq	r8, r1, #2, 28
 6b8:	cbce0aa6 	blgt	ff383158 <__user_program+0xff083158>
 6bc:	c7c8c9ca 	strbgt	ip, [r8, sl, asr #19]
 6c0:	c3c4c5c6 	bicgt	ip, r4, #830472192	; 0x31800000
 6c4:	0b42000e 	bleq	1080704 <__user_program+0xd80704>
 6c8:	0000000c 	andeq	r0, r0, ip
 6cc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 6d0:	7c020001 	stcvc	0, cr0, [r2], {1}
 6d4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 6d8:	0000002c 	andeq	r0, r0, ip, lsr #32
 6dc:	000006c8 	andeq	r0, r0, r8, asr #13
 6e0:	0000a38c 	andeq	sl, r0, ip, lsl #7
 6e4:	00000120 	andeq	r0, r0, r0, lsr #2
 6e8:	84200e46 	strthi	r0, [r0], #-3654	; 0xe46
 6ec:	86078508 	strhi	r8, [r7], -r8, lsl #10
 6f0:	88058706 	stmdahi	r5, {r1, r2, r8, r9, sl, pc}
 6f4:	8a038904 	bhi	e2b0c <__bss_end+0xb4b0c>
 6f8:	02018e02 	andeq	r8, r1, #2, 28
 6fc:	c9cace88 	stmibgt	sl, {r3, r7, r9, sl, fp, lr, pc}^
 700:	c5c6c7c8 	strbgt	ip, [r6, #1992]	; 0x7c8
 704:	00000ec4 	andeq	r0, r0, r4, asr #29

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
       0:	00000000 	andeq	r0, r0, r0
       4:	00000038 	andeq	r0, r0, r8, lsr r0
       8:	38500001 	ldmdacc	r0, {r0}^
       c:	54000000 	strpl	r0, [r0], #-0
      10:	04000000 	streq	r0, [r0], #-0
      14:	5001f300 	andpl	pc, r1, r0, lsl #6
      18:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
      1c:	00000000 	andeq	r0, r0, r0
      20:	00000c00 	andeq	r0, r0, r0, lsl #24
      24:	00003800 	andeq	r3, r0, r0, lsl #16
      28:	70000e00 	andvc	r0, r0, r0, lsl #28
      2c:	3a25f700 	bcc	97dc34 <__user_program+0x67dc34>
      30:	f71b25f7 			; <UNDEFINED> instruction: 0xf71b25f7
      34:	1aff0800 	bne	fffc203c <__user_program+0xffcc203c>
      38:	0000389f 	muleq	r0, pc, r8	; <UNPREDICTABLE>
      3c:	00005400 	andeq	r5, r0, r0, lsl #8
      40:	f3000f00 	vpmax.f32	d0, d0, d0
      44:	25f75001 	ldrbcs	r5, [r7, #1]!
      48:	1b25f73a 	blne	97dd38 <__user_program+0x67dd38>
      4c:	ff0800f7 			; <UNDEFINED> instruction: 0xff0800f7
      50:	00009f1a 	andeq	r9, r0, sl, lsl pc
      54:	00000000 	andeq	r0, r0, r0
      58:	00300000 	eorseq	r0, r0, r0
      5c:	004c0000 	subeq	r0, ip, r0
      60:	00010000 	andeq	r0, r1, r0
      64:	00004c52 	andeq	r4, r0, r2, asr ip
      68:	00005400 	andeq	r5, r0, r0, lsl #8
      6c:	50000100 	andpl	r0, r0, r0, lsl #2
	...
      78:	00000040 	andeq	r0, r0, r0, asr #32
      7c:	0000004c 	andeq	r0, r0, ip, asr #32
      80:	00500001 	subseq	r0, r0, r1
      84:	00000000 	andeq	r0, r0, r0
      88:	54000000 	strpl	r0, [r0], #-0
      8c:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
      90:	01000000 	mrseq	r0, (UNDEF: 0)
      94:	00685000 	rsbeq	r5, r8, r0
      98:	00800000 	addeq	r0, r0, r0
      9c:	00040000 	andeq	r0, r4, r0
      a0:	9f5001f3 	svcls	0x005001f3
      a4:	00000080 	andeq	r0, r0, r0, lsl #1
      a8:	00000088 	andeq	r0, r0, r8, lsl #1
      ac:	88500001 	ldmdahi	r0, {r0}^
      b0:	98000000 	stmdals	r0, {}	; <UNPREDICTABLE>
      b4:	04000000 	streq	r0, [r0], #-0
      b8:	5001f300 	andpl	pc, r1, r0, lsl #6
      bc:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
      c0:	00000000 	andeq	r0, r0, r0
      c4:	00009800 	andeq	r9, r0, r0, lsl #16
      c8:	0000ac00 	andeq	sl, r0, r0, lsl #24
      cc:	50000100 	andpl	r0, r0, r0, lsl #2
      d0:	000000ac 	andeq	r0, r0, ip, lsr #1
      d4:	000000c4 	andeq	r0, r0, r4, asr #1
      d8:	01f30004 	mvnseq	r0, r4
      dc:	00c49f50 	sbceq	r9, r4, r0, asr pc
      e0:	00cc0000 	sbceq	r0, ip, r0
      e4:	00010000 	andeq	r0, r1, r0
      e8:	0000cc50 	andeq	ip, r0, r0, asr ip
      ec:	0000dc00 	andeq	sp, r0, r0, lsl #24
      f0:	f3000400 	vshl.u8	d0, d0, d0
      f4:	009f5001 	addseq	r5, pc, r1
      f8:	00000000 	andeq	r0, r0, r0
      fc:	dc000000 	stcle	0, cr0, [r0], {-0}
     100:	00000000 	andeq	r0, r0, r0
     104:	01000001 	tsteq	r0, r1
     108:	01005000 	mrseq	r5, (UNDEF: 0)
     10c:	01600000 	cmneq	r0, r0
     110:	00040000 	andeq	r0, r4, r0
     114:	9f5001f3 	svcls	0x005001f3
	...
     120:	000000dc 	ldrdeq	r0, [r0], -ip
     124:	00000103 	andeq	r0, r0, r3, lsl #2
     128:	03510001 	cmpeq	r1, #1
     12c:	60000001 	andvs	r0, r0, r1
     130:	04000001 	streq	r0, [r0], #-1
     134:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     138:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     13c:	00000000 	andeq	r0, r0, r0
     140:	00000400 	andeq	r0, r0, r0, lsl #8
     144:	00002400 	andeq	r2, r0, r0, lsl #8
     148:	30000200 	andcc	r0, r0, r0, lsl #4
     14c:	0000249f 	muleq	r0, pc, r4	; <UNPREDICTABLE>
     150:	00004400 	andeq	r4, r0, r0, lsl #8
     154:	53000100 	movwpl	r0, #256	; 0x100
	...
     160:	000001c0 	andeq	r0, r0, r0, asr #3
     164:	00000230 	andeq	r0, r0, r0, lsr r2
     168:	fc530001 	mrrc2	0, 0, r0, r3, cr1
     16c:	34000002 	strcc	r0, [r0], #-2
     170:	02000003 	andeq	r0, r0, #3
     174:	009f3000 	addseq	r3, pc, r0
     178:	00000000 	andeq	r0, r0, r0
     17c:	40000000 	andmi	r0, r0, r0
     180:	4c000002 	stcmi	0, cr0, [r0], {2}
     184:	01000002 	tsteq	r0, r2
     188:	024c5300 	subeq	r5, ip, #0, 6
     18c:	02fc0000 	rscseq	r0, ip, #0
     190:	00010000 	andeq	r0, r1, r0
     194:	00000052 	andeq	r0, r0, r2, asr r0
     198:	00000000 	andeq	r0, r0, r0
     19c:	00009800 	andeq	r9, r0, r0, lsl #16
     1a0:	00018800 	andeq	r8, r1, r0, lsl #16
     1a4:	75000d00 	strvc	r0, [r0, #-3328]	; 0xd00
     1a8:	10740a00 	rsbsne	r0, r4, r0, lsl #20
     1ac:	d004031e 	andle	r0, r4, lr, lsl r3
     1b0:	9f220000 	svcls	0x00220000
	...
     1bc:	00000188 	andeq	r0, r0, r8, lsl #3
     1c0:	000001a4 	andeq	r0, r0, r4, lsr #3
     1c4:	00550001 	subseq	r0, r5, r1
     1c8:	00000000 	andeq	r0, r0, r0
     1cc:	d0000000 	andle	r0, r0, r0
     1d0:	20000001 	andcs	r0, r0, r1
     1d4:	0d000002 	stceq	0, cr0, [r0, #-8]
     1d8:	0a007300 	beq	1cde0 <tcb_array+0xfddc>
     1dc:	031e1074 	tsteq	lr, #116	; 0x74
     1e0:	0000d004 	andeq	sp, r0, r4
     1e4:	00009f22 	andeq	r9, r0, r2, lsr #30
     1e8:	00000000 	andeq	r0, r0, r0
     1ec:	02600000 	rsbeq	r0, r0, #0
     1f0:	02940000 	addseq	r0, r4, #0
     1f4:	000d0000 	andeq	r0, sp, r0
     1f8:	740a0072 	strvc	r0, [sl], #-114	; 0x72
     1fc:	04031e10 	streq	r1, [r3], #-3600	; 0xe10
     200:	220000d0 	andcs	r0, r0, #208	; 0xd0
     204:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     208:	00000000 	andeq	r0, r0, r0
     20c:	0002c000 	andeq	ip, r2, r0
     210:	0002d000 	andeq	sp, r2, r0
     214:	7c000d00 	stcvc	13, cr0, [r0], {-0}
     218:	10740a00 	rsbsne	r0, r4, r0, lsl #20
     21c:	d004031e 	andle	r0, r4, lr, lsl r3
     220:	9f220000 	svcls	0x00220000
     224:	000002dc 	ldrdeq	r0, [r0], -ip
     228:	000002e4 	andeq	r0, r0, r4, ror #5
     22c:	0071000d 	rsbseq	r0, r1, sp
     230:	1e10740a 	cfmulsne	mvf7, mvf0, mvf10
     234:	00d00403 	sbcseq	r0, r0, r3, lsl #8
     238:	009f2200 	addseq	r2, pc, r0, lsl #4
     23c:	00000000 	andeq	r0, r0, r0
     240:	34000000 	strcc	r0, [r0], #-0
     244:	cc000003 	stcgt	0, cr0, [r0], {3}
     248:	01000003 	tsteq	r0, r3
     24c:	03cc5000 	biceq	r5, ip, #0
     250:	03e40000 	mvneq	r0, #0
     254:	00040000 	andeq	r0, r4, r0
     258:	9f7fb476 	svcls	0x007fb476
	...
     264:	00000338 	andeq	r0, r0, r8, lsr r3
     268:	00000370 	andeq	r0, r0, r0, ror r3
     26c:	70500001 	subsvc	r0, r0, r1
     270:	74000003 	strvc	r0, [r0], #-3
     274:	01000003 	tsteq	r0, r3
     278:	03745c00 	cmneq	r4, #0, 24
     27c:	03840000 	orreq	r0, r4, #0
     280:	00030000 	andeq	r0, r3, r0
     284:	849f7c7c 	ldrhi	r7, [pc], #3196	; 28c <__start-0x7d74>
     288:	ac000003 	stcge	0, cr0, [r0], {3}
     28c:	01000003 	tsteq	r0, r3
     290:	03ac5c00 			; <UNDEFINED> instruction: 0x03ac5c00
     294:	03b00000 	movseq	r0, #0
     298:	00010000 	andeq	r0, r1, r0
     29c:	0003b052 	andeq	fp, r3, r2, asr r0
     2a0:	0003bc00 	andeq	fp, r3, r0, lsl #24
     2a4:	72000300 	andvc	r0, r0, #0, 6
     2a8:	03bc9f7c 			; <UNDEFINED> instruction: 0x03bc9f7c
     2ac:	03d00000 	bicseq	r0, r0, #0
     2b0:	00010000 	andeq	r0, r1, r0
     2b4:	00000052 	andeq	r0, r0, r2, asr r0
     2b8:	00000000 	andeq	r0, r0, r0
     2bc:	00035000 	andeq	r5, r3, r0
     2c0:	0003dc00 	andeq	sp, r3, r0, lsl #24
     2c4:	74000d00 	strvc	r0, [r0], #-3328	; 0xd00
     2c8:	10740a00 	rsbsne	r0, r4, r0, lsl #20
     2cc:	d004031e 	andle	r0, r4, lr, lsl r3
     2d0:	9f220000 	svcls	0x00220000
	...
     2dc:	00000350 	andeq	r0, r0, r0, asr r3
     2e0:	00000370 	andeq	r0, r0, r0, ror r3
     2e4:	9f300002 	svcls	0x00300002
     2e8:	00000370 	andeq	r0, r0, r0, ror r3
     2ec:	00000398 	muleq	r0, r8, r3
     2f0:	ac510001 	mrrcge	0, 0, r0, r1, cr1
     2f4:	cc000003 	stcgt	0, cr0, [r0], {3}
     2f8:	01000003 	tsteq	r0, r3
     2fc:	00005100 	andeq	r5, r0, r0, lsl #2
     300:	00000000 	andeq	r0, r0, r0
     304:	03e40000 	mvneq	r0, #0
     308:	04980000 	ldreq	r0, [r8], #0
     30c:	00010000 	andeq	r0, r1, r0
     310:	00049850 	andeq	r9, r4, r0, asr r8
     314:	00049c00 	andeq	r9, r4, r0, lsl #24
     318:	74000400 	strvc	r0, [r0], #-1024	; 0x400
     31c:	009f00d0 	ldrsbeq	r0, [pc], r0	; <UNPREDICTABLE>
     320:	00000000 	andeq	r0, r0, r0
     324:	e8000000 	stmda	r0, {}	; <UNPREDICTABLE>
     328:	1c000003 	stcne	0, cr0, [r0], {3}
     32c:	01000004 	tsteq	r0, r4
     330:	041c5000 	ldreq	r5, [ip], #-0
     334:	04600000 	strbteq	r0, [r0], #-0
     338:	00010000 	andeq	r0, r1, r0
     33c:	00047452 	andeq	r7, r4, r2, asr r4
     340:	00049400 	andeq	r9, r4, r0, lsl #8
     344:	51000100 	mrspl	r0, (UNDEF: 16)
     348:	00000494 	muleq	r0, r4, r4
     34c:	00000498 	muleq	r0, r8, r4
     350:	b4700004 	ldrbtlt	r0, [r0], #-4
     354:	04989f7f 	ldreq	r9, [r8], #3967	; 0xf7f
     358:	049c0000 	ldreq	r0, [ip], #0
     35c:	00010000 	andeq	r0, r1, r0
     360:	00000050 	andeq	r0, r0, r0, asr r0
     364:	00000000 	andeq	r0, r0, r0
     368:	00040000 	andeq	r0, r4, r0
     36c:	00047400 	andeq	r7, r4, r0, lsl #8
     370:	7e000d00 	cdpvc	13, 0, cr0, cr0, cr0, {0}
     374:	10740a00 	rsbsne	r0, r4, r0, lsl #20
     378:	d004031e 	andle	r0, r4, lr, lsl r3
     37c:	9f220000 	svcls	0x00220000
	...
     388:	0000041c 	andeq	r0, r0, ip, lsl r4
     38c:	00000438 	andeq	r0, r0, r8, lsr r4
     390:	9f3c0002 	svcls	0x003c0002
     394:	00000438 	andeq	r0, r0, r8, lsr r4
     398:	00000458 	andeq	r0, r0, r8, asr r4
     39c:	74510001 	ldrbvc	r0, [r1], #-1
     3a0:	9c000004 	stcls	0, cr0, [r0], {4}
     3a4:	01000004 	tsteq	r0, r4
     3a8:	00005200 	andeq	r5, r0, r0, lsl #4
     3ac:	00000000 	andeq	r0, r0, r0
     3b0:	049c0000 	ldreq	r0, [ip], #0
     3b4:	04a70000 	strteq	r0, [r7], #0
     3b8:	00010000 	andeq	r0, r1, r0
     3bc:	0004a750 	andeq	sl, r4, r0, asr r7
     3c0:	0004e000 	andeq	lr, r4, r0
     3c4:	54000100 	strpl	r0, [r0], #-256	; 0x100
     3c8:	000004e0 	andeq	r0, r0, r0, ror #9
     3cc:	000004f4 	strdeq	r0, [r0], -r4
     3d0:	b4740004 	ldrbtlt	r0, [r4], #-4
     3d4:	04f49f7f 	ldrbteq	r9, [r4], #3967	; 0xf7f
     3d8:	05000000 	streq	r0, [r0, #-0]
     3dc:	00010000 	andeq	r0, r1, r0
     3e0:	00050054 	andeq	r0, r5, r4, asr r0
     3e4:	00051000 	andeq	r1, r5, r0
     3e8:	f3000400 	vshl.u8	d0, d0, d0
     3ec:	109f5001 	addsne	r5, pc, r1
     3f0:	18000005 	stmdane	r0, {r0, r2}
     3f4:	01000005 	tsteq	r0, r5
     3f8:	00005400 	andeq	r5, r0, r0, lsl #8
     3fc:	00000000 	andeq	r0, r0, r0
     400:	04e00000 	strbteq	r0, [r0], #0
     404:	04f40000 	ldrbteq	r0, [r4], #0
     408:	00010000 	andeq	r0, r1, r0
     40c:	00050054 	andeq	r0, r5, r4, asr r0
     410:	00051000 	andeq	r1, r5, r0
     414:	54000100 	strpl	r0, [r0], #-256	; 0x100
	...
     420:	00000518 	andeq	r0, r0, r8, lsl r5
     424:	0000057c 	andeq	r0, r0, ip, ror r5
     428:	7c500001 	mrrcvc	0, 0, r0, r0, cr1	; <UNPREDICTABLE>
     42c:	84000005 	strhi	r0, [r0], #-5
     430:	04000005 	streq	r0, [r0], #-5
     434:	5001f300 	andpl	pc, r1, r0, lsl #6
     438:	0005849f 	muleq	r5, pc, r4	; <UNPREDICTABLE>
     43c:	00058800 	andeq	r8, r5, r0, lsl #16
     440:	50000100 	andpl	r0, r0, r0, lsl #2
     444:	00000588 	andeq	r0, r0, r8, lsl #11
     448:	00000598 	muleq	r0, r8, r5
     44c:	01f30004 	mvnseq	r0, r4
     450:	05989f50 	ldreq	r9, [r8, #3920]	; 0xf50
     454:	059c0000 	ldreq	r0, [ip]
     458:	00010000 	andeq	r0, r1, r0
     45c:	00059c50 	andeq	r9, r5, r0, asr ip
     460:	0005a400 	andeq	sl, r5, r0, lsl #8
     464:	f3000400 	vshl.u8	d0, d0, d0
     468:	a49f5001 	ldrge	r5, [pc], #1	; 470 <__start-0x7b90>
     46c:	a8000005 	stmdage	r0, {r0, r2}
     470:	01000005 	tsteq	r0, r5
     474:	05a85000 	streq	r5, [r8, #0]!
     478:	05b40000 	ldreq	r0, [r4, #0]!
     47c:	00040000 	andeq	r0, r4, r0
     480:	9f5001f3 	svcls	0x005001f3
     484:	000005b4 			; <UNDEFINED> instruction: 0x000005b4
     488:	000005b8 			; <UNDEFINED> instruction: 0x000005b8
     48c:	b8500001 	ldmdalt	r0, {r0}^
     490:	c0000005 	andgt	r0, r0, r5
     494:	04000005 	streq	r0, [r0], #-5
     498:	5001f300 	andpl	pc, r1, r0, lsl #6
     49c:	0005c09f 	muleq	r5, pc, r0	; <UNPREDICTABLE>
     4a0:	0005c400 	andeq	ip, r5, r0, lsl #8
     4a4:	50000100 	andpl	r0, r0, r0, lsl #2
     4a8:	000005c4 	andeq	r0, r0, r4, asr #11
     4ac:	000005d4 	ldrdeq	r0, [r0], -r4
     4b0:	01f30004 	mvnseq	r0, r4
     4b4:	05d49f50 	ldrbeq	r9, [r4, #3920]	; 0xf50
     4b8:	05d80000 	ldrbeq	r0, [r8]
     4bc:	00010000 	andeq	r0, r1, r0
     4c0:	0005d850 	andeq	sp, r5, r0, asr r8
     4c4:	0005e800 	andeq	lr, r5, r0, lsl #16
     4c8:	f3000400 	vshl.u8	d0, d0, d0
     4cc:	e89f5001 	ldm	pc, {r0, ip, lr}	; <UNPREDICTABLE>
     4d0:	ec000005 	stc	0, cr0, [r0], {5}
     4d4:	01000005 	tsteq	r0, r5
     4d8:	05ec5000 	strbeq	r5, [ip, #0]!
     4dc:	05f80000 	ldrbeq	r0, [r8, #0]!
     4e0:	00040000 	andeq	r0, r4, r0
     4e4:	9f5001f3 	svcls	0x005001f3
     4e8:	000005f8 	strdeq	r0, [r0], -r8
     4ec:	000005fc 	strdeq	r0, [r0], -ip
     4f0:	fc500001 	mrrc2	0, 0, r0, r0, cr1	; <UNPREDICTABLE>
     4f4:	0c000005 	stceq	0, cr0, [r0], {5}
     4f8:	04000006 	streq	r0, [r0], #-6
     4fc:	5001f300 	andpl	pc, r1, r0, lsl #6
     500:	00060c9f 	muleq	r6, pc, ip	; <UNPREDICTABLE>
     504:	00060f00 	andeq	r0, r6, r0, lsl #30
     508:	50000100 	andpl	r0, r0, r0, lsl #2
     50c:	0000060f 	andeq	r0, r0, pc, lsl #12
     510:	00000614 	andeq	r0, r0, r4, lsl r6
     514:	01f30004 	mvnseq	r0, r4
     518:	06149f50 	ssaxeq	r9, r4, r0
     51c:	06180000 	ldreq	r0, [r8], -r0
     520:	00010000 	andeq	r0, r1, r0
     524:	00061850 	andeq	r1, r6, r0, asr r8
     528:	00062400 	andeq	r2, r6, r0, lsl #8
     52c:	f3000400 	vshl.u8	d0, d0, d0
     530:	249f5001 	ldrcs	r5, [pc], #1	; 538 <__start-0x7ac8>
     534:	28000006 	stmdacs	r0, {r1, r2}
     538:	01000006 	tsteq	r0, r6
     53c:	06285000 	strteq	r5, [r8], -r0
     540:	06440000 	strbeq	r0, [r4], -r0
     544:	00040000 	andeq	r0, r4, r0
     548:	9f5001f3 	svcls	0x005001f3
     54c:	00000644 	andeq	r0, r0, r4, asr #12
     550:	00000648 	andeq	r0, r0, r8, asr #12
     554:	48500001 	ldmdami	r0, {r0}^
     558:	54000006 	strpl	r0, [r0], #-6
     55c:	04000006 	streq	r0, [r0], #-6
     560:	5001f300 	andpl	pc, r1, r0, lsl #6
     564:	0006549f 	muleq	r6, pc, r4	; <UNPREDICTABLE>
     568:	00065800 	andeq	r5, r6, r0, lsl #16
     56c:	50000100 	andpl	r0, r0, r0, lsl #2
     570:	00000658 	andeq	r0, r0, r8, asr r6
     574:	00000664 	andeq	r0, r0, r4, ror #12
     578:	01f30004 	mvnseq	r0, r4
     57c:	06649f50 	uqsaxeq	r9, r4, r0
     580:	06680000 	strbteq	r0, [r8], -r0
     584:	00010000 	andeq	r0, r1, r0
     588:	00066850 	andeq	r6, r6, r0, asr r8
     58c:	00067400 	andeq	r7, r6, r0, lsl #8
     590:	f3000400 	vshl.u8	d0, d0, d0
     594:	749f5001 	ldrvc	r5, [pc], #1	; 59c <__start-0x7a64>
     598:	77000006 	strvc	r0, [r0, -r6]
     59c:	01000006 	tsteq	r0, r6
     5a0:	06775000 	ldrbteq	r5, [r7], -r0
     5a4:	06800000 	streq	r0, [r0], r0
     5a8:	00040000 	andeq	r0, r4, r0
     5ac:	9f5001f3 	svcls	0x005001f3
     5b0:	00000680 	andeq	r0, r0, r0, lsl #13
     5b4:	00000683 	andeq	r0, r0, r3, lsl #13
     5b8:	83500001 	cmphi	r0, #1
     5bc:	88000006 	stmdahi	r0, {r1, r2}
     5c0:	04000006 	streq	r0, [r0], #-6
     5c4:	5001f300 	andpl	pc, r1, r0, lsl #6
     5c8:	0006889f 	muleq	r6, pc, r8	; <UNPREDICTABLE>
     5cc:	00068b00 	andeq	r8, r6, r0, lsl #22
     5d0:	50000100 	andpl	r0, r0, r0, lsl #2
     5d4:	0000068b 	andeq	r0, r0, fp, lsl #13
     5d8:	00000690 	muleq	r0, r0, r6
     5dc:	01f30004 	mvnseq	r0, r4
     5e0:	06909f50 			; <UNDEFINED> instruction: 0x06909f50
     5e4:	06940000 	ldreq	r0, [r4], r0
     5e8:	00010000 	andeq	r0, r1, r0
     5ec:	00069450 	andeq	r9, r6, r0, asr r4
     5f0:	00069c00 	andeq	r9, r6, r0, lsl #24
     5f4:	f3000400 	vshl.u8	d0, d0, d0
     5f8:	009f5001 	addseq	r5, pc, r1
     5fc:	00000000 	andeq	r0, r0, r0
     600:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     604:	7f000005 	svcvc	0x00000005
     608:	01000005 	tsteq	r0, r5
     60c:	057f5100 	ldrbeq	r5, [pc, #-256]!	; 514 <__start-0x7aec>
     610:	05840000 	streq	r0, [r4]
     614:	00040000 	andeq	r0, r4, r0
     618:	9f5101f3 	svcls	0x005101f3
     61c:	00000584 	andeq	r0, r0, r4, lsl #11
     620:	0000058c 	andeq	r0, r0, ip, lsl #11
     624:	8c510001 	mrrchi	0, 0, r0, r1, cr1
     628:	93000005 	movwls	r0, #5
     62c:	01000005 	tsteq	r0, r5
     630:	05935c00 	ldreq	r5, [r3, #3072]	; 0xc00
     634:	05980000 	ldreq	r0, [r8]
     638:	00040000 	andeq	r0, r4, r0
     63c:	9f5101f3 	svcls	0x005101f3
     640:	00000598 	muleq	r0, r8, r5
     644:	0000059f 	muleq	r0, pc, r5	; <UNPREDICTABLE>
     648:	9f510001 	svcls	0x00510001
     64c:	a4000005 	strge	r0, [r0], #-5
     650:	04000005 	streq	r0, [r0], #-5
     654:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     658:	0005a49f 	muleq	r5, pc, r4	; <UNPREDICTABLE>
     65c:	0005ac00 	andeq	sl, r5, r0, lsl #24
     660:	51000100 	mrspl	r0, (UNDEF: 16)
     664:	000005ac 	andeq	r0, r0, ip, lsr #11
     668:	000005af 	andeq	r0, r0, pc, lsr #11
     66c:	af5c0001 	svcge	0x005c0001
     670:	b4000005 	strlt	r0, [r0], #-5
     674:	04000005 	streq	r0, [r0], #-5
     678:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     67c:	0005b49f 	muleq	r5, pc, r4	; <UNPREDICTABLE>
     680:	0005bb00 	andeq	fp, r5, r0, lsl #22
     684:	51000100 	mrspl	r0, (UNDEF: 16)
     688:	000005bb 			; <UNDEFINED> instruction: 0x000005bb
     68c:	000005c0 	andeq	r0, r0, r0, asr #11
     690:	01f30004 	mvnseq	r0, r4
     694:	05c09f51 	strbeq	r9, [r0, #3921]	; 0xf51
     698:	05c80000 	strbeq	r0, [r8]
     69c:	00010000 	andeq	r0, r1, r0
     6a0:	0005c851 	andeq	ip, r5, r1, asr r8
     6a4:	0005cf00 	andeq	ip, r5, r0, lsl #30
     6a8:	5c000100 	stfpls	f0, [r0], {-0}
     6ac:	000005cf 	andeq	r0, r0, pc, asr #11
     6b0:	000005d4 	ldrdeq	r0, [r0], -r4
     6b4:	01f30004 	mvnseq	r0, r4
     6b8:	05d49f51 	ldrbeq	r9, [r4, #3921]	; 0xf51
     6bc:	05dc0000 	ldrbeq	r0, [ip]
     6c0:	00010000 	andeq	r0, r1, r0
     6c4:	0005dc51 	andeq	sp, r5, r1, asr ip
     6c8:	0005e300 	andeq	lr, r5, r0, lsl #6
     6cc:	5c000100 	stfpls	f0, [r0], {-0}
     6d0:	000005e3 	andeq	r0, r0, r3, ror #11
     6d4:	000005e8 	andeq	r0, r0, r8, ror #11
     6d8:	01f30004 	mvnseq	r0, r4
     6dc:	05e89f51 	strbeq	r9, [r8, #3921]!	; 0xf51
     6e0:	05ef0000 	strbeq	r0, [pc, #0]!	; 6e8 <__start-0x7918>
     6e4:	00010000 	andeq	r0, r1, r0
     6e8:	0005ef51 	andeq	lr, r5, r1, asr pc
     6ec:	0005f800 	andeq	pc, r5, r0, lsl #16
     6f0:	f3000400 	vshl.u8	d0, d0, d0
     6f4:	f89f5101 			; <UNDEFINED> instruction: 0xf89f5101
     6f8:	00000005 	andeq	r0, r0, r5
     6fc:	01000006 	tsteq	r0, r6
     700:	06005100 	streq	r5, [r0], -r0, lsl #2
     704:	06070000 	streq	r0, [r7], -r0
     708:	00010000 	andeq	r0, r1, r0
     70c:	0006075c 	andeq	r0, r6, ip, asr r7
     710:	00060c00 	andeq	r0, r6, r0, lsl #24
     714:	f3000400 	vshl.u8	d0, d0, d0
     718:	0c9f5101 	ldfeqs	f5, [pc], {1}
     71c:	0f000006 	svceq	0x00000006
     720:	01000006 	tsteq	r0, r6
     724:	060f5100 	streq	r5, [pc], -r0, lsl #2
     728:	06140000 	ldreq	r0, [r4], -r0
     72c:	00040000 	andeq	r0, r4, r0
     730:	9f5101f3 	svcls	0x005101f3
     734:	00000614 	andeq	r0, r0, r4, lsl r6
     738:	0000061c 	andeq	r0, r0, ip, lsl r6
     73c:	1c510001 	mrrcne	0, 0, r0, r1, cr1
     740:	1f000006 	svcne	0x00000006
     744:	01000006 	tsteq	r0, r6
     748:	061f5c00 	ldreq	r5, [pc], -r0, lsl #24
     74c:	06240000 	strteq	r0, [r4], -r0
     750:	00040000 	andeq	r0, r4, r0
     754:	9f5101f3 	svcls	0x005101f3
     758:	00000624 	andeq	r0, r0, r4, lsr #12
     75c:	0000062c 	andeq	r0, r0, ip, lsr #12
     760:	2c510001 	mrrccs	0, 0, r0, r1, cr1
     764:	38000006 	stmdacc	r0, {r1, r2}
     768:	01000006 	tsteq	r0, r6
     76c:	06385c00 	ldrteq	r5, [r8], -r0, lsl #24
     770:	06440000 	strbeq	r0, [r4], -r0
     774:	00040000 	andeq	r0, r4, r0
     778:	9f5101f3 	svcls	0x005101f3
     77c:	00000644 	andeq	r0, r0, r4, asr #12
     780:	0000064c 	andeq	r0, r0, ip, asr #12
     784:	4c510001 	mrrcmi	0, 0, r0, r1, cr1
     788:	4f000006 	svcmi	0x00000006
     78c:	01000006 	tsteq	r0, r6
     790:	064f5c00 	strbeq	r5, [pc], -r0, lsl #24
     794:	06540000 	ldrbeq	r0, [r4], -r0
     798:	00040000 	andeq	r0, r4, r0
     79c:	9f5101f3 	svcls	0x005101f3
     7a0:	00000654 	andeq	r0, r0, r4, asr r6
     7a4:	0000065b 	andeq	r0, r0, fp, asr r6
     7a8:	5b510001 	blpl	14407b4 <__user_program+0x11407b4>
     7ac:	64000006 	strvs	r0, [r0], #-6
     7b0:	04000006 	streq	r0, [r0], #-6
     7b4:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     7b8:	0006649f 	muleq	r6, pc, r4	; <UNPREDICTABLE>
     7bc:	00066b00 	andeq	r6, r6, r0, lsl #22
     7c0:	51000100 	mrspl	r0, (UNDEF: 16)
     7c4:	0000066b 	andeq	r0, r0, fp, ror #12
     7c8:	00000674 	andeq	r0, r0, r4, ror r6
     7cc:	01f30004 	mvnseq	r0, r4
     7d0:	06749f51 	uhsaxeq	r9, r4, r1
     7d4:	06770000 	ldrbteq	r0, [r7], -r0
     7d8:	00010000 	andeq	r0, r1, r0
     7dc:	00067751 	andeq	r7, r6, r1, asr r7
     7e0:	00068000 	andeq	r8, r6, r0
     7e4:	f3000400 	vshl.u8	d0, d0, d0
     7e8:	809f5101 	addshi	r5, pc, r1, lsl #2
     7ec:	83000006 	movwhi	r0, #6
     7f0:	01000006 	tsteq	r0, r6
     7f4:	06835100 	streq	r5, [r3], r0, lsl #2
     7f8:	06880000 	streq	r0, [r8], r0
     7fc:	00040000 	andeq	r0, r4, r0
     800:	9f5101f3 	svcls	0x005101f3
     804:	00000688 	andeq	r0, r0, r8, lsl #13
     808:	0000068b 	andeq	r0, r0, fp, lsl #13
     80c:	8b510001 	blhi	1440818 <__user_program+0x1140818>
     810:	90000006 	andls	r0, r0, r6
     814:	04000006 	streq	r0, [r0], #-6
     818:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     81c:	0006909f 	muleq	r6, pc, r0	; <UNPREDICTABLE>
     820:	00069400 	andeq	r9, r6, r0, lsl #8
     824:	51000100 	mrspl	r0, (UNDEF: 16)
     828:	00000694 	muleq	r0, r4, r6
     82c:	0000069c 	muleq	r0, ip, r6
     830:	01f30004 	mvnseq	r0, r4
     834:	00009f51 	andeq	r9, r0, r1, asr pc
	...
     840:	00480000 	subeq	r0, r8, r0
     844:	00010000 	andeq	r0, r1, r0
     848:	00004850 	andeq	r4, r0, r0, asr r8
     84c:	0000e000 	andeq	lr, r0, r0
     850:	f3000400 	vshl.u8	d0, d0, d0
     854:	009f5001 	addseq	r5, pc, r1
	...
     860:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
     864:	06000000 	streq	r0, [r0], -r0
     868:	04935200 	ldreq	r5, [r3], #512	; 0x200
     86c:	48049353 	stmdami	r4, {r0, r1, r4, r6, r8, r9, ip, pc}
     870:	7c000000 	stcvc	0, cr0, [r0], {-0}
     874:	06000000 	streq	r0, [r0], -r0
     878:	04935600 	ldreq	r5, [r3], #1536	; 0x600
     87c:	80049357 	andhi	r9, r4, r7, asr r3
     880:	e0000000 	and	r0, r0, r0
     884:	06000000 	streq	r0, [r0], -r0
     888:	04935600 	ldreq	r5, [r3], #1536	; 0x600
     88c:	00049357 	andeq	r9, r4, r7, asr r3
     890:	00000000 	andeq	r0, r0, r0
     894:	10000000 	andne	r0, r0, r0
     898:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
     89c:	02000000 	andeq	r0, r0, #0
     8a0:	909f3000 	addsls	r3, pc, r0
     8a4:	9c000000 	stcls	0, cr0, [r0], {-0}
     8a8:	01000000 	mrseq	r0, (UNDEF: 0)
     8ac:	00b05800 	adcseq	r5, r0, r0, lsl #16
     8b0:	00b80000 	adcseq	r0, r8, r0
     8b4:	00010000 	andeq	r0, r1, r0
     8b8:	0000b858 	andeq	fp, r0, r8, asr r8
     8bc:	0000c400 	andeq	ip, r0, r0, lsl #8
     8c0:	78000300 	stmdavc	r0, {r8, r9}
     8c4:	00009f7f 	andeq	r9, r0, pc, ror pc
     8c8:	00000000 	andeq	r0, r0, r0
     8cc:	00100000 	andseq	r0, r0, r0
     8d0:	00380000 	eorseq	r0, r8, r0
     8d4:	00030000 	andeq	r0, r3, r0
     8d8:	389f5791 	ldmcc	pc, {r0, r4, r7, r8, r9, sl, ip, lr}	; <UNPREDICTABLE>
     8dc:	64000000 	strvs	r0, [r0], #-0
     8e0:	01000000 	mrseq	r0, (UNDEF: 0)
     8e4:	00645400 	rsbeq	r5, r4, r0, lsl #8
     8e8:	009c0000 	addseq	r0, ip, r0
     8ec:	00030000 	andeq	r0, r3, r0
     8f0:	9c9f0174 	ldflss	f0, [pc], {116}	; 0x74
     8f4:	b0000000 	andlt	r0, r0, r0
     8f8:	01000000 	mrseq	r0, (UNDEF: 0)
     8fc:	00b05400 	adcseq	r5, r0, r0, lsl #8
     900:	00c40000 	sbceq	r0, r4, r0
     904:	00030000 	andeq	r0, r3, r0
     908:	c49f0174 	ldrgt	r0, [pc], #372	; 910 <__start-0x76f0>
     90c:	c8000000 	stmdagt	r0, {}	; <UNPREDICTABLE>
     910:	01000000 	mrseq	r0, (UNDEF: 0)
     914:	00c85400 	sbceq	r5, r8, r0, lsl #8
     918:	00cc0000 	sbceq	r0, ip, r0
     91c:	00030000 	andeq	r0, r3, r0
     920:	cc9f7f74 	ldcgt	15, cr7, [pc], {116}	; 0x74
     924:	e0000000 	and	r0, r0, r0
     928:	01000000 	mrseq	r0, (UNDEF: 0)
     92c:	00005400 	andeq	r5, r0, r0, lsl #8
     930:	00000000 	andeq	r0, r0, r0
     934:	00e00000 	rsceq	r0, r0, r0
     938:	01080000 	mrseq	r0, (UNDEF: 8)
     93c:	00020000 	andeq	r0, r2, r0
     940:	01087091 	swpeq	r7, r1, [r8]
     944:	011c0000 	tsteq	ip, r0
     948:	00010000 	andeq	r0, r1, r0
     94c:	00011c54 	andeq	r1, r1, r4, asr ip
     950:	00027c00 	andeq	r7, r2, r0, lsl #24
     954:	74000300 	strvc	r0, [r0], #-768	; 0x300
     958:	027c9f01 	rsbseq	r9, ip, #1, 30
     95c:	02880000 	addeq	r0, r8, #0
     960:	00010000 	andeq	r0, r1, r0
     964:	00000054 	andeq	r0, r0, r4, asr r0
     968:	00000000 	andeq	r0, r0, r0
     96c:	0001e800 	andeq	lr, r1, r0, lsl #16
     970:	0001f400 	andeq	pc, r1, r0, lsl #8
     974:	73000200 	movwvc	r0, #512	; 0x200
     978:	0001f400 	andeq	pc, r1, r0, lsl #8
     97c:	0001f700 	andeq	pc, r1, r0, lsl #14
     980:	52000100 	andpl	r0, r0, #0, 2
	...
     98c:	00000208 	andeq	r0, r0, r8, lsl #4
     990:	00000214 	andeq	r0, r0, r4, lsl r2
     994:	00730002 	rsbseq	r0, r3, r2
     998:	00000214 	andeq	r0, r0, r4, lsl r2
     99c:	00000217 	andeq	r0, r0, r7, lsl r2
     9a0:	00520001 	subseq	r0, r2, r1
     9a4:	00000000 	andeq	r0, r0, r0
     9a8:	84000000 	strhi	r0, [r0], #-0
     9ac:	bc000001 	stclt	0, cr0, [r0], {1}
     9b0:	01000001 	tsteq	r0, r1
     9b4:	00005500 	andeq	r5, r0, r0, lsl #10
     9b8:	00000000 	andeq	r0, r0, r0
     9bc:	01c80000 	biceq	r0, r8, r0
     9c0:	01d40000 	bicseq	r0, r4, r0
     9c4:	00020000 	andeq	r0, r2, r0
     9c8:	01d40073 	bicseq	r0, r4, r3, ror r0
     9cc:	01d70000 	bicseq	r0, r7, r0
     9d0:	00010000 	andeq	r0, r1, r0
     9d4:	00000052 	andeq	r0, r0, r2, asr r0
     9d8:	00000000 	andeq	r0, r0, r0
     9dc:	00022c00 	andeq	r2, r2, r0, lsl #24
     9e0:	00024000 	andeq	r4, r2, r0
     9e4:	55000100 	strpl	r0, [r0, #-256]	; 0x100
     9e8:	00000240 	andeq	r0, r0, r0, asr #4
     9ec:	0000024c 	andeq	r0, r0, ip, asr #4
     9f0:	7f750003 	svcvc	0x00750003
     9f4:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     9f8:	00000000 	andeq	r0, r0, r0
     9fc:	00025800 	andeq	r5, r2, r0, lsl #16
     a00:	00025f00 	andeq	r5, r2, r0, lsl #30
     a04:	73000200 	movwvc	r0, #512	; 0x200
	...
     a14:	00001000 	andeq	r1, r0, r0
     a18:	50000100 	andpl	r0, r0, r0, lsl #2
     a1c:	00000010 	andeq	r0, r0, r0, lsl r0
     a20:	00000074 	andeq	r0, r0, r4, ror r0
     a24:	00550001 	subseq	r0, r5, r1
	...
     a30:	14000000 	strne	r0, [r0], #-0
     a34:	01000000 	mrseq	r0, (UNDEF: 0)
     a38:	00145100 	andseq	r5, r4, r0, lsl #2
     a3c:	00740000 	rsbseq	r0, r4, r0
     a40:	00010000 	andeq	r0, r1, r0
     a44:	00000054 	andeq	r0, r0, r4, asr r0
     a48:	00000000 	andeq	r0, r0, r0
     a4c:	00007400 	andeq	r7, r0, r0, lsl #8
     a50:	00009000 	andeq	r9, r0, r0
     a54:	50000100 	andpl	r0, r0, r0, lsl #2
     a58:	00000090 	muleq	r0, r0, r0
     a5c:	00000098 	muleq	r0, r8, r0
     a60:	01f30004 	mvnseq	r0, r4
     a64:	00009f50 	andeq	r9, r0, r0, asr pc
     a68:	00000000 	andeq	r0, r0, r0
     a6c:	00740000 	rsbseq	r0, r4, r0
     a70:	00840000 	addeq	r0, r4, r0
     a74:	00010000 	andeq	r0, r1, r0
     a78:	00008451 	andeq	r8, r0, r1, asr r4
     a7c:	00009800 	andeq	r9, r0, r0, lsl #16
     a80:	f3000400 	vshl.u8	d0, d0, d0
     a84:	009f5101 	addseq	r5, pc, r1, lsl #2
     a88:	00000000 	andeq	r0, r0, r0
     a8c:	c8000000 	stmdagt	r0, {}	; <UNPREDICTABLE>
     a90:	ec000000 	stc	0, cr0, [r0], {-0}
     a94:	01000000 	mrseq	r0, (UNDEF: 0)
     a98:	00ec5000 	rsceq	r5, ip, r0
     a9c:	01180000 	tsteq	r8, r0
     aa0:	00040000 	andeq	r0, r4, r0
     aa4:	9f5001f3 	svcls	0x005001f3
	...
     ab4:	00000034 	andeq	r0, r0, r4, lsr r0
     ab8:	34500001 	ldrbcc	r0, [r0], #-1
     abc:	3b000000 	blcc	ac4 <__start-0x753c>
     ac0:	01000000 	mrseq	r0, (UNDEF: 0)
     ac4:	003b5100 	eorseq	r5, fp, r0, lsl #2
     ac8:	00440000 	subeq	r0, r4, r0
     acc:	00040000 	andeq	r0, r4, r0
     ad0:	9f5001f3 	svcls	0x005001f3
	...
     adc:	00000020 	andeq	r0, r0, r0, lsr #32
     ae0:	00000028 	andeq	r0, r0, r8, lsr #32
     ae4:	28500001 	ldmdacs	r0, {r0}^
     ae8:	70000000 	andvc	r0, r0, r0
     aec:	04000000 	streq	r0, [r0], #-0
     af0:	5001f300 	andpl	pc, r1, r0, lsl #6
     af4:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     af8:	00000000 	andeq	r0, r0, r0
     afc:	00002400 	andeq	r2, r0, r0, lsl #8
     b00:	00004000 	andeq	r4, r0, r0
     b04:	30000200 	andcc	r0, r0, r0, lsl #4
     b08:	0000409f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     b0c:	00005400 	andeq	r5, r0, r0, lsl #8
     b10:	54000100 	strpl	r0, [r0], #-256	; 0x100
	...
     b20:	00000008 	andeq	r0, r0, r8
     b24:	08500001 	ldmdaeq	r0, {r0}^
     b28:	0c000000 	stceq	0, cr0, [r0], {-0}
     b2c:	04000000 	streq	r0, [r0], #-0
     b30:	5001f300 	andpl	pc, r1, r0, lsl #6
     b34:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     b38:	00000000 	andeq	r0, r0, r0
     b3c:	00000c00 	andeq	r0, r0, r0, lsl #24
     b40:	00001800 	andeq	r1, r0, r0, lsl #16
     b44:	50000100 	andpl	r0, r0, r0, lsl #2
     b48:	00000018 	andeq	r0, r0, r8, lsl r0
     b4c:	0000001f 	andeq	r0, r0, pc, lsl r0
     b50:	1f510001 	svcne	0x00510001
     b54:	2c000000 	stccs	0, cr0, [r0], {-0}
     b58:	04000000 	streq	r0, [r0], #-0
     b5c:	5001f300 	andpl	pc, r1, r0, lsl #6
     b60:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     b64:	00000000 	andeq	r0, r0, r0
     b68:	00002c00 	andeq	r2, r0, r0, lsl #24
     b6c:	00004000 	andeq	r4, r0, r0
     b70:	50000100 	andpl	r0, r0, r0, lsl #2
     b74:	00000040 	andeq	r0, r0, r0, asr #32
     b78:	00000094 	muleq	r0, r4, r0
     b7c:	01f30004 	mvnseq	r0, r4
     b80:	00949f50 	addseq	r9, r4, r0, asr pc
     b84:	009c0000 	addseq	r0, ip, r0
     b88:	00010000 	andeq	r0, r1, r0
     b8c:	00009c50 	andeq	r9, r0, r0, asr ip
     b90:	0000a800 	andeq	sl, r0, r0, lsl #16
     b94:	f3000400 	vshl.u8	d0, d0, d0
     b98:	a89f5001 	ldmge	pc, {r0, ip, lr}	; <UNPREDICTABLE>
     b9c:	ac000000 	stcge	0, cr0, [r0], {-0}
     ba0:	01000000 	mrseq	r0, (UNDEF: 0)
     ba4:	00ac5000 	adceq	r5, ip, r0
     ba8:	00b00000 	adcseq	r0, r0, r0
     bac:	00040000 	andeq	r0, r4, r0
     bb0:	9f5001f3 	svcls	0x005001f3
	...
     bbc:	0000002c 	andeq	r0, r0, ip, lsr #32
     bc0:	0000004c 	andeq	r0, r0, ip, asr #32
     bc4:	4c510001 	mrrcmi	0, 0, r0, r1, cr1
     bc8:	50000000 	andpl	r0, r0, r0
     bcc:	01000000 	mrseq	r0, (UNDEF: 0)
     bd0:	00505400 	subseq	r5, r0, r0, lsl #8
     bd4:	005c0000 	subseq	r0, ip, r0
     bd8:	00030000 	andeq	r0, r3, r0
     bdc:	5c9f7f74 	ldcpl	15, cr7, [pc], {116}	; 0x74
     be0:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     be4:	01000000 	mrseq	r0, (UNDEF: 0)
     be8:	00685100 	rsbeq	r5, r8, r0, lsl #2
     bec:	00700000 	rsbseq	r0, r0, r0
     bf0:	00030000 	andeq	r0, r3, r0
     bf4:	709f7f74 	addsvc	r7, pc, r4, ror pc	; <UNPREDICTABLE>
     bf8:	80000000 	andhi	r0, r0, r0
     bfc:	01000000 	mrseq	r0, (UNDEF: 0)
     c00:	00805100 	addeq	r5, r0, r0, lsl #2
     c04:	00840000 	addeq	r0, r4, r0
     c08:	00030000 	andeq	r0, r3, r0
     c0c:	849f7f74 	ldrhi	r7, [pc], #3956	; c14 <__start-0x73ec>
     c10:	94000000 	strls	r0, [r0], #-0
     c14:	01000000 	mrseq	r0, (UNDEF: 0)
     c18:	00945400 	addseq	r5, r4, r0, lsl #8
     c1c:	00a00000 	adceq	r0, r0, r0
     c20:	00010000 	andeq	r0, r1, r0
     c24:	0000a051 	andeq	sl, r0, r1, asr r0
     c28:	0000a800 	andeq	sl, r0, r0, lsl #16
     c2c:	54000100 	strpl	r0, [r0], #-256	; 0x100
     c30:	000000a8 	andeq	r0, r0, r8, lsr #1
     c34:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
     c38:	00510001 	subseq	r0, r1, r1
     c3c:	00000000 	andeq	r0, r0, r0
     c40:	2c000000 	stccs	0, cr0, [r0], {-0}
     c44:	4c000000 	stcmi	0, cr0, [r0], {-0}
     c48:	01000000 	mrseq	r0, (UNDEF: 0)
     c4c:	004c5200 	subeq	r5, ip, r0, lsl #4
     c50:	005c0000 	subseq	r0, ip, r0
     c54:	00040000 	andeq	r0, r4, r0
     c58:	9f5201f3 	svcls	0x005201f3
     c5c:	0000005c 	andeq	r0, r0, ip, asr r0
     c60:	00000068 	andeq	r0, r0, r8, rrx
     c64:	68520001 	ldmdavs	r2, {r0}^
     c68:	70000000 	andvc	r0, r0, r0
     c6c:	04000000 	streq	r0, [r0], #-0
     c70:	5201f300 	andpl	pc, r1, #0, 6
     c74:	0000709f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     c78:	00008000 	andeq	r8, r0, r0
     c7c:	52000100 	andpl	r0, r0, #0, 2
     c80:	00000080 	andeq	r0, r0, r0, lsl #1
     c84:	00000094 	muleq	r0, r4, r0
     c88:	01f30004 	mvnseq	r0, r4
     c8c:	00949f52 	addseq	r9, r4, r2, asr pc
     c90:	00a00000 	adceq	r0, r0, r0
     c94:	00010000 	andeq	r0, r1, r0
     c98:	0000a052 	andeq	sl, r0, r2, asr r0
     c9c:	0000a800 	andeq	sl, r0, r0, lsl #16
     ca0:	f3000400 	vshl.u8	d0, d0, d0
     ca4:	a89f5201 	ldmge	pc, {r0, r9, ip, lr}	; <UNPREDICTABLE>
     ca8:	b0000000 	andlt	r0, r0, r0
     cac:	01000000 	mrseq	r0, (UNDEF: 0)
     cb0:	00005200 	andeq	r5, r0, r0, lsl #4
     cb4:	00000000 	andeq	r0, r0, r0
     cb8:	00340000 	eorseq	r0, r4, r0
     cbc:	004c0000 	subeq	r0, ip, r0
     cc0:	00020000 	andeq	r0, r2, r0
     cc4:	004c9f30 	subeq	r9, ip, r0, lsr pc
     cc8:	005c0000 	subseq	r0, ip, r0
     ccc:	00010000 	andeq	r0, r1, r0
     cd0:	00005c53 	andeq	r5, r0, r3, asr ip
     cd4:	00006800 	andeq	r6, r0, r0, lsl #16
     cd8:	30000200 	andcc	r0, r0, r0, lsl #4
     cdc:	0000689f 	muleq	r0, pc, r8	; <UNPREDICTABLE>
     ce0:	00007000 	andeq	r7, r0, r0
     ce4:	53000100 	movwpl	r0, #256	; 0x100
     ce8:	00000070 	andeq	r0, r0, r0, ror r0
     cec:	00000080 	andeq	r0, r0, r0, lsl #1
     cf0:	9f300002 	svcls	0x00300002
     cf4:	00000080 	andeq	r0, r0, r0, lsl #1
     cf8:	00000088 	andeq	r0, r0, r8, lsl #1
     cfc:	00760007 	rsbseq	r0, r6, r7
     d00:	22007420 	andcs	r7, r0, #32, 8	; 0x20000000
     d04:	0000889f 	muleq	r0, pc, r8	; <UNPREDICTABLE>
     d08:	00009400 	andeq	r9, r0, r0, lsl #8
     d0c:	53000100 	movwpl	r0, #256	; 0x100
     d10:	00000094 	muleq	r0, r4, r0
     d14:	000000a0 	andeq	r0, r0, r0, lsr #1
     d18:	9f300002 	svcls	0x00300002
     d1c:	000000a0 	andeq	r0, r0, r0, lsr #1
     d20:	000000a8 	andeq	r0, r0, r8, lsr #1
     d24:	00530001 	subseq	r0, r3, r1
     d28:	00000000 	andeq	r0, r0, r0
     d2c:	b0000000 	andlt	r0, r0, r0
     d30:	dc000000 	stcle	0, cr0, [r0], {-0}
     d34:	01000000 	mrseq	r0, (UNDEF: 0)
     d38:	00dc5000 	sbcseq	r5, ip, r0
     d3c:	014c0000 	mrseq	r0, (UNDEF: 76)
     d40:	00040000 	andeq	r0, r4, r0
     d44:	9f5001f3 	svcls	0x005001f3
     d48:	0000014c 	andeq	r0, r0, ip, asr #2
     d4c:	00000150 	andeq	r0, r0, r0, asr r1
     d50:	50500001 	subspl	r0, r0, r1
     d54:	58000001 	stmdapl	r0, {r0}
     d58:	04000001 	streq	r0, [r0], #-1
     d5c:	5001f300 	andpl	pc, r1, r0, lsl #6
     d60:	0001589f 	muleq	r1, pc, r8	; <UNPREDICTABLE>
     d64:	00015c00 	andeq	r5, r1, r0, lsl #24
     d68:	50000100 	andpl	r0, r0, r0, lsl #2
     d6c:	0000015c 	andeq	r0, r0, ip, asr r1
     d70:	00000168 	andeq	r0, r0, r8, ror #2
     d74:	01f30004 	mvnseq	r0, r4
     d78:	00009f50 	andeq	r9, r0, r0, asr pc
     d7c:	00000000 	andeq	r0, r0, r0
     d80:	00b00000 	adcseq	r0, r0, r0
     d84:	00dc0000 	sbcseq	r0, ip, r0
     d88:	00010000 	andeq	r0, r1, r0
     d8c:	0000dc51 	andeq	sp, r0, r1, asr ip
     d90:	00014c00 	andeq	r4, r1, r0, lsl #24
     d94:	56000100 	strpl	r0, [r0], -r0, lsl #2
     d98:	0000014c 	andeq	r0, r0, ip, asr #2
     d9c:	00000150 	andeq	r0, r0, r0, asr r1
     da0:	50510001 	subspl	r0, r1, r1
     da4:	58000001 	stmdapl	r0, {r0}
     da8:	04000001 	streq	r0, [r0], #-1
     dac:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     db0:	0001589f 	muleq	r1, pc, r8	; <UNPREDICTABLE>
     db4:	00016000 	andeq	r6, r1, r0
     db8:	51000100 	mrspl	r0, (UNDEF: 16)
     dbc:	00000160 	andeq	r0, r0, r0, ror #2
     dc0:	00000168 	andeq	r0, r0, r8, ror #2
     dc4:	00560001 	subseq	r0, r6, r1
     dc8:	00000000 	andeq	r0, r0, r0
     dcc:	b0000000 	andlt	r0, r0, r0
     dd0:	dc000000 	stcle	0, cr0, [r0], {-0}
     dd4:	01000000 	mrseq	r0, (UNDEF: 0)
     dd8:	00dc5200 	sbcseq	r5, ip, r0, lsl #4
     ddc:	014c0000 	mrseq	r0, (UNDEF: 76)
     de0:	00010000 	andeq	r0, r1, r0
     de4:	00014c55 	andeq	r4, r1, r5, asr ip
     de8:	00015000 	andeq	r5, r1, r0
     dec:	52000100 	andpl	r0, r0, #0, 2
     df0:	00000150 	andeq	r0, r0, r0, asr r1
     df4:	00000158 	andeq	r0, r0, r8, asr r1
     df8:	01f30004 	mvnseq	r0, r4
     dfc:	01589f52 	cmpeq	r8, r2, asr pc
     e00:	01600000 	cmneq	r0, r0
     e04:	00010000 	andeq	r0, r1, r0
     e08:	00016052 	andeq	r6, r1, r2, asr r0
     e0c:	00016800 	andeq	r6, r1, r0, lsl #16
     e10:	55000100 	strpl	r0, [r0, #-256]	; 0x100
	...
     e1c:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
     e20:	000000dc 	ldrdeq	r0, [r0], -ip
     e24:	9f300002 	svcls	0x00300002
     e28:	000000dc 	ldrdeq	r0, [r0], -ip
     e2c:	0000014c 	andeq	r0, r0, ip, asr #2
     e30:	4c540001 	mrrcmi	0, 0, r0, r4, cr1
     e34:	50000001 	andpl	r0, r0, r1
     e38:	02000001 	andeq	r0, r0, #1
     e3c:	589f3000 	ldmpl	pc, {ip, sp}	; <UNPREDICTABLE>
     e40:	60000001 	andvs	r0, r0, r1
     e44:	02000001 	andeq	r0, r0, #1
     e48:	609f3000 	addsvs	r3, pc, r0
     e4c:	68000001 	stmdavs	r0, {r0}
     e50:	01000001 	tsteq	r0, r1
     e54:	00005400 	andeq	r5, r0, r0, lsl #8
     e58:	00000000 	andeq	r0, r0, r0
     e5c:	00e00000 	rsceq	r0, r0, r0
     e60:	01080000 	mrseq	r0, (UNDEF: 8)
     e64:	00010000 	andeq	r0, r1, r0
     e68:	00011050 	andeq	r1, r1, r0, asr r0
     e6c:	00012400 	andeq	r2, r1, r0, lsl #8
     e70:	50000100 	andpl	r0, r0, r0, lsl #2
     e74:	00000124 	andeq	r0, r0, r4, lsr #2
     e78:	0000012b 	andeq	r0, r0, fp, lsr #2
     e7c:	00760005 	rsbseq	r0, r6, r5
     e80:	34220074 	strtcc	r0, [r2], #-116	; 0x74
     e84:	3b000001 	blcc	e90 <__start-0x7170>
     e88:	01000001 	tsteq	r0, r1
     e8c:	01605000 	cmneq	r0, r0
     e90:	01640000 	cmneq	r4, r0
     e94:	00010000 	andeq	r0, r1, r0
     e98:	00000050 	andeq	r0, r0, r0, asr r0
     e9c:	00000000 	andeq	r0, r0, r0
     ea0:	00016800 	andeq	r6, r1, r0, lsl #16
     ea4:	00016c00 	andeq	r6, r1, r0, lsl #24
     ea8:	50000100 	andpl	r0, r0, r0, lsl #2
     eac:	0000016c 	andeq	r0, r0, ip, ror #2
     eb0:	00000170 	andeq	r0, r0, r0, ror r1
     eb4:	01f30004 	mvnseq	r0, r4
     eb8:	00009f50 	andeq	r9, r0, r0, asr pc
     ebc:	00000000 	andeq	r0, r0, r0
     ec0:	01780000 	cmneq	r8, r0
     ec4:	01a40000 			; <UNDEFINED> instruction: 0x01a40000
     ec8:	00010000 	andeq	r0, r1, r0
     ecc:	0001a450 	andeq	sl, r1, r0, asr r4
     ed0:	0001dc00 	andeq	sp, r1, r0, lsl #24
     ed4:	73000300 	movwvc	r0, #768	; 0x300
     ed8:	01dc1c8c 	bicseq	r1, ip, ip, lsl #25
     edc:	01f00000 	mvnseq	r0, r0
     ee0:	00030000 	andeq	r0, r3, r0
     ee4:	047c8c72 	ldrbteq	r8, [ip], #-3186	; 0xc72
     ee8:	08000002 	stmdaeq	r0, {r1}
     eec:	01000002 	tsteq	r0, r2
     ef0:	02085000 	andeq	r5, r8, #0
     ef4:	02100000 	andseq	r0, r0, #0
     ef8:	00040000 	andeq	r0, r4, r0
     efc:	9f5001f3 	svcls	0x005001f3
	...
     f08:	00000178 	andeq	r0, r0, r8, ror r1
     f0c:	000001b0 			; <UNDEFINED> instruction: 0x000001b0
     f10:	b0510001 	subslt	r0, r1, r1
     f14:	04000001 	streq	r0, [r0], #-1
     f18:	01000002 	tsteq	r0, r2
     f1c:	02045e00 	andeq	r5, r4, #0, 28
     f20:	02100000 	andseq	r0, r0, #0
     f24:	00010000 	andeq	r0, r1, r0
     f28:	00000051 	andeq	r0, r0, r1, asr r0
     f2c:	00000000 	andeq	r0, r0, r0
     f30:	00021000 	andeq	r1, r2, r0
     f34:	00024000 	andeq	r4, r2, r0
     f38:	50000100 	andpl	r0, r0, r0, lsl #2
     f3c:	00000240 	andeq	r0, r0, r0, asr #4
     f40:	000002d4 	ldrdeq	r0, [r0], -r4
     f44:	00540001 	subseq	r0, r4, r1
     f48:	00000000 	andeq	r0, r0, r0
     f4c:	10000000 	andne	r0, r0, r0
     f50:	30000002 	andcc	r0, r0, r2
     f54:	01000002 	tsteq	r0, r2
     f58:	02305100 	eorseq	r5, r0, #0, 2
     f5c:	02d40000 	sbcseq	r0, r4, #0
     f60:	00010000 	andeq	r0, r1, r0
     f64:	00000055 	andeq	r0, r0, r5, asr r0
     f68:	00000000 	andeq	r0, r0, r0
     f6c:	00021000 	andeq	r1, r2, r0
     f70:	0002c400 	andeq	ip, r2, r0, lsl #8
     f74:	52000100 	andpl	r0, r0, #0, 2
     f78:	000002c4 	andeq	r0, r0, r4, asr #5
     f7c:	000002cc 	andeq	r0, r0, ip, asr #5
     f80:	01f30004 	mvnseq	r0, r4
     f84:	02cc9f52 	sbceq	r9, ip, #328	; 0x148
     f88:	02d40000 	sbcseq	r0, r4, #0
     f8c:	00010000 	andeq	r0, r1, r0
     f90:	00000052 	andeq	r0, r0, r2, asr r0
     f94:	00000000 	andeq	r0, r0, r0
     f98:	00021000 	andeq	r1, r2, r0
     f9c:	00027400 	andeq	r7, r2, r0, lsl #8
     fa0:	53000100 	movwpl	r0, #256	; 0x100
     fa4:	00000274 	andeq	r0, r0, r4, ror r2
     fa8:	000002ac 	andeq	r0, r0, ip, lsr #5
     fac:	d0710003 	rsbsle	r0, r1, r3
     fb0:	0002ac00 	andeq	sl, r2, r0, lsl #24
     fb4:	0002c000 	andeq	ip, r2, r0
     fb8:	71000300 	mrsvc	r0, LR_irq
     fbc:	02cc5fe8 	sbceq	r5, ip, #232, 30	; 0x3a0
     fc0:	02d40000 	sbcseq	r0, r4, #0
     fc4:	00010000 	andeq	r0, r1, r0
     fc8:	00000053 	andeq	r0, r0, r3, asr r0
     fcc:	00000000 	andeq	r0, r0, r0
     fd0:	0002d400 	andeq	sp, r2, r0, lsl #8
     fd4:	0002f000 	andeq	pc, r2, r0
     fd8:	50000100 	andpl	r0, r0, r0, lsl #2
     fdc:	000002f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     fe0:	0000030c 	andeq	r0, r0, ip, lsl #6
     fe4:	00520001 	subseq	r0, r2, r1
     fe8:	00000000 	andeq	r0, r0, r0
     fec:	0c000000 	stceq	0, cr0, [r0], {-0}
     ff0:	17000003 	strne	r0, [r0, -r3]
     ff4:	01000003 	tsteq	r0, r3
     ff8:	03175000 	tsteq	r7, #0
     ffc:	03fc0000 	mvnseq	r0, #0
    1000:	00010000 	andeq	r0, r1, r0
    1004:	00000054 	andeq	r0, r0, r4, asr r0
    1008:	00000000 	andeq	r0, r0, r0
    100c:	00034800 	andeq	r4, r3, r0, lsl #16
    1010:	00035000 	andeq	r5, r3, r0
    1014:	51000100 	mrspl	r0, (UNDEF: 16)
	...
    1020:	00000348 	andeq	r0, r0, r8, asr #6
    1024:	00000350 	andeq	r0, r0, r0, asr r3
    1028:	00520001 	subseq	r0, r2, r1
    102c:	00000000 	andeq	r0, r0, r0
    1030:	fc000000 	stc2	0, cr0, [r0], {-0}
    1034:	07000003 	streq	r0, [r0, -r3]
    1038:	01000004 	tsteq	r0, r4
    103c:	04075000 	streq	r5, [r7], #-0
    1040:	06800000 	streq	r0, [r0], r0
    1044:	00010000 	andeq	r0, r1, r0
    1048:	00000054 	andeq	r0, r0, r4, asr r0
    104c:	00000000 	andeq	r0, r0, r0
    1050:	00047400 	andeq	r7, r4, r0, lsl #8
    1054:	00048c00 	andeq	r8, r4, r0, lsl #24
    1058:	53000100 	movwpl	r0, #256	; 0x100
    105c:	0000049c 	muleq	r0, ip, r4
    1060:	000004a0 	andeq	r0, r0, r0, lsr #9
    1064:	bc530001 	mrrclt	0, 0, r0, r3, cr1
    1068:	d4000004 	strle	r0, [r0], #-4
    106c:	01000004 	tsteq	r0, r4
    1070:	04d45100 	ldrbeq	r5, [r4], #256	; 0x100
    1074:	04e40000 	strbteq	r0, [r4], #0
    1078:	00010000 	andeq	r0, r1, r0
    107c:	0004e453 	andeq	lr, r4, r3, asr r4
    1080:	0004ec00 	andeq	lr, r4, r0, lsl #24
    1084:	51000100 	mrspl	r0, (UNDEF: 16)
    1088:	000004f4 	strdeq	r0, [r0], -r4
    108c:	00000508 	andeq	r0, r0, r8, lsl #10
    1090:	00530001 	subseq	r0, r3, r1
    1094:	00000000 	andeq	r0, r0, r0
    1098:	74000000 	strvc	r0, [r0], #-0
    109c:	b8000004 	stmdalt	r0, {r2}
    10a0:	02000004 	andeq	r0, r0, #4
    10a4:	b89f3000 	ldmlt	pc, {ip, sp}	; <UNPREDICTABLE>
    10a8:	c8000004 	stmdagt	r0, {r2}
    10ac:	01000004 	tsteq	r0, r4
    10b0:	00005000 	andeq	r5, r0, r0
    10b4:	00000000 	andeq	r0, r0, r0
    10b8:	04740000 	ldrbteq	r0, [r4], #-0
    10bc:	04980000 	ldreq	r0, [r8], #0
    10c0:	00020000 	andeq	r0, r2, r0
    10c4:	04989f30 	ldreq	r9, [r8], #3888	; 0xf30
    10c8:	049c0000 	ldreq	r0, [ip], #0
    10cc:	00020000 	andeq	r0, r2, r0
    10d0:	049c9f31 	ldreq	r9, [ip], #3889	; 0xf31
    10d4:	04f00000 	ldrbteq	r0, [r0], #0
    10d8:	00020000 	andeq	r0, r2, r0
    10dc:	04f09f30 	ldrbteq	r9, [r0], #3888	; 0xf30
    10e0:	04f40000 	ldrbteq	r0, [r4], #0
    10e4:	00020000 	andeq	r0, r2, r0
    10e8:	04f49f31 	ldrbteq	r9, [r4], #3889	; 0xf31
    10ec:	05080000 	streq	r0, [r8, #-0]
    10f0:	00020000 	andeq	r0, r2, r0
    10f4:	064c9f30 			; <UNDEFINED> instruction: 0x064c9f30
    10f8:	06640000 	strbteq	r0, [r4], -r0
    10fc:	00020000 	andeq	r0, r2, r0
    1100:	00009f30 	andeq	r9, r0, r0, lsr pc
    1104:	00000000 	andeq	r0, r0, r0
    1108:	04740000 	ldrbteq	r0, [r4], #-0
    110c:	05300000 	ldreq	r0, [r0, #-0]!
    1110:	00020000 	andeq	r0, r2, r0
    1114:	05309f30 	ldreq	r9, [r0, #-3888]!	; 0xf30
    1118:	05700000 	ldrbeq	r0, [r0, #-0]!
    111c:	00010000 	andeq	r0, r1, r0
    1120:	00057051 	andeq	r7, r5, r1, asr r0
    1124:	00057400 	andeq	r7, r5, r0, lsl #8
    1128:	30000200 	andcc	r0, r0, r0, lsl #4
    112c:	00064c9f 	muleq	r6, pc, ip	; <UNPREDICTABLE>
    1130:	00066400 	andeq	r6, r6, r0, lsl #8
    1134:	30000200 	andcc	r0, r0, r0, lsl #4
    1138:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    113c:	00000000 	andeq	r0, r0, r0
    1140:	00050800 	andeq	r0, r5, r0, lsl #16
    1144:	00053000 	andeq	r3, r5, r0
    1148:	09000300 	stmdbeq	r0, {r8, r9}
    114c:	05309fff 	ldreq	r9, [r0, #-4095]!	; 0xfff
    1150:	05700000 	ldrbeq	r0, [r0, #-0]!
    1154:	00010000 	andeq	r0, r1, r0
    1158:	00057052 	andeq	r7, r5, r2, asr r0
    115c:	00057400 	andeq	r7, r5, r0, lsl #8
    1160:	09000300 	stmdbeq	r0, {r8, r9}
    1164:	05889fff 	streq	r9, [r8, #4095]	; 0xfff
    1168:	06470000 	strbeq	r0, [r7], -r0
    116c:	00010000 	andeq	r0, r1, r0
    1170:	00066452 	andeq	r6, r6, r2, asr r4
    1174:	00068000 	andeq	r8, r6, r0
    1178:	52000100 	andpl	r0, r0, #0, 2
	...
    1184:	00000520 	andeq	r0, r0, r0, lsr #10
    1188:	00000580 	andeq	r0, r0, r0, lsl #11
    118c:	00530001 	subseq	r0, r3, r1
    1190:	00000000 	andeq	r0, r0, r0
    1194:	c8000000 	stmdagt	r0, {}	; <UNPREDICTABLE>
    1198:	d8000004 	stmdale	r0, {r2}
    119c:	01000004 	tsteq	r0, r4
    11a0:	04d85300 	ldrbeq	r5, [r8], #768	; 0x300
    11a4:	04e40000 	strbteq	r0, [r4], #0
    11a8:	00010000 	andeq	r0, r1, r0
    11ac:	0004e452 	andeq	lr, r4, r2, asr r4
    11b0:	0004ec00 	andeq	lr, r4, r0, lsl #24
    11b4:	53000100 	movwpl	r0, #256	; 0x100
    11b8:	000004ec 	andeq	r0, r0, ip, ror #9
    11bc:	000004fc 	strdeq	r0, [r0], -ip
    11c0:	fc520001 	mrrc2	0, 0, r0, r2, cr1
    11c4:	08000004 	stmdaeq	r0, {r2}
    11c8:	01000005 	tsteq	r0, r5
    11cc:	00005300 	andeq	r5, r0, r0, lsl #6
    11d0:	00000000 	andeq	r0, r0, r0
    11d4:	07100000 	ldreq	r0, [r0, -r0]
    11d8:	072c0000 	streq	r0, [ip, -r0]!
    11dc:	00020000 	andeq	r0, r2, r0
    11e0:	072c9f30 			; <UNDEFINED> instruction: 0x072c9f30
    11e4:	07cc0000 	strbeq	r0, [ip, r0]
    11e8:	00010000 	andeq	r0, r1, r0
    11ec:	00000055 	andeq	r0, r0, r5, asr r0
    11f0:	00000000 	andeq	r0, r0, r0
    11f4:	00071000 	andeq	r1, r7, r0
    11f8:	00072c00 	andeq	r2, r7, r0, lsl #24
    11fc:	9e000600 	cfmadd32ls	mvax0, mvfx0, mvfx0, mvfx0
    1200:	00000004 	andeq	r0, r0, r4
    1204:	00072c00 	andeq	r2, r7, r0, lsl #24
    1208:	0007cc00 	andeq	ip, r7, r0, lsl #24
    120c:	59000100 	stmdbpl	r0, {r8}
	...
    1218:	000007cc 	andeq	r0, r0, ip, asr #15
    121c:	00000800 	andeq	r0, r0, r0, lsl #16
    1220:	00500001 	subseq	r0, r0, r1
    1224:	24000008 	strcs	r0, [r0], #-8
    1228:	04000008 	streq	r0, [r0], #-8
    122c:	5001f300 	andpl	pc, r1, r0, lsl #6
    1230:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    1234:	00000000 	andeq	r0, r0, r0
    1238:	00082400 	andeq	r2, r8, r0, lsl #8
    123c:	00082800 	andeq	r2, r8, r0, lsl #16
    1240:	50000100 	andpl	r0, r0, r0, lsl #2
    1244:	00000828 	andeq	r0, r0, r8, lsr #16
    1248:	0000082c 	andeq	r0, r0, ip, lsr #16
    124c:	01f30004 	mvnseq	r0, r4
    1250:	00009f50 	andeq	r9, r0, r0, asr pc
    1254:	00000000 	andeq	r0, r0, r0
    1258:	082c0000 	stmdaeq	ip!, {}	; <UNPREDICTABLE>
    125c:	08300000 	ldmdaeq	r0!, {}	; <UNPREDICTABLE>
    1260:	00010000 	andeq	r0, r1, r0
    1264:	00083050 	andeq	r3, r8, r0, asr r0
    1268:	00083400 	andeq	r3, r8, r0, lsl #8
    126c:	f3000400 	vshl.u8	d0, d0, d0
    1270:	009f5001 	addseq	r5, pc, r1
    1274:	00000000 	andeq	r0, r0, r0
    1278:	34000000 	strcc	r0, [r0], #-0
    127c:	38000008 	stmdacc	r0, {r3}
    1280:	01000008 	tsteq	r0, r8
    1284:	08385000 	ldmdaeq	r8!, {ip, lr}
    1288:	083c0000 	ldmdaeq	ip!, {}	; <UNPREDICTABLE>
    128c:	00040000 	andeq	r0, r4, r0
    1290:	9f5001f3 	svcls	0x005001f3
	...
    129c:	0000083c 	andeq	r0, r0, ip, lsr r8
    12a0:	00000840 	andeq	r0, r0, r0, asr #16
    12a4:	40500001 	subsmi	r0, r0, r1
    12a8:	44000008 	strmi	r0, [r0], #-8
    12ac:	04000008 	streq	r0, [r0], #-8
    12b0:	5001f300 	andpl	pc, r1, r0, lsl #6
    12b4:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    12b8:	00000000 	andeq	r0, r0, r0
	...

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
   0:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
   4:	00000220 	andeq	r0, r0, r0, lsr #4
   8:	00000308 	andeq	r0, r0, r8, lsl #6
   c:	00000334 	andeq	r0, r0, r4, lsr r3
	...
  18:	000000f8 	strdeq	r0, [r0], -r8
  1c:	00000100 	andeq	r0, r0, r0, lsl #2
  20:	000001dc 	ldrdeq	r0, [r0], -ip
  24:	000001fc 	strdeq	r0, [r0], -ip
	...
  30:	00000100 	andeq	r0, r0, r0, lsl #2
  34:	00000104 	andeq	r0, r0, r4, lsl #2
  38:	000001fc 	strdeq	r0, [r0], -ip
  3c:	0000021c 	andeq	r0, r0, ip, lsl r2
	...
