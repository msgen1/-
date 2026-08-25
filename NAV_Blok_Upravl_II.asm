;
.device ATmega32
; тактовая частота 4 Мгц
.include "m32def.inc"                             

;***** Регистры-переменные ******************************************************************************

; .def 		 			= r0					; дисплей 
; .def 	tm0				= r1
.def	tmp		 		= r2					; таймеры 
.def 	temp0 			= r3					; температура 
.def 	AdT1			= r4					; температура
.def	Adw0			= r5					; ACP 
.def	Adw1			= r6					; ACP
.def	MW0				= r7					; ACP
.def	MW1				= r8					; ACP
.def	MW2				= r9					; ACP
.def	divtm1			= r10					; 
.def	divtm2			= r11					; 
.def	divsr1			= r12					; Регистры используются в подпрограмме деления и умножения числа и в измерении температуры
.def	divsr2			= r13					; 
.def	divnt1			= r14					; 
.def	divnt2			= r15					; 

.def	count			= r16 					; счетчик 
.def	ring_dtmf 		= r17					; КОМАНДА НА УПРАВЛЕНИЕ ПО DTMF 
.def	data_uart		= r18 					; данные уарт
.def	search_flags 	= r19 					; температуры
.def 	tm1				= r20 					; прерывания
.def	temp			= r21
.def	cnt3			= r22 
.def	divtm3			= r23				 
.def	cnt0			= r24					; ACP						; 
.def	cnt1			= r25					; ACP

.def	adres_data		= r30	 				; Запись в ЕЕПРОМ и в преобразовании чисел				; 
.def	data			= r31

;***********************************************************************************************************

;***********************************************************************************************************

.equ  	ACP_IZM_U		= PA0					; асп измерение
.equ  	dallas			= PA1					; датчики температурs 1				ACP_IZM_T1
; .equ  ACP_IZM_T2		= PA2					; 						; 			
; .equ	ACP_IZM_T3		= PA3					;  						; 
.equ	vkl_semistora	= PA4					; включение семистора 
.equ	vkl_2_tan		= PA5 					; включение допонительного тэна		vkl_voda_220-реле воды 220 в 					; 
; .equ	call_tan_2		= PA6					; 
.equ	signal			= PA7					; сирена
;———————————————————————————————————————————
.equ  	klapan_hvostov	= PB0					; клапан хвостов
.equ  	kl_tela 		= PB1					; клапан тела
.equ 	shim_golov		= PB2					; реле управения отбором 
.equ	Out_shim		= PB3  					; шим регулятор напряжения
.equ 	vkl_voda_12		= PB4 					; реле воды 12 в 		           	;     
.equ	Call_1			= PB5					; кнопка пуск
.equ	Call_2			= PB6					; кнопка +
.equ	Call_3			= PB7					; кнопка -
;———————————————————————————————————————————
.equ 	pd4_			= PC0					; индикатор 
.equ 	pd5_ 			= PC1					; индикатор 
.equ 	pd6_ 			= PC2					; индикатор 					
.equ	pd7_			= PC3					; индикатор  
; .equ	call_tan_2		= PC4  					; кнопка вкл второго тэна
.equ	call_tan_3		= PC5  					; кнопка вкл третьего тэна
.equ  	qvarc1			= PC6 					; кварц часов					
.equ  	qvarc2		  	= PC7					; кварц часов					
;———————————————————————————————————————————
; .equ	TXD				= PD0 					; txd
; .equ 	RXD				= PD1					; rxd
.equ	dat_rozl		= PD2 					; датчик розлива 
.equ	RS		 		= PD3 					; индикатор 
.equ 	E	 			= PD4 					; индикатор 
.equ	d_golov			= PD5   				; датчик голов									;
.equ	call_tan_2		= PD6 					; реле включения второго тэна  					;
.equ	vkl_3_tan		= PD7 					; реле включения третьго тэна 
 					;
;———————————————————————————————————————————
.equ 	Addr 			= 7 					; бит7=1 команда установки адреса в RAM
.equ 	Str 			= 6 					; бит6=0 - строка 1, бит6=1 - строка 2

.equ TIMER1_PRELOAD = 65536 - 15625  

.equ 	XTAL = 4000000
.equ 	baudrate = 9600
.equ 	bauddivider = XTAL/(16*baudrate) - 1

.dseg
;==============================================================================


; ТЕЛЕФОНИЯ
	GSM_opoveshen:		.byte 1				; отключение в программе работу GSM
	nomer1:				.byte 1				; данные номера телефона
	nomer2:				.byte 1	
	nomer3:				.byte 1	
	nomer4:				.byte 1	
	nomer5:				.byte 1	
	nomer6:				.byte 1				; данные номера телефона
	nomer7:				.byte 1	
	nomer8:				.byte 1	
	nomer9:				.byte 1	
	flag_nomera_tlf:	.byte 1

	num_programs:		.byte 1
	zapusk:				.byte 1

	flag_uart:			.byte 1
	num_sms:			.byte 1

; ПИВОВАРЕНИЕ 
	tim_data:			.byte 1			; флаг отправки данных
	rejim_stb:			.byte 1			; выбор одного из трех напряжений стабилизации
	prog_avtoklav:		.byte 1			; флаг включения автоклава 
	prog_pivo:			.byte 1			; флаг включения пивоварения

	p_1:				.byte 1			; пауза1
	p_2:				.byte 1			; пауза2
	p_3:				.byte 1			; пауза3	
	p_4:				.byte 1			; пауза4
	p_5:				.byte 1			; пауза5
	p_6:				.byte 1			; пауза6
	p_7:				.byte 1			; пауза7
	p_8:				.byte 1			; пауза8
	p_9:				.byte 1			; пауза9
	p_10:				.byte 1			; пауза10
	p_11:				.byte 1			; пауза11
	p_12:				.byte 1			; пауза12

	T_pause1_r:			.byte 1			; температура разгона при автоклаве
	T_pause1:			.byte 1			; контрольная температура паузы1
	T_pause2:			.byte 1			; контрольная температура паузы2
	T_pause3:			.byte 1			; контрольная температура паузы3
	T_pause4:			.byte 1			; контрольная температура паузы4
	T_pause5:			.byte 1			; контрольная температура паузы5
	T_pause6:			.byte 1			; контрольная температура паузы6
	T_pause7:			.byte 1			; контрольная температура паузы7

	TS_sbor_NZ:			.byte 1			; температура нагрева для затирания
	TN_1:				.byte 1	
	TN_2:				.byte 1	
 	TS_sbor_NV:			.byte 1			; температура нагрева для варения пива 
	Tak_1:				.byte 1	
	Tak_2:				.byte 1			; температура на индикаторе в пиве
	Tak_3:				.byte 1	

	nomer:				.byte 1			; номер паузы или температуры
	nomer0:				.byte 1			; номер паузы или температуры
	nomer00:			.byte 1			; номер паузы или температуры

	alarmsP:			.byte 1			; звук вкл/откл в пивоварении
	alarmsA:			.byte 1			; звук вкл/откл в АВТОКЛАВЕ
	Prichina:			.byte 1			; причина аварии
	recept:				.byte 1			; номер рецепта пивоварения 
	receptA:			.byte 1			; номер рецепта автоклава 
	fl_max:				.byte 1			; флаг на повышение температур
	fl_min:				.byte 1			; флаг на понижение температур

; ОБЩЕЕ
	dat_rozliva:		.byte 1			; отключение в программе работу датчика розлива
	kl_hvostov:			.byte 1			; отключение в программе работу хвостов
	dat_golov:			.byte 1			; отключение в программе работу датчика голов

	fl_otkl_tana:		.byte 1			; управление дополнительными тэнами проверка нажатия выключателей

	alarms:				.byte 1			; звук вкл/откл
; напряжение
	napryj_kontr:		.byte 1			; напряжение контроля
	U1_1:				.byte 1	
	U1_2:				.byte 1	
	U1_3:				.byte 1			; индикация напряжение на тэне 

	indik_1:			.byte 1	
	indik_2:			.byte 1	
	indik_3:			.byte 1			; индикация 
	indik_4:			.byte 1			; индикация 

	Uk_sbor_h:			.byte 1
	Uk_sbor_l:			.byte 1

	regul_Ur:			.byte 1			; напряжение регулировки ректификации
	regul_Ud:			.byte 1			; напряжение регулировки дистилляции
	regul_U_R:			.byte 1			; напряжение регулировки разгона в пивоварении
	regul_U_S:			.byte 1			; напряжение регулировки стабилизации в пивоварении
	regul_U_V:			.byte 1			; напряжениеки варения в пивоварении
	regul_U_A:			.byte 1			; напряжение регулировки варения в автоклаве 

	count_U:			.byte 1			; управление напряжением на тэне
	indik:				.byte 1

; температуры 
	T_ok_1_l:			.byte 1			; температура переключения 1
	T_ok_1_h:			.byte 1			; температура переключения 1
	T_ok_2_l:			.byte 1			; температура переключения 2
	T_ok_2_h:			.byte 1			; температура переключения 2
	T_ok_3_l:			.byte 1			; температура переключения 3
	T_ok_3_h:			.byte 1			; температура переключения 3

	T_contr_s:			.byte 1			; контрольная температуры сырца
	T1_0:				.byte 1
	T1_1:				.byte 1	
	T1_2:				.byte 1			; температура в кубе
	T1_3:				.byte 1	

	T_contr_o:			.byte 1	
	T2_0:				.byte 1	
	T2_1:				.byte 1	
	T2_2:				.byte 1			; температура в царге
	T2_3:				.byte 1	

	T_contr_d:			.byte 1			; контрольная температуры в дефлегматоре
	T3_0:				.byte 1	
	T3_1:				.byte 1	
	T3_2:				.byte 1			; температура в дефлегматоре
	T3_3:				.byte 1	

	TA_sbor:			.byte 1			; настраиваемая аварийная температура в дефлегматоре
	TV_sbor:			.byte 1			; настраиваемая температура включения воды
	TD_sbor:			.byte 1			; настраиваемая температура в дефлегматоре на настройку U
	
	Ts_sbor_r:			.byte 1			; настраиваемая температура перехода на стабилизацию при ректиф
	TS_sbor_d:			.byte 1			; настраиваемая температура перехода на стабилизацию при дистил

	T_ok_d_h:			.byte 1			; настраиваемая температура окончания дистилляции
	T_ok_d_l:			.byte 1	
	T_ok_r_h:			.byte 1			; настраиваемая температура окончания ректификации
	T_ok_r_l:			.byte 1	

	T4_1:				.byte 1	
	T4_2:				.byte 1			; температура в царге + дельта
	T4_3:				.byte 1	

	T_contr_o_h_const:	.byte 1	
	T_contr_o_l_const:	.byte 1	
	T_contr_o_h_c:		.byte 1			; расчетная температуры в узле отбора
	T_contr_o_l_c:		.byte 1

	T_contr_o_h:		.byte 1	
	T_contr_o_l:		.byte 1			; контрольная температуры в узле отбора

	temper_hs:			.byte 1			; контрольная температуры в кубе
	temper_ls:			.byte 1

	count_otbora_ostatok: .byte 1			; количество пауз оставшихся
	count_otbora:		.byte 1			; количество пауз настроенных

; ШИМ РЭЛЕ
	fl_SHIM:			.byte 1			; разрешение/запрет  шим

	xxh:				.byte 1			; расчетное число паузы реле отбора
	xxl:				.byte 1

	tim_vkl:			.byte 1			; время простоя отбора (пауза отбора) 
	contr_tim_vkl:		.byte 1

;ВРЕМЯ
	minutes_g:			.byte 1			; настраиваемое время окончания отбора голов
	hours_g:			.byte 1

	secondsA:			.byte 1
	seconds:			.byte 1
	sec_h:				.byte 1
	sec_l:				.byte 1			; секунды
	sec_s:				.byte 1			; 
	minutesA:			.byte 1	
	minutes:			.byte 1	
	min_h:				.byte 1
	min_l:				.byte 1			; минуты
	min_z:				.byte 1			; 

	hours:				.byte 1	
	hour_h:				.byte 1
	hour_l:				.byte 1			; часы

	timer1:				.byte 1			; таймер проверки температуры дефлегматора
	timer2:				.byte 1			; таймер меню
	timer3:				.byte 1			; счетчик цикла

	seconds_r:			.byte 1	
	minutes_r:			.byte 1	
	hours_r:			.byte 1	

	minutes_stb:		.byte 1			; настраиваемое время стабилизации при ректификации

	tim_kontr:			.byte 1			; время контроля проверки на регулировку напряжения в секундах
	tim_kontr_l:		.byte 1		
	tim_kontr_h:		.byte 1		
	tim_kontr_z:		.byte 1	

	minutes_P:			.byte 1			; настраиваемое время ПАУЗЫ ПРИ ОТБОРЕ ТЕЛА
	min_p_h:			.byte 1
	min_p_l:			.byte 1			; минуты

	delta:				.byte 1
	delta_ascii:		.byte 1
	delta_ascii2:		.byte 1

	dalay_h:			.byte 1			; число сброса реле отбора
	dalay_l:			.byte 1

	count_ascii:		.byte 1
	count_ascii2:		.byte 1

	fl_real_cloc:		.byte 1			; флаг работы реального таймера часов

	fl_vkl_vater:		.byte 1			; флаг для контроля включения воды (1 раз за сеанс)
	fl_peregrev:		.byte 1			; флаг используется при достижении определенных температур
	fl_rejima:			.byte 1			; флаг на запрет смены режима - если система уже запущена
	fl_tims:			.byte 1			; флаг управления таймером обратного отсчета в пивоварении
	fl_timsA:			.byte 1			; флаг остановки таймера при настройках
	fl_datch_rozl:		.byte 1			; флаг включения датчика розлива по архитектуре комплектации

	rejim_rab:			.byte 1			; номер программы ректиф или дист 1- ректиф 0- дистил

.cseg
.org	0

;-*********************************************************************************************-
;					ВЕКТОРА ПРЕРЫВАНИЙ ДЛЯ ATMEGA32
;-*********************************************************************************************-
;0
rjmp	RESET					;Установка
;1______________________________________________________________________________________________________________
.ORG INT0addr	    rjmp 	DEFAULT_ISR				;Внешнее прерывание 0
;2______________________________________________________________________________________________________________
.ORG INT1addr	    rjmp	DEFAULT_ISR				;Внешнее прерывание 1
;3______________________________________________________________________________________________________________
.ORG INT2addr	    rjmp	DEFAULT_ISR				;Внешнее прерывание 2
;4______________________________________________________________________________________________________________
.ORG OC2addr	    rjmp 	DEFAULT_ISR				;Совпадение  таймера/счетчика Т2
;5______________________________________________________________________________________________________________
.ORG OVF2addr		rjmp	TIMER2_OVF				;Переполнение таймера/счетчика Т2
;6______________________________________________________________________________________________________________
.ORG ICP1addr	    rjmp 	DEFAULT_ISR				;Захват таймера/счетчика Т1
;7______________________________________________________________________________________________________________
.ORG OC1Aaddr	    rjmp 	DEFAULT_ISR				;Совпадение «А» таймера/счетчика Т1
;8______________________________________________________________________________________________________________
.ORG OC1Baddr	    rjmp 	DEFAULT_ISR				;Совпадение «В» таймера/счетчика Т1
;9______________________________________________________________________________________________________________
.ORG OVF1addr		rjmp	TIMER1_OVF				;Переполнение таймера/счетчика Т1
;10______________________________________________________________________________________________________________
.ORG OC0addr	    rjmp 	DEFAULT_ISR				;Совпадение таймера/счетчика Т0
;11______________________________________________________________________________________________________________
.ORG OVF0addr		rjmp	TIMER0_OVF				;Переполнение таймера/счетчика Т0
;12______________________________________________________________________________________________________________
.ORG SPIaddr	    rjmp 	DEFAULT_ISR				;Передача по SPI завершена
;13______________________________________________________________________________________________________________
.ORG URXCaddr		rjmp	USART_RXC				;USART, прием завершен
;14______________________________________________________________________________________________________________
.ORG UDREaddr		rjmp 	DEFAULT_ISR				;Регистр данных USART пуст
;15______________________________________________________________________________________________________________
.ORG UTXCaddr	    rjmp 	DEFAULT_ISR				;USART, передача завершена
;16______________________________________________________________________________________________________________
.ORG ADCCaddr	    rjmp 	DEFAULT_ISR				;Преобразование АЦП завершено
;17______________________________________________________________________________________________________________
.ORG ERDYaddr	    rjmp 	DEFAULT_ISR				;EEPROM, готово
;18______________________________________________________________________________________________________________
.ORG ACIaddr	    rjmp 	DEFAULT_ISR				;Аналоговый компаратор
;19______________________________________________________________________________________________________________
.ORG TWIaddr	    rjmp 	DEFAULT_ISR				;Прерывание от модуля TWI
;20_____________________________________________________________________________________________________________
.ORG SPMRaddr	    rjmp 	DEFAULT_ISR				;Готовность SPM
;-------------------------------------------------------------------------------------------------------------------------------------
DEFAULT_ISR:	    reti

;*************************************************************************************************************************************
TIMER1_OVF:						; ШИМ РЭЛЕ ОТБОРА
;*************************************************************************************************************************************
	lds 	tm1, fl_SHIM					; выключатель шим
	tst		tm1
	brne	out_tim_3						; работает, если взведен
	reti

 ;--------------------------------------------------------------------
;		ВРЕМЯ выключенной РЭЛЮШКИ  - прерывание произойдет уже через 1 секунду
 ;--------------------------------------------------------------------
out_tim_3:
	lds		tm1, tim_vkl					; тикает секундный таймер обратного отсчета
	dec		tm1
	sts		tim_vkl, tm1
	tst		tm1
  ;--------------------------------------------------------------------
	breq	out_tim_2						; если tm1=0 запускаем время таймера удержания
  ;--------------------------------------------------------------------

	cbi 	portB, shim_golov				; включаем реле на время секундного таймера
	cpi		tm1, 100						; аварийный перезапуск таймера
	brsh	avariy_tim
	reti
avariy_tim:
 	lds		tm1, contr_tim_vkl     	 		; если сбой переписываемся
	sts		tim_vkl, tm1					; переписываем его в рабочий регистр

; ЭТО ВРЕМЯ ПРЕРЫВАЕНИЯ СЕКУНДНОГО ТАЙМЕРА

	ldi 	temp, high(TIMER1_PRELOAD)
	out 	TCNT1H, temp
	ldi 	temp, low(TIMER1_PRELOAD)
	out 	TCNT1L, temp


	reti

 ;--------------------------------------------------------------------
;		ВРЕМЯ УДЕРЖАНИЯ РЭЛЮШКИ В НАЖАТОМ СОСТОЯНИИ - прерывание произойдет уже через миллисекунды
 ;--------------------------------------------------------------------
	; запускаем таймер на миллисекунды, - это время удержания реле включенным.
out_tim_2:
	sbi 	portB, shim_golov				; включаем реле и удерживаем его по выше настроенным параметрам пока опять не произойдет прерывание таймера
 	lds		tm1, contr_tim_vkl				; это настроенный таймер в меню настроек
	sts		tim_vkl, tm1	

; ЭТО ВРЕМЯ ПРЕРЫВАЕНИЯ МИЛЛИСЕКУНДНОГО ТАЙМЕРА
	lds 	tm1, xxh						; Считать от нуля до xxh - это данные импульса шим
	out 	tcnt1h, tm1
	lds 	tm1, xxl						; Считать от нуля до xxl - это данные импульса шим
	out 	tcnt1l, tm1 
	reti

;*************************************************************************************************************************************
TIMER0_OVF:								; ШИМ - управление семистором (регулировкой напряжения)
	reti
;*************************************************************************************************************************************

;*************************************************************************************************************************************
TIMER2_OVF:						; Часы реального времени и таймеры отсчета
;*************************************************************************************************************************************
	lds		tm1, timer1
	inc		tm1								; блок  таймера прямого отсчета ( контроль температуры в дефлегматоре )
	sts		timer1, tm1
;  ------------------------------------------------------
	lds		tm1, timer2
	inc		tm1								; блок  таймера прямого отсчета цикл подпрограмм
	sts		timer2, tm1
;  ------------------------------------------------------
	lds		tm1, timer3
	inc		tm1								; блок  таймера прямого отсчета цикл подпрограмм
	sts		timer3, tm1
;  ------------------------------------------------------

;  ------------------------------------------------------
	lds		tm1, fl_otkl_tana				; управление дополнительными тэнами проверка нажатия выключателей
	tst		tm1
	breq	no_kontr
	sbic	PinD,call_tan_2
	cbi		PortA,vkl_2_tan
	sbis	PinD,call_tan_2
	sbi		PortA,vkl_2_tan
no_kontr:
;  ------------------------------------------------------
	lds		tm1, fl_timsA						; управление таймером при настройках
	tst		tm1
	brne	out_tim1

	lds		tm1, fl_tims						; управление таймером обратного отсчета
	tst		tm1
	brne	out_tim1

	lds		tm1, secondsA
	dec		tm1
	sts		secondsA, tm1						; блок  таймера обратного отсчета для отбора голов и стабилизации
	cpi		tm1, 255
	brne	out_tim1

	ldi		tm1, 59
	sts		secondsA, tm1

	lds		tm1, minutesA
	dec		tm1
	sts		minutesA, tm1

out_tim1:

	lds		tm1, seconds
	dec		tm1
	sts		seconds, tm1						; блок  таймера обратного отсчета для отбора голов и стабилизации
	cpi		tm1, 255
	brne	out_tim2

	ldi		tm1, 59
	sts		seconds, tm1

	lds		tm1, minutes
	dec		tm1
	sts		minutes, tm1
	cpi		tm1, 255
	brne	out_tim2

	ldi		tm1, 59
	sts		minutes, tm1

	lds		tm1, hours
	tst		tm1
	breq	out_tim2
	dec		tm1
	sts		hours, tm1

;  ------------------------------------------------------
out_tim2:

	lds		tm1, fl_real_cloc				; если не 0 - реальное время не тикает
	tst		tm1
	brne	out_tim2_1

	lds		tm1, seconds_r
	inc		tm1
	sts		seconds_r, tm1
	cpi		tm1, 60
	brlo	out_tim2_1
	clr		tm1
	sts		seconds_r, tm1					; блок часов реального времени работы системы
	lds		tm1, minutes_r
	inc		tm1
	sts		minutes_r, tm1
	cpi		tm1, 60
	brlo	out_tim2_1
	clr		tm1
	sts		minutes_r, tm1

	lds		tm1, hours_r
	inc		tm1
	sts		hours_r, tm1
;  ------------------------------------------------------
out_tim2_1:
	reti

;*************************************************************************************************************************************
USART_RXC:
;*************************************************************************************************************************************
	rcall 	USART_Receive
	cpi 	data_uart, 0x32					; проверка звонка - 2
	brne	USART_RXC_0
	rjmp 	zvonok							; да звонок идем на определение номера свой - чужой
USART_RXC_0:
	cpi 	data_uart, 0x44					; проверка D
	breq 	read							; это команда
	reti

;*********************************************************************
read:
	rcall 	USART_Receive
	cpi 	data_uart, 0x41					; проверка A
	breq 	read1							; 
	reti
read1:
	rcall 	USART_Receive
	cpi 	data_uart, 0x54					; проверка T
	breq 	read2							; 
	reti
read2:
	rcall 	USART_Receive
	cpi 	data_uart, 0x41					; проверка A
	breq 	read3							; 
	reti
read3:
	rcall 	USART_Receive
	cpi 	data_uart, 0x55					; проверка U
	breq 	rec_U_stb
	cpi 	data_uart, 0x53					; проверка S
	breq 	rec_reset							; 
	cpi 	data_uart, 0x41					; проверка A
	breq 	rec_zapusk
	reti
rec_U_stb:
	rcall 	USART_Receive
	lds		tm1, rejim_rab	
	cpi		tm1, 0	
	breq	priem_regul_Ud
	cpi		tm1, 1
	breq	priem_regul_Ur
	cpi		tm1, 2
	breq	priem_regul_Up
	sts		regul_U_A, data_uart			; напряжение стабилизации автоклава	
	ldi		adres_data, 50				; адрес еепром записи 50
	lds		data, regul_U_A
	call	write_eprom
	reti
priem_regul_Ud:
	sts		regul_Ud, data_uart			; напряжение стабилизации дистилляции 
	ldi		adres_data, 2				; адрес еепром записи 2
	lds		data, regul_Ud
	call	write_eprom
	reti
priem_regul_Ur:
	sts		regul_Ur, data_uart			; напряжение стаб ректификации
	ldi		adres_data, 3				; адрес еепром записи 3
	lds		data, regul_Ur
	call	write_eprom
	reti
priem_regul_Up:
	sts		regul_U_R, data_uart			; напряжение стабилизации пивоварения
	ldi		adres_data, 49				; адрес еепром записи 49
	lds		data, regul_U_R
	call	write_eprom
	reti
rec_zapusk:
	sts		zapusk, data_uart
	reti
rec_reset:
	sts		zapusk, data_uart
	reti

;*********************************************************************
;            +CLIP: "+79505833316",145,"",,":TSA",0 - такой ответ получаем при звонке и определившемся номере
;*********************************************************************
zvonok:
	ser		temp
	sts 	flag_uart, temp					; взводим флаг для смены номера хозяина аппаратуры

	ldi 	temp, (1<<RXEN) | (1<<TXEN) | (0<<RXCIE)
	out 	UCSRB, temp

	lds 	temp, flag_nomera_tlf
	tst		temp
	brne	read_nom_aon					; если номер уже записан в памяти, идем на его проверку при звонке
	clr		ring_dtmf
	reti
read_nom_aon:
	rcall 	USART_Receive					; пропускаем не нужную инфу до "+"
	cpi 	data_uart, 0x2B					; текст "+" ?

	breq	DTMF_upravlenie11
	brne 	read_nom_aon
DTMF_upravlenie11:
	rcall 	USART_Receive
	cpi 	data_uart, 0x43					; C
	breq 	DTMF_upravlenie21
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок
DTMF_upravlenie21:
	rcall 	USART_Receive
	cpi 	data_uart, 0x4C					; L
	breq 	DTMF_upravlenie31
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок
DTMF_upravlenie31:
	rcall 	USART_Receive
	cpi 	data_uart, 0x49					; I
	breq 	DTMF_upravlenie41
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок
DTMF_upravlenie41:
	rcall 	USART_Receive
	cpi 	data_uart, 0x50					; P
	breq 	DTMF_upravlenie51
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок
DTMF_upravlenie51:
	rcall 	USART_Receive					; пропускаем не нужную инфу до "+"
	cpi 	data_uart, 0x2B					; текст "+" ?
	breq 	DTMF_upravlenie52
	brne 	DTMF_upravlenie51
DTMF_upravlenie52:

	rcall 	USART_Receive; 7
	rcall 	USART_Receive; 9
	rcall 	USART_Receive; 5
	rcall 	USART_Receive; 0
	rcall 	USART_Receive; 5
	; ПРОВЕРЯЕМ ТОЛЬКО 6 ПОСЛЕДНИХ ЦИФР В НОМЕРЕ ТЕЛЕФОНА.
	lds		temp, nomer4		; 8
	rcall 	USART_Receive
	cp		temp, data_uart
	breq	read_nom_aon0					; это свой телефон - идем на сл строку
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок 
read_nom_aon0:
	lds		temp, nomer5		; 3
	rcall 	USART_Receive
	cp		temp, data_uart
	breq	read_nom_aon1					; это свой телефон - идем на сл строку
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок 
read_nom_aon1:
	lds		temp, nomer6		; 3
	rcall 	USART_Receive
	cp		temp, data_uart
	breq	read_nom_aon2					; это свой телефон - идем на сл строку
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок 
read_nom_aon2:
	lds		temp, nomer7		; 3
	rcall 	USART_Receive
	cp		temp, data_uart
	breq	read_nom_aon3					; это свой телефон - идем на сл строку
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок 
read_nom_aon3:
	lds		temp, nomer8		; 1
	rcall 	USART_Receive
	cp		temp, data_uart
	breq	read_nom_aon4					; это свой телефон - идем на сл строку
	rjmp	sbros_ring						; это чужой телефон - сбрасываем звонок
read_nom_aon4:
	lds		temp, nomer9		; 6
	rcall 	USART_Receive
	cp		temp, data_uart
	breq	read_nom_aon5					; это свой телефон - идем на сл строку
	rjmp 	sbros_ring						; это чужой телефон - сбрасываем звонок 
read_nom_aon5:
	ldi		ring_dtmf, 125
	reti
;  ------------------------------------------------------
sbros_ring:

	ldi 	data_uart, 0x41					; A
	rcall 	uart_snt
	ldi 	data_uart, 0x54					; T
	rcall 	uart_snt
	ldi 	data_uart, 0x48					; H
	rcall 	uart_snt 		
	ldi 	data_uart, 0x30					; 0
	rcall 	uart_snt 		
	rcall	crlf
	clr		ring_dtmf
	reti
;*************************************************************************************************************************************

;*************************************************************************************************************************************
; Инициализация прерываний
;*************************************************************************************************************************************

RESET:
	ldi		temp, low(RAMEND)             
	out		SPL, temp
	ldi		temp, high(RAMEND)				; установка стека
	out		SPH, temp

; Инициализация портов
InitPorts:
	ldi		temp, 0b10110000					; Установка PA
	out		DDRA, temp						; Записываем данные в регистры порта A
	ldi		temp, 0b01000000					; 
	out   	PortA, temp						; 1 - есть подключенный датчик, 0 - нет

	ldi		temp, 0b00011111					; Установка PB
	out		DDRB, temp						; Записываем данные в регистры порта B
	ldi		temp, 0b11100000					; 
	out   	PortB, temp						; 1 - есть подключенный датчик, 0 - нет

	ldi		temp, 0b00001111					; Установка PC
	out		DDRC, temp						; Записываем данные в регистры порта C
	ldi		temp, 0b00110000					; 
	out   	PortC, temp						; 1 - есть подключенный датчик, 0 - нет

	ldi		temp, 0b10011000					; Установка PD
	out		DDRD, temp						; Записываем данные в регистры порта D
	ldi		temp, 0b01100100					; 
	out   	PortD, temp

; Инициализация дисплея
    ldi temp, 1
    sts n_displ, temp

; Инициализация PA1
    cbi DDRA, dallas
    cbi PORTA, dallas

; Инициализация UART
uart_init:
    LDI 	temp, low(bauddivider)
    OUT 	UBRRL, temp
    LDI 	temp, high(bauddivider)
    OUT 	UBRRH, temp
    
	LDI 	temp, 0
    OUT 	UCSRA, temp
        
	LDI 	temp, (1 << URSEL) | (1 << UCSZ0) | (1 << UCSZ1) ; установка на 8 бит
    OUT 	UCSRC, temp

	ldi 	temp, (1 << RXEN) | (1 << TXEN) | (1 << RXCIE)
	out 	UCSRB, temp

	ldi 	temp, high(TIMER1_PRELOAD)
	out 	TCNT1H, temp

	ldi 	temp, low(TIMER1_PRELOAD)
	out 	TCNT1L, temp

	ldi 	temp, (1 << CS12)
	out 	TCCR1B, temp					; делитель = F/256

	ldi		temp, (1 << AS2)					; включение асинхронного режима таймера 2
	out		ASSR, temp
	clr		temp
	out		TCNT2, temp
	ldi		temp, 5
	out		TCCR2, temp						; Предделитель на 128 на 32768 частот 256 в секунду

	ldi		temp, 0b01110011
	out		TCCR0, temp						; настройка TCCR0 

	ldi		temp, 255
	out		tcnt0, temp
	ldi		temp, 0
	out		OCR0, temp						; установка 0

	ldi		temp, (1 << TOIE0 | 1 << TOIE1 | 1 << TOIE2) ; разрешение прерываний таймеров 2 (ОПЕЧАТКА)
	out		TIMSK, temp

	sei

	call	LCD_ini							; инициализация дисплея
	rcall	read_eeprom						; чтение памяти


;*************************************************************************************************************************************
; Флаги выключения/включения
;*************************************************************************************************************************************
	clr		temp
	;ser		temp							; установка флага отбора хвостов
	sts		kl_hvostov, temp
;*************************************************************************************************************************************
	clr		temp
	;ser		temp							; установка флага GSM
	sts		GSM_opoveshen, temp   
;*************************************************************************************************************************************
	clr		temp
;	ser		temp							; установка флага датчика розлива
	sts		fl_datch_rozl, temp   
;*************************************************************************************************************************************
	clr		temp
	;ser		temp							; установка флага пивоварения
	sts		prog_pivo, temp   
;*************************************************************************************************************************************
	clr		temp
	;ser		temp							; установка флага автоклава
	sts		prog_avtoklav, temp   
;*************************************************************************************************************************************





	clr		ring_dtmf						; сброс флага для обработки DTMF

	clr		temp

	sts		nomer, temp						; номер телефона в памяти (если 0 - будет записан в памяти)

	sts		num_sms, temp					; номер SMS
	sts		zapusk, temp					; сброс флага запуска
	sts		flag_uart, temp					; сброс флага UART

	sts		fl_otkl_tana, temp				; сброс флага управления тэном

	sts		fl_real_cloc, temp				; сброс флага работы реального таймера часов
	sts		fl_tims, temp					; сброс флага таймера обратного отсчета
	sts		fl_timsA, temp					; сброс флага таймера обратного отсчета

	sts		fl_rejima, temp					; сброс флага смены режима
	sts		fl_vkl_vater, temp				; сброс флага включения воды
	sts		fl_SHIM, temp					; сброс флага SHIM
	sts		fl_peregrev, temp				; сброс флага перегрева

	ldi		temp, 255
	sts		num_programs, temp				; для сброса пульта управления
	call	out_data

	cbi		PortB, klapan_hvostov			; выключение клапана хвостов
	cbi 	portB, shim_golov				; выключение реле отбора
	cbi		PortB, kl_tela					; выключение клапана тела

	cbi		PortA, vkl_2_tan				; выключение тэна 2

	rcall	otkl_kl_vod						; выключение клапана воды

;===============================

	ldi		temp, 0
	sts		num_programs, temp				; номер программы 0 - ДИСТИЛЯЦИЯ запущена

	lds		temp, GSM_opoveshen				; проверка флага GSM
	tst		temp
	brne	pusk_pauza						; если 1 - не выключен

	rcall	install_sim900					; инициализация SIM900

	lds		temp, flag_nomera_tlf
	tst		temp
	brne	pusk_pauza						; если флаг установлен, проверяем номер
proverka_nom:
	rcall	kontr_ring0						; проверка на звонок
	call	text_nomer
	call	text_nomera_tlf
	call	Delay_1sec
	rcall	kontr_ring0						; проверка на звонок
	call	Delay_1sec
	rcall	kontr_ring0						; проверка на звонок
	call	Delay_1sec
	rcall	kontr_ring0						; проверка на звонок
	call	text_nomer
	call	text_najm_pusk					; вывод сообщения "ПУСК"
	call	Delay_1sec
	sbis	PinB, Call_1					; проверка нажатия кнопки "ПУСК"
	rjmp	pusk_pauza0
	rjmp	proverka_nom
pusk_pauza0:
	call	text_pusto
	call	text_otpusti_pusk				; вывод сообщения "ОТПУСТИ ПУСК"
	call	Delay_1sec
	sbis	PinB, Call_1
	rjmp	pusk_pauza0						; ожидание нажатия кнопки "ПУСК"

	ldi		adres_data, 34					; адрес для записи
	ser		data							; запись - адрес для номера
	sts		flag_nomera_tlf, data
	call	write_eprom
	rjmp	pusk_pauza						; номер телефона записан в памяти

;===============================
kontr_ring0:
	lds		temp, flag_uart					; если флаг UART установлен - проверяем номер
	tst		temp
	brne	kontr_n
	ret
kontr_n:
	rjmp	Rec_nymbers						; идем на проверку номера
;===============================




;*************************************************************************************************************************************
	; Начало программы запуска  ОЖИДАНИЕ МЕНЮ НАСТРОЕК ИЛИ ЗАПУСКА
;*************************************************************************************************************************************
pusk_pauza:





;	lds		temp,zapusk						; автоматический запуск разгона по команде DTMF - 2 буква А
;	cpi		temp,0x41						;A
;	brne	pusk_pauza_0
;	rjmp	razgon_sys_00
pusk_pauza_0:

	clr		temp
	sts		timer3,temp
pusk_pauza_1:

	rcall	vibor_rejima
	call	text_najm_pusk
	call	Delay_1sec


;	sbis	PinB,Call_1
;	rjmp	razgon_sys_00					; при нажатии кнопки пуск - уходим на разгон системы
	sbis	PinB,Call_2
	call	nastroika_d					; при нажатии кнопки "+" - переход в меню настроек

	lds		temp,timer3
	cpi		temp,2
	brlo	pusk_pauza_1

;===============================
;	rcall	contr_vkl_vod					; контроль включения воды

;	lds		temp,zapusk						; автоматический запуск разгона по команде DTMF - 2
;	cpi		temp,0x41						;A
;	brne	pusk_pauza_2_0
;	rjmp	razgon_sys_00
pusk_pauza_2_0:

	clr		temp
	sts		timer3,temp
pusk_pauza_2:
	call	text_najm_pusk
	call	text_zapusk
	call	Delay_1sec

;	sbis	PinB,Call_1
;	rjmp	razgon_sys_00					; при нажатии кнопки пуск - уходим на разгон системы
	sbis	PinB,Call_2
	call	nastroika_d					; при нажатии кнопки пуск - переход в меню настроек

	lds		temp,timer3
	cpi		temp,3
	brlo	pusk_pauza_2
;===============================
;	rcall	contr_vkl_vod					; контроль включения воды
;	lds		temp,zapusk						; автоматический запуск разгона по команде DTMF - 2
;	cpi		temp,0x41						;A
;	brne	pusk_pauza_3_0
;	rjmp	razgon_sys_00
pusk_pauza_3_0:
	clr		temp
	sts		timer3,temp
pusk_pauza_3:

	rcall	izmereniy_ALL
	call	Delay_1sec

;	sbis	PinB,Call_1
;	rjmp	razgon_sys_00					; при нажатии кнопки пуск - уходим на разгон системы
	sbis	PinB,Call_2
	call	nastroika_d					; при нажатии кнопки пуск - переход в меню настроек

	lds		temp,timer3
	cpi		temp,6
	brlo	pusk_pauza_3
;===============================
;	rcall	contr_vkl_vod					; контроль включения воды


	rjmp	pusk_pauza


















;========================================================================================================================
razgon_sys_00:
	call	Delay_1sec
	rcall	vibor_rejima
	call	text_otpusti_pusk				; высвечиваем отпусти пуск
	sbis	PinB,Call_1
	rjmp	razgon_sys_00					; зацикливаемся до отпускания кнопки пуск

	rjmp	razgon_sys_0					; есл 0 или 1 -уходим на разгон системы дистилляции или ректификации

;========================================================================================================================
;				В идикатре высвечивается надпись в зависимости от выьранного режима
;========================================================================================================================
vibor_rejima:
	lds		temp,rejim_rab
	cpi		temp,0
	brne	rejim_dalee
	call	text_distil
	ret
rejim_dalee:
	cpi		temp,1
	brne	rejim_dalee1
	call	text_rectif
	ret
rejim_dalee1:	
	cpi		temp,2
	brne	rejim_dalee2
	call	text_pivovaren
	ret
rejim_dalee2:
	call	text_avtoklav
	ret







;*************************************************************************************************************************************
			; ПРОВЕРКА ТЕМПЕРАТУРЫ В КУБЕ ДЛЯ ВКЛЮЧЕНИЯ ОХЛАЖДЕНИЯ
;*************************************************************************************************************************************
contr_vkl_vod:
	lds		temp,fl_vkl_vater
	tst		temp
	breq	vkl_vod						; если флаг 0 - разрешаем контроль включения воды
	ret
vkl_vod:	
	call	Read_T_all				; измеряем температуры
	lds		xl,T_contr_s
	lds		yl,TV_sbor
	cp		xl,yl						; если температура в кубе больше настроенной
	brsh	vkl_vod0					; еидем на контрольное измерение
	rcall	otkl_kl_vod						; выключаем клапан подачи воды
	ret
vkl_vod0:								; включаем воду
	call	Delay_1sec
	call	Read_T_all				; измеряем температуры
	lds		xl,T_contr_s
	lds		yl,TV_sbor
	cp		xl,yl						; если температура в кубе больше настроенной
	brsh	vkl_vod1					; еидем на контрольное измерение
	rcall	otkl_kl_vod					; выключаем клапан подачи воды
	ret
vkl_vod1:								; включаем воду
	call	Delay_1sec
	call	Read_T_all				; измеряем температуры
	lds		xl,T_contr_s
	lds		yl,TV_sbor
	cp		xl,yl						; если температура в кубе больше настроенной
	brsh	vkl_vod2					; еидем на контрольное измерение
	rcall	otkl_kl_vod					; выключаем клапан подачи воды
	ret	
vkl_vod2:
	ser		temp
	sts		fl_vkl_vater,temp			; запрещаем контроль включения воды
	rcall	vkl_kl_vod					; включаем клапан подачи воды
	ret
;*************************************************************************************************************************************
	; Подготовка для разгона системы
;*************************************************************************************************************************************
razgon_sys_0:
	ldi		count,1
	call	signal_sis1					; звучит звуковой сигнал 5 секунд

	ser		temp
	sts		fl_rejima,temp				; запрет на смену режима в меню настроек

	ldi		temp,255
	out		OCR0,temp
	sbi		PortA,vkl_semistora			; включаем семистор

	clr		temp
	sts		hours_r,temp
	sts		minutes_r,temp				; обнуляем время  работы колонны
	sts		seconds_r,temp

sbi		PortA,vkl_2_tan					; включение тэна 2

	rcall	izmereniy_ALL				; измерение температур и напряжения 2 раза для точных данных в смс
	call	Delay_1sec
	rcall	izmereniy_ALL				; измерение температур и напряжения

	ldi		temp,1
	sts		num_programs,temp			; номер программы 1 разгон
	sts		num_sms,temp				; отправляем первую смс, что идет разгон
	rcall	out_sms

podgot_T_stb:
	lds		cnt3,TS_sbor_d				;  заппись дистилляции 
	lds		temp,rejim_rab
	cpi		temp,0
	breq	nastr_T_stabil00			; если  0 - идем в работу
	lds		cnt3,TS_sbor_r				; если не 1 - то данные ректификации
nastr_T_stabil00:
	mov		temp,cnt3
	call	calk
	sts		indik_2,r0
	call	div						; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		indik_1,r0

;*************************************************************************************************************************************
	; разгон системы
;*************************************************************************************************************************************
razgon_sys:

	rcall	clr_timer3
razgon_sys_1:

	sbis	PinB,Call_2						; при нажатии кнопки "+" - переход в меню настроек
	call	nastroika_d
	sbis	PinB,Call_3						; "-" - принудительный выход из разгона
	rjmp	stb_sys

	lds		temp,rejim_rab
	cpi		temp,1
	breq	rectif2
	call	text_razgon_dist			; высвечивается разгон дистилляции
	rjmp	distil2
rectif2:
	call	text_razgon_rekt			; высвечивается разгон ректификации
distil2:
	call	vremy_narab					; и высвечивается время работы колоны

	rcall	telo_razgona

	breq	razgon_sys_1_0				; если  0 - разгоняемся далее
	rjmp	stb_sys						; если  1 - выход из разгона
razgon_sys_1_0:
	lds		temp,timer3
	cpi		temp,5
	brlo	razgon_sys_1
;===============================
	rcall	clr_timer3
razgon_sys_2:

	sbis	PinB,Call_2						; при нажатии кнопки "+" - переход в меню настроек
	call	nastroika_d
	sbis	PinB,Call_3						; "-" - принудительный выход из разгона
	rjmp	stb_sys

	call	text_T_stab					; высвечивается температура стабилизации

	rcall	telo_razgona

	breq	razgon_sys_2_0				; если  0 - разгоняемся далее
	rjmp	stb_sys						; если  1 - выход из разгона
razgon_sys_2_0:
	lds		temp,timer3
	cpi		temp,5
	brlo	razgon_sys_2
;===============================
	rcall	clr_timer3
razgon_sys_3:

	sbis	PinB,Call_2						; при нажатии кнопки "+" - переход в меню настроек
	call	nastroika_d
	sbis	PinB,Call_3						; "-" - принудительный выход из разгона
	rjmp	stb_sys

	rcall	izmereniy_ALL				; измерение температур и напряжения

	rcall	telo_razgona

	breq	razgon_sys_3_0				; если  0 - разгоняемся далее
	rjmp	stb_sys						; если  1 - выход из разгона
razgon_sys_3_0:
	lds		temp,timer3
	cpi		temp,10
	brlo	razgon_sys_3

	rjmp	razgon_sys

;=========================================================================================================================================
clr_timer3:
	clr		temp
	sts		timer3,temp
	ret
;=========================================================================================================================================
telo_razgona:
	call	Delay_1sec
	rcall	contr_vkl_vod				; контроль включения воды
	rcall	kontr_stb					; контроль температур стабилизации
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	ret

;=========================================================================================================================================
;----------------------------------------------------------------------------------
;*****  ;- Контроль перехода на стабилизацию	****************************************************************************************
;----------------------------------------------------------------------------------
kontr_stb:
	lds		temp,rejim_rab
	cpi		temp,1
	breq	kontr_T_stb_rekt
;===============================

kontr_T_stb_dist:		  				; контроль при дистилляции
	call	Read_T_all
	clr		count
kontr_T_stb_dist0:
	lds		xl,T_contr_s				; контрольная температура в кубе
	lds		yl,TS_sbor_d				; температура настроенная для дистилляции 
	cp		xl,yl						; контроль температуры в кубе
	brsh	kontr_T_d					; если больше - идем на контроль еще раз
	ret
kontr_T_d:
	call	Delay_1sec
	call	Read_T_all
	inc		count
	cpi		count,3						; три раза проверяем температуру перехода
	brlo	kontr_T_stb_dist0
	ser		temp
	sts		fl_peregrev,temp			; взводим флаг о превышении температуры
	ret
;==================================================================================================================
kontr_T_stb_rekt:		  				; контроль при ректификации
	call	Read_T_all
	clr		count
kontr_T_stb_rect0:
	lds		xl,T_contr_o				; контрольная температура в узле отбора
	lds		yl,TS_sbor_r				; температура настроенная для ректификации
	cp		xl,yl						; контроль температуры в царге
	brsh	kontr_T_r					; если больше - идем на контроль еще раз
	ret
kontr_T_r:
	call	Delay_1sec
	call	Read_T_all
	inc		count
	cpi		count,3						; три раза проверяем температуру перехода
	brlo	kontr_T_stb_rect0
	ser		temp
	sts		fl_peregrev,temp			; взводим флаг о превышении температуры в царге
	ret

;========================================================================================================================
;========================================================================================================================
	; Стабилизация ректификациии или дистилляции
;========================================================================================================================
stb_sys:	

	ser		temp
	sts		fl_otkl_tana,temp				; разрешение на включение тэнов


	call	text_ind_stabil					; высвечивается стабилизация
	call	Delay_1sec
	sbis	PinB,Call_3						; - зацикливаемся - служебное
	rjmp	stb_sys

	ldi		temp,220
	out		OCR0,temp						; уменшаем резко напряжение примерно на половину

	clr		temp
	sts		indik,temp						; показываем индикацию при регулировки напряжения
	rcall	coreks_U						; стабилизируем напряжение до настроенного

	ldi		count,3
	call	signal_sis1						; звучит звуковой сигнал 5 секунд

	lds		temp,rejim_rab					; смотрим номер режима работы
	cpi		temp,0
	breq	distillyciy_sys_00				; уходим на дистилляцию 
	rjmp	stabilizaciy_rekt_0				; уходим на ректификацию

;=========================================================================================================================================

ind_voda0:			jmp	ind_voda
distillyciy_sys_00:	jmp	distillyciy_sys_0












;----------------------------------------------------------------------------------
;*****  ;-  ВСЕ  ИЗМЕРЕНИЯ	****************************************************************************************
;----------------------------------------------------------------------------------
izmereniy_ALL:
	rcall	contr_alarm_defa				; контроль аварийной температуры в дефлегматоре
izmereniy_ALL_0:
	call 	izmerenie_U						; измеряем напряжение
	call	Read_T_all					; измеряем температуру
	call	izmereniy						; индикация трех температур и напряжения на тэне
	ret


;=========================================================================================================================================
		;  ВЫКЛЮЧЕНИЕ  электроклапана воды 12 в или 220 вольт
;=========================================================================================================================================
otkl_kl_vod:
;	cbi		PortA,vkl_voda_220				; реле включения воды 220 в
	cbi		PortB,vkl_voda_12				; реле включения воды 12 в 
	ret
;=========================================================================================================================================
		;  ВКЛЮЧЕНИЕ  электроклапана воды 12 в или 220 вольт
;=========================================================================================================================================
vkl_kl_vod:
;	sbi		PortA,vkl_voda_220				; реле включения воды 220 в
	sbi		PortB,vkl_voda_12				; реле включения воды 12 в 
	ret




;========================================================================================================================
contr_alarm_defa:			; ПРОВЕРКА ТЕМПЕРАТУРЫ В ДЭФЕ  на аварию
;========================================================================================================================
	lds		xl,T_contr_d				; контроль аварийной температуры в дефе
	lds		yl,TA_sbor
	cp		xl,yl
	brsh	alarm						; уходим на повторный контроль

	lds 	temp,fl_datch_rozl			; смотрим есть ли датчик разлива в программе 0- есть
	tst		temp
	breq	contr_rozl_0				; если 0 - включен идем на контроль сработки
	ret
contr_rozl_0:
	lds 	temp,dat_rozliva			; смотрим включен  ли датчик разлива в настройках  0 - да
	tst		temp
	breq	contr_rozl_1				; если 0 - включен идем на контроль сработки
	ret
contr_rozl_1:
;=================================================================
	sbic	PinD,dat_rozl				; Если через полевик, то sbis
;=================================================================
	rjmp 	contr_rozl					; если сработал - проверяемся					; 
	ret
;========================================================================================================================
		; ПРОВЕРКА датчика розлива
;========================================================================================================================
contr_rozl:	
	call	Delay_1sec					; проверка через 1 сек
;=================================================================
	sbic	PinD,dat_rozl				; Если через полевик, то sbis
;=================================================================
	rjmp	alarm_voda					; сработал идем на индикацию ролива воды
	ret

;========================================================================================================================
			; ПРОВЕРКА АВАРИЙНОЙ ТЕМПЕРАТУРЫ В ДЕФЛЕГМАТОРЕ
;========================================================================================================================	
alarm:									; 3 раз проверка аварийной температуры
	call	Delay_1sec
	call	Read_T_all
	lds		xl,T_contr_d
	lds		yl,	TA_sbor
	cp		xl,yl						; если температура в дефлегматоре меньше настроенной
	brsh	alarm_1
	ret
alarm_1:
	call	Delay_1sec	
	call	Read_T_all
	lds		xl,T_contr_d
	lds		yl,	TA_sbor
	cp		xl,yl						; если температура в дефлегматоре меньше настроенной
	brsh	alarm_2
	ret
alarm_2:
	call	Delay_1sec
	call	Read_T_all
	lds		xl,T_contr_d
	lds		yl,	TA_sbor
	cp		xl,yl						; если температура в дефлегматоре меньше настроенной
	brsh	alarm_3
	ret
alarm_3:
;========ДА ЭТО ПЕРЕГРЕВ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	rcall	alarm_otklycheniy
alarm_full:
	ldi		count,2
	call	signal_sis1
	call	ind_alarm					; высвечивается перегрев
	call	text_najm_pusk
	call	Delay_1sec
	sbis	PinB,Call_1
	rjmp	out_indik
	ser		temp
	sts		Prichina,temp				; авария по перегреву - 1
	rjmp	alarm_full	
;======================================
alarm_voda:
	rcall	alarm_otklycheniy
alarm_voda0:
	ldi		count,2
	call	signal_sis1
	rcall	ind_voda0					; высвечивается разлита вода
	call	text_najm_pusk
	call	Delay_1sec
	sbis	PinB,Call_1
	rjmp	out_indik
	clr		temp
	sts		Prichina,temp				; авария по воде - 0
	rjmp	alarm_voda0
;======================================
out_indik:
	call	text_pusto
	call	text_otpusti_pusk			; высвечиваем отпусти пуск
	call	Delay_1sec
	sbis	PinB,Call_1					; крутимся до отпускания кнопки пуск
	rjmp	out_indik
	rjmp	reset
;======================================

alarm_otklycheniy:
	ldi		temp,200
	sts		num_programs,temp			; номер программы 0 - ДЕЖУРНЫЙ РЕЖИМ пульт ресетится

	clr 	temp						; 
	sts		fl_otkl_tana,temp			; запрет на включение тэнов

	sts		fl_SHIM,temp				; запрещаем  шим
	out		OCR0,temp					; уменьшаем напряжение на тэне
	cbi		PortA,vkl_semistora			; выключение семистора
	cbi 	portB,shim_golov
	rcall	otkl_kl_vod					; выключаем клапан подачи воды
	cbi		PortB,kl_tela				; КЛАПАН ТЕЛА
	cbi		PortB,klapan_hvostov		; клапан хвостов

	cbi		PortA,vkl_2_tan				; выключение тэна 2

	ret

;========================================================================================================================
;******	;- контроль температуры  в дефлегматоре на регулировку напряжения по настраиваемому таймеру  ******
;========================================================================================================================
contr_t_def:
	lds		temp,count_U				; ручное или автоматическое
	tst 	temp
	breq	regulirovka					; если  0 - ручная регулировка

	lds		yl,timer1					; данные таймера
	lds		xl,tim_kontr				;!!!!tim_kontr!!!!!!!! Через сколько секунд   контроллируем температуру с регулировкой напряжения
	cp		yl,xl
	brsh	contr_t_def1				; если время прошло болше настроенного то идем на регулировку напряжения
	ret

regulirovka:
	ser		temp
	sts		indik,temp					; НЕ показываем индикацию при регулировки напряжения
	rjmp	coreks_U					; если 0 - стабилизация напряжения к настроенному - ручное
	clr		temp
	sts		indik,temp					; показываем индикацию при регулировки напряжения
	ret
;========================================================================================================================
					; Регулировка напряжения в зависимости от темпеатуры в дефлегматоре

;менше 44 гралусов -увеличиваем напряжение 44,45,46 - пропускаем (норма), 47 градусов и более - уменьшаем напряжение
;========================================================================================================================
contr_t_def1:
	call	napryjenie					; высвечивается текст (напряжение в 1 строке)
	call	nastr_contr_U				; высвечивается текст (регулир во 2 строке)
	lds		xl,T_contr_d				; температура в дефлегматоре
	lds		yl,TD_sbor					; температура настраиваемая
	subi	yl,2						; уменьшили на 2
	cp		xl,yl						; cравниваем измеренную температуру и нстраиваемую
	brlo	inc_U_tena					; если меньше, идем на увеличение

	call	napryjenie					; высвечивается текст (напряжение в 1 строке)
	call	nastr_contr_U				; высвечивается текст (регулир во 2 строке)
	lds		xl,T_contr_d				; температура в дефлегматоре
	lds		yl,TD_sbor					; температура настраиваемая
	subi	yl,-2						; увеличмваем на 2
	cp		xl,yl						; cравниваем измеренную температуру и нстраиваемую
	brsh	dec_U_tena					; если больше, идем на уменьшение
	call	norma						; -  высвечивается норма
cancel_contr_u:
	call	izmerenie_U
	call	text_Utana_v				; -  высвечивается напряжение на тэне
	call	Delay_1sec
	clr		temp						
	sts		timer1,temp					; обнуляем время
	ret									
;======================================
;*****  ;- УВЕЛИЧЕНИЕ НАПРЯЖЕНИЯ	********
;======================================
inc_U_tena:
	rcall	raspred_u_max				; распределение высвечивается (максимум данные во 2 строке)
	ldi		cnt0,4
inc_U_tena0:
	call	U_incremnt					; высвечивается (плюс  в 1 строке)
	call	Delay_1sec
	dec		cnt0
	cpi		cnt0,254
	brlo	inc_U_tena0
;======================================
	lds		xl,Uk_sbor_h				; - напряжение контроля для ректификации
	lds		yl,napryj_kontr
	cp		yl,xl
	brsh 	minus_Un					; - если выше настроенной - уменьшаем
plys_Un:
	in		temp,OCR0
	cpi		temp,254
	brsh	cancel_contr_u				; - больше 245 - не увеличиваем
	inc		temp
	out		OCR0,temp
	rjmp	cancel_contr_u
;======================================
;*****  ;- УМЕНЬШЕНИЕ НАПРЯЖЕНИЯ	********
;======================================
dec_U_tena:
	rcall	raspred_u_min				; распределение, высвечивается (минимум данные во 2 строке)
	ldi		cnt0,4
dec_U_tena0:
	call	U_decriment					; высвечивается (минус в 1 строке)
	call	Delay_1sec
	dec		cnt0
	cpi		cnt0,254
	brlo	dec_U_tena0
;======================================
	lds		xl,Uk_sbor_l				; - напряжение контроля для ректификации
	lds		yl,napryj_kontr
	cp		yl,xl
	brlo	plys_Un						; - если ниже настроенной - увеличиваем
minus_Un:
	in		temp,OCR0
	cpi		temp,1
	brlo	cancel_contr_u				; - менше 1 - не уменьшаем
	dec		temp
	out		OCR0,temp
	rjmp	cancel_contr_u
;========================================================================================================================
raspred_u_min:
	lds		temp,regul_Ur				; минимальное настроенное напряжение
	subi	temp,10						; верхнее напряжение контроля
	sts		Uk_sbor_l,temp				; максимальное настроенное напряжение
	rjmp	ind_raspr
;======================================
raspred_u_max:
	lds		temp,regul_Ur
	subi	temp,-10					; верхнее напряжение контроля
	sts		Uk_sbor_h,temp				; максимальное настроенное напряжение
ind_raspr:
	call	calk
	sts		indik_3,r0
	call	div					
	mov		r30,divtm2			
	call	preobraz
	sts		indik_2,r0
	call	div					
	mov		r30,divtm2			
	call	preobraz
	sts		indik_1,r0
	call	max_contr_U					; высвечивается (максисмум данные во 2 строке)
	ret

;========================================================================================================================
	; РУЧНАЯ РЕГУЛИРОВКА НАПРЯЖЕНИЯ
;========================================================================================================================
kontr_zagr_U:
	lds		yl,regul_Ud					; напряжение стабилизации при дистилляции
	lds		temp,rejim_rab
	cpi		temp,0
	breq	kontr_zagr_U_0
	lds		yl,regul_Ur					; напряжение стабилизации при ректификации
kontr_zagr_U_0:
	ret
;==================================================================================================================
;*****  ;- коррекция НАПРЯЖЕНИЯ СТБ	********
;==================================================================================================================
coreks_U:
	lds		temp,indik	
	tst		temp
	brne	coreks_U_P_A

	call	napr_stsb1					; высвечивается напряжение стабил
	call	text_Utana_v				; Высвечивается  измеренное напряжение на тэне во второй строке
coreks_U_P_A:

	call	izmerenie_U				; измеряем напряжение на тэне
	lds		xl,napryj_kontr				; измеренное напряжение

	rcall	kontr_zagr_U

	subi	yl,2						; уменьшили на 2
	cp		xl,yl						; cравниваем измеренное напряжение  и контрольное
	brlo	plys_Ud						; если меньше, идем на увеличение

	rcall	kontr_zagr_U

	subi	yl,-2						; увеличмваем на 2
	cp		xl,yl						; больше - cравниваем напряжение контроля и настроенное
	brsh	minus_Ud					; если больше, идем на уменьшение
	clr		temp						
	sts		timer1,temp					; обнуляем время контроля напряжения ручного
	ret
;========================================================================================================================	
;*****  ;- УВЕЛИЧИВАЕМ НАПРЯЖЕНИЯ СТБ	********
;========================================================================================================================	
plys_Ud:
	in		temp,OCR0
	cpi		temp,254
	brlo	plys_U_0					; - если меньше 250, то еще увеличиваем
	ret									; если болше - выходим
plys_U_0:
	in		temp,OCR0
	inc		temp
	out		OCR0,temp
	rjmp	coreks_U					; уходим на еще один контроль
;========================================================================================================================	
;*****  ;- УМЕНЬШЕНИЕ НАПРЯЖЕНИЯ СТБ	********
;========================================================================================================================	
minus_Ud:
	in		temp,OCR0
	cpi		temp,1
	brsh	minus_U_0					; - если больше 5, то еще уменьшаем
	ret									; если меньше - выходим
minus_U_0:
	in		temp,OCR0
	dec		temp
	out		OCR0,temp
	rjmp	coreks_U					; уходим на еще один контроль

.macro Set_cursorD
	ldi		temp,(1<<Addr)|(@0<<Str)+@1 	; курсор строка @0 (0-1) позиция @1 (0-15)
	call	LCD_command_4bit
.endm













;***************************************************************************************
install_sim900:
;***************************************************************************************
;peredacha:
	ldi 	temp,(0<<RXEN)|(1<<TXEN)|(0<<RXCIE)
	out 	UCSRB,temp
;***************************************************************************************
				;1 отправка ate0-выключить эхо команду
;***************************************************************************************
	rcall	at
	ldi 	data_uart,0x45		;E
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x30		;0
	rcall 	uart_snt						; отправляем байт
	rcall	crlf
;***************************************************************************************	
				;2 отправка atq0-отвечать на команды
;***************************************************************************************					
	rcall	at
	ldi 	data_uart,0x51		;Q
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x30		;0
	rcall 	uart_snt						; отправляем байт	
	rcall	crlf			
;***************************************************************************************	
				;3 отправка atv0-отвечать на команды цифровым кодом
;***************************************************************************************
	rcall	at
	ldi 	data_uart,0x56		;v
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x30		;0
	rcall 	uart_snt						; отправляем байт
	rcall	crlf
;***************************************************************************************
				;4 автоответ через 2 звонка  ATS0=2
;***************************************************************************************
	rcall	at
	ldi 	data_uart,0x53		;S
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x30		;0
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x32		;2
	rcall 	uart_snt						; отправляем байт
	rcall	crlf				
;***************************************************************************************
			;	5 Команда AT+DDET=1 включить dtmf ответ
;***************************************************************************************
	rcall	at
	ldi 	data_uart,0x2B		;+
	rcall 	uart_snt
	ldi 	data_uart,0x44		; d
	rcall 	uart_snt
	ldi 	data_uart,0x44		; d
	rcall 	uart_snt
	ldi		data_uart,0x45		; e	
	rcall	uart_snt				;
	ldi		data_uart,0x54		; t	
	rcall	uart_snt
	ldi 	data_uart,0x3D		; =	
	rcall	uart_snt
	ldi		data_uart,0x31		; 1	
	rcall	uart_snt
	rcall	crlf				
;***************************************************************************************	
			;	6 Команда 	;AT+CLIP=1	-определять номер
;***************************************************************************************	
	rcall	at
	ldi 	data_uart,0x2B		;+
	rcall 	uart_snt
	ldi 	data_uart,0x43		;C
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x49		;I
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x50		;P
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x31		;1
	rcall 	uart_snt						; отправляем байт
	rcall	crlf
;***************************************************************************************
					;7 отправка AT+CMGF=1 текстовый режим
;***************************************************************************************
	rcall	at
	ldi 	data_uart,0x2B		;+
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x43		;c
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x4D		;m
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x47		;g
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x46		;f
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x31		;1
	rcall 	uart_snt						; отправляем байт	
	rcall	crlf
;***************************************************************************************	
				;A 8 T+CSCB=1 - не принимать широковещательные сообщения
;***************************************************************************************
	rcall	at
	ldi 	data_uart,0x2B		;+
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x43		;c
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x73		;s
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x47		;c
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x62		;b
	rcall 	uart_snt						; отправляем байт
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt						; отправляем байт	
	ldi 	data_uart,0x31		;1
	rcall 	uart_snt						; отправляем байт	
	rcall	crlf

	ldi 	temp,(1<<RXEN)|(1<<TXEN)|(1<<RXCIE)
	out 	UCSRB,temp
	ret
;***************************************************************************************
;*********************************************************************
; Процедура приема байта через уарт 0
;*********************************************************************
USART_Receive:
	sbis	UCSRA,RXC				; ждем освобождения буфера приема
	rjmp	USART_Receive
	in		data_uart,UDR
	ret
;*********************************************************************		
; Процедура отправки байта через уарт 1
;*********************************************************************
uart_snt: 	
	sbis	UCSRA,UDRE				; ждем освобождения буфера передачи
	rjmp	uart_snt
	out		UDR,data_uart
	ret
;*********************************************************************		
		;общие подпрограммы.
;*********************************************************************
at:
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt
	ret
;*********************************************************************		
		;общие подпрограммы.
;*********************************************************************
crlf:
	ldi 	data_uart,0x0D		;перевод каретки 
	rcall 	uart_snt
	ldi 	data_uart,0x0A		;новая строка
	rcall 	uart_snt
	ret






;***************************************************************************************
; ДТМФ управление
;***************************************************************************************
komands_dtmf0:

	ldi 	temp,(1<<RXEN)|(1<<TXEN)|(0<<RXCIE)		; прием передача
	out 	UCSRB,temp

	call	text_komandaD
	call	text_pusto
	rcall	DTMF_upravlenie0
jdem_dtmf0:
	rcall 	USART_Receive
	cpi 	data_uart,0x30				
	brne	komands_dtmf1
	rjmp 	komanda0
komands_dtmf1:
	cpi 	data_uart,0x31				;
	brne	komands_dtmf2
	rjmp 	komanda1
komands_dtmf2:
	cpi 	data_uart,0x32
	brne	komands_dtmf3
	rjmp 	komanda2
komands_dtmf3:
	cpi 	data_uart,0x33				;	смотрим, какой нрмер запишем в 0 ячейку
	brne	komands_dtmf4
	rjmp 	komanda3
komands_dtmf4:
	cpi 	data_uart,0x34
	brne	komands_dtmf5
	rjmp 	komanda4
komands_dtmf5:
	cpi 	data_uart,0x35				;
	brne	komands_dtmf6
	rjmp 	komanda5
komands_dtmf6:
	cpi 	data_uart,0x36
	brne	komands_dtmf7
	rjmp 	komanda6
komands_dtmf7:
	cpi 	data_uart,0x37				;
	brne	komands_dtmf8
	rjmp 	komanda7
komands_dtmf8:
	cpi 	data_uart,0x38
	brne	komands_dtmf9
	rjmp 	komanda8
komands_dtmf9:
	cpi 	data_uart,0x39				;
	brne	komands_dtmf10
	rjmp 	komanda9
komands_dtmf10:
	cpi 	data_uart,0x23				;#
	brne	komands_dtmf11
	rjmp 	komanda10					; при получении # - сбрасываем соединение
komands_dtmf11:
	cpi 	data_uart,0x2A				;*
	brne	komands_dtmf12
	rjmp 	komanda11					; при получении * - сбрасываем соединение
komands_dtmf12:

	rjmp 	komands_dtmf0			; крутимся, пока не получим нужную команду

;***************************************************************************************
		; ПРОЦЕДУРА СЧИТЫВАНИЯ КОМАНДЫ
;***************************************************************************************

DTMF_upravlenie0:

	rcall 	USART_Receive
	cpi 	data_uart,0x2B				;+
	breq 	DTMF_upravlenie1
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie1:
	rcall 	USART_Receive
	cpi 	data_uart,0x44				;D
	breq 	DTMF_upravlenie2
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie2:
	rcall 	USART_Receive
	cpi 	data_uart,0x54				;T
	breq 	DTMF_upravlenie3
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie3:
	rcall 	USART_Receive
	cpi 	data_uart,0x4D				;M
	breq 	DTMF_upravlenie4
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie4:
	rcall 	USART_Receive
	cpi 	data_uart,0x46				;F
	breq 	DTMF_upravlenie5
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie5:
	rcall 	USART_Receive
	cpi 	data_uart,0x3A				;:
	breq 	DTMF_upravlenie6
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie6:
	rcall 	USART_Receive
	cpi 	data_uart,0x20				;пробел
	breq 	DTMF_upravlenie7
	rjmp 	DTMF_upravlenie0
DTMF_upravlenie7:
	ret

;***************************************************************************************
		; КОМАНДА 0		остановка системы
;***************************************************************************************
komanda0:
Set_cursorD 1,2 ;курсор строка 0 позиция 0  (0-15)
	ldi		temp,$30					;- 0
	call	LCD_data

	call	Delay_1sec
	rcall	sbros_zvonka

	ldi		temp,9
	sts		num_sms,temp
	rcall	out_sms
	rjmp	reset					; 0 - сброс системы
;***************************************************************************************
		; КОМАНДА 1		запуск системы
;***************************************************************************************
komanda1:							; 1 - включение системы
Set_cursorD 1,2 ;курсор строка 0 позиция 0  (0-15)
	ldi		temp,$31					;- 1
	call	LCD_data

	ser		temp
	sts		zapusk,temp

	rcall	sbros_zvonka
	ret
;***************************************************************************************
		; КОМАНДА 2		отправка информации о работе системы
;***************************************************************************************

komanda2:
Set_cursorD 1,5 ;курсор строка 0 позиция 0  (0-15)
	ldi		temp,$32					;- 2
	call	LCD_data

	lds		temp,num_programs
	cpi		temp,1
	brne	komanda2_0
	sts		num_sms,temp
komanda2_0:
	cpi		temp,2
	brne	komanda2_1
	sts		num_sms,temp
komanda2_1:
	cpi		temp,3
	brne	komanda2_2
	sts		num_sms,temp
komanda2_2:	
	cpi		temp,4
	brne	komanda2_3
	sts		num_sms,temp
komanda2_3:
	cpi		temp,5
	brne	komanda2_4
	sts		num_sms,temp
komanda2_4:
	cpi		temp,6
	brne	komanda2_5
	sts		num_sms,temp
komanda2_5:
	rcall	sbros_zvonka
	rcall	out_sms
	ret

;***************************************************************************************
		; НА ОСТАЛЬНЫЕ КОМАНДЫ - СБРОС ЗВОНКА
;***************************************************************************************
komanda3:
	ldi		temp,$33					;- 3
	call	LCD_data
	rcall	sbros_zvonka
	ret							
komanda4:
	ldi		temp,$34					;- 4
	call	LCD_data
	rcall	sbros_zvonka
	ret							
komanda5:
	ldi		temp,$35					;- 5
	call	LCD_data
	rcall	sbros_zvonka
	ret
komanda6:
	ldi		temp,$36					;- 6
	call	LCD_data
	rcall	sbros_zvonka
	ret
komanda7:
	ldi		temp,$37					;- 7
	call	LCD_data
	rcall	sbros_zvonka
	ret
komanda8:
	ldi		temp,$38					;- 8
	call	LCD_data
	rcall	sbros_zvonka
	ret
komanda9:
	ldi		temp,$39					;- 9
	call	LCD_data
	rcall	sbros_zvonka
	ret
komanda10:
	ldi		temp,$23					;- #
	call	LCD_data
	rcall	sbros_zvonka
	ret
komanda11:
	ldi		temp,$23					;- #
	call	LCD_data
	rcall	sbros_zvonka
	ret

;*********************************************************************
						; запись нового номера
;*********************************************************************
Rec_nymbers:
Set_cursorD 0,0
	call	text_zap_nomerD
	call	text_pusto
Set_cursorD 1,2
	ldi		temp,'+'					;- +
	call	LCD_data
	ldi		temp,'7'					;- 7
	call	LCD_data
	ldi		temp,'9'					;- 9
	call	LCD_data
	clr		cnt0								
Rec_nymbers1:
	rcall	DTMF_upravlenie0
	rcall 	USART_Receive

	cpi 	data_uart,0x30				
	brne 	Rec_nymbers1_0
	rjmp	zapis
Rec_nymbers1_0:
	cpi 	data_uart,0x31				;
	brne 	Rec_nymbers1_1
	rjmp	zapis
Rec_nymbers1_1:
	cpi 	data_uart,0x32
	brne 	Rec_nymbers1_2
	rjmp	zapis
Rec_nymbers1_2:
	cpi 	data_uart,0x33				;	смотрим, какой нрмер запишем в 0 ячейку
	brne 	Rec_nymbers1_3
	rjmp	zapis
Rec_nymbers1_3:
	cpi 	data_uart,0x34
	brne 	Rec_nymbers1_4
	rjmp	zapis
Rec_nymbers1_4:
	cpi 	data_uart,0x35				;
	brne 	Rec_nymbers1_5
	rjmp	zapis
Rec_nymbers1_5:
	cpi 	data_uart,0x36
	brne 	Rec_nymbers1_6
	rjmp	zapis
Rec_nymbers1_6:
	cpi 	data_uart,0x37				;
	brne 	Rec_nymbers1_7
	rjmp	zapis
Rec_nymbers1_7:
	cpi 	data_uart,0x38
	brne 	Rec_nymbers1_8
	rjmp	zapis
Rec_nymbers1_8:
	cpi 	data_uart,0x39				;
	brne 	Rec_nymbers1_9
	rjmp	zapis
Rec_nymbers1_9:
	cpi 	data_uart,0x23				;#
	brne 	Rec_nymbers1_10					; при получении # - сбрасываем соединение
	rjmp	sbros_zvonka
Rec_nymbers1_10:
	cpi 	data_uart,0x2A				;*
	brne 	Rec_nymbers1_11					; при получении # - сбрасываем соединение
	rjmp	sbros_zvonka
Rec_nymbers1_11:
	rjmp	Rec_nymbers1
;=========================================================================================================
zapis:
	cpi		cnt0,0	
	brne	zapis_0
	rjmp	zapis0
zapis_0:
	cpi		cnt0,1	
	brne	zapis_1
	rjmp	zapis1
zapis_1:
	cpi		cnt0,2	
	brne	zapis_2
	rjmp	zapis2
zapis_2:
	cpi		cnt0,3	
	brne	zapis_3
	rjmp	zapis3
zapis_3:
	cpi		cnt0,4
	brne	zapis_4
	rjmp	zapis4
zapis_4:
	cpi		cnt0,5
	brne	zapis_5
	rjmp	zapis5
zapis_5:
	cpi		cnt0,6
	brne	zapis_6
	rjmp	zapis6
zapis_6:
	cpi		cnt0,7
	brne	zapis_7
	rjmp	zapis7
zapis_7:
	cpi		cnt0,8
	brne	zapis_8
	rjmp	zapis8
zapis_8:
	rjmp 	Rec_nymbers1
;=========================================================================================================

;-------------------------------------
zapis0:								;5
	sts		nomer1,data_uart	
Set_cursorD 1,5
	lds		temp,nomer1			
	call	LCD_data
	ldi		cnt0,1
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis1:								;0
	sts		nomer2,data_uart	
Set_cursorD 1,6
	lds		temp,nomer2
	call	LCD_data
	ldi		cnt0,2
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis2:								;5
	sts		nomer3,data_uart	
Set_cursorD 1,7
	lds		temp,nomer3
	call	LCD_data
	ldi		cnt0,3
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis3:								;8
	sts		nomer4,data_uart	
Set_cursorD 1,8
	lds		temp,nomer4
	call	LCD_data
	ldi		cnt0,4
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis4:								;3
	sts		nomer5,data_uart	
Set_cursorD 1,9
	lds		temp,nomer5
	call	LCD_data
	ldi		cnt0,5
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis5:								;3
	sts		nomer6,data_uart	
Set_cursorD 1,10
	lds		temp,nomer6
	call	LCD_data
	ldi		cnt0,6
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis6:								;3
	sts		nomer7,data_uart	
Set_cursorD 1,11
	lds		temp,nomer7
	call	LCD_data
	ldi		cnt0,7
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis7:								;1
	sts		nomer8,data_uart	
Set_cursorD 1,12
	lds		temp,nomer8
	call	LCD_data
	ldi		cnt0,8
	rjmp 	Rec_nymbers1
;-------------------------------------
zapis8:								;6
	sts		nomer9,data_uart	
Set_cursorD 1,13
	lds		temp,nomer9
	call	LCD_data


	ldi		adres_data,35				; адрес еепром записи 7
	lds		data,nomer1		;5
	rcall	write_epromD
	ldi		adres_data,36				; адрес еепром записи сл.номера
	lds		data,nomer2		;0
	rcall	write_epromD
	ldi		adres_data,37				; адрес еепром записи сл.номера
	lds		data,nomer3		;5
	rcall	write_epromD
	ldi		adres_data,38				; адрес еепром записи сл.номера
	lds		data,nomer4		;8
	rcall	write_epromD
	ldi		adres_data,39				; адрес еепром записи сл.номера
	lds		data,nomer5		;3
	rcall	write_epromD
	ldi		adres_data,40				; адрес еепром записи сл.номера
	lds		data,nomer6		;3
	rcall	write_epromD
	ldi		adres_data,41				; адрес еепром записи сл.номера
	lds		data,nomer7		;3
	rcall	write_epromD
	ldi		adres_data,42				; адрес еепром записи сл.номера
	lds		data,nomer8		;1
	rcall	write_epromD
	ldi		adres_data,43				; адрес еепром записи сл.номера
	lds		data,nomer9		;6
	rcall	write_epromD	
	rcall	sbros_zvonka
	rjmp	reset					; - сброс системы

;========================================================================================================================	
						; Блок записи в ЕЕПРОМ по указанному адресу
;========================================================================================================================
write_epromD:	jmp		write_eprom


;*********************************************************************
;	сброс звонка	ATH0
;*********************************************************************
sbros_zvonka:
	call	Delay_1sec

	ldi 	temp,(0<<RXEN)|(1<<TXEN)|(0<<RXCIE)		; передача
	out 	UCSRB,temp

	ldi 	data_uart,0x41		;A
	rcall 	uart_snt
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt
	ldi 	data_uart,0x48		;H
	rcall 	uart_snt 		
	ldi 	data_uart,0x30		;0
	rcall 	uart_snt 		
	rcall	crlf				
	call	Delay_1sec

	clr		ring_dtmf

	ldi 	temp,(1<<RXEN)|(1<<TXEN)|(1<<RXCIE)		; прием, передача, прерывание
	out 	UCSRB,temp
	ret






;*********************************************************************
;	подготовка СМС
;*********************************************************************

listing_sms:
	lds		temp,num_sms

	cpi		temp,1
	brne	listing_sms0
	rjmp	sms_razgon					; если номер программы 1 - РАЗГОН
listing_sms0:
	cpi		temp,2
	brne	listing_sms1
	rjmp	sms_distil					; если номер программы 2 - ДИСТИЛЛЯЦИЯ
listing_sms1:
	cpi		temp,3
	brne	listing_sms2
	rjmp	sms_stabil					; если номер программы 3 - СТАБИЛИЗАЦИЯ
listing_sms2:
	cpi		temp,4
	brne	listing_sms3
	rjmp	sms_golov					; если номер программы 4 - ОТБОР ГОЛОВ
listing_sms3:
	cpi		temp,5
	brne	listing_sms4
	rjmp	sms_telo					; если номер программы 5 - ОТБОР ТЕЛА
listing_sms4:
	cpi		temp,6
	brne	listing_sms5
	rjmp	sms_thvost					; если номер программы 6 - XVOST
listing_sms5:
	cpi		temp,7
	brne	listing_sms6
	rjmp	sms_alarm					; если номер программы 7 - АВАРИЯ 
listing_sms6:
	cpi		temp,8
	brne	listing_sms7
	rjmp	sms_cancel					; если номер программы 8 - CANCEL
listing_sms7:
	cpi		temp,9
	brne	listing_sms8
	rjmp	sms_sbrosa					; если номер программы 9 - RESET
listing_sms8:
	ret

;-------------------------------------------------
sms_cancel:
	ldi 	data_uart,0x43		;C
	rcall 	uart_snt 		
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt			
	ldi 	data_uart,0x4E		;N
	rcall 	uart_snt	
	ldi 	data_uart,0x43		;C
	rcall 	uart_snt	
	ldi 	data_uart,0x45		;E
	rcall 	uart_snt
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_sbrosa:
	ldi 	data_uart,0x52		;R
	rcall 	uart_snt 		
	ldi 	data_uart,0x45		;E
	rcall 	uart_snt			
	ldi 	data_uart,0x53		;S
	rcall 	uart_snt	
	ldi 	data_uart,0x45		;E
	rcall 	uart_snt	
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt

	ret
;-------------------------------------------------
sms_alarm:
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt 		
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt			
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt	
	ldi 	data_uart,0x52		;R
	rcall 	uart_snt	
	ldi 	data_uart,0x4D		;M
	rcall 	uart_snt
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_razgon:
	ldi 	data_uart,0x52		;R
	rcall 	uart_snt 		
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt			
	ldi 	data_uart,0x5A		;Z
	rcall 	uart_snt	
	ldi 	data_uart,0x47		;G
	rcall 	uart_snt	
	ldi 	data_uart,0x4F		;0
	rcall 	uart_snt
	ldi 	data_uart,0x4E		;N
	rcall 	uart_snt
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_distil:
	ldi 	data_uart,0x44		;D
	rcall 	uart_snt 		
	ldi 	data_uart,0x49		;I
	rcall 	uart_snt			
	ldi 	data_uart,0x53		;S
	rcall 	uart_snt	
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt	
	ldi 	data_uart,0x49		;I
	rcall 	uart_snt
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_stabil:
	ldi 	data_uart,0x53		;S
	rcall 	uart_snt 		
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt			
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt	
	ldi 	data_uart,0x42		;B
	rcall 	uart_snt	
	ldi 	data_uart,0x49		;I
	rcall 	uart_snt
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_golov:
	ldi 	data_uart,0x47		;G
	rcall 	uart_snt 		
	ldi 	data_uart,0x4F		;O
	rcall 	uart_snt
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt			
	ldi 	data_uart,0x4F		;O
	rcall 	uart_snt	
	ldi 	data_uart,0x55		;V
	rcall 	uart_snt	
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_telo:
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt 		
	ldi 	data_uart,0x45		;E
	rcall 	uart_snt
	ldi 	data_uart,0x4C		;L
	rcall 	uart_snt			
	ldi 	data_uart,0x4F		;O
	rcall 	uart_snt	
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_thvost:
	ldi 	data_uart,0x58		;X
	rcall 	uart_snt 		
	ldi 	data_uart,0x56		;V
	rcall 	uart_snt
	ldi 	data_uart,0x4F		;O
	rcall 	uart_snt			
	ldi 	data_uart,0x53		;S
	rcall 	uart_snt	
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt	
	rcall	crlf
	rcall 	sms_T
	ret
;-------------------------------------------------
sms_T:
	ldi 	data_uart,0x54		;T
	rcall 	uart_snt 		
	ldi 	data_uart,0x20		;пусто
	rcall 	uart_snt
	ldi 	data_uart,0x4B		;K
	rcall 	uart_snt 		
	ldi 	data_uart,0x55		;U
	rcall 	uart_snt			
	ldi 	data_uart,0x42		;B
	rcall 	uart_snt	
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt
	lds		data_uart,T1_1 					;- число температуры
	rcall 	uart_snt
	lds		data_uart,T1_2 					;- число температуры
	rcall 	uart_snt
	ldi		data_uart,0x2C					;- запятая
	rcall 	uart_snt
	lds		data_uart,T1_3 					;- число температуры
	rcall 	uart_snt
	rcall	crlf

	ldi 	data_uart,0x54		;T
	rcall 	uart_snt 		
	ldi 	data_uart,0x20		;пусто
	rcall 	uart_snt
	ldi 	data_uart,0x43		;C
	rcall 	uart_snt	
	ldi 	data_uart,0x41		;A
	rcall 	uart_snt
	ldi 	data_uart,0x52		;R
	rcall 	uart_snt
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt
	lds		data_uart,T2_1 					;- число температуры
	rcall 	uart_snt
	lds		data_uart,T2_2 					;- число температуры
	rcall 	uart_snt
	ldi		data_uart,0x2C					;- запятая
	rcall 	uart_snt
	lds		data_uart,T2_3 					;- число температуры
	rcall 	uart_snt
	rcall	crlf

	ldi 	data_uart,0x54		;T
	rcall 	uart_snt 		
	ldi 	data_uart,0x20		;пусто
	rcall 	uart_snt
	ldi 	data_uart,0x44		;D
	rcall 	uart_snt	
	ldi 	data_uart,0x45		;E
	rcall 	uart_snt
	ldi 	data_uart,0x46		;F
	rcall 	uart_snt
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt
	lds		data_uart,T3_1 					;- число температуры
	rcall 	uart_snt
	lds		data_uart,T3_2 					;- число температуры
	rcall 	uart_snt
	ldi		data_uart,0x2C					;- запятая
	rcall 	uart_snt
	lds		data_uart,T3_3 					;- число температуры
	rcall 	uart_snt
	rcall	crlf

	ldi 	data_uart,0x55		;U
	rcall 	uart_snt 		
	ldi 	data_uart,0x20		;пусто
	rcall 	uart_snt
	ldi 	data_uart,0x74		;t
	rcall 	uart_snt	
	ldi 	data_uart,0x65		;e
	rcall 	uart_snt
	ldi 	data_uart,0x6E		;n
	rcall 	uart_snt
	ldi 	data_uart,0x61		;a
	rcall 	uart_snt
	ldi 	data_uart,0x3D		;=
	rcall 	uart_snt
	lds		data_uart,U1_1 		;- число напряжния
	rcall 	uart_snt
	lds		data_uart,U1_2 		;- число напряжния
	rcall 	uart_snt
	lds		data_uart,U1_3 		;- число напряжнияы
	rcall 	uart_snt
	ldi		data_uart,0x76		;- v
	rcall 	uart_snt
	ret
;-------------------------------------------------




;*********************************************************************
;	работа с СМС
;*********************************************************************
out_sms:
;AT+CMGS=«ХХХХХХХХХХХ» — отправка смс.
; После ввода команды выдает приглашение ">" после чего можно вводить текст сообщений.
; Завершается символом ESC или Ctrl-Z.

;-------------------------------------------------
	lds		temp,GSM_opoveshen				; смотрим разрешон ли GSM
	tst		temp
	brne	no_sms						; Если 1 - не разрешон.- уходим 
	rjmp	otpr_sms
no_sms:
	ret
otpr_sms:
	ldi 	temp,(0<<RXEN)|(1<<TXEN)|(0<<RXCIE) 	; перед
	out 	UCSRB,temp

	rcall	at
	ldi 	data_uart,0x2B			;+
	rcall 	uart_snt
	ldi 	data_uart,0x43			;C
	rcall 	uart_snt 	
	ldi 	data_uart,0x4D			;M
	rcall 	uart_snt
	ldi 	data_uart,0x47			;G
	rcall 	uart_snt 	
	ldi 	data_uart,0x53			;S
	rcall 	uart_snt
	ldi 	data_uart,0x3D			;=
	rcall 	uart_snt 	

	ldi 	data_uart,0x22			;"
	rcall 	uart_snt
	ldi 	data_uart,0x2B			;+
	rcall 	uart_snt
	ldi 	data_uart,0x37			;7
	rcall 	uart_snt	
	ldi 	data_uart,0x39			;9
	rcall 	uart_snt
	lds		data_uart,nomer1		;5
	rcall 	uart_snt
	lds		data_uart,nomer2		;0
	rcall 	uart_snt
	lds		data_uart,nomer3		;5
	rcall 	uart_snt
	lds		data_uart,nomer4		;8
	rcall 	uart_snt
	lds		data_uart,nomer5		;3
	rcall 	uart_snt
	lds		data_uart,nomer6		;3
	rcall 	uart_snt
	lds		data_uart,nomer7		;3
	rcall 	uart_snt
	lds		data_uart,nomer8		;1
	rcall 	uart_snt
	lds		data_uart,nomer9		;6
	rcall 	uart_snt
	ldi 	data_uart,0x22			;"
	rcall 	uart_snt

	rcall	crlf

	call	Delay_1sec
	call	Delay_1sec

	rcall	listing_sms

	ldi 	data_uart,0x1A			;CTRL+Z
	rcall 	uart_snt

	call	Delay_1sec

	clr		ring_dtmf
	sts		num_sms,ring_dtmf

	ldi 	temp,(0<<RXEN)|(0<<TXEN)|(0<<RXCIE)		;	уарт не работает
	out 	UCSRB,temp

	call	Delay_1sec
	call	Delay_1sec
	call	Delay_1sec
	call	Delay_1sec
	call	Delay_1sec

	ldi 	temp,(1<<RXEN)|(0<<TXEN)|(1<<RXCIE)		; прием и прерывание
	out 	UCSRB,temp
	ret



read_eeprom:


;========================================================================================================================
	sbic	PinB,Call_1
	rjmp	no_reset					; если при чтении епром нажата кнопка пуск - то производим принудительную запись начальных настроек
;========================================================================================================================


;========================================================================================================================
	ldi		adres_data,1				; адрес еепром 1
	ldi		data,0						; включаем режим ДИСТИЛЛЯЦИИ 
	call	write_eprom
;======================================
	ldi		adres_data,2				; адрес еепром 2
	ldi		data,170					; 170 вольт  запись  напржения регулировки для дистилляции 
	call	write_eprom
;======================================
	ldi		adres_data,3				; адрес еепром 3
	ldi		data,160					; 160 вольт  запись  напржения регулировки для ректификации
	call	write_eprom
;======================================
	ldi		adres_data,4				; адрес еепром 4
	ldi		data,60						; 60 градусов запись температуры ухода в аварию в дэфе
	call	write_eprom
;======================================
	ldi		adres_data,5				; адрес еепром 5
	ldi		data,70						; 70 градусов запись  температуры включения воды 
	call	write_eprom
;======================================
	ldi		adres_data,6				; адрес еепром 6
	ldi		data,80						; 80 граусов запись температуры стабилизации при дистилляции
	call	write_eprom
;======================================
	ldi		adres_data,7				; адрес еепром 7
	ldi		data,40						; 40 градусов запись температуры стабилизации при ректификации
	call	write_eprom
;======================================
	ldi		xh,high(965)
	ldi		xl,low(965)					; 96,5 градусов ЗАПИСЬ ТЕМПЕРАТУРЫ ОКОНЧАНИЯ ДИСТИЛЛЯЦИИ
	ldi		adres_data,8				; адрес еепром 8
	mov		data,xl
	call	write_eprom	
	ldi		adres_data,9				; адрес еепром 9
	mov		data,xh
	call	write_eprom
;======================================
	ldi		adres_data,10				; адрес еепром 10
	ldi		data,40						; 40 минут - время стабилизации
	call	write_eprom
;======================================
	ldi		adres_data,11				; адрес еепром 11
	ldi		data,10						; 10 секунд записываем времени закрытия (пауза) реле ШИМ для голов
	call	write_eprom
;======================================
	ldi		xh,high(3120)				; 40 msek
	ldi		xl,low(3120)
	ldi		adres_data,12				; адрес еепром 12
	mov		data,xh						; запись импульса на время открытия шим H для голов
	call	write_eprom
	ldi		adres_data,13				; адрес еепром 13
	mov		data,xl						; запись импульса на время открытия шим L для голов 
	call	write_eprom
;======================================
    ldi		adres_data,14				; адрес еепром 14
	ldi		data,4						; 4 -  запись часов отбора голов
	call	write_eprom				; 
;======================================
	ldi		adres_data,15				; адрес еепром 15
	ldi		data,30						; 30 минут запись минут отбора  голов
	call	write_eprom
;======================================
	ldi		adres_data,16				; адрес еепром 16
	ldi		data,5	
	call	write_eprom				; запись дэльты для расчета окончания отбора тела
;======================================
	ldi		adres_data,17				; адрес еепром 17
	ldi		data,5						; 5 секунд записываем времени закрытия (пауза) реле ШИМ для тела 1
	call	write_eprom
;======================================
	ldi		xh,high(6240)				; 80 msek
	ldi		xl,low(6240)
	ldi		adres_data,18				; адрес еепром 18
	mov		data,xh						; запись импульса на время открытия шим H для тела 1
	call	write_eprom
	ldi		adres_data,19				; адрес еепром 19
	mov		data,xl						; запись импульса на время открытия шим L для тела 1 
	call	write_eprom
;======================================
	ldi		adres_data,20				; адрес еепром 20
	ldi		data,6						; 6 секунд записываем времени закрытия (пауза) реле ШИМ для тела 2
	call	write_eprom
;======================================
	ldi		xh,high(5460)				; 70 msek
	ldi		xl,low(5460)
	ldi		adres_data,21				; адрес еепром 21
	mov		data,xh						; запись импульса на время открытия шим H для тела 2
	call	write_eprom
	ldi		adres_data,22				; адрес еепром 22
	mov		data,xl						; запись импульса на время открытия шим L для тела 2 
	call	write_eprom
;======================================
	ldi		adres_data,23				; адрес еепром 23
	ldi		data,7						; 7 секунд записываем времени закрытия (пауза) реле ШИМ для тела 3
	call	write_eprom
;======================================
	ldi		xh,high(4680)				; 60 msek
	ldi		xl,low(4680)
	ldi		adres_data,24				; адрес еепром 24
	mov		data,xh						; запись импульса на время открытия шим H для тела 3
	call	write_eprom
	ldi		adres_data,25				; адрес еепром 25
	mov		data,xl						; запись импульса на время открытия шим L для тела 3 
	call	write_eprom
;======================================
	ldi		adres_data,26				; адрес еепром 26
	ldi		data,2						; 2 ПАУЗЫ ПРИ ОТБОРЕ ТЕЛА
	call	write_eprom
;======================================
	ldi		adres_data,27				; адрес еепром 27
	ldi		data,15						; 15 минут  - ВРЕМЯ ПАУЗ ПРИ ОТБОРЕ ТЕЛА
	call	write_eprom
;======================================
	ldi		xh,high(896)
	ldi		xl,low(896)					; 89,5 градусов ЗАПИСЬ ТЕМПЕРАТУРЫ ОКОНЧАНИЯ РЕКТИФИКАЦИИ
	ldi		adres_data,28				; адрес еепром 28
	mov		data,xl
	call	write_eprom	
	ldi		adres_data,29				; адрес еепром 29
	mov		data,xh
	call	write_eprom
;======================================
	ldi		adres_data,30				; адрес еепром 30
	ldi		data,90						; таймер контроля температуры в дефе для регулировки напряжения - 90 секунд 
	call	write_eprom
;======================================
	ldi		adres_data,31				; адрес еепром 31
	ldi		data,45						; 45 градусов температура в дефлегматоре для настройки U на тэне
	call	write_eprom
;======================================
	ldi		adres_data,32			 	; адрес еепром 32
	ldi		data,0						; ручное управление напряжением на тэне
	call	write_eprom
;======================================
	ldi		adres_data,33				; адрес еепром 33
	ser		data						; отключение звука
	call	write_eprom
;======================================
	ldi		adres_data,34				; адрес еепром 34
	clr		data						; сбрасываем  -  для записи нового номера
	call	write_eprom
;======================================================================================================================================

; адреса с 35 по 43, используются для записи номера телефона хозяина автоматики и пишутся в GSM файле. 

;======================================================================================================================================
	ldi		adres_data,44				; адрес еепром 44
	clr		data						; включение датчика голов
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,45				; адрес еепром 45
	clr 	data						; включение датчика разлива - 0
	call	write_eprom
;======================================================================================================================================

;	пивоварение/ автоклав


	ldi		adres_data,46				; адрес еепром 46
	ser		data						; звук при пивоварении
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,47				; адрес еепром 47
	ldi		data,$31					; рецепрт номер 1 -  в пивоварении 
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,48				; адрес еепром 48
	ldi		data,$31						; рецепрт номер 1  - мясо в автоклаве
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,49				; адрес еепром 49
	ldi		data,180					; 180 ВОЛЬТ напряжение разгона при пивоварении
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,50				; адрес еепром 50
	ldi		data,170					; 170 ВОЛЬТ напряжение стб автоклава
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,51				; адрес еепром 51
	ldi		data,160					; 160 ВОЛЬТ напряжение стабилизации при пивоварении
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,52				; адрес еепром 52
	ldi		data,190					; 190 ВОЛЬТ напряжение варения при пивоварении
	call	write_eprom
;======================================================================================================================================
	ldi		adres_data,53				; адрес еепром 53
	ser		data						; звук В АВТОКЛАВЕ
	call	write_eprom




;======================================================================================================================================
;		ПИВО 
;======================================================================================================================================


  	ldi		count,101 					; начальный адрес для 1 рецепта
rez:
	mov		adres_data,count			; с 101 по 121 адрес пишем 41
	ldi		data,50						; пауза 1
	call	write_eprom
	inc		count
	cpi		count,122
	breq	rez1		
	rjmp	rez
rez1:
	mov		adres_data,count			; с 122 по 142 адрес пишем 42
	ldi		data,50						; пауза 1
	call	write_eprom
	inc		count
	cpi		count,143
	breq	rez2
	rjmp	rez1
rez2:
	mov		adres_data,count			; с 143 по 163 адрес пишем 43
	ldi		data,30						; пауза 1
	call	write_eprom
	inc		count
	cpi		count,164
	breq	rez3
	rjmp	rez2
rez3:
	mov		adres_data,count			; с 164 по 184 адрес пишем 44
	ldi		data,40						; пауза 1
	call	write_eprom
	inc		count
	cpi		count,185
	breq	rez4
	rjmp	rez3
rez4:
	mov		adres_data,count			; с 185 по 205 адрес пишем 45
	ldi		data,60						; пауза 1
	call	write_eprom
	inc		count
	cpi		count,206
	breq	rez5
	rjmp	rez4
rez5:


;======================================================================================================================================
;		АВТОКЛАВ
;======================================================================================================================================

  	ldi		count,211 					; начальный адрес для 1 рецепта мяса
resA:
	mov		adres_data,count			; с 210 по 219 адрес пишем 51
	ldi		data,50					
	call	write_eprom
	inc		count
	cpi		count,221
	breq	resA1		
	rjmp	resA
resA1:
	mov		adres_data,count			; с 220 по 229 адрес пишем 52
	ldi		data,105					
	call	write_eprom
	inc		count
	cpi		count,231
	breq	resA2
	rjmp	resA1
resA2:
	mov		adres_data,count			; с 230 по 239 адрес пишем 53
	ldi		data,125					
	call	write_eprom
	inc		count
	cpi		count,241
	breq	resA3
	rjmp	resA2
resA3:


  

;======================================================================================================================================
;======================================================================================================================================
;======================================================================================================================================
;======================================================================================================================================
;======================================================================================================================================
no_reset:
	sbic	PinB,Call_1
	rjmp	no_reset1

	rcall	text_system_reset			; высвечиваем система ресет
	rcall	text_otpusti_pusk			; высвечиваем отпусти пуск
	sbis	PinB,Call_1
	rjmp	no_reset					; крутимся в цикле до отпускания кнопки
no_reset1:
;======================================================================================================================================
;======================================================================================================================================
;======================================================================================================================================
;======================================================================================================================================

	; ЧТЕНИЕ ЕПРОМ ПРИ ЗАГРУЗКИ СИСТЕМЫ



;======================================================================================================================================

  	ldi		adres_data,1				; адрес еепром 1
	call	read_eprom
	sts		rejim_rab,data				; читаем номер режима 1 - ректификация, 0 - дистилляция
;======================================
   	ldi		adres_data,2				; адрес еепром 2
	call	read_eprom
	sts		regul_Ud,data				; читаем стабилизации при дистилляции
;======================================
   	ldi		adres_data,3				; адрес еепром 3
	call	read_eprom
	sts		regul_Ur,data				; читаем стабилизации при ректифик
;======================================
	ldi		adres_data,4				; адрес еепром 4
	call	read_eprom
	sts		TA_sbor,data				; читаем аварийной температуры
;======================================
	ldi		adres_data,5				; адрес еепром 5
	call	read_eprom
	sts		TV_sbor,data				; чтение  температуры включения воды
;======================================
  	ldi		adres_data,6				; адрес еепром 6
	call	read_eprom
	sts		TS_sbor_d,data				; чтение температуры стабилизации при дистилляции
;======================================
   	ldi		adres_data,7				; адрес еепром 7
	call	read_eprom
	sts		TS_sbor_r,data				; чтение температуры стабилизации при ректифик
;======================================
	ldi		adres_data,8				; адрес еепром 8
	call	read_eprom
	sts		T_ok_d_l,data				; чтение L температуры окончания дистилляции
;======================================
	ldi		adres_data,9				; адрес еепром 9
	call	read_eprom
	sts		T_ok_d_h,data				; чтение H температуры окончания дистилляции
;======================================
	ldi		adres_data,10				; адрес еепром 9
	call	read_eprom
	sts		minutes_stb,data			; читаем время стабилизации при ректификации
;======================================================================================================================================

; адрес 11,12,13 - ШИМ отбора голов - читается перед отбором голов

;======================================================================================================================================
    ldi		adres_data,14				; адрес еепром 14
	call	read_eprom
	sts		hours_g,data				; часы отбора голов1
 ;======================================
 	ldi		adres_data,15				; адрес еепром 15
	call	read_eprom
	sts		minutes_g,data				; минуты  отбора голов1
;======================================
	ldi		adres_data,16				; адрес еепром 16
	call	read_eprom
	sts		delta,data					; дэльта для расчета окончания отбора тела
	lds		temp,delta
	call	calk
	sts		delta_ascii2,r0				; распределение на индикаторе
	call	div		
	mov		r30,divtm2			
	call	preobraz
	sts		delta_ascii,r0
;======================================================================================================================================

; адрес 17,18,19 - ШИМ отбора тела 1 - читается перед отбором тела 1

;======================================================================================================================================

; адрес 20,21,22 - ШИМ отбора тела 2 - читается перед отбором тела 2

;======================================================================================================================================

; адрес 23,24,25 - ШИМ отбора тела 3 - читается перед отбором тела 3

;======================================================================================================================================
	ldi		adres_data,26				; адрес еепром 26
	call	read_eprom
	sts		count_otbora,data			; количество пауз
	sts		count_otbora_ostatok,data
;======================================
	ldi		adres_data,27				; адрес еепром 27
	call	read_eprom
	sts		minutes_P,data				; количество минут в паузе
;======================================
	ldi		adres_data,28
	call	read_eprom
	sts		T_ok_r_l,data
;======================================
	ldi		adres_data,29
	call	read_eprom
	sts		T_ok_r_h,data
;======================================
 	ldi		adres_data,30				; адрес еепром 30
	call	read_eprom
 	sts		tim_kontr,data				; таймера контроля температуры в дефлегматоре
;======================================
	ldi		adres_data,31				; адрес еепром 31
	call	read_eprom
	sts		TD_sbor,data				; читаем температуру настройки в дэфе
;======================================
	ldi		adres_data,32				; адрес еепром 32
	call	read_eprom
	sts		count_U,data				; ручное иди автоматическое управление напряжением на тэне
;======================================
	ldi		adres_data,33				; адрес еепром 33
	call	read_eprom
	sts		alarms,data					; звук включен или выключен
;======================================
  	ldi		adres_data,34				; адрес еепром 34
	call	read_eprom
	sts 	flag_nomera_tlf,data		; смотрим нужно ли записывать номер телефона хозяина автоматики.

;======================================================================================================================================
; ЧИТАЕМ НОМЕР ТЕЛЕФОНА ХОЗЯИНА АВТОМАТИКИ  в предложении +79 - затем 9 цифh номера телефона например: 505833316
;======================================================================================================================================
	ldi		adres_data,35				; адрес еепром 35
	call	read_eprom
	sts		nomer1,data
 	ldi		adres_data,36				; адрес еепром 36
	call	read_eprom
	sts		nomer2,data
	ldi		adres_data,37				; адрес еепром 37
	call	read_eprom
	sts		nomer3,data
	ldi		adres_data,38				; адрес еепром 38
	call	read_eprom
	sts		nomer4,data
	ldi		adres_data,39				; адрес еепром 39
	call	read_eprom
	sts		nomer5,data
	ldi		adres_data,40				; адрес еепром 40
	call	read_eprom
	sts		nomer6,data
	ldi		adres_data,41				; адрес еепром 41
	call	read_eprom
	sts		nomer7,data
	ldi		adres_data,42				; адрес еепром 42
	call	read_eprom
	sts		nomer8,data
	ldi		adres_data,43				; адрес еепром 43
	call	read_eprom
	sts		nomer9,data

;======================================
	ldi		adres_data,44				; адрес еепром 44
	call	read_eprom
	sts		dat_golov,data				; датчик голов включен или выключен
;======================================
	ldi		adres_data,45				; адрес еепром 45
	call	read_eprom
	sts		dat_rozliva,data			; датчик разлива включен или выключен
;======================================



;	пивоварение / автоклав


	ldi		adres_data,46				; адрес еепром 46
	call	read_eprom
	sts		alarmsP,data				; звук при пивоварении
;======================================
	ldi		adres_data,47				; адрес еепром 47
	call	read_eprom
	sts		recept,data					; номер рецепта пива
;======================================
	ldi		adres_data,48				; адрес еепром 48
	call	read_eprom
	sts		receptA,data				; номер рецепта автоклава
;======================================
	ldi		adres_data,49				; адрес еепром 49
	call	read_eprom
	sts		regul_U_R,data				; напряжение разгонное при пивоварении
;======================================
	ldi		adres_data,50				; адрес еепром 50
	call	read_eprom
	sts		regul_U_A,data				; напряжение стб автоклава 
;======================================
	ldi		adres_data,51				; адрес еепром 51
	call	read_eprom
	sts		regul_U_S,data				; напряжение стабилизации при пивоварении
;======================================
	ldi		adres_data,52				; адрес еепром 52
	call	read_eprom
	sts		regul_U_V,data				; номер напряжение варения при пивоварении
;======================================
	ldi		adres_data,53				; адрес еепром 52
	call	read_eprom
	sts		alarmsA,data				; Звук при автоклаве
;======================================

	ret

;========================================================================================================================
;========================================================================================================================
	; ДИСТИЛЛЯЦИЯ 
;========================================================================================================================
distillyciy_sys_0:
	ldi		temp,2
	sts		num_programs,temp				; пишем номер программы 2 - дистилляция
	ldi		temp,2
	sts		num_sms,temp					; отправляем вторую смс
	rcall	out_sms
	clr		temp
	sts		fl_peregrev,temp				; сбрасываем флаг превышения контрольной температуры

	clr		temp
	sts		indik,temp						; показываем индикацию при регулировки напряжения
	rcall	coreks_U						; стабилизируем напряжение до настроенного

;===============================

distillyciy_sys:

	ser		temp
	sts		indik,temp						; НЕ показываем индикацию при регулировки напряжения
	rcall	coreks_U						; стабилизируем напряжение до настроенного

	clr		temp
	sts		indik,temp						; показываем индикацию при регулировки напряжения
	sts		timer3,temp
distillyciy_sys_1:
	sbis	PinB,Call_2						; при нажатии кнопки "+" - переход в меню настроек
	call	nastroika_d
	sbis	PinB,Call_3						; "-" - принудительный выход из дистилляции
	rjmp	cancel_distil

	rcall	text_distil						; высвечивается дистилляция
	call	vremy_narab						; и высвечивается время работы колоны
	call	Delay_1sec

	rcall	contr_vkl_vod					; контроль включения воды
	rcall	kontr_T_cancel_dist
	lds 	temp,fl_peregrev				; смотрим фла перегрева
	tst		temp
	breq	distillyciy_sys_1_0				; если  0 - продолжаем дистилляцию
	rjmp	cancel_distil					; если  1 - заканчиваем дистилляцию

distillyciy_sys_1_0:
	lds		temp,timer3
	cpi		temp,5
	brlo	distillyciy_sys_1
;===============================

	ser		temp
	sts		indik,temp						; НЕ показываем индикацию при регулировки напряжения
	rcall	coreks_U						; стабилизируем напряжение до настроенного

	clr		temp
	sts		indik,temp						; показываем индикацию при регулировки напряжения
	sts		timer3,temp
distillyciy_sys_2:

	sbis	PinB,Call_2						; при нажатии кнопки "+" - переход в меню настроек
	call	nastroika_d
	sbis	PinB,Call_3						; "-" - принудительный выход из дистилляции
	rjmp	cancel_distil


	rcall	text_T_ok_d						; высвечивается время окончания дистилляции
	call	Delay_1sec

	call	contr_vkl_vod					; контроль включения воды
	rcall	kontr_T_cancel_dist
	lds 	temp,fl_peregrev				; смотрим фла перегрева
	tst		temp
	breq	distillyciy_sys_2_0				; если  0 - продолжаем дистилляцию
	rjmp	cancel_distil					; если  1 - заканчиваем дистилляцию

distillyciy_sys_2_0:
	lds		temp,timer3
	cpi		temp,5
	brlo	distillyciy_sys_2
;===============================

	ser		temp
	sts		indik,temp						; НЕ показываем индикацию при регулировки напряжения
	rcall	coreks_U						; стабилизируем напряжение до настроенного

	clr		temp
	sts		indik,temp						; показываем индикацию при регулировки напряжения
	sts		timer3,temp
distillyciy_sys_3:
	call	Delay_1sec

	sbis	PinB,Call_2						; при нажатии кнопки "+" - переход в меню настроек
	call	nastroika_d
	sbis	PinB,Call_3						; "-" - принудительный выход из дистилляции
	rjmp	cancel_distil


	rcall	izmereniy_ALL					; измерение температур и напряжения
	call	contr_vkl_vod					; контроль включения воды
	rcall	kontr_T_cancel_dist
	lds 	temp,fl_peregrev				; смотрим флаг перегрева
	tst		temp
	breq	distillyciy_sys_3_0				; если  0 - продолжаем дистилляцию
	rjmp	cancel_distil					; если  1 - заканчиваем дистилляцию
distillyciy_sys_3_0:
	lds		temp,timer3
	cpi		temp,10
	brlo	distillyciy_sys_3

;===============================
; ГОМЕНИЗАЦИЯ - окончание по датчику наполнения
;===============================
	lds		temp,dat_golov					; смотрим разрешон ли датчик голов
	tst		temp
	brne	no_dat_gogl						; Если 1 - не разрешон.- пропускаем контроль датчика наполнения

	sbis	PinD,d_golov					; если банка наполнилась, идем на проверку

	rjmp	cancel_distil0
no_dat_gogl:
	rjmp	distillyciy_sys
cancel_distil0:
	call	Delay_1sec

	sbis	PinD,d_golov					; проверка

	rjmp	cancel_distil1	
	rjmp	distillyciy_sys
cancel_distil1:
	call	Delay_1sec

	sbis	PinD,d_golov 

	rjmp	cancel_distil					; если банка наполнилась, заканчиваем работу
	rjmp	distillyciy_sys

;========================================================================================================================
				 ;КОНТРОЛЬ ОКОНЧАНИЕ ОТБОРА ДИСТИЛЛЯЦИИ 
;========================================================================================================================
kontr_T_cancel_dist:		  				; контроль окончания дистилляции
	call	Read_T_all
	call	contr_vkl_vod					; контроль включения воды
	clr		count
kontr_T_cancel_dist0:
	lds		yh,temper_hs
	lds		yl,temper_ls
	lds		xh,T_ok_d_h						; пишим настраиваемую температуру оконч дисц
	lds		xl,T_ok_d_l
	cp		yl,xl
	cpc		yh,xh							; контроль температуры в кубе
	brsh	kontr_T_cancel_dist1			; если больше - идем на контроль еще раз
	ret
kontr_T_cancel_dist1:
	call	Delay_1sec
	call	Read_T_all
	inc		count
	cpi		count,3							; три раза проверяем температуру окончания 
	brlo	kontr_T_cancel_dist0
	ser		temp
	sts		fl_peregrev,temp				; взводим флаг о превышении температуры
	ret
;========================================================================================================================
				 ; ОКОНЧАНИЕ ОТБОРА ДИСТИЛЛЯЦИИ 
;========================================================================================================================
cancel_distil:
	rcall	text_stop_kolonna				; высвечивается стоп колонна
	call	Delay_1sec
	sbis	PinB,Call_3						; "-" - принудительный выход из дистилляции или ректификации
	rjmp	cancel_distil

	ldi		count,10
	call	signal_sis1						; звучит звуковой сигнал 10 секунд

	ldi		temp,8
	sts		num_sms,temp					; отправляем восьмую смс
	rcall	out_sms

	ser		temp
	sts		fl_real_cloc,temp				; запрет работы таймера реального времени - останавливаем часы

	clr		temp							; обнуляем время открытия рэле скорости отбора для слива флегмы и выключения воды
	sts		timer1,temp

	out		OCR0,temp						; уменьшаем напряжение на тэне
	sts		num_programs,temp

	cbi		PortA,vkl_semistora				; выключаем семистор

	clr		temp
	sts		fl_otkl_tana,temp				; запрет на включение  тэнов

	cbi		PortA,vkl_2_tan					; выключение тэна 2

;======================================
stop_fulld:
	clr		temp
	sts		timer3,temp
stop_fulld0:
	rcall	text_stop_kolonna				; высвечивается стоп колонна
	rcall	text_najm_pusk					; высвечивается нажмите пуск
	call	Delay_1sec

	sbis	PinB,Call_1
	rjmp	otp_pusk_d

	lds		temp,timer3
	cpi		temp,3
	brlo	stop_fulld0

;======================================
	clr		temp
	sts		timer3,temp
stop_full_d_0:
	lds		temp,rejim_rab
	cpi		temp,1
	breq	rectif3
	rcall	text_T_cuba						; высвечивается  температуры в кубе
	rjmp	distil3
rectif3:
	rcall	text_T_carga					; высвечивается  температуры в сарге 
distil3:
	call	vremy_narab						; и высвечивается время работы колоны
	call	Delay_1sec

	sbis	PinB,Call_1
	rjmp	otp_pusk_d

	lds		temp,timer3
	cpi		temp,3
	brlo	stop_full_d_0

;======================================
	lds		temp,timer1						; счетчик паузы удержания реле шим
	cpi		temp,120
	brlo	vkl_otb
	cbi 	portB,shim_golov				; выкючаем клапан отбора для слива флегмы - прошло время
	rcall	otkl_kl_vod						; выключаем клапан подачи воды
vkl_otb:
;======================================

	rjmp	stop_fulld

otp_pusk_d:
	ldi		temp,255
	sts		num_programs,temp				; пишем номер программы 255 - выход пульта на ресет

	rcall	text_otpusti_pusk				; высвечиваем отпусти пуск
	sbis	PinB,Call_1
	rjmp	otp_pusk_d						; крутимся в цикле до отпускания кнопки

	ldi		temp,255
	sts		num_programs,temp				; пишем номер программы 255 - выход пульта на ресет
	call	Delay_1sec
	jmp		reset




;========================================================================================================================
;========================================================================================================================
;========================================================================================================================
;========================================================================================================================
	; СТАБИЛИЗАЦИЯ РЕКТИФИКАЦИИ
;========================================================================================================================
stabilizaciy_rekt_0:

	ldi		count,3
	call	signal_sis1					; звучит звуковой сигнал 5 секунд

	ldi		temp,3
	sts		num_programs,temp			; номер программы 3 - стабилизация

	ldi		temp,3
	sts		num_sms,temp
	rcall	out_sms						; отправляем третью смс, что идет разгон

	lds		temp,minutes_stb
	sts		minutes,temp				; Записываем контрольное время стабилизации
	ldi		temp,5
	sts		seconds,temp

;======================================
stabilizaciy_rekt:
	rcall	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат
	clr		temp
	sts		timer3,temp
stabilizaciy_rekt_1:

	call	Delay_1sec

	sbis	PinB,Call_2
	call 	nastr_rekt				; можем перейти в настройки
	sbis	PinB,Call_3					; "-"  - принудительный выход из стабилизации
	rjmp	ottbor_frakciy

	rcall	text_ind_stabil				; высвечивается стабилизация
	call	vremy_narab					; и 5 сек высвечивается время работы колоны

	call	contr_vkl_vod				; контроль включения воды

	lds		temp,minutes				; Контроль окончания времени стабилизации
	tst		temp
	breq	ottbor_frakciy

	lds		temp,timer3
	cpi		temp,5
	brlo	stabilizaciy_rekt_1
;======================================
	rcall	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат
	clr		temp
	sts		timer3,temp
stabilizaciy_rekt_2:

	call	Delay_1sec

	sbis	PinB,Call_2
	call 	nastr_rekt				; можем перейти в настройки
	sbis	PinB,Call_3					; "-"  - принудительный выход из стабилизации
	rjmp	ottbor_frakciy

	rcall	text_ind_stabil				; высвечивается стабилизация
	rcall	vremy_stsb					; и 5 сек высвечивается время окончания стабилизации

	call	contr_vkl_vod				; контроль включения воды

	lds		temp,minutes				; Контроль окончания времени стабилизации
	tst		temp
	breq	ottbor_frakciy

	lds		temp,timer3
	cpi		temp,5
	brlo	stabilizaciy_rekt_2
;======================================
	rcall	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат
	clr		temp
	sts		timer3,temp
stabilizaciy_rekt_3:

	call	Delay_1sec

	sbis	PinB,Call_2
	call 	nastr_rekt				; можем перейти в настройки
	sbis	PinB,Call_3					; "-"  - принудительный выход из стабилизации
	rjmp	ottbor_frakciy

	call	izmereniy_ALL

	call	contr_vkl_vod				; контроль включения воды

	lds		temp,minutes				; Контроль окончания времени стабилизации
	tst		temp
	breq	ottbor_frakciy

	lds		temp,timer3
	cpi		temp,10
	brlo	stabilizaciy_rekt_3
;======================================

	rjmp	stabilizaciy_rekt


;========================================================================================================================
;========================================================================================================================
;========================================================================================================================
				 ; ОТБОР ФРАКЦИЙ
;========================================================================================================================

ottbor_frakciy:
	rcall	text_golov					; Высвечивается надпись отбор голов
	call	vremy_narab					; и высвечивается время работы колоны
	call	Delay_1sec
	sbis	PinB,Call_3					; "-" - принудительный выход из стабилизации - зацикливаемся
	rjmp	ottbor_frakciy

	ser 	temp						; 
	sts		fl_SHIM,temp				; разрешение работы шим	

	lds		data,hours_g
	sts		hours,data					; часы отбора голов
	lds		data,minutes_g
	sts		minutes,data				; минуты отбора голов
	ldi		temp,59
	sts		seconds,temp



	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	ldi		temp,4
	sts		num_programs,temp			; номер программы 4 - головы

	ldi		temp,4
	sts		num_sms,temp				; отправляем 4-ю смс
	rcall	out_sms



;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;========================================================================================================================
				 ; ОТБОР ГОЛОВ
;========================================================================================================================


	ldi		adres_data,12
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 12 адресу
	ldi		adres_data,13
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 13 адресу

	rcall	impuls_sbrosa				; расчет импульса сброса

	ldi		adres_data,11
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для голов по 11 адресу
	sts		tim_vkl,data

Otbor_golov:

;======================================
	rcall	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_golov1:
	sbis	PinB,Call_2
	call	nastr_rekt				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора голов - служебное
	rjmp	Otbor_tela_0

	rcall	text_golov					; Высвечивается надпись отбор голов
	rcall	vremy_narab					; и высвечивается время работы колоны
	call	Delay_1sec

	lds		temp,timer3
	cpi		temp,10
	brlo	Otbor_golov1
;======================================
	rcall	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_golov2:
	call	Delay_1sec
	sbis	PinB,Call_2
	call	nastr_rekt				; можем перейти в настройки	
	sbis	PinB,Call_3					; + - принудительный выход из отбора голов - служебное
	rjmp	Otbor_tela_0

	rcall	text_golov					; Высвечивается надпись отбор голов
	rcall	vremy_stsb_gol				; и высвечивается время отбора голов

	lds		temp,timer3
	cpi		temp,10
	brlo	Otbor_golov2
;======================================
	rcall	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_golov3:
	sbis	PinB,Call_2
	call	nastr_rekt				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора голов - служебное
	rjmp	Otbor_tela_0

	call	izmereniy_ALL
	call	Delay_1sec

	lds		temp,timer3
	cpi		temp,10
	brlo	Otbor_golov3


;========================================================================================================================
				 ; ПРОВЕРКА НАПОЛНЕНИЯ ГОЛОВ ИЛИ ВРЕМЯ ОКОНЧАНИЯ ОТБОРА ГОЛОВ
;========================================================================================================================

	lds		temp,dat_golov				; смотрим разрешон ли датчик голов
	tst		temp
	brne	contr_tim					; Если 1 - не разрешон.- пропускаем контроль датчика голов 

	sbis	PinD,d_golov				; если банка голов наполнилась, идем на проверку

	rjmp	Otbor_tela_00
	rjmp	contr_tim
Otbor_tela_00:
	call	Delay_1sec

	sbis	PinD,d_golov				; проверка

	rjmp	Otbor_tela_01
	rjmp	contr_tim
Otbor_tela_01:
	call	Delay_1sec

	sbis	PinD,d_golov 

	rjmp	Otbor_tela_0				; если банка голов наполнилась, переходим на отбор тела

contr_tim:
	lds		temp,hours					; Контроль окончания времени отбора голов
	tst		temp
	brne	Otbor_golov00
	lds		temp,minutes				; Контроль окончания времени отбора голов
	cpi 	temp,1
	brsh	Otbor_golov00
	rjmp	Otbor_tela_0	
Otbor_golov00:
	rjmp	Otbor_golov		

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;========================================================================================================================
				 ; ОТБОР ТЕЛА
;========================================================================================================================
Otbor_tela_0:
	rcall	text_tela1					; Высвечивается надпись отбор тела 1
	rcall	vremy_narab					; и высвечивается время работы колоны
	call	Delay_1sec
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора голов - зацикливаемся
	rjmp	Otbor_tela_0

  	sbi		PortB,kl_tela				; ВКЛЮЧЕНИЕ  КЛАПАН ТЕЛА

	lds		yh,T_contr_o_h
	lds		yl,T_contr_o_l
	sts		T_contr_o_h_const,yh
	sts		T_contr_o_l_const,yl		; расчитываем температуру окончания отбора тела
	rcall	calk_T4

	clr		temp
	sts		fl_peregrev,temp			; сбрасываем флаг о превышении температуры в царге

	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	ldi		temp,5
	sts		num_sms,temp				; отправляем 5-ю смс
	rcall	out_sms

	ldi		temp,5
	sts		num_programs,temp			; номер программы 5 - тело 1

	ldi		adres_data,18
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 18 адресу
	ldi		adres_data,19
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 19 адресу

	rcall	impuls_sbrosa				; расчет импульса сброса

	ldi		adres_data,17
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 17 адресу
	sts		tim_vkl,data				; записываем тайм

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Otbor_tela_1_st:

	sbis	PinB,Call_3					; "-" - принудительный выход из отбора тела 1
	rjmp	Otbor_tela_1_st_0

	rcall	text_tela1					; Высвечивается надпись отбор тела 1
	rcall	Otbor_tela

	rcall	contr_T_rekt
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	breq	Otbor_tela_1_st				; если  0 - отбираем тело 1 далее
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Otbor_tela_1_st_0:
	rcall	text_ind_pause				;  высвечивается текст ПАУЗА ОТБОРА
	call	Delay_1sec

	sbis	PinB,Call_3					; "-" - принудительный выход из отбора тела 1
	rjmp	Otbor_tela_1_st_0

	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	ldi		temp,6
	sts		num_programs,temp			; номер программы 6 - пауза 1
	rcall	run_pause
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	clr		temp
	sts		fl_peregrev,temp			; сбрасываем флаг о превышении температуры в царге

	ldi		temp,7
	sts		num_programs,temp			; номер программы 7 - тело 2

	ldi		adres_data,21
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 21 адресу
	ldi		adres_data,22
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 22 адресу

	rcall	impuls_sbrosa				; расчет импульса сброса

	ldi		adres_data,20
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 20 адресу
	sts		tim_vkl,data				; записываем тайм

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Otbor_tela_2_st:

	sbis	PinB,Call_3					; "-" - принудительный выход из отбора тела номер2
	rjmp	Otbor_tela_2_st_0

	rcall	text_tela2					; Высвечивается надпись отбор тела 2
	rcall	Otbor_tela

	rcall	contr_T_rekt
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	breq	Otbor_tela_2_st				; если  0 - отбираем тело 2 далее
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Otbor_tela_2_st_0:
	rcall	text_ind_pause				;  высвечивается текст ПАУЗА ОТБОРА
	call	Delay_1sec

	sbis	PinB,Call_3					; + - принудительный выход из отбора тела номер2
	rjmp	Otbor_tela_2_st_0

	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	ldi		temp,8
	sts		num_programs,temp			; номер программы 8 - пауза 2
	rcall	run_pause
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	clr		temp
	sts		fl_peregrev,temp			; сбрасываем флаг о превышении температуры в царге

	ldi		temp,9
	sts		num_programs,temp			; номер программы 9 - тело 3

	ldi		adres_data,24
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 24 адресу
	ldi		adres_data,25
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 25 адресу

	rcall	impuls_sbrosa				; расчет импульса сброса

	ldi		adres_data,23
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 23 адресу
	sts		tim_vkl,data				; записываем тайм

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Otbor_tela_3_st:

	sbis	PinB,Call_3					; "-" - принудительный выход из отбора тела 3
	rjmp	Otbor_tela_3_st_0

	rcall	text_tela3					; Высвечивается надпись отбор тела 3
	rcall	Otbor_tela

	rcall	contr_T_rekt
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	breq	Otbor_tela_3_st				; если  0 - отбираем тело 2 далее

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Otbor_tela_3_st_0:
	rcall	text_hvost					; Высвечивается надпись отбор хвостов
	call	Delay_1sec
	sbis	PinB,Call_3					; + - принудительный выход из отбора тела 3
	rjmp	Otbor_tela_3_st_0

	lds		temp,kl_hvostov
	tst		temp						; смотрим флаг работы хвостов
	breq	otbor_hvostov				; если он 0, то хвосты отбираем
	rjmp	cancel_otbora_tela			; если он 1, то заканчиваем работу

otbor_hvostov:
	ldi		count,3
	call	signal_sis1					; звучит сигнал 5 сек

	sbi		PortB,klapan_hvostov		; переключились на отбор хвостов

	ldi		temp,10
	sts		num_programs,temp			; номер программы 10 хвосты 
	ldi		temp,6
	sts		num_sms,temp				; отправляем 6-ю смс
	rcall	out_sms

	clr		temp
	sts		fl_peregrev,temp			; сбрасываем флаг о превышении температуры в царге

	ldi		adres_data,18
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 18 адресу
	ldi		adres_data,19
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 19 адресу

	rcall	impuls_sbrosa				; расчет импульса сброса

	ldi		adres_data,17
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 17 адресу
	sts		tim_vkl,data				; записываем тайм


	lds		divnt1,T_ok_r_h
	lds		divnt2,T_ok_r_l				; для индикации температуры сброса ХВОСТОВ	
	rcall	calk_T4h


;========================================================================================================================
; ПРОГОРАММА ОТБОРА ХВОСТОВ
;========================================================================================================================
Otbor_hvostov_0:
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_hvostov_1:

	sbis	PinB,Call_2
	call		nastroyka_T_okonch_rekt0				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора хвостов
	rjmp	cancel_otbora_tela

	rcall	text_hvost					; Высвечивается надпись отбор хвостов
	rcall	vremy_narab					; и высвечивается время работы колоны
	call	Delay_1sec

	rcall	kontr_T_otb_hvost
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	breq	Otbor_hvostov_1_0			; если  0 - отбираем хвосты далее
	rjmp	cancel_otbora_tela
Otbor_hvostov_1_0:
	lds		temp,timer3
	cpi		temp,3
	brlo	Otbor_hvostov_1
;======================================
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_hvostov_2:

	sbis	PinB,Call_2
	call		nastroyka_T_okonch_rekt0				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора хвостов
	rjmp	cancel_otbora_tela

	call	izmereniy_ALL
	call	Delay_1sec

	rcall	kontr_T_otb_hvost
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	breq	Otbor_hvostov_2_0			; если  0 - отбираем хвосты далее
	rjmp	cancel_otbora_tela
Otbor_hvostov_2_0:
	lds		temp,timer3
	cpi		temp,10
	brlo	Otbor_hvostov_2
;======================================
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_hvostov_3:

	sbis	PinB,Call_2
	call		nastroyka_T_okonch_rekt0				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора хвостов
	rjmp	cancel_otbora_tela

	rcall	text_T_carga				; высвечивается  температуры в сарге 
	rcall	indik_cancel_T				; температура окончания отбора тела
	call	Delay_1sec

	rcall	kontr_T_otb_hvost
	lds 	temp,fl_peregrev			; смотрим фла перегрева
	tst		temp
	breq	Otbor_hvostov_3_0			; если  0 - отбираем хвосты далее
	rjmp	cancel_otbora_tela
Otbor_hvostov_3_0:
	lds		temp,timer3
	cpi		temp,3
	brlo	Otbor_hvostov_3

	rjmp	Otbor_hvostov_0

;========================================================================================================================
; ОКОНЧАНИЕ ПРОГРАММЫ РЕКТИФИКАЦИИ
;========================================================================================================================
cancel_otbora_tela:
	rcall	text_stop_kolonna			; высвечивается стоп колонна
	call	Delay_1sec
	sbis	PinB,Call_3					; "-" - принудительный выход из отбора голов
	rjmp	cancel_otbora_tela

	cbi		PortB,klapan_hvostov		; клапан хвостов
	cbi		PortB,kl_tela				; КЛАПАН ТЕЛА
	clr 	temp				
	sts		fl_SHIM,temp				; запрет работы шим
	sbi 	portB,shim_golov			; вкючаем клапан отбора для слива флегмы
	rjmp	cancel_distil				; Уходим на подпрограмму окончания в дистилляцию

;========================================================================================================================
; контроль окончания ректификации 
;========================================================================================================================
contr_T_rekt:
	clr		count
	call	Read_T_all
contr_T_rekt_1:
	lds		yh,T_contr_o_h
	lds		yl,T_contr_o_l
	lds		xh,T_contr_o_h_c
	lds		xl,T_contr_o_l_c
	cp		yl,xl
	cpc		yh,xh
	brsh	proverka
	ret
;======================================
proverka:
	call	Delay_1sec
	call	Read_T_all
	inc		count
	cpi		count,3
	brlo	contr_T_rekt_1
	ser		temp
	sts		fl_peregrev,temp			; взводим флаг о превышении температуры
	ret
;========================================================================================================================
; контроль окончания отбора хвостов
;========================================================================================================================
kontr_T_otb_hvost:		  				; контроль при отборе хвостов
	clr		count
	call	Read_T_all
kontr_T_otb_hvost0:
	lds		yh,T_contr_o_h
	lds		yl,T_contr_o_l
	lds		xh,T_ok_r_h					; пишим настраиваемую температуру оконч отбора хвостов
	lds		xl,T_ok_r_l
	cp		yl,xl
	cpc		yh,xh						; контроль температуры в кубе
	brsh	proverka					; если больше - идем на контроль еще раз
	ret
;========================================================================================================================
;  ПРОГРАММА ПАУЗ ДОЕНИЯ
;========================================================================================================================
run_pause:
	lds		temp,count_otbora			; количество настроенных пауз 
	cpi 	temp,0
	brne	run_pause0
	rjmp	Otbor_tela_3_st_0			; если количество пауз 0 - уходим на окончание отбора
run_pause0:
	clr 	temp						; 
	sts		fl_SHIM,temp				; запрещаем работу шим
	cbi 	portB,shim_golov			; запираем отбор
	lds		temp,minutes_P				; количество минут в паузе
	sts		minutes,temp				; Записываем контрольное время стабилизации
	clr		temp
	sts		seconds,temp

;======================================
pause_otbora:
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
pause_otbora1:

	sbis	PinB,Call_2
	call	nastr_kol_pauz0				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из паузы
	rjmp	out_pauz

	rcall	text_ind_pause				; 6 секунд высвечивается текст ПАУЗА ОТБОРА
	rcall	vremy_stsb					; высвечивается время окончания паузы
	call	Delay_1sec

	lds		temp,timer3
	cpi		temp,5
	brlo	pause_otbora1

;======================================
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
pause_otbora2:

	sbis	PinB,Call_2
	call	nastr_kol_pauz0				; можем перейти в настройки	
	sbis	PinB,Call_3					; "-" - принудительный выход из паузы
	rjmp	out_pauz

	call	izmereniy_ALL
	call	Delay_1sec

	lds		temp,timer3
	cpi		temp,10
	brlo	pause_otbora2

;======================================
contr_t_pause:

	lds		temp,seconds				; Контроль окончания времени паузы
	cpi 	temp,30
	brlo	contr_t_pause_min
	rjmp	pause_otbora
contr_t_pause_min:
	lds		temp,minutes				; Контроль окончания времени паузы
	cpi		temp,0
	brne	pause_otbora

out_pauz:
	rcall	text_tela
	call	Delay_1sec
	sbis	PinB,Call_3					; "-" - зацикливаемся для выхода из паузы
	rjmp	out_pauz

	lds		temp,count_otbora			; количество пауз
	dec		temp
	sts		count_otbora,temp			; количество пауз --  уменьшаем на 1
	ser 	temp						; 
	sts		fl_SHIM,temp				; разрешаем работу шим
	ret
;========================================================================================================================
				; расчет температуры окончания отбора тела
;========================================================================================================================
calk_T4:
	lds		yh,T_contr_o_h_const
	lds		yl,T_contr_o_l_const
calk_T4_xv:
	clr		xh
	lds		xl,delta
	add		yl,xl
	adc		yh,xh
	sts		T_contr_o_h_c,yh
	sts		T_contr_o_l_c,yl
	mov		divnt1,yh
	mov		divnt2,yl
calk_T4h:
	clr		divsr1						; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  				; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp					; В нижний регистр делителя помещаем число на которое делим
	call	div							; Включаем подпрограмму деления
	mov		r30,divtm2			
	call	preobraz
	sts		T4_3,r0
	call	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		T4_2,r0
	call	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		T4_1,r0
	ret
;========================================================================================================================
				; подпрограмма отбора тела
;========================================================================================================================
Otbor_tela:
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_tela_1:
	sbis	PinB,Call_2
	call	nastr_rekt				; можем перейти в настройки	

	rcall	vremy_narab					; и высвечивается время работы колоны
	call	Delay_1sec

	lds		temp,timer3
	cpi		temp,3
	brlo	Otbor_tela_1
;------------------------------------------
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_tela_2_0:

	sbis	PinB,Call_2
	call	nastr_rekt				; можем перейти в настройки	

	call	izmereniy_ALL
	call	Delay_1sec

	lds		temp,timer3
	cpi		temp,10
	brlo	Otbor_tela_2_0
;------------------------------------------
	call	contr_t_def					; ручная или автоматическая регулировка напряжения по времени и в зависимости от Т дефлегматора если автомат

	clr		temp
	sts		timer3,temp
Otbor_tela_3_0:
	sbis	PinB,Call_2
	call	nastr_rekt				; можем перейти в настройки	
	call	Delay_1sec
	rcall	text_T_carga				; Высвечивается  температуры в царге
	rcall	indik_cancel_T				; температура окончания отбора тела

	lds		temp,timer3
	cpi		temp,3
	brlo	Otbor_tela_3_0

	ret
;========================================================================================================================

;========================================================================================================================
				; расчет ширины импульса сьроса
;========================================================================================================================
;impuls_sbrosa:							; высчитываем ширину импульса сброса
;	lds		yh,dalay_h
;	lds		yl,dalay_l
;	ldi		xh,high($ffff)				; подготовка числа сброса реле
;	ldi		xh,low($ffff)
;	sub		xh,yh						; вычесть старший байт
;	sbc		xl,yl						; вычесть младший байт
;	sts		xxh,xh
;	sts		xxl,xl
;	ret


impuls_sbrosa:
    ; YH:YL — ????? ?????? ?????????? ????????.
    lds YH, dalay_h
    lds YL, dalay_l

    ; XH:XL = 65536 - YH:YL.
    clr XL
    clr XH

    sub XL, YL
    sbc XH, YH

    sts xxh, XH
    sts xxl, XL
    ret





;========================================================================================================================


;========================================================================================================================
.macro Set_cursor
	ldi		temp,(1<<Addr)|(@0<<Str)+@1 	; курсор строка @0 (0-1) позиция @1 (0-15)
	rcall	LCD_command_4bit			
.endm








;========================================================================================================================
;========================================================================================================================
;========================================================================================================================
LCD_ini: 								; почти как в LiqidCrystal
	sbi		DDRD,E 						;линии E (PB4) и RS (PB3) на выход
	sbi  	DDRD,RS
	cbi		PortD,E 					;E=0
	call	Delay_05sec 				;ждем  0,5 с - установление питания
	ldi		temp,0b00000011
	rcall	LCD_command	
	call	Delay_005sec
	ldi		temp,0b00000011
	rcall	LCD_command	
	call	Delay_005sec
	ldi		temp,0b00000011
	rcall	LCD_command	
	call	Delay_005sec
	ldi		temp,0b00000010
	rcall	LCD_command	
	call	Delay_005sec

#ifdef Rs_table 
;для Wistar OLED
	ldi		temp,0b00101010 			;DL=1 - 4 bit  N=1 - 2строки, FT=10 - рус/англ таблица
#else
;для остальных рус/англ дисплеев
	ldi		temp,0b00101000 			;DL=1 - 4 bit  N=1 - 2строки, 
#endif
	rcall	LCD_command_4bit	
	call	Delay_005sec
	ldi		temp,0b00001000 
	rcall	LCD_command_4bit 			;дисплей Off	
	call	Delay_005sec
	ldi		temp,0b00000001 
	rcall	LCD_command_4bit 			;дисплей clear 
	call	Delay_005sec
	ldi		temp,0b00000110 
	rcall	LCD_command_4bit 			;I/D=1 - инкремент S=0 - сдвиг курсора
#ifdef Blink
;включение с миганием
	ldi		temp,0b00001101 			;D=1- дисплей On B=1 - мигает символ в позиции курсора
#else
;просто включение
	ldi		temp,0b00001100 			;D=1- дисплей On
#endif
	rcall	LCD_command_4bit 
	call	Delay_005sec
	ldi		temp,0b10000000 ;			курсор в позицию 0,0
	rcall	LCD_command_4bit ;

;========================================================================================================================
gradus_ris:
	ldi 	temp,0b01000000  ;адрес
	rcall	LCD_command_4bit 
	ldi 	temp,0b00000000 
	rcall 	LCD_data
	ldi 	temp,0b00001100 
	rcall	LCD_data
	ldi 	temp,0b00010010 
	rcall	LCD_data
	ldi 	temp,0b00010010 
	rcall 	LCD_data
	ldi 	temp,0b00001100 
	rcall 	LCD_data
	ldi 	temp,0b00000000 
	rcall 	LCD_data
	ldi 	temp,0b00000000 
	rcall 	LCD_data
	ldi 	temp,0b00000000 
	rcall 	LCD_data
	ret

;========================================================================================================================
LCD_command: 							; выводим тетраду команды из из младших бит temp 
	cbi		PortD,RS 							; RS=0
	out		PortC,temp 					; выводим младшую PC3..0
	sbi		PortD,E 					; E=1 - строб 1 mks
	cbi		PortD,E ;E=0
	ret

;========================================================================================================================
LCD_command_4bit: 						; выводим байт команды из temp в два приема
	cbi		PortD,RS					; RS=0
	swap	temp 
	out		PortC,temp 					; выводим старший PC0..3
	sbi		PortD,E 					; E=1 - строб 1 mks
	cbi		PortD,E 					; E=0
	swap	temp 
	out		PortC,temp 					; выводим младший PC0..3
	sbi		PortD,E 					; E=1 - строб 1 mks
	cbi		PortD,E 					; E=0
	call 	Delay_150mkc
	ret

;*********************************************************************
				;Вывод данных  на дисплей 
;*********************************************************************
LCD_data:  								; выводим код сисмвола из temp в 2 приема
	sbi		PortD,RS 					; RS=1
	swap	temp 								
	out		PortC,temp					; выводим старший PC0..3
	sbi		PortD,E						; E=1 - строб 1 mks
	cbi		PortD,E						; E=0
	swap	temp								
	out		PortC,temp					; выводим младший PC0..3
	sbi		PortD,E						; E=1 - строб 1 mks
	cbi		PortD,E						; E=0
	call 	Delay_150mkc
	ret

;*********************************************************************
				;Вывод текста на дисплей 
;*********************************************************************
Text_pc:								; Вывод текста на ПК
	wdr
	lpm 	temp,z+						; Загружаем ASCII-символ в peredasha
	cpi 	temp,0						; Конец текста?
	breq 	out_text1					; Переход, если готов
	rcall 	LCD_data
	rjmp 	Text_pc						; Следующий символ
out_text1:
	ret
;========================================================================================================================
probel:
	ldi		temp,' '					; пробел
	rcall	LCD_data
	ret






;========================================================================================================================
text_komandaD:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(komand<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(komand<<1)			; на начало текста
	rcall 	Text_pc					; Выводим текста на ПК
	ret
;========================================================================================================================
text_zap_nomerD:
Set_cursor 0,0
	ldi 	zH,High(zap_tlf<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(zap_tlf<<1)			; на начало текста
	rcall 	Text_pc					; Выводим текста на ПК
	ret
;========================================================================================================================
text_system_resetG:
Set_cursor 0,0 
	ldi 	zH,High(sys_res<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(sys_res<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_otpusti_puskG:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otpusmite_pusk<<1)	; Устанавливаем указатель Z
	ldi 	zl,Low(otpusmite_pusk<<1)	; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_otpusti_pusk:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otpusmite_pusk<<1)	; Устанавливаем указатель Z
	ldi 	zl,Low(otpusmite_pusk<<1)	; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_system_reset:
Set_cursor 0,0 
	ldi 	zH,High(sys_res<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(sys_res<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;====================================================================================================================
text_najm_pusk:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(najmite_pusk<<1)	; Устанавливаем указатель Z
	ldi 	zl,Low(najmite_pusk<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_nomer:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(nomer_tlf<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nomer_tlf<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_nomera_tlf:						; Высвечивается номер телефона 
Set_cursor 1,0 
	ldi		temp,' '					;пробел
	rcall	LCD_data
	ldi		temp,' '					;пробел
	rcall	LCD_data
	ldi		temp,'+'					;- +
	rcall	LCD_data
	ldi		temp,0x37					;- 7
	rcall	LCD_data
	ldi		temp,0x39					;- 9
	rcall	LCD_data
	lds		temp,nomer1					;- 5
	rcall	LCD_data
	lds		temp,nomer2					;- 0
	rcall	LCD_data
	lds		temp,nomer3 				;- 6
	rcall	LCD_data
	lds		temp,nomer4					;- 8
	rcall	LCD_data
	lds		temp,nomer5 				;- 3
	rcall	LCD_data
	lds		temp,nomer6					;- 3
	rcall	LCD_data
	lds		temp,nomer7					;- 3
	rcall	LCD_data
	lds		temp,nomer8 				;- 1
	rcall	LCD_data
	lds		temp,nomer9					;- 6
	rcall	LCD_data
	ldi		temp,' '					;пробел
	rcall	LCD_data
	ldi		temp,' '					;пробел
	rcall	LCD_data
	ret
;========================================================================================================================
text_pusto:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
ind_pusto:
	ldi 	zH,High(pust<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(pust<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_t_stabil:						; высвечивается разгон колонны
Set_cursor 0,0 
	ldi 	zH,High(t_stab<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(t_stab<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret

;========================================================================================================================
text_razgon_dist:						; высвечивается разгон колонны
Set_cursor 0,0 
	ldi 	zH,High(razg_dist<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(razg_dist<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret

;========================================================================================================================
text_zapusk:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(dly_zpuska<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(dly_zpuska<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret

;========================================================================================================================
text_avtoklav:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(avtoklav<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(avtoklav<<1)			; на начало текста
	rcall 	Text_pc					; Выводим текста на ПК
	ret

;========================================================================================================================
text_rectif:							; Высвечивается ректификация
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(rektif<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(rektif<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret

;========================================================================================================================
izmereniy:
Set_cursor 0,0
;	ldi		temp,'D';$E0				;- D
	ldi		temp,$E0					;- Д
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data
	lds		temp,T3_0 					;- число температуры
	rcall	LCD_data
	lds		temp,T3_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T3_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T3_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	rcall	probel						;- пробел

	ldi		temp,'K'					;- K
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data
	lds		temp,T1_0 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T1_3 					;- число температуры
	rcall	LCD_data
;	ldi		temp,$00 					;- рисованный значок градуса
;	rcall	LCD_data

Set_cursor 1,0
;	ldi		temp,'C'					;- C
	ldi		temp,$E1					;- Ц
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data

	lds		temp,T2_0 					;- число температуры
	rcall	LCD_data
	lds		temp,T2_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T2_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T2_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	rcall	probel						;- пробел

	ldi		temp,'U'					;- U
	rcall	LCD_data
	ldi		temp,'t'					;- t
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data
	lds		temp,U1_1 					;- число U измеренное 
	rcall	LCD_data	
	lds		temp,U1_2 					;- число U измеренное
	rcall	LCD_data
	lds		temp,U1_3 					;- число U измеренное
	rcall	LCD_data
	ldi		temp,'v'  					;- v
	rcall	LCD_data
	rcall	probel						;- пробел
	ret

;========================================================================================================================
text_razgon_rekt:						; высвечивается разгон колонны
Set_cursor 0,0 
	ldi 	zH,High(razg_rekt<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(razg_rekt<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret

;========================================================================================================================
text_distil:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(distillyciy<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(distillyciy<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_pivovaren:							; Высвечивается ректификация
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(pivovaren<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(pivovaren<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
max_contr_U:
Set_cursor 1,8
	ldi 	zH,High(max<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(max<<1)				; на начало текста
	rcall 	Text_pc
	lds		temp,indik_1 					;- контрольное число максимального напряжения
	rcall	LCD_data
	lds		temp,indik_2 				;- контрольное число максимального напряжения
	rcall	LCD_data
	lds		temp,indik_3 				;- контрольное число максимального напряжения
	rcall	LCD_data
	ldi		temp,'v'  					;- v
	rcall	LCD_data
	ret
;========================================================================================================================
U_incremnt:
Set_cursor 0,11
	ldi 	zH,High(plys<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(plys<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
U_decriment:
Set_cursor 0,11
	ldi 	zH,High(minus<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(minus<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_Utana_v:						; Высвечивается напряжение на тэне
Set_cursor 1,0 	
	ldi 	zH,High(pust<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(pust<<1)			; на начало текста
	rcall 	Text_pc	
Set_cursor 1,6 
	ldi		temp,'U'				;U
	rcall	LCD_data
	ldi		temp,'='				;=
	rcall	LCD_data

	lds		temp,U1_1 				;- число U измеренное 
	rcall	LCD_data	
	lds		temp,U1_2 				;- число U измеренное
	rcall	LCD_data
	lds		temp,U1_3 				;- число U измеренное
	rcall	LCD_data
	ldi		temp,'v'  				;- v
	rcall	LCD_data
	rcall	probel					;- пробел
	rcall	probel					;- пробел
	ret
;========================================================================================================================
norma:
Set_cursor 0,11
	ldi 	zH,High(norma1<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(norma1<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
nastr_contr_U:
Set_cursor 1,0 	
	ldi 	zH,High(regul<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(regul<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
napryjenie:
Set_cursor 0,0 	
	ldi 	zH,High(napr1<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(napr1<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_ind_stabil:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(stb<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(stb<<1)				; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_T_stab:							; Высвечивается  темпераура перехода на стабилизацию(настраиваемая)
Set_cursor 0,0 
	ldi 	zH,High(razgon_do<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(razgon_do<<1)		; на начало текста
	rcall 	Text_pc
text_T_stab1:
	lds		temp,rejim_rab
	cpi		temp,0
	breq	text_kuba
;***********************************
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(car<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(car<<1)				; на начало текста
	rjmp	raspred
;***********************************
text_kuba:
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(kub<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(kub<<1)				; на начало текста
raspred:
	rcall 	Text_pc						; Выводим текста на ПК
	lds		temp,indik_1 					;- число температуры перехода к стабил
	rcall	LCD_data
	lds		temp,indik_2 					;- число температуры перехода к стабил
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C' 					;- C
	rcall	LCD_data
	rcall	probel
	rcall	probel
	ret
;========================================================================================================================
vremy_stsb_gol:
Set_cursor 1,0 	
	ldi 	zH,High(okonhe<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonhe<<1)			; на начало текста
	rcall 	Text_pc	
	lds		temp,minutes				; тикающее время в минутах
	call	calk
	sts		sec_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_h,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_s,r0
	lds		temp,hours				; тикающее время в часах
	call	calk
	sts		min_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0
	lds		temp,min_h					;- число минут 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	ldi		temp,'h'  					;- m
	rcall	LCD_data
	lds		temp,sec_h 					;- число секунд
	rcall	LCD_data
	lds		temp,sec_l 					;- число секунд
	rcall	LCD_data
	ldi		temp,'m'  					;- s
	rcall	LCD_data
	ret

;========================================================================================================================
indik_cancel_T:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otb_do<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(otb_do<<1)			; на начало текста
	rcall 	Text_pc	
	lds		temp,T4_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T4_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T4_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C' 					;- C
	rcall	LCD_data
	ret
;========================================================================================================================
text_T_ok_d:					; Высвечивается температура в царге
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(okonh_d<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonh_d<<1)			; на начало текста
	rcall 	Text_pc	
text_T_ok_d_1:
	lds		divnt1,T_ok_d_h
	lds		divnt2,T_ok_d_l
	rcall	calk_okonchan
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(kub<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(kub<<1)				; на начало текста
	rcall 	Text_pc	
indic_temper_000:
	lds		temp,indik_1 					;- число температуры
	rcall	LCD_data
	lds		temp,indik_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,indik_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- C
	rcall	LCD_data
	ret
;========================================================================================================================
text_T_carga:							; Высвечивается температура в царге
Set_cursor 0,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(car<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(car<<1)				; на начало текста
	rcall 	Text_pc	
	lds		temp,T2_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T2_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T2_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- C
	rcall	LCD_data
	ret
;========================================================================================================================
text_T_cuba:							; Высвечивается температура в кубе 
Set_cursor 0,0 	
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(kub<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(kub<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	lds		temp,T1_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T1_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- С
	rcall	LCD_data
	ret
;========================================================================================================================
text_stop_kolonna:
Set_cursor 0,0 	
	ldi 	zH,High(stop<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(stop<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
prirashen:
Set_cursor 1,0 ;курсор строка 1 позиция 0  (0-15)
	ldi 	zH,High(prirash<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(prirash<<1)			; на начало текста
	rcall 	Text_pc
	lds		temp,delta_ascii			;- число дельты
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,delta_ascii2			;- число дельты
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C' 					;- C
	rcall	LCD_data
	ret
;========================================================================================================================
calk_okonchan:
	clr		divsr1						; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  				; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp					; В нижний регистр делителя помещаем число на которое делим
	call	div							; Включаем подпрограмму деления
	mov		r30,divtm2			
	call	preobraz
	sts		indik_3,r0
	call	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_2,r0
	call	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
	ret
;========================================================================================================================
text_nastr_vod:
Set_cursor 0,0 	;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(txt_vkl_vod<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(txt_vkl_vod<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
text_nastr_vod1:
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	ldi 	zH,High(kub<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(kub<<1)				; на начало текста

	rcall 	Text_pc						; Выводим текста на ПК
	lds		temp,indik_1 					;- число температуры аварии
	rcall	LCD_data
	lds		temp,indik_2 					;- число температуры аварии
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- С
	rcall	LCD_data
	rcall	probel
	rcall	probel
	ret
;========================================================================================================================
text_nastr_alarm:
Set_cursor 0,0 	;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(txt_alarm<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(txt_alarm<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК

text_nastr_alarm1:
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	ldi 	zH,High(def<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(def<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК

	lds		temp,indik_1 					;- число температуры аварии
	rcall	LCD_data
	lds		temp,indik_2 					;- число температуры аварии
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- С
	rcall	LCD_data
	rcall	probel
	rcall	probel
	ret

;========================================================================================================================
vremy_stsb:
Set_cursor 1,0 	
	ldi 	zH,High(okonhe<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonhe<<1)			; на начало текста
	rcall 	Text_pc	
vremy_stsb0:
	lds		temp,seconds				; тикающее время в секундах
	call	calk
	sts		sec_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_h,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_s,r0
	lds		temp,minutes				; тикающее время в минутах
	call	calk
	sts		min_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0
	lds		temp,min_h					;- число минут 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	ldi		temp,'m'  					;- m
	rcall	LCD_data
	lds		temp,sec_h 					;- число секунд
	rcall	LCD_data
	lds		temp,sec_l 					;- число секунд
	rcall	LCD_data
	ldi		temp,'s'  					;- s
	rcall	LCD_data
	ret
;========================================================================================================================
text_golov:							; Высвечивается  отбор голов с таймером паузы
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otbor_g1<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(otbor_g1<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret

;========================================================================================================================
text_Utana:				; распределитель регулируемого напряжения
Set_cursor 0,0 	
	ldi 	zH,High(napr1<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(napr1<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
text_Utana1:
Set_cursor 1,0 	
	ldi 	zH,High(Utana<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(Utana<<1)			; на начало текста
	rcall 	Text_pc	

	lds		temp,indik_1 					;- число U настраиваемое
	rcall	LCD_data
	lds		temp,indik_2 					;- число U настраиваемое
	rcall	LCD_data
	lds		temp,indik_3 					;- число U настраиваемое
	rcall	LCD_data
	ldi		temp,'v'  					;- v
	rcall	LCD_data
	rcall	probel						;- пробел
	rcall	probel						;- пробел
	rcall	probel						;- пробел
	ret
;====================================================================================================================
text_najmD:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(push_kn<<1)	; Устанавливаем указатель Z
	ldi 	zl,Low(push_kn<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
ind_alarm:
Set_cursor 0,0 	
	ldi 	zH,High(peregr<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(peregr<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_nastr_paus:
Set_cursor 1,0 
	ldi 	zH,High(col_p<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(col_p<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК

	lds		temp,count_otbora
	call	calk
	sts		count_ascii2,r0				; распределение на индикаторе
	call	div		
	mov		r30,divtm2			
	call	preobraz			
	sts		count_ascii,r0

	lds		temp,count_ascii 			;- число пауз
	rcall	LCD_data
	lds		temp,count_ascii2 			;- число пауз
	rcall	LCD_data
	ret
;========================================================================================================================
text_tela1:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 						; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otb_t1<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(otb_t1<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
napr_stsb1:
;***********************************
	lds		cnt1,regul_Ud
	lds		temp,rejim_rab
	cpi		temp,0
	breq	napr_stsb2
	lds		cnt1,regul_Ur
	cpi		temp,1
	breq	napr_stsb2
	lds		cnt1,regul_U_R
	cpi		temp,2
	breq	napr_stsb2
	lds		cnt1,regul_U_A
;***********************************
napr_stsb2:
	mov		temp,cnt1
	call	calk
	sts		indik_3,r0
	call	div	
	mov		r30,divtm2
	call	preobraz
	sts		indik_2,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
Set_cursor 0,0 	
	ldi 	zH,High(napr2<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(napr2<<1)		; на начало текста
	rcall 	Text_pc

	lds		temp,indik_1 				;- число U
	rcall	LCD_data
	lds		temp,indik_2 				;- число U
	rcall	LCD_data
	lds		temp,indik_3 				;- число U
	rcall	LCD_data
	ldi		temp,'v'  				;- v
	rcall	LCD_data
	ret

;========================================================================================================================
text_nastr_golov:							; Высвечивается  отбор голов с таймером паузы
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(d_gol<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(d_gol<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_nastr_rozliva:							; Высвечивается  отбор голов с таймером паузы
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(d_roz<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(d_roz<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_tela:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 						; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otb_t<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(otb_t<<1)		; на начало текста
	rcall 	Text_pc
	ret

;========================================================================================================================
text_nastr_alarms:							; Высвечивается  отбор голов с таймером паузы
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(zvuk<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(zvuk<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_tela2:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 						; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otb_t2<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(otb_t2<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_tela3:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 						; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otb_t3<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(otb_t3<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_hvost:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 						; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otb_x<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(otb_x<<1)		; на начало текста
	rcall 	Text_pc
	ret

;========================================================================================================================
text_ind_pause:
	lds		data,count_otbora
	lds		temp,count_otbora_ostatok
	sub		temp,data
	inc		temp
	call	calk
	sts		count_ascii2,r0				; распределение на индикаторе
	call	div		
	mov		r30,divtm2			
	call	preobraz			
	sts		count_ascii,r0
Set_cursor 0,14 ;курсор строка 0 позиция 0  (0-15)
	lds		temp,count_ascii 			;- число пауз
	rcall	LCD_data
	lds		temp,count_ascii2 			;- число пауз
	rcall	LCD_data
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(paus_o<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(paus_o<<1)				; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
nastr_stsb:
Set_cursor 1,0 	
	ldi 	zH,High(okonh_t<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonh_t<<1)			; на начало текста
	rcall 	Text_pc	
	rjmp	vremy_stsb_nastr1


;========================================================================================================================
vremy_stsb_nastr:
Set_cursor 1,0 	
	ldi 	zH,High(okonh<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonh<<1)			; на начало текста
	rcall 	Text_pc	

	lds		temp,seconds				; тикающее время в секундах
	clr		temp
	call	calk
	sts		sec_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_h,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_s,r0
vremy_stsb_nastr1:
	mov		temp,cnt1				; настраиваемое время в минутах
	call	calk
	sts		min_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0

	lds		temp,min_h					;- число минут 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	ldi		temp,'m'  					;- m
	rcall	LCD_data
	lds		temp,sec_h 					;- число секунд
	rcall	LCD_data
	lds		temp,sec_l 					;- число секунд
	rcall	LCD_data
	ldi		temp,'s'  					;- s
	rcall	LCD_data
	ret
;========================================================================================================================
text_nastr:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(nastroyka<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nastroyka<<1)		; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_vkl:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(vklychen<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(vklychen<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_otkl:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(otklychen<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(otklychen<<1)		; на начало текста
	rcall 	Text_pc
	ret


;========================================================================================================================
vremy_kontr_prov:
Set_cursor 1,0
	ldi 	zH,High(t_contr<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(t_contr<<1)		; на начало текста
	rcall 	Text_pc

	lds		temp,tim_kontr_h 		;- число времени контроля
	rcall	LCD_data
	lds		temp,tim_kontr_l		;- число времени контроля
	rcall	LCD_data
	lds		temp,tim_kontr_z		;- число времени контроля
	rcall	LCD_data
	ldi		temp,'c'				;- c
	rcall	LCD_data
	ret
;========================================================================================================================
text_P_otb_gol:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(P_otb_gol<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(P_otb_gol<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_I_otb_gol:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 							; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(I_otb_gol<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(I_otb_gol<<1)		; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_P_otb_tela_1:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 								; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(P_otb_tel_1<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(P_otb_tel_1<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_I_otb_tela_1:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 								; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(I_otb_tela_1<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(I_otb_tela_1<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_P_otb_tela_2:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 								; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(P_otb_tel_2<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(P_otb_tel_2<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_I_otb_tela_2:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 								; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(I_otb_tela_2<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(I_otb_tela_2<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_P_otb_tela_3:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 								; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(P_otb_tel_3<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(P_otb_tel_3<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_t_control:
Set_cursor 0,0 	
	ldi 	zH,High(t_control<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(t_control<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_I_otb_tela_3:							; Высвечивается  отбор тела с таймером паузы
Set_cursor 0,0 								; курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(I_otb_tela_3<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(I_otb_tela_3<<1)			; на начало текста
	rcall 	Text_pc
	ret

;========================================================================================================================
text_T_ok_r:					; Высвечивается температура в царге
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(okonh_r<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonh_r<<1)			; на начало текста
	rcall 	Text_pc	
text_T_ok_r_1:
	lds		divnt1,T_ok_r_h
	lds		divnt2,T_ok_r_l
	rcall	calk_okonchan
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	ldi 	zH,High(car<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(car<<1)				; на начало текста
	rcall 	Text_pc	
	rjmp	indic_temper_000


;========================================================================================================================
text_SHIM_pause:						; Высвечивается пауза отбора (настраиваемая в секундах)
	mov		temp,cnt1					; разделение cnt1
	call	calk
	sts		indik_1,r0
	call	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_2,r0
	call	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_3,r0
Set_cursor 1,0 ;курсор строка 1 позиция 0  (0-15)
	ldi 	zH,High(paus<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(paus<<1)				; на начало текста
	rcall 	Text_pc

	lds		temp,indik_3 				;- настраиваемое число паузы
	rcall	LCD_data	
	lds		temp,indik_2 				;- настраиваемое число паузы
	rcall	LCD_data
	lds		temp,indik_1 				;- настраиваемое число паузы
	rcall	LCD_data	
	ldi		temp,'s' 					;- s
	rcall	LCD_data
	ldi		temp,'e' 					;- e
	rcall	LCD_data
	ldi		temp,'k' 					;- k
	rcall	LCD_data
	ret
;========================================================================================================================
text_kontr_U:
Set_cursor 0,0 
	ldi 	zH,High(contr_Ur<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(contr_Ur<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
ind_voda:
Set_cursor 0,0 	
	ldi 	zH,High(voda<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(voda<<1)				; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_t_glov1:
Set_cursor 0,0 	
	ldi 	zH,High(t_golov1<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(t_golov1<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
vremy_otbora_golov:
Set_cursor 1,0 	
	ldi 	zH,High(okonh<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(okonh<<1)			; на начало текста
	rcall 	Text_pc	

	mov		temp,cnt3					; настраиваемое время в часах 
	call	calk
	sts		hour_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		hour_h,r0

	mov		temp,cnt1					; настраиваемое время в часах
	call	calk
	sts		min_l,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0

	lds		temp,hour_h 				;- число часов 
	rcall	LCD_data
	lds		temp,hour_l 					;- число часов
	rcall	LCD_data
	ldi		temp,'h'  					;- h
	rcall	LCD_data

	lds		temp,min_h					;- число минут 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	ldi		temp,'m'  					;- m
	rcall	LCD_data
	ret
;========================================================================================================================
;========================================================================================================================
text_nastr_daf:
Set_cursor 0,0 	;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(txt_T_daf<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(txt_T_daf<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
Set_cursor 1,0 
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	ldi 	zH,High(def<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(def<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК

	lds		temp,indik_1 					;- число температуры аварии
	rcall	LCD_data
	lds		temp,indik_2 					;- число температуры аварии
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- С
	rcall	LCD_data
	rcall	probel						;- пробел
	rcall	probel						;- пробел
	ret

;========================================================================================================================
text_dl_P :
Set_cursor 0,0 	
	ldi 	zH,High(dlit_pauza<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(dlit_pauza<<1)			; на начало текста
	rcall 	Text_pc
	ret
;========================================================================================================================
text_ruchn:
Set_cursor 1,0 
	ldi 	zH,High(ruchnoe<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(ruchnoe<<1)				; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_avtomat:
Set_cursor 1,0 
	ldi 	zH,High(avtomat<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(avtomat<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	ret
;========================================================================================================================
text_SHIM_impuls:							; Высвечивается импульс  сброса (настраиваемая в миллисекундахсекундах)
	lds		divnt1,dalay_h
	lds		divnt2,dalay_l					; делим на 780 - получаем шаги (условные)

	ldi		temp,high(780)
	mov		divsr1,temp
	ldi		temp,low(780)
	mov 	divsr2,temp		

	call	div	
	mov		r30,divtm2			
	call	preobraz
	sts		indik_1,r0

	clr		divsr1							; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  					; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp						; В нижний регистр делителя помещаем число на которое делим
	call	div								; Включаем подпрограмму деления

	mov		r30,divtm2			
	call	preobraz
	sts		indik_2,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz
	sts		indik_3,r0

;вторая строка -дата:
Set_cursor 1,0 ;курсор строка 1 позиция 0  (0-15)
	ldi 	zH,High(sbros<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(sbros<<1)				; на начало текста
	rcall 	Text_pc

	lds		temp,indik_3 					;- настраиваемое число паузы
	rcall	LCD_data
	lds		temp,indik_2					;- настраиваемое число паузы
	rcall	LCD_data
	lds		temp,indik_1 					;- настраиваемое число паузы
	rcall	LCD_data
	ldi		temp,'m' 						;- m
	rcall	LCD_data
	ldi		temp,'s' 						;- s
	rcall	LCD_data
	ldi		temp,'k' 						;- k
	rcall	LCD_data
	ret
;========================================================================================================================
text_rec_ovosh:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(ovoshi<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(ovoshi<<1)			; на начало текста
	call 	Text_pc					; Выводим текста на ПК
	ret
;========================================================================================================================
text_rec_riba:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(riba<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(riba<<1)				; на начало текста
	call 	Text_pc					; Выводим текста на ПК
	ret
;========================================================================================================================
text_rec_mysa:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(myso<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(myso<<1)				; на начало текста
	call 	Text_pc					; Выводим текста на ПК
	ret
;====================================================================================================================
text_zas_soloda:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(z_solov<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(z_solov<<1)			; на начало текста
	call 	Text_pc					; Выводим текста на ПК
	ret
;========================================================================================================================
text_T_nagrV:							; Высвечивается  темпераура перехода на стабилизацию(настраиваемая)
Set_cursor 0,0 
	ldi 	zH,High(nagrev_do<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nagrev_do<<1)		; на начало текста
	call 	Text_pc
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(cuba<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(cuba<<1)				; на начало текста
	call 	Text_pc					; Выводим текста на ПК
text_T_nagrV1:
Set_cursor 1,0 
	ldi 	zH,High(varka<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(varka<<1)			; на начало текста
	call 	Text_pc
	call	probel
	call	probel
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data
	lds		temp,TN_1 					;- число температуры перехода к стабил
	rcall	LCD_data
	lds		temp,TN_2 					;- число температуры перехода к стабил
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C' 					;- C
	rcall	LCD_data
	call	probel
	ret
;========================================================================================================================
text_T_cubaP:							; Высвечивается температура в кубе 
Set_cursor 0,0 	
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data

	ldi 	zH,High(kub<<1)				; Устанавливаем указатель Z
	ldi 	zl,Low(kub<<1)				; на начало текста
	call 	Text_pc						; Выводим текста на ПК
t_kub_data:
	lds		temp,T1_0 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_2 					;- число температуры
	rcall	LCD_data
	ldi		temp,','					;- запятая
	rcall	LCD_data
	lds		temp,T1_3 					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- С
	rcall	LCD_data
	ret
;========================================================================================================================
text_stop_avtoklava:
Set_cursor 0,0 	
	ldi 	zH,High(stop<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(stop<<1)				; на начало текста
	call 	Text_pc
	ret
;========================================================================================================================
text_stop_zatir:
Set_cursor 0,0 	
	ldi 	zH,High(stop_zat<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(stop_zat<<1)			; на начало текста
	call 	Text_pc
	ret
;=====================================
vremy_narab:						;-  высвечивается время наработки колонны
	lds		temp,hours_r
	call	calk
	sts		hour_l,r0
	call	div						; 
	mov		r30,divtm2			
	call	preobraz			
	sts		hour_h,r0
	lds		temp,minutes_r
	call	calk
	sts		min_l,r0
	call	div						; 
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0
Set_cursor 1,0 
	ldi 	zH,High(rabot<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(rabot<<1)		; на начало текста
	rcall 	Text_pc	
	lds		temp,hour_h 			;- число часов
	rcall	LCD_data
	lds		temp,hour_l 			;- число часов
	rcall	LCD_data
	ldi		temp,'h' 				;- h
	rcall	LCD_data
	ldi		temp,':'				;- :
	rcall	LCD_data
	lds		temp,min_h 				;- число митут
	rcall	LCD_data
	lds		temp,min_l 				;- число минут
	rcall	LCD_data
	ldi		temp,'m' 				;- m
	rcall	LCD_data
	ret
;====================================================================================================================
nastroyka2:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(nastroykaP<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nastroykaP<<1)		; на начало текста
	call 	Text_pc	
	ret
;====================================================================================================================
nastroyka1:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(nastroykaT<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nastroykaT<<1)		; на начало текста
	call 	Text_pc
	ret
;====================================================================================================================
stroka_1:
	lds		temp,secondsA				; тикающее время в секундах
	call	calk
	sts		sec_l,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		sec_h,r0

	lds		temp,minutesA				; тикающее время в минутах
	call	calk
	sts		min_l,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		min_z,r0

Set_cursor 0,0

	lds		temp,min_z					;- число минут 
	rcall	LCD_data
	lds		temp,min_h					;- число минут 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	ldi		temp,':'  					;- :
	rcall	LCD_data
	lds		temp,sec_h 					;- число секунд
	rcall	LCD_data
	lds		temp,sec_l 					;- число секунд
	rcall	LCD_data

	call	probel  					;- пробел
	call	probel  					;- пробел
	ldi		temp,'T' 					;- T
	rcall	LCD_data
	ldi		temp,'k' 					;- k
	rcall	LCD_data
	ldi		temp,'=' 					;- =
	rcall	LCD_data

	lds		temp,T1_0 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_1 					;- число температуры
	rcall	LCD_data
	lds		temp,T1_2 					;- число температуры
	rcall	LCD_data

	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C'					;- С
	call	LCD_data
	ret
;====================================================================================================================
stroka_2:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi		temp,'U'					;- U
	rcall	LCD_data
	ldi		temp,'t'					;- t
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data
	lds		temp,U1_1 					;- число U измеренное 
	call		LCD_data	
	lds		temp,U1_2 					;- число U измеренное
	rcall	LCD_data
	lds		temp,U1_3 					;- число U измеренное
	rcall	LCD_data
	ldi		temp,'v'  					;- v
	rcall	LCD_data
	call	probel	

	lds		temp,seconds_r
	cpi		temp,50
	brsh	ind_stb
	cpi		temp,40
	brsh	indik_nom_progr
	cpi		temp,30						; переключатель режимов индикации - смена через каждые 10 сек
	brsh	ind_stb
	cpi		temp,20
	brsh	indik_nom_progr
	cpi		temp,10
	brsh	ind_stb
	cpi		temp,0
	brsh	indik_nom_progr
	ret
;====================================================================================================================
indik_nom_progr:
Set_cursor 1,8
	ldi 	zH,High(niomer_pr<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(niomer_pr<<1)		; на начало текста
	call 	Text_pc						; Выводим текста на ПК
	ldi		temp,'N' 					;- номер программы
	rcall	LCD_data

	ldi		temp,$30
	sts		nomer0,temp

	lds 	temp,nomer
	sts		nomer00,temp

	cpi		temp,$40
	brne	indik_nom_progr1
	ldi		temp,$31
	sts		nomer0,temp
	ldi		temp,$30
	sts		nomer00,temp
indik_nom_progr1:
	cpi		temp,$41
	brne	indik_nom_progr2
	ldi		temp,$31
	sts		nomer0,temp
	ldi		temp,$31
	sts		nomer00,temp
indik_nom_progr2:
	cpi		temp,$42
	brne	indik_nom_progr3
	ldi		temp,$31
	sts		nomer0,temp
	ldi		temp,$32
	sts		nomer00,temp
indik_nom_progr3:
	lds		temp,nomer0 				;- 0
	rcall	LCD_data
	lds		temp,nomer00 				;- номер программы
	rcall	LCD_data
	ret
;====================================================================================================================
ind_stb:
	mov		temp,AdT1
	call	calk
	sts		min_z,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		min_l,r0
	call	div
	mov		r30,divtm2			
	call	preobraz
	sts		min_h,r0
Set_cursor 1,8
	ldi		temp,'T' 					;- T
	rcall	LCD_data
	ldi		temp,'s' 					;- s
	rcall	LCD_data
	ldi		temp,'=' 					;- =
	rcall	LCD_data
	lds		temp,min_h					;- температра 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	lds		temp,min_z					;- число минут 
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C' 					;- C
	rcall	LCD_data
	ret
;====================================================================================================================
vremy_P1:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$31 					;- 1
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P2:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$32 					;- 2
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P3:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$33 					;- 3
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P4:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$34 					;- 4
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P5:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$35 					;- 5
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P6:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$36 					;- 6
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P7:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$37 					;- 7
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P8:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$38 					;- 8
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P9:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$39 					;- 9
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_P10:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$31 					;- 1
	rcall	LCD_data
	ldi		temp,$30 					;- 0
	rcall	LCD_data
	rjmp	prob_2
;====================================================================================================================
vremy_P11:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$31 					;- 1
	rcall	LCD_data
	ldi		temp,$31 					;- 1
	rcall	LCD_data
	rjmp	prob_2
;====================================================================================================================
vremy_P12:
	rcall	nastroyka2					; Выводим текста на ПК
	ldi		temp,$31 					;- 1
	rcall	LCD_data
	ldi		temp,$32 					;- 2
	rcall	LCD_data
	rjmp	prob_2

;====================================================================================================================
vremy_T_pause2:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,$32 					;- 2
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_T_pause3:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,$33 					;- 3
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_T_pause4:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,$34 					;- 4
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_T_pause5:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,$35 					;- 5
	rcall	LCD_data
	rjmp	prob_3
	ret
;====================================================================================================================
vremy_T_pause6:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,$36 					;- 6
	rcall	LCD_data
	rjmp	prob_3
;====================================================================================================================
vremy_T_pause7:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,$37 					;- 7
	rcall	LCD_data
prob_3:
	rcall	probel
prob_2:
	rcall	probel
	rcall	probel
	ret
;====================================================================================================================
ind_pause:
	mov		temp,cnt3
	call	calk
	sts		min_z,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		min_l,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		min_h,r0
Set_cursor 1,0 	
	ldi 	zH,High(pauza<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(pauza<<1)			; на начало текста
	call 	Text_pc	
	lds		temp,min_h					;- число минут 
	rcall	LCD_data
	lds		temp,min_l					;- число минут 
	rcall	LCD_data
	lds		temp,min_z					;- число минут 
	rcall	LCD_data
	ldi 	zH,High(minut<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(minut<<1)			; на начало текста
	call 	Text_pc	
	ret
;========================================================================================================================
nomer_recepta:
Set_cursor 0,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(nastroyka_r<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nastroyka_r<<1)		; на начало текста
	rcall 	Text_pc
	lds		temp,recept					;- номер рецепта 
	rcall	LCD_data
	ret
;====================================================================================================================
text_recept:
Set_cursor 1,0 ;курсор строка 0 позиция 0  (0-15)
	ldi 	zH,High(nom_rec<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(nom_rec<<1)			; на начало текста
	rcall 	Text_pc					; Выводим текста на ПК
	ret
;====================================================================================================================
indik_temperatur:
	mov		temp,cnt3
	call	calk
	sts		Tak_1,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		Tak_2,r0
	call	div			
	mov		r30,divtm2			
	call	preobraz			
	sts		Tak_3,r0
Set_cursor 1,0 	
	ldi 	zH,High(temperatura<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(temperatura<<1)		; на начало текста
	call 	Text_pc	

	lds		temp,Tak_3					;- число температуры 
	rcall	LCD_data
	lds		temp,Tak_2					;- число температуры 
	rcall	LCD_data
	lds		temp,Tak_1					;- число температуры
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ret
;========================================================================================================================
text_T_nagr:							; Высвечивается  темпераура перехода на стабилизацию(настраиваемая)
Set_cursor 0,0 
	ldi 	zH,High(nagrev_do<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(nagrev_do<<1)		; на начало текста
	rcall 	Text_pc
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi 	zH,High(cuba<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(cuba<<1)				; на начало текста
	call 	Text_pc
text_T_nagr1:
Set_cursor 1,0 
	ldi 	zH,High(zatirka<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(zatirka<<1)			; на начало текста
	rcall 	Text_pc
	rcall	probel
	ldi		temp,'T'					;- T
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'='					;- =
	rcall	LCD_data
	lds		temp,TN_1 					;- число температуры перехода к стабил
	rcall	LCD_data
	lds		temp,TN_2 					;- число температуры перехода к стабил
	rcall	LCD_data
	ldi		temp,$00 					;- рисованный значок градуса
	rcall	LCD_data
	ldi		temp,'C' 					;- C
	rcall	LCD_data
	ret
;========================================================================================================================
text_UtanaP_R:				; распределитель регулируемого напряжения разгона
Set_cursor 0,0 	
	ldi 	zH,High(napr3<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(napr3<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	rjmp	text_UtanaR1
;========================================================================================================================
text_UtanaP_V:				; распределитель регулируемого напряжения
Set_cursor 0,0 	
	ldi 	zH,High(napr4<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(napr4<<1)			; на начало текста
	rcall 	Text_pc						; Выводим текста на ПК
	rjmp	text_UtanaR1
;========================================================================================================================
text_UtanaP_S:				; распределитель регулируемого напряжения стабилизации
Set_cursor 0,0 	
	ldi 	zH,High(napr1<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(napr1<<1)			; на начало текста
	call 	Text_pc					; Выводим текста на ПК
text_UtanaR1:
Set_cursor 1,0 	
	ldi 	zH,High(Utana<<1)			; Устанавливаем указатель Z
	ldi 	zl,Low(Utana<<1)			; на начало текста
	rcall 	Text_pc	

	lds		temp,indik_1 					;- число U настраиваемое
	rcall	LCD_data
	lds		temp,indik_2 					;- число U настраиваемое
	rcall	LCD_data
	lds		temp,indik_3 					;- число U настраиваемое
	rcall	LCD_data
	ldi		temp,'v'  					;- v
	rcall	LCD_data
	rcall	probel						;- пробел
	rcall	probel						;- пробел
	rcall	probel						;- пробел
	ret

;====================================================================================================================
vremy_T_pause1:
	rcall	nastroyka1					; Выводим текста на ПК
	ldi		temp,$00 					;- рисованный значок градуса
	call	LCD_data
	ldi		temp,$31 					;- 1
	call	LCD_data
	jmp		prob_3
;========================================================================================================================
text_Utana_v_P:						; Высвечивается напряжение на тэне
Set_cursor 1,0 	
	ldi 	zH,High(pust<<1)		; Устанавливаем указатель Z
	ldi 	zl,Low(pust<<1)			; на начало текста
	call 	Text_pc	
Set_cursor 1,6 
	ldi		temp,'U'				;U
	rcall	LCD_data
	ldi		temp,'='				;=
	rcall	LCD_data

	lds		temp,U1_1 			;- число U измеренное 
	rcall	LCD_data	
	lds		temp,U1_2 			;- число U измеренное
	rcall	LCD_data
	lds		temp,U1_3				;- число U измеренное
	rcall	LCD_data
	ldi		temp,'v'  				;- v
	rcall	LCD_data
	rcall	probel					;- пробел
	rcall	probel					;- пробел
	ret



;========================================================================================================================
;========================================================================================================================
;========================================================================================================================

text_vkl_otkl:							; текст включен / выулючен
	tst		temp
	brne	otkl						; если 1 - отключен
	rcall	text_vkl					; включен
	ret
otkl:
	rcall	text_otkl					; отключен
	ret

;=======================================================================================================================
;=======================================================================================================================
;=======================================================================================================================
;=======================================================================================================================
	; МЕНЮ ОБЩЕЕ ДЛЯ ДИСТИЛЛЯЦИИ И РЕКТИФИКАЦИИ
nastroika_d:
	lds		temp,fl_rejima				; запрет на смену режима	
	tst		temp
	breq	vkl_rejima0					; дежрный режим - идем на смену режимов
	rjmp	kontrol_rejima_nastr		; Если уже прошли режим ожидания, то меню о смене режима больше не высвечиваем.

;**************************************************************************************************
;**************************************************************************************************
; ПРОГРАММА ПЕРЕКЛЮЧЕНИЯ РЕЖИМОВ
;**************************************************************************************************
vkl_rejima0:
	call	Delay_025sec

	rcall	vibor_rejimaM				; выбирается название режима
	rcall	text_najmD					; текст смены режима

	sbis	PinB,Call_1
	rjmp	vkl_rejima0					; крутимся
;**************************************************************************************************
	call	clr_tim
vkl_rejima:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	perekl_rej					; процедура переключения
	sbis	PinB,Call_2
	rjmp	kontrol_rejima_nastr		; в - следующее меню
vkl_rejima_1:
	sbis	PinB,Call_3
	rjmp	nastr_kol_U_0				; уходим в конец настроек

	lds		temp,timer2
	cpi		temp,8
	brlo	vkl_rejima
	ret
;**************************************************************************************************
				; ПРОЦЕДУРА ПЕРЕКЛЮЧЕНИЯ РЕЖИМОВ
;**************************************************************************************************
perekl_rej:
	rcall	vibor_rejimaM				; высвечивается режим
	call	Delay_05sec
	call	text_pusto				; текст пусто
	call	Delay_05sec
	sbis	PinB,Call_1			
	rjmp	perekl_rej					; крутимся с миганием
perekl_rej_0:
	rcall	vibor_rejimaM				; высвечивается режим
	call	Delay_05sec
	rcall	text_pusto				; текст пусто
	call	Delay_05sec

	sbis	PinB,Call_1
	rjmp	vkl_rejima0					; выход из настройки
	sbis	PinB,Call_2					; кнопками + или - производим настройки
	rcall 	perekl
	sbis	PinB,Call_3
	rcall	perek2

	rjmp	perekl_rej_0
;==================================
perekl:
	lds		data,rejim_rab
	cpi 	data,1				; 1 - рект дист  2 - рект дист пиво, 3 -рект дист пиво автокл
	brsh	no_perekl
	inc 	data
no_perekl:
	sts		rejim_rab,data
	rcall	vibor_rejimaM
	call	Delay_1sec
	sbis	PinB,Call_2
	rjmp	perekl
	rjmp	zapis_perekl_rejD
;==================================
perek2:
	lds		data,rejim_rab
	tst 	data
	breq	no_perek2
	dec 	data
no_perek2:
	sts		rejim_rab,data
	rcall	vibor_rejimaM
	call	Delay_1sec
	sbis	PinB,Call_3
	rjmp	perek2
;==================================
zapis_perekl_rejD:
	ldi		adres_data,1				; адрес еепром 1
	lds		data,rejim_rab
	call	write_eprom
	ret
;**************************************************************************************************
;**************************************************************************************************
vibor_rejimaM:
	lds		data,rejim_rab
	cpi		data,0
	breq	distil_m
	cpi		data,1
	breq	rectif_m
	cpi		data,2
	breq	pivo_m
	cpi		data,3
	breq	avtoklav_m
distil_m:
	rcall	text_distil
	ret
rectif_m:
	rcall	text_rectif
	ret
pivo_m:
	rcall	text_pivovaren
	ret
avtoklav_m:
	rcall	text_avtoklav
	ret
;=======================================================================================================================
;   разветвление на дальнейшую настройку дист, рект или пиво или автоклав
kontrol_rejima_nastr:
	lds		temp,rejim_rab
	cpi		temp,0
	breq	nastr_zvuk
	cpi		temp,1
	breq	nastr_zvuk



;**************************************************************************************************
;**************************************************************************************************
; ПРОГРАММА ВЫКЛЮЧНИЯ ЗВУКА
;**************************************************************************************************
nastr_zvuk:
	call	Delay_025sec

	lds		temp,alarms
	rcall	text_vkl_otkl
	rcall	text_nastr_alarms			; в вехней строке - текст - звук

	sbis	PinB,Call_1
	rjmp	nastr_zvuk					; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastr_zvuk1:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_zvuk_0				; процедура переключения
	sbis	PinB,Call_2
	rjmp	nastr_dat_golov				; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika					; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastr_zvuk1
	ret
nastroika:
	lds		temp,fl_rejima				; запрет на смену режима	
	tst		temp
	breq	nastroika_0					
	rjmp	vkl_rejima_1				; Если уже прошли режим ожидания, то меню о смене режима больше не высвечиваем
nastroika_0:
	rjmp	nastroika_d					; в предыдущее меню	.


;**************************************************************************************************
		;	ПРОЦЕДУРА переключения  звука
;**************************************************************************************************
nastr_zvuk_0:
	lds		temp,alarms
	rcall	text_vkl_otkl				; 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_zvuk_0				; крутимся с миганием
nastr_alarms:
	lds		temp,alarms
	rcall	text_vkl_otkl					; 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastr_zvuk					; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_alarms					; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall 	minus_alarms

	rjmp	nastr_alarms	
;==================================
plys_alarms:
	clr		temp
	sts		alarms,temp
	rcall	text_vkl_otkl					; включен
	call	Delay_1sec
	sbis	PinB,Call_2
	rjmp	plys_alarms
	rjmp	zapis_alarms
;==================================
minus_alarms:
	ser		temp
	sts		alarms,temp
	rcall	text_vkl_otkl					; отключен
	call	Delay_1sec
	sbis	PinB,Call_3
	rjmp	minus_alarms
;==================================
zapis_alarms:							; запись в память
	ldi		adres_data,33			 	; адрес еепром 33
	lds		data,alarms					; данные минут в еепром
	call	write_eprom
	ret

;**************************************************************************************************
; ПРОГРАММА  Выключения датчика голов
;**************************************************************************************************
nastr_dat_golov:
	call	Delay_025sec

	rcall	text_nastr_golov			; в вехней строке - текст - датчик голов
	lds		temp,dat_golov
	rcall	text_vkl_otkl

	sbis	PinB,Call_1
	rjmp	nastr_dat_golov				; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastr_dat_golov_0:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	perekl_dat_golov_0			; процедура переключения
	sbis	PinB,Call_2
	rjmp	nastr_dat_rozliva			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastr_zvuk					; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastr_dat_golov_0
	ret
;**************************************************************************************************
				; процедура переключения датчика голов
;**************************************************************************************************
perekl_dat_golov_0:
	lds		temp,dat_golov
	rcall	text_vkl_otkl
	rcall	pauza_pusto
	sbis	PinB,Call_1					; крутимся с миганием
	rjmp	perekl_dat_golov_0
perekl_dat_golov:
	lds		temp,dat_golov
	rcall	text_vkl_otkl
	rcall	pauza_pusto

	sbis	PinB,Call_1					; выход из настройки
	rjmp	nastr_dat_golov
	sbis	PinB,Call_2
	rcall	vkl_dat_golov				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	otkl_dat_golov

	rjmp	perekl_dat_golov
;==================================
vkl_dat_golov:
	clr		temp
	sts		dat_golov,temp
	rcall	text_vkl_otkl					; включен
	call	Delay_1sec
	sbis	PinB,Call_2
	rjmp	vkl_dat_golov
	rjmp	zapis_dat_golov
;==================================
otkl_dat_golov:
	ser		temp
	sts		dat_golov,temp
	rcall	text_vkl_otkl					; отключен
	call	Delay_1sec
	sbis	PinB,Call_3
	rjmp	otkl_dat_golov
;==================================
zapis_dat_golov:						; запись в память
	ldi		adres_data,44			 	; адрес еепром 33
	lds		data,dat_golov				; данные минут в еепром
	call	write_eprom
	ret

;**************************************************************************************************
; Программа выключения датчика разлива
;**************************************************************************************************
nastr_dat_rozliva00:

	lds 	temp,fl_datch_rozl
	tst		temp
	breq	nastr_dat
	rjmp	nastr_dat_golov				; если датчик запрещен то пропускае его настройку.
nastr_dat_rozliva:
	lds 	temp,fl_datch_rozl
	tst		temp
	breq	nastr_dat
	rjmp	nastroika_U_stab			; если датчик запрещен то пропускае его настройку.
nastr_dat:

	call	Delay_025sec

	lds		temp,dat_rozliva
	rcall	text_vkl_otkl
	rcall	text_nastr_rozliva			; в вехней строке - текст - датчика розлива

	sbis	PinB,Call_1
	rjmp	nastr_dat					; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastr_dat_rozliva_0:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_dat_rozliva0			; процедура 
	sbis	PinB,Call_2
	rjmp	nastroika_U_stab			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastr_dat_golov				; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastr_dat_rozliva_0
	ret

;**************************************************************************************************
				; Процедура выключения работы датчика розлива
;**************************************************************************************************
nastr_dat_rozliva0:
	lds		temp,dat_rozliva
	rcall	text_vkl_otkl
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_dat_rozliva0			; крутимся с миганием

nastr_dat_rozliva2:
	lds		temp,dat_rozliva
	rcall	text_vkl_otkl
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastr_dat_rozliva			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_dat_rozliva			; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_dat_rozliva

	rjmp	nastr_dat_rozliva2
;==================================
plys_dat_rozliva:
	clr		temp
	sts		dat_rozliva,temp
	rcall	text_vkl_otkl					; текст  включен
	call	Delay_1sec
	sbis	PinB,Call_2
	rjmp	plys_dat_rozliva
	rjmp	zapis_dat_rozliva
;==================================
minus_dat_rozliva:
	ser 	temp
	sts		dat_rozliva,temp
	rcall	text_vkl_otkl					; текст отключен
	call	Delay_1sec
	sbis	PinB,Call_3
	rjmp	minus_dat_rozliva
;==================================
zapis_dat_rozliva:						; запись в память
	ldi		adres_data,45			 	; адрес еепром 45
	lds		data,dat_rozliva			; данные 
	call	write_eprom
	ret

;**************************************************************************************************
;ПРОГРАММА нстройка напряжения стабилизации при ректификации или дистилляции
;**************************************************************************************************
nastroika_U_stab:
	call	Delay_025sec

	lds		cnt3,regul_Ud				; данные дистилляции
	lds		temp,rejim_rab
	cpi		temp,0
	breq	nastr_U_stab				; если  0 - идем в работу настройки дистилляции
	lds		cnt3,regul_Ur				; если 1 - то пишем данные ректификации и идем в настройку
nastr_U_stab:
	rcall	calc_Ustb
	rcall	text_Utana					; индикация настраиваемго напряжения стабилизации

	sbis	PinB,Call_1
	rjmp	nastroika_U_stab			; крутимся
;**************************************************************************************************

	rcall	clr_tim
nastroika_U_stab0:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_U_stabi0				; ПРОЦЕДУРА НАСТРОЙКИ  ; напряжение стабилизаци на тэне при дистилляции или ректификации
	sbis	PinB,Call_2
	rjmp	nastroika_T_alarm0			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastr_dat_rozliva00			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_U_stab0
	ret

;**************************************************************************************************
				; Процедура изменения напряжения стабилизации на тэне при ректификации или дистилляции
;**************************************************************************************************
nastr_U_stabi0:
	rcall	text_Utana1					; индикация настраиваемго напряжения стабилизации
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_U_stabi0				; крутимся с миганием

nastr_U_stabil:
	rcall	text_Utana1					; индикация настраиваемго напряжения стабилизации
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_U_stab			; выход из настройки
	sbis	PinB,Call_2					; кнопками + или - производим настройки
	rcall	plys_Ur
	sbis	PinB,Call_3
	rcall	minus_Ur

	rjmp	nastr_U_stabil
;==================================
plys_Ur:
	cpi		cnt3,220					; максимум 220 вольт
	brsh	plys_Ur0
	inc		cnt3
plys_Ur0:
	rcall	calc_Ustb
	sbis	PinB,Call_2
	rjmp	plys_Ur
	rjmp	zapis_U
;==================================
minus_Ur:
	cpi		cnt3,80						; минимум 80 вольт
	brlo	minus_Ur0
	dec		cnt3
minus_Ur0:
	rcall	calc_Ustb
	sbis	PinB,Call_3
	rjmp	minus_Ur
;==================================
zapis_U:								; запись в память
	ldi		adres_data,2				; адрес еепром 2
	lds		cnt1,rejim_rab				; смотрим режим работы
	cpi		cnt1,0
	breq	write_nastrU				; если 0 - идем на запись  дистилляции 
	ldi		adres_data,3				; адрес еепром 3
write_nastrU:
	mov		data,cnt3					; измененные даные
	call	write_eprom				; записали нужный параметр дистилляции
   	ldi		adres_data,3				; чтение
	call	read_eprom
	sts		regul_Ur,data				; стабилизации при ректифик
  
   	ldi		adres_data,2 
	call	read_eprom
	sts		regul_Ud,data				; стабилизации при дистилляции
	ret

;==================================
; Распределение данных напряжения на индикаторе
;==================================
calc_Ustb:
	mov		temp,cnt3
	call	calk
	sts		indik_3,r0
	call	div	
	mov		r30,divtm2
	call	preobraz
	sts		indik_2,r0
	call	div				
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
	rcall	text_Utana					; индикация настраиваемго напряжения стабилизации
	call	Delay_05sec
	ret


;**************************************************************************************************
;	ПРОГРАММА нстройки температуры в дефе  на аварию
;**************************************************************************************************
nastroika_T_alarm0:
	call	Delay_025sec

	lds		temp,TA_sbor
	rcall	calk_TA_sbor
	rcall	text_nastr_alarm			; индикация настраиваемой температуры на аварию.

	sbis	PinB,Call_1
	rjmp	nastroika_T_alarm0			; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroika_T_alarm:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_T_alarm				; ПРОЦЕДУРА НАСТРОЙКИ	; температура в дефлегматоре на аварию
	sbis	PinB,Call_2
	rjmp	nastroika_T_voda0			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_U_stab			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_T_alarm
	ret
;**************************************************************************************************
							; Процедура настройки аварийной температуры в дефлегматоре
;**************************************************************************************************
nastr_T_alarm:
	rcall	text_nastr_alarm1			; индикация настраиваемго напряжения стабилизации
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_T_alarm				; крутимся с миганием

nastr_T_alarm0:
	rcall	text_nastr_alarm1			; индикация настраиваемго напряжения стабилизации
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_T_alarm0			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_alarm					; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_alarm

	rjmp	nastr_T_alarm0
;====================================
plys_alarm:
	lds		temp,TA_sbor
	inc		temp
	rcall	calk_TA_sbor
	sbis	PinB,Call_2
	rjmp	plys_alarm
	rjmp	zapis_TA_sbor
;====================================
minus_alarm:
	lds		temp,TA_sbor
	dec		temp
	rcall	calk_TA_sbor
	sbis	PinB,Call_3
	rjmp	minus_alarm
;====================================
zapis_TA_sbor:							; запись в память
	ldi		adres_data,4				; адрес еепром 4
	lds		data,TA_sbor				; TA_sbor записываем в еепром по 9 адресу
	call	write_eprom
	ret
;====================================
calk_TA_sbor:
	sts		TA_sbor,temp
	call	calk
	sts		indik_2,r0
	call	div						; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
	rcall	text_nastr_alarm			; индикация настраиваемой температур на аварию.
	call	Delay_05sec
	ret

;**************************************************************************************************
;	Программа нстройки температуры в кубе на включение воды
;**************************************************************************************************
nastroika_T_voda0:
	call	Delay_025sec

	lds		temp,TV_sbor
	rcall	calc_vkl_voda
	rcall	text_nastr_vod				; индикация настраиваемой температуры на включение воды

	sbis	PinB,Call_1
	rjmp	nastroika_T_voda0			; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroika_T_voda:					
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_T_voda				; ПРОЦЕДУРА НАСТРОЙКИ  температура в кубе на включения воды
	sbis	PinB,Call_2
	rjmp	nastroika_T_stb0			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_T_alarm0			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_T_voda
	ret
;**************************************************************************************************
						; Процедура регулиповки температуры в кубе для включения воды
;**************************************************************************************************
nastr_T_voda:
	rcall	text_nastr_vod1				; индикация данных настройки волы
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_T_voda				; крутимся с миганием
nastr_T_voda_0:
	rcall	text_nastr_vod1				; индикация данных настройки волы
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_T_voda0			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_vkl_vod				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_vkl_vod

	rjmp	nastr_T_voda_0
;===================================
plys_vkl_vod:
	lds		temp,TV_sbor
	inc		temp
	rcall	calc_vkl_voda
	sbis	PinB,Call_2
	rjmp	plys_vkl_vod
	rjmp	zapis_TV_sbor
;===================================
minus_vkl_vod:
	lds		temp,TV_sbor
	dec		temp
	rcall	calc_vkl_voda
	sbis	PinB,Call_3
	rjmp	minus_vkl_vod
;====================================
zapis_TV_sbor:							; запись в память
	ldi		adres_data,5				; адрес еепром 5
	lds		data,TV_sbor				; запись  температуры включения воды 
	call	write_eprom
	ret
;====================================
calc_vkl_voda:
	sts		TV_sbor,temp
	call	calk
	sts		indik_2,r0
	call	div						; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
	rcall	text_nastr_vod				; индикация настраиваемой температуры на включение воды
	call	Delay_05sec
	ret

;**************************************************************************************************
;Программа нстройки температуры в кубе или в царге для перехода на стабилизацию.универсальная 
;**************************************************************************************************
nastroika_T_stb0:
	call	Delay_025sec

	lds		cnt3,TS_sbor_d				;  заппись дистилляции 
	lds		temp,rejim_rab
	cpi		temp,0
	breq	nastr_T_stabi2				; если  0 - идем в работу
	lds		cnt3,TS_sbor_r				; если не 1 - то данные ректификации
nastr_T_stabi2:

	rcall	calk_TS_sbor
	call	text_T_stab					; индикация настраиваемой температуры для перехода на стабилизацию

	sbis	PinB,Call_1
	rjmp	nastroika_T_stb0			; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroika_T_stb:					
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_T_stabil				; ПРОЦЕДУРА НАСТРОЙКИ  температура в кубе на включения воды
	sbis	PinB,Call_2
	rjmp	vabor						; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_T_voda0			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_T_stb
	ret
;**************************************************************************************************
vabor:
	lds		temp,rejim_rab
	cpi		temp,1						; 1- ректификация
	breq	vabor0
	rjmp	nastroyka_T_okonch_dist0	; Нет - уходим на настройку окончания дистилляции
vabor0:
	rjmp	nastr_rekt					; Да - уходим на настройку ректификациии

;**************************************************************************************************
						; Процедура регулиповки температуры перехода на стабилизацию универсальная для всех режимов
;**************************************************************************************************
nastr_T_stabil:
	call	text_T_stab1				; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_T_stabil				; крутимся с миганием
nastr_T_stab_0:	
	call	text_T_stab1				; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_T_stb0			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_T_stabil				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_T_stabil

	rjmp	nastr_T_stab_0	
;===================================
plys_T_stabil:
	inc		cnt3
	rcall	calk_TS_sbor				; распред TS_sbor
	sbis	PinB,Call_2
	rjmp	plys_T_stabil
	rjmp	zapis_TS_sbor
;==================================
minus_T_stabil:
	dec		cnt3
	rcall	calk_TS_sbor				; распред TS_sbor
	sbis	PinB,Call_3
	rjmp	minus_T_stabil
;==================================
zapis_TS_sbor:							; запись в память
	ldi		adres_data,6				; адрес еепром 6 для дистилляции
	lds		temp,rejim_rab
	cpi		temp,0
	breq	write_nastr
	ldi		adres_data,7				; адрес еепром 7 для ректификации
write_nastr:
	mov		data,cnt3
	call	write_eprom				; запись  температуры ухода в стабилизациюпо
  
   	ldi		adres_data,7				; чтение температуры стабилизации при ректифик
	call	read_eprom
	sts		TS_sbor_r,data
  	ldi		adres_data,6				; чтение температуры стабилизации при дистилляции
	call	read_eprom
	sts		TS_sbor_d,data
	ret

;==================================
; Распределение данных температур на индикаторе
;==================================
calk_TS_sbor:
	mov		temp,cnt3
	call	calk
	sts		indik_2,r0
	call	div						; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
	call	text_T_stab					; индикация настраиваемой температуры для перехода на стабилизацию.
	call	Delay_05sec
	ret

;**************************************************************************************************
;Программа нстройки температуры окончания дистилляции 
;**************************************************************************************************
nastroyka_T_okonch_dist0:
	call	Delay_025sec

	call	text_T_ok_d					; 

	sbis	PinB,Call_1
	rjmp	nastroyka_T_okonch_dist0	; крутимся

;**************************************************************************************************
	rcall	clr_tim
nastroyka_T_okonch_dist:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_okonch_0			; ПРОЦЕДУРА НАСТРОЙКИ  ; темпеатуры окончанмя дистилляции 
	sbis	PinB,Call_2
	rjmp	vabor1						; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_T_stb0			; в предыдущее меню	

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_T_okonch_dist
	ret
;**************************************************************************************************
vabor1:
	lds		temp,rejim_rab
	cpi		temp,1						; ректификация? 
	breq	vabor2
	rjmp	nastroika_d					; нет - уходим в начало меню
vabor2:
	rjmp	nastr_rekt					; да - уходим на настройку ректификации

;**************************************************************************************************
				; процедура изменениz температуры окончания дисциляции от 65 до 99 градусов
;**************************************************************************************************
nastroyka_okonch_0:
	call	text_T_ok_d_1				; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastroyka_okonch_0			; крутимся с миганием
nastroyka_okonch:
	call	text_T_ok_d_1				; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroyka_T_okonch_dist0	; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_T_ok_dis				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_T_ok_dis

	rjmp	nastroyka_okonch
;======================================
plys_T_ok_dis:
	lds		yh,T_ok_d_h					; пишим настраиваемую температуру оконч дисцилляции и идем далше работать
	lds		yl,T_ok_d_l

	ldi		Xl,low(990)					; это max настройки
	ldi		XH,high(990)
	cp		yl,Xl						; сравниваем младший байт
	cpc		yh,Xh						; сравниваем старший байт
	brsh	text_ok_p					; больше не уменьшаем
	adiw	yl,1						; увеличиваем на 1
text_ok_p:
	sts		T_ok_d_h,yh					; пишим настроенную температуру оконч дисцилляции и идем далше работать
	sts		T_ok_d_l,yl
	call	text_T_ok_d					; выводим на дисплей
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_T_ok_dis
	rjmp	zapis_T_ok					; записывем в энергонезавис память
;==================================
minus_T_ok_dis:
	lds		yh,T_ok_d_h					; пишим настраиваемую температуру оконч дисцилляции и идем далше работать
	lds		yl,T_ok_d_l

	ldi		Xl,low(800)					; это min настройки
	ldi		XH,high(800)
	cp		yl,Xl						; сравниваем младший байт
	cpc		yh,Xh						; сравниваем старший байт
	brlo	text_ok_m					; больше не уменьшаем
	sbiw	yl,1						; увеличиваем на 1
text_ok_m:
	sts		T_ok_d_h,yh					; пишим настроенную температуру оконч дисцилляции и идем далше работать
	sts		T_ok_d_l,yl
	call	text_T_ok_d					; выводим на дисплей
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_T_ok_dis
;==================================
zapis_T_ok:							; 
	ldi		adres_data,8				; адрес еепром 8
	lds		data,T_ok_d_l
	call	write_eprom					; 

	ldi		adres_data,9				; адрес еепром 9
	lds		data,T_ok_d_h
	call	write_eprom					; 
	ret

;**************************************************************************************************
;**************************************************************************************************
;**************************************************************************************************
			;	РЕКТИФИКАЦИЯ
;**************************************************************************************************
;**************************************************************************************************


nastr_rekt:
;**************************************************************************************************
;Нстройка времени стабилизации при ректификации
;**************************************************************************************************
nastroika_t_stab0:
	call	Delay_025sec

	call	text_t_stabil

	clr		temp
	sts		seconds,temp

	lds		cnt1,minutes_stb
	rcall	vremy_stsb_nastr			; индикация настраиваемого времени стабилизации

	sbis	PinB,Call_1
	rjmp	nastroika_t_stab0			; крутимся

;**************************************************************************************************
	rcall	clr_tim
nastroika_t_stab:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_t_stb_0				; ПРОЦЕДУРА НАСТРОЙКИ  времени стабилизации
	sbis	PinB,Call_2
	rjmp	nastroyka_Pause_golov		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_T_stb0			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_t_stab
	ret

;**************************************************************************************************
				; Процедура изменения времени стабилизации при ректификации с сохранением в еепром от 1 до 60 мин
;**************************************************************************************************
nastr_t_stb_0:
	rcall	vremy_stsb_nastr			; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_t_stb_0				; крутимся с миганием
nastr_t_stab:
	rcall	vremy_stsb_nastr			; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_t_stab0			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_minutes				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_minutes

	rjmp	nastr_t_stab
;==================================
plys_minutes:
	lds		cnt1,minutes_stb
	cpi		cnt1,59
	breq	plys_minutes0
	inc		cnt1
plys_minutes0:
	sts		minutes_stb,cnt1
	rcall	vremy_stsb_nastr			; высвечивается время окончания стабилизации
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_minutes
	rjmp	zapis_minutes
;==================================
minus_minutes:
	lds		cnt1,minutes_stb
	cpi		cnt1,1
	breq	minus_minutes0
	dec		cnt1
minus_minutes0:
	sts		minutes_stb,cnt1
	rcall	vremy_stsb_nastr			; высвечивается время окончания стабилизации
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_minutes
;==================================
zapis_minutes:							; запись в память
	ldi		adres_data,10				; адрес еепром 10
	lds		data,minutes_stb			; данные минут в еепром
	call	write_eprom

	lds  	temp,num_programs			; Если мы не в стабилизации, то таймер не обнуляем
	cpi		temp,3
	breq	obnul_stb
	ret
obnul_stb:
	lds		temp,minutes_stb
	inc		temp
	inc		temp
	sts		minutes,temp				; Записываем контрольное время окончания стабидизаци
	clr		temp
	sts		seconds,temp
	ret

;**************************************************************************************************
	;Программа нстройки паузы отбора голов
;**************************************************************************************************
nastroyka_Pause_golov:
	ldi		adres_data,11
	call	read_eprom
	mov		cnt1,data			; читаем паузу шим для голов по 5 адресу
nastroyka_Pause_golov0:
	call	Delay_025sec
	rcall	text_P_otb_gol				; текст настройки паузы отбора голов
	rcall	text_SHIM_pause				; текст настройки паузы 

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_golov0		; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroyka_Pause_golov_0:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_pausa_otbora_g_0	; ПРОЦЕДУРА НАСТРОЙКИ  паузы отбора голов
	sbis	PinB,Call_2
	rjmp	nastroyka_Impulsa_golov		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_t_stab0			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Pause_golov_0
	ret
;**************************************************************************************************
				; процедура изменение паузы отбора ШИМ голов  от 2 до 30 с
;**************************************************************************************************
nastroyka_pausa_otbora_g_0:
	rcall	migaem_P_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_pausa_otbora_g_0	; крутимся с миганием

nastroyka_pausa_otbora_g:
	rcall	migaem_P_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_golov		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_vkl_g				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_vkl_g

	rjmp	nastroyka_pausa_otbora_g
;==================================
plys_tim_vkl_g:
	rcall	plys_tim_vkl
	rjmp	zapis_tim_vkl_g
;==================================
minus_tim_vkl_g:
	rcall	minus_tim_vkl
;==================================
zapis_tim_vkl_g:						; запись в память
	ldi		adres_data,11				; адрес еепром 11
	mov		data,cnt1					; времени закрытия реле ШИМ для голов в еепром по 5 адресу для голов
	call	write_eprom

	lds		temp,num_programs
	cpi		temp,4
	breq	zapis_golov_P
	ret
;==================================
zapis_golov_P:
	ldi		adres_data,11
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для голов по 11 адресу
	sts		tim_vkl,data
	ret


;**************************************************************************************************
	;Программа нстройки импульса  отбора голов
;**************************************************************************************************
nastroyka_Impulsa_golov:

	ldi		adres_data,12				; адрес еепром 12
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 1 адресу
	ldi		adres_data,13				; адрес еепром 13
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 2 адресу
nastroyka_Impulsa_golov0:
	call	Delay_025sec
	rcall	text_I_otb_gol				; текст настройки паузы отбора голов
	rcall	text_SHIM_impuls			; Высвечивается импульс  отбора (настраиваемая в m/секундах)

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_golov0	; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroyka_Impulsa_golov_0:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_g_0; ПРОЦЕДУРА НАСТРОЙКИ  импульса  отбора голов
	sbis	PinB,Call_2
	rjmp	nastroika_gol				; в - следующее меню
	sbis	PinB,Call_3	
	rjmp	nastroyka_Pause_golov		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Impulsa_golov_0
	ret
;**************************************************************************************************
				; процедура изменение импульса сброса ШИМ голов
;**************************************************************************************************
nastroyka_impulsa_otbora_g_0:
	rcall	migaem_imp_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_g_0; крутимся с миганием

nastroyka_impulsa_otbora_g:
	rcall	migaem_imp_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_golov		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_sbrosa_g			; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_sbrosa_g

	rjmp	nastroyka_impulsa_otbora_g

;===================================
plys_tim_sbrosa_g:
	rcall	plys_tim_sbrosa
	rjmp	zapis_dalay_sbrosa_g		; записывем в энергонезавис память
;==================================
minus_tim_sbrosa_g:
	rcall	minus_tim_sbrosa
;==================================
zapis_dalay_sbrosa_g:					; распределение записи дэлэй голов или тела
	ldi		adres_data,12				; адрес еепром 12
	lds		data,dalay_h
	call	write_eprom				; запись паузу шим H для голов  по 3 адресу
	ldi		adres_data,13				; адрес еепром 13
	lds		data,dalay_l
	call	write_eprom				; запись паузу шим L для головпо 4 адресу

	lds		temp,num_programs
	cpi		temp,4
	breq	zapis_golov_I
	ret
;==================================
zapis_golov_I:
	ldi		adres_data,12
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 12 адресу
	ldi		adres_data,13
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 13 адресу
	call	impuls_sbrosa				; расчет импульса сброса
	ret






;**************************************************************************************************
				; Программа настройки времени отбора голов 1
;**************************************************************************************************
nastroika_gol:
	call	Delay_025sec
	lds		cnt1,minutes_g
	lds		cnt3,hours_g
	rcall	text_t_glov1
	rcall	vremy_otbora_golov			; индикация настраиваемого времени отбора 

	sbis	PinB,Call_1
	rjmp	nastroika_gol				; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroika_gol_0:				
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_t_glov0				; ПРОЦЕДУРА НАСТРОЙКИ   времени  отбора
	sbis	PinB,Call_2
	rjmp	nastroika_prir0				; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Impulsa_golov		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_gol_0
	ret
;**************************************************************************************************
				; ПРОЦЕДУРА НАСТРОЙКИ   времени  отбора голов 1
;**************************************************************************************************
nastr_t_glov0:
	rcall	vremy_otbora_golov			; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_t_glov0				; крутимся с миганием
nastr_t_glov:
	rcall	vremy_otbora_golov			; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_gol				; выход из настройки
	sbis	PinB,Call_2
	rcall	nastr_hours_g				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	nastr_minutes_g

	rjmp	nastr_t_glov
;==================================
nastr_hours_g:
	inc		cnt3
	cpi		cnt3,24
	brlo	nastr_hours_g_0
	clr		cnt3
nastr_hours_g_0:
	rcall	vremy_otbora_golov
	call	Delay_05sec

	sbis	PinB,Call_2
	rjmp	nastr_hours_g
	rjmp	zapis_t_golov
;==================================
nastr_minutes_g:
	inc		cnt1
	cpi		cnt1,60
	brlo	nastr_minutes_g_0
	clr 	cnt1
nastr_minutes_g_0:
	rcall	vremy_otbora_golov
	call	Delay_05sec

	sbis	PinB,Call_3
	rjmp	nastr_minutes_g
;==================================
zapis_t_golov:							; запись в память
	ldi		adres_data,14				; адрес еепром 14
	mov		data,cnt3					; данные часов в еепром
	call	write_eprom
	call	read_eprom
	sts		hours_g,data

	ldi		adres_data,15				; адрес еепром 15
	mov		data,cnt1					; данные минут в еепром
	call	write_eprom
	call	read_eprom
	sts		minutes_g,data


	lds  	temp,num_programs			; Если мы не в отборе голов, то таймер не обнуляем
	cpi		temp,4
	breq	obnul_g
	ret
obnul_g:
	lds		temp,hours_g
	sts		hours,temp					; Записываем контрольное время окончания отбора голов 1
	lds		temp,minutes_g
	sts		minutes,temp				; Записываем контрольное время окончания отбора голов 1
	ldi		temp,59
	sts		seconds,temp
	ret

;**************************************************************************************************
; Программа настройка приращения
;**************************************************************************************************
nastroika_prir0:
	call	Delay_025sec

	lds		cnt3,delta
	rcall	calk_prirash

	call	text_nastr					; в вехней строке - текст - настройка приращения
	call	prirashen					; Высвечивается  температура приращения

	sbis	PinB,Call_1
	rjmp	nastroika_prir0				; крутимся
;**************************************************************************************************

	rcall	clr_tim
nastroika_prir:				
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_prirash_0				; ПРОЦЕДУРА НАСТРОЙКИ  ; напряжение стабилизаци на тэне при дистилляции
	sbis	PinB,Call_2
	rjmp	nastroyka_Pause_tela1		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_gol				; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_prir
	ret
;**************************************************************************************************
					;ПРОЦЕДУРА НАСТРОЙКИ  приращения для расчета окончания отбора тела от 0,2 до 2,0 градуса
;**************************************************************************************************

nastr_prirash_0:					
	call	prirashen					; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_prirash_0				; крутимся с миганием
nastr_prirash:					
	call	prirashen					; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_prir0				; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_prirash				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_prirash

	rjmp	nastr_prirash
;=======================================
plys_prirash:
	lds		cnt3,delta
	cpi		cnt3,20
	brsh	plys_prirash0
	inc		cnt3
plys_prirash0:
	rcall	calk_prirash
	sbis	PinB,Call_2
	rjmp	plys_prirash
	rjmp	zapis_prirash
;======================================
minus_prirash:
	lds		cnt3,delta
	cpi		cnt3,2
	brlo	minus_prirash0
	dec		cnt3
minus_prirash0:
	rcall	calk_prirash
	sbis	PinB,Call_3
	rjmp	minus_prirash
;==================================
zapis_prirash:							; запись в память
	ldi		adres_data,16				; адрес еепром 16
	lds		data,delta					; настраиваемое приращение 
	call	write_eprom
	ret
;==================================
calk_prirash:
	sts		delta,cnt3
	lds		temp,delta
	call	calk
	sts		delta_ascii2,r0				; распределение на индикаторе
	call	div
	mov		r30,divtm2			
	call	preobraz
	sts		delta_ascii,r0

	call	calk_T4
	call	prirashen					; Высвечивается  температура приращения
	call	Delay_05sec
	ret

;**************************************************************************************************
;	Программа нстройки паузы отбора тела номер 1
;**************************************************************************************************
nastroyka_Pause_tela1:
	ldi		adres_data,17
	call	read_eprom
	mov		cnt1,data					; читаем паузу шим для тела по 17 адресу
nastroyka_Pause_tela10:
	call	Delay_025sec
	call	text_P_otb_tela_1			; текст настройки паузы отбора тела 1
	call	text_SHIM_pause				; текст настройки паузы

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_tela10		; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroyka_Pause_tela_10:
	call	Delay_2sec
  
  	sbis	PinB,Call_1
  	rjmp	nastroyka_pausa_otbora_t10	; ПРОЦЕДУРА НАСТРОЙКИ  паузы отбора тела
	sbis	PinB,Call_2
	rjmp	nastroyka_Impulsa_tela1		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_prir0				; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Pause_tela_10
	ret
;**************************************************************************************************
				; процедура изменение паузы отбора ШИМ тела  1  
;**************************************************************************************************

nastroyka_pausa_otbora_t10:
	rcall	migaem_P_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_pausa_otbora_t10	; крутимся с миганием
nastroyka_pausa_otbora_t1:
	rcall	migaem_P_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_tela1		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_vkl_t1				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_vkl_t1

	rjmp	nastroyka_pausa_otbora_t1
;=====================================
plys_tim_vkl_t1:
	rcall	plys_tim_vkl
	rjmp	zapis_tim_vkl_t1
;==================================
minus_tim_vkl_t1:
	rcall	minus_tim_vkl

;==================================
zapis_tim_vkl_t1:						; запись в память
	ldi		adres_data,17				; адрес еепром 17
	mov		data,cnt1					; времени закрытия реле ШИМ для голов в еепром по 5 адресу для голов
	call	write_eprom

	lds		temp,num_programs
	cpi		temp,5
	breq	zapis_tela_1_P
	ret
;==================================
zapis_tela_1_P:
	ldi		adres_data,17
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 17 адресу
	sts		tim_vkl,data				; записываем тайм
	ret

;**************************************************************************************************
	;Программа нстройки импульса  отбора тела номер1
;**************************************************************************************************
nastroyka_Impulsa_tela1:
	ldi		adres_data,18
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 18 адресу
	ldi		adres_data,19
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 19 адресу
nastroyka_Impulsa_tela10:
	call	Delay_025sec
	call	text_I_otb_tela_1			; текст настройки импульса отбора тела 
	rcall	text_SHIM_impuls			; Высвечивается импульс  отбора (настраиваемая в m/секундах)

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_tela10	; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroyka_Impulsa_tela_10:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_t10
	sbis	PinB,Call_2
	rjmp	nastroyka_Pause_tela2		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Pause_tela1		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Impulsa_tela_10
	ret
;**************************************************************************************************
				; процедура изменение импульса сброса ШИМ тела  1
;**************************************************************************************************
nastroyka_impulsa_otbora_t10:
	rcall	migaem_imp_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_t10; крутимся с миганием

nastroyka_impulsa_otbora_t1:
	rcall	migaem_imp_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_tela1		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_sbrosaT1			; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_sbrosaT1

	rjmp	nastroyka_impulsa_otbora_t1
;=======================================================================================================================
plys_tim_sbrosaT1:
	rcall	plys_tim_sbrosa
	rjmp	zapis_dalay_sbrosa1			; записывем в энергонезавис память
;==================================
minus_tim_sbrosaT1:
	rcall	minus_tim_sbrosa
;==================================
zapis_dalay_sbrosa1:					; распределение записи дэлэй голов или тела
	ldi		adres_data,18				; адрес еепром 18
	lds		data,dalay_h
	call	write_eprom					; запись паузу шим H для голов  по 3 адресу
	ldi		adres_data,19				; адрес еепром 19
	lds		data,dalay_l
	call	write_eprom				; запись паузу шим L для головпо 4 адресу

	lds		temp,num_programs
	cpi		temp,5
	breq	zapis_tela_1_I
	ret
;==================================
zapis_tela_1_I:
	ldi		adres_data,18
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 18 адресу
	ldi		adres_data,19
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 19 адресу
	call	impuls_sbrosa			; расчет импульса сброса
	ret

;**************************************************************************************************
;**************************************************************************************************
;	Программа нстройки паузы отбора тела номер 2
;**************************************************************************************************
nastroyka_Pause_tela2:
	ldi		adres_data,20
	call	read_eprom
	mov		cnt1,data					; читаем паузу шим для тела по 20 адресу
nastroyka_Pause_tela20:
	call	Delay_025sec
	call	text_P_otb_tela_2			; текст настройки паузы отбора тела 2
	call	text_SHIM_pause				; текст настройки паузы

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_tela20		; крутимся

;**************************************************************************************************
	rcall	clr_tim
nastroyka_Pause_tela_20:
	call	Delay_2sec
  
  	sbis	PinB,Call_1
  	rjmp	nastroyka_pausa_otbora_t20	; ПРОЦЕДУРА НАСТРОЙКИ  паузы отбора тела 2
	sbis	PinB,Call_2
	rjmp	nastroyka_Impulsa_tela2		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Impulsa_tela1		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Pause_tela_20
	ret
;**************************************************************************************************
				; процедура изменение паузы отбора ШИМ тела  2
;**************************************************************************************************

nastroyka_pausa_otbora_t20:
	rcall	migaem_P_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_pausa_otbora_t20	; крутимся с миганием
nastroyka_pausa_otbora_t2:
	rcall	migaem_P_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_tela2		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_vkl_t2				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_vkl_t2

	rjmp	nastroyka_pausa_otbora_t2
;=====================================
plys_tim_vkl_t2:
	rcall	plys_tim_vkl
	rjmp	zapis_tim_vkl_t2
;==================================
minus_tim_vkl_t2:
	rcall	minus_tim_vkl
zapis_tim_vkl_t2:						; запись в память
 	ldi		adres_data,20				; адрес еепром 20
	mov		data,cnt1					; времени закрытия реле ШИМ для голов в еепром по 5 адресу для голов
	call	write_eprom

	lds		temp,num_programs
	cpi		temp,7
	breq	zapis_tela_2_P
	ret
;==================================
zapis_tela_2_P:
	ldi		adres_data,20
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 17 адресу
	sts		tim_vkl,data				; записываем тайм
	ret


;**************************************************************************************************
	;Программа нстройки импульса  отбора тела номер 2
;**************************************************************************************************
nastroyka_Impulsa_tela2:
	ldi		adres_data,21
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 2 адресу
	ldi		adres_data,22
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 22 адресу
nastroyka_Impulsa_tela20:
	call	Delay_025sec
	call	text_I_otb_tela_2			; текст настройки импульса  отбора тела 
	call	text_SHIM_impuls			; Высвечивается импульс  отбора (настраиваемая в m/секундах)

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_tela20	; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroyka_Impulsa_tela_20:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_t20; ПРОЦЕДУРА НАСТРОЙКИ
	sbis	PinB,Call_2
	rjmp	nastroyka_Pause_tela3		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Pause_tela2		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Impulsa_tela_20
	ret
;**************************************************************************************************
				; процедура изменение импульса сброса ШИМ тела  2
;**************************************************************************************************
nastroyka_impulsa_otbora_t20:
	rcall	migaem_imp_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_t20; крутимся с миганием

nastroyka_impulsa_otbora_t2:
	rcall	migaem_imp_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_tela2		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_sbrosaT2			; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_sbrosaT2

	rjmp	nastroyka_impulsa_otbora_t2
;=======================================================================================================================
plys_tim_sbrosaT2:
	rcall	plys_tim_sbrosa
	rjmp	zapis_dalay_sbrosa2			; записывем в энергонезавис память
;==================================
minus_tim_sbrosaT2:
	rcall	minus_tim_sbrosa
;==================================
zapis_dalay_sbrosa2:					; распределение записи дэлэй голов или тела
	ldi		adres_data,21				; адрес еепром 21
	lds		data,dalay_h
	call	write_eprom				; запись паузу шим H для голов  по 3 адресу
	ldi		adres_data,22				; адрес еепром 22
	lds		data,dalay_l
	call	write_eprom				; запись паузу шим L для головпо 4 адресу

	lds		temp,num_programs
	cpi		temp,7
	breq	zapis_tela_2_I
	ret
;==================================
zapis_tela_2_I:
	ldi		adres_data,21
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 18 адресу
	ldi		adres_data,22
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 19 адресу
	call	impuls_sbrosa				; расчет импульса сброса
	ret

;**************************************************************************************************
;	Программа нстройки паузы отбора тела номер 3
;**************************************************************************************************
nastroyka_Pause_tela3:
;======================================
	ldi		adres_data,23
	call	read_eprom
	mov		cnt1,data					; читаем паузу шим для тела по 23 адресу
nastroyka_Pause_tela30:
	call	Delay_025sec
	call	text_P_otb_tela_3			; текст настройки паузы отбора тела
	call	text_SHIM_pause				; текст настройки паузы

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_tela30		; крутимся

;**************************************************************************************************
	rcall	clr_tim
nastroyka_Pause_tela_30:
	call	Delay_2sec
  
  	sbis	PinB,Call_1
  	rjmp	nastroyka_pausa_otbora_t30	; ПРОЦЕДУРА НАСТРОЙКИ  паузы отбора тела 3
	sbis	PinB,Call_2
	rjmp	nastroyka_Impulsa_tela3		; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Impulsa_tela2		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Pause_tela_30
	ret
;**************************************************************************************************
				; процедура изменение паузы отбора ШИМ тела  3
;**************************************************************************************************

nastroyka_pausa_otbora_t30:
	rcall	migaem_P_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_pausa_otbora_t30	; крутимся с миганием
nastroyka_pausa_otbora_t3:
	rcall	migaem_P_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Pause_tela3		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_vkl_t3				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_vkl_t3

	rjmp	nastroyka_pausa_otbora_t3
;=====================================
plys_tim_vkl_t3:
	rcall	plys_tim_vkl
	rjmp	zapis_tim_vkl_t3
;==================================
minus_tim_vkl_t3:
	rcall	minus_tim_vkl
zapis_tim_vkl_t3:						; запись в память
	ldi		adres_data,23				; адрес еепром 23
	mov		data,cnt1					; времени закрытия реле ШИМ для голов в еепром по 5 адресу для голов
	call	write_eprom

	lds		temp,num_programs
	cpi		temp,9
	breq	zapis_tela_3_P
	ret
;==================================
zapis_tela_3_P:
	ldi		adres_data,23
	call	read_eprom
	sts		contr_tim_vkl,data			; читаем паузу шим для тела по 17 адресу
	sts		tim_vkl,data				; записываем тайм
	ret


;**************************************************************************************************
	;Программа нстройки импульса  отбора тела номер 3
;**************************************************************************************************
nastroyka_Impulsa_tela3:
	ldi		adres_data,24
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 24 адресу
	ldi		adres_data,25
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 25 адресу
nastroyka_Impulsa_tela30:
	call	Delay_025sec
	call	text_I_otb_tela_3				; текст настройки паузы отбора тела 
	call	text_SHIM_impuls			; Высвечивается импульс  отбора (настраиваемая в m/секундах)

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_tela30	; крутимся

;**************************************************************************************************
	rcall	clr_tim
nastroyka_Impulsa_tela_30:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_t30; ПРОЦЕДУРА НАСТРОЙКИ 
	sbis	PinB,Call_2
	rjmp	nastr_kol_pauz0				; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Pause_tela3		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_Impulsa_tela_30
	ret
;**************************************************************************************************
				; процедура изменение импульса сброса ШИМ тела  3
;**************************************************************************************************
nastroyka_impulsa_otbora_t30:
	rcall	migaem_imp_shim
	sbis	PinB,Call_1
	rjmp	nastroyka_impulsa_otbora_t30; крутимся с миганием

nastroyka_impulsa_otbora_t3:
	rcall	migaem_imp_shim

	sbis	PinB,Call_1
	rjmp	nastroyka_Impulsa_tela3		; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_sbrosaT3			; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_sbrosaT3

	rjmp	nastroyka_impulsa_otbora_t3
;=======================================================================================================================
plys_tim_sbrosaT3:
	rcall	plys_tim_sbrosa
	rjmp	zapis_dalay_sbrosa3			; записывем в энергонезавис память
;==================================
minus_tim_sbrosaT3:
	rcall	minus_tim_sbrosa

;==================================
zapis_dalay_sbrosa3:					; распределение записи дэлэй голов или тела
	ldi		adres_data,24				; адрес еепром 24
	lds		data,dalay_h
	call	write_eprom				; запись паузу шим H для голов  по 3 адресу
	ldi		adres_data,25				; адрес еепром 25
	lds		data,dalay_l
	call	write_eprom				; запись паузу шим L для головпо 4 адресу

	lds		temp,num_programs
	cpi		temp,9
	breq	zapis_tela_3_I
	ret
;==================================
zapis_tela_3_I:
	ldi		adres_data,24
	call	read_eprom
	sts		dalay_h,data				; читаем dalay_h по 18 адресу
	ldi		adres_data,25
	call	read_eprom
	sts		dalay_l,data				; читаем dalay_l по 19 адресу
	call	impuls_sbrosa				; расчет импульса сброса
	ret



;**************************************************************************************************
; 	Программа настройки количества пауз доения
;**************************************************************************************************
nastr_kol_pauz0:
	call	Delay_025sec

	call	text_nastr					; в вехней строке - текст - настройка
	call	text_nastr_paus				; высвечивается количество пауз

	sbis	PinB,Call_1
	rjmp	nastr_kol_pauz0				; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastr_kol_pauz:							; напряжение стабилизаци на тэне
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_col_pauz_0			; ПРОЦЕДУРА НАСТРОЙКИ  ; количества пауз 
	sbis	PinB,Call_2
	rjmp	nastroika_pause				; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_Impulsa_tela3		; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastr_kol_pauz
	ret
;**************************************************************************************************
				; Процедура изменения колтчества пауз при отборе тела
;**************************************************************************************************
nastr_col_pauz_0:
call	text_nastr_paus				; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_col_pauz_0			; крутимся с миганием
nastr_col_pauz:
	call	text_nastr_paus				; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastr_kol_pauz0				; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_Paus					; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_Paus

	rjmp	nastr_col_pauz

;===================================
plys_Paus:
	lds		temp,count_otbora
	cpi		temp,2
	brsh	plys_Paus0
	inc		temp
plys_Paus0:
	sts		count_otbora,temp
	call	text_nastr_paus				; высвечивается количество пауз
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_Paus
	rjmp	zapis_Paus
;==================================
minus_Paus:
	lds		temp,count_otbora
	cpi		temp,1
	brlo	minus_Paus0
	dec		temp
minus_Paus0:
	sts		count_otbora,temp
	call	text_nastr_paus				; высвечивается количество пауз
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_Paus
;==================================
zapis_Paus:								; запись в память
	ldi		adres_data,26				; адрес еепром 26
	lds		data,count_otbora			; данные минут в еепром
	call	write_eprom
	call	read_eprom
	sts		count_otbora,data
	sts		count_otbora_ostatok,data
	ret

;**************************************************************************************************
; 	Программа изменения времени паузы при ректификации
;**************************************************************************************************
nastroika_pause:
 	call	Delay_025sec

	clr		temp
	sts		seconds,temp

	lds		cnt1,minutes_P
 	call	text_dl_P					; в вехней строке - текст - настройка 
	call	nastr_stsb					; высвечивается число времени паузы
 
 	sbis	PinB,Call_1
	rjmp	nastroika_pause				; крутимся
;**************************************************************************************************
 	rcall	clr_tim
nastroika_pause_rektif:					; напряжение стабилизаци на тэне
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	pause_rektif_0				; ПРОЦЕДУРА НАСТРОЙКИ  ; количества пауз 
	sbis	PinB,Call_2
	rjmp	nastroyka_T_okonch_rekt0	; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastr_kol_pauz0				; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_pause_rektif
	ret
;**************************************************************************************************
				; Процедура изменения времени паузы при ректификации с сохранением в еепром от 1 до 15 мин
;**************************************************************************************************
pause_rektif_0:
	call	nastr_stsb					; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	pause_rektif_0				; крутимся с миганием	

pause_rektif:
	call	nastr_stsb					; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_pause				; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_minutesP				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_minutesP

	rjmp	pause_rektif
;===================================
plys_minutesP:
	lds		cnt1,minutes_P
	cpi		cnt1,30
	breq	plys_minutesP_0
	inc		cnt1
plys_minutesP_0:
	sts		minutes_P,cnt1
	call	nastr_stsb					; высвечивается время окончания паузы
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_minutesP
	rjmp	zapis_minutesP
;==================================
minus_minutesP:
	lds		cnt1,minutes_P
	cpi		cnt1,0
	breq	minus_minutesP_0
	dec		cnt1
minus_minutesP_0:
	sts		minutes_P,cnt1
	call	nastr_stsb					; высвечивается время окончания паузы
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_minutesP
;==================================
zapis_minutesP:							; запись в память
	ldi		adres_data,27				; адрес еепром 27
	lds		data,minutes_P				; данные минут в еепром
	call	write_eprom
	call	read_eprom
	sts		minutes_P,data

	lds		temp,num_programs
	cpi		temp,6
	breq	vvod_timer
	ldi		temp,8
	breq	vvod_timer
	ret
vvod_timer:
	lds		temp,minutes_P				; количество минут в паузе
	inc		temp
;	inc 	temp
	sts		minutes,temp				; Записываем контрольное время стабилизации
	ldi		temp,59
	sts		seconds,temp
	ret

;**************************************************************************************************
;	Программа нстройки температуры окончания  ректификации.
;**************************************************************************************************
nastroyka_T_okonch_rekt00:


	lds		temp,kl_hvostov
	tst		temp						; смотрим флаг работы хвостов
	breq	nastroyka_T_okonch			; если он 0, то настраиваем температуру окончания отбора
	rjmp	nastroika_pause				; если он 1, то пропускаем настройку
nastroyka_T_okonch_rekt0:
	lds		temp,kl_hvostov
	tst		temp						; смотрим флаг работы хвостов
	breq	nastroyka_T_okonch			; если он 0, то настраиваем температуру окончания отбора
	rjmp	nastr_tim_contr0			; если он 1, то пропускаем настройку

nastroyka_T_okonch:

	call	Delay_025sec

	call	text_T_ok_r					; текст окончния ректификации

	sbis	PinB,Call_1
	rjmp	nastroyka_T_okonch			; крутимся
;**************************************************************************************************

	rcall	clr_tim
nastroyka_T_okonch_rekt:				; напряжение стабилизаци на тэне
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastroyka_okonch_R_0		; ПРОЦЕДУРА НАСТРОЙКИ  ; напряжение стабилизаци на тэне при ректификации
	sbis	PinB,Call_2
	rjmp	nastr_tim_contr0			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_pause				; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroyka_T_okonch_rekt
	ret
;**************************************************************************************************
				; Процедура изменения температуры окончания ректификации от 65 до 85 градусов
;**************************************************************************************************
nastroyka_okonch_R_0:
	call	text_T_ok_r_1				; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastroyka_okonch_R_0		; крутимся с миганием
nastroyka_okonch_R:
	call	text_T_ok_r_1				; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroyka_T_okonch_rekt0	; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_T_ok_rek				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_T_ok_rek

	rjmp	nastroyka_okonch_R
;==================================
plys_T_ok_rek:
	lds		yh,T_ok_r_h					; пишим настраиваемую температуру оконч ректификации и идем далше работать
	lds		yl,T_ok_r_l
	ldi		Xl,low(990)					; это max настройки
	ldi		XH,high(990)
	cp		yl,Xl						; сравниваем младший байт
	cpc		yh,Xh						; сравниваем старший байт
	brsh	plys_T_ok_rek0					; больше не увеличиваем
	adiw	yl,1						; увеличиваем на 1
plys_T_ok_rek0:
	sts		T_ok_r_h,yh					; пишим настроенную температуру оконч дисцилляции и идем далше работать
	sts		T_ok_r_l,yl
	call	text_T_ok_r_1				; выводим на дисплей
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_T_ok_rek
	rjmp	zapis_T_okr					; записывем в энергонезавис память
;==================================
minus_T_ok_rek:
	lds		yh,T_ok_r_h					; пишим настраиваемую температуру оконч ректификации и идем далше работать
	lds		yl,T_ok_r_l
	ldi		Xl,low(650)					; это max настройки
	ldi		XH,high(650)
	cp		yl,Xl						; сравниваем младший байт
	cpc		yh,Xh						; сравниваем старший байт
	brlo	minus_T_ok_rek0				; больше не уменьшаем
	sbiw	yl,1						; увеличиваем на 1
minus_T_ok_rek0:
	sts		T_ok_r_h,yh					; пишим настроенную температуру оконч ректификации и идем далше работать
	sts		T_ok_r_l,yl
	call	text_T_ok_r_1				; выводим на дисплей
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_T_ok_rek
;==================================
zapis_T_okr:							; 
	ldi		adres_data,28				; адрес еепром 28
	lds		data,T_ok_r_l
	call	write_eprom					; 
	call	read_eprom
	sts		T_ok_r_l,data

	ldi		adres_data,29				; адрес еепром 29
	lds		data,T_ok_r_h
	call	write_eprom					; 
	call	read_eprom
	sts		T_ok_r_h,data
	ret

;**************************************************************************************************
; 	Программа настройки времени контроля температуры в дэфе
;**************************************************************************************************
nastr_tim_contr0:
	call	Delay_025sec

	rcall	raspred_tim_kontr
	call	text_t_control				; в вехней строке - текст - время контроля
	call	vremy_kontr_prov			;-показываем время контроля проверки

	sbis	PinB,Call_1
	rjmp	nastr_tim_contr0			; крутимся
;**************************************************************************************************
 	rcall	clr_tim
nastr_tim_contr:						; напряжение стабилизаци на тэне
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_tim_contr10			; ПРОЦЕДУРА НАСТРОЙКИ  ; времени контроля температуры в дэфе
	sbis	PinB,Call_2
	rjmp	nastroika_T_daf0			; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroyka_T_okonch_rekt00	; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastr_tim_contr
	ret
;**************************************************************************************************
						; Процедура изменения время таймера контрля температуры в дефе для  регулировки напряжения от 5 сек до 180сек
;**************************************************************************************************
nastr_tim_contr10:
	call	vremy_kontr_prov			; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_tim_contr10			; крутимся с миганием
nastr_tim_contr1:
	call	vremy_kontr_prov			; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastr_tim_contr0			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_tim_kontr				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_tim_kontr

	rjmp	nastr_tim_contr1
;===========================================
plys_tim_kontr:
	lds		temp,tim_kontr
	inc		temp
	sts		tim_kontr,temp
	rcall	raspred_tim_kontr
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_tim_kontr
	rjmp	zapis_tim_kontr
;===========================================
minus_tim_kontr:
	lds		temp,tim_kontr
	dec		temp
	sts		tim_kontr,temp
	rcall	raspred_tim_kontr
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_tim_kontr
zapis_tim_kontr:						; запись в память
	ldi		adres_data,30				; адрес еепром 30
	lds		data,tim_kontr				; tim_kontr записываем в еепром по 14 адресу
	call	write_eprom
	call	read_eprom
	sts		tim_kontr,data				; чтение  таймера по 14 адресу
	ret
;============================================
raspred_tim_kontr:
	lds		temp,tim_kontr				; распределяем контрольное время
	clr		divnt1
	mov		divnt2,temp
	clr		divsr1						; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  				; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp					; В нижний регистр делителя помещаем число на которое делим
	call	div						; Включаем подпрограмму деления
	mov		r30,divtm2			
	call	preobraz
	sts		tim_kontr_z,r0
	call	div					; 
	mov		r30,divtm2			
	call	preobraz
	sts		tim_kontr_l,r0
	call	div					; 
	mov		r30,divtm2			
	call	preobraz			
	sts		tim_kontr_h,r0
	call	vremy_kontr_prov			;-показываем время контроля проверки
	ret
;**************************************************************************************************
;	Программа нстройки температуры в дефлегматоре на стабилизацию напряжения
;**************************************************************************************************

nastroika_T_daf0:
	call	Delay_025sec

	lds		temp,TD_sbor
	rcall	calc_vkl_daf
	call	text_nastr_daf				; индикация настраиваемой температуры на стабилизацию напряжения

	sbis	PinB,Call_1
	rjmp	nastroika_T_daf0			; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastroika_T_daf:					
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_T_daf_0				; ПРОЦЕДУРА НАСТРОЙКИ  температура в кубе на включения воды
	sbis	PinB,Call_2
	rjmp	nastr_kol_U_0				; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastr_tim_contr0			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastroika_T_daf
	ret
;**************************************************************************************************
						; регулиповка температуры в дэфе на регулироку U
;**************************************************************************************************

nastr_T_daf_0:
	call	text_nastr_daf				; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_T_daf_0				; крутимся с миганием
nastr_T_daf:
	call	text_nastr_daf				; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastroika_T_daf0			; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_vkl_daf				; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_vkl_daf

	rjmp	nastr_T_daf
;===================================
plys_vkl_daf:
	lds		temp,TD_sbor
	inc		temp
	rcall	calc_vkl_daf
	sbis	PinB,Call_2
	rjmp	plys_vkl_daf
	rjmp	zapis_TD_sbor
;===================================
minus_vkl_daf:
	lds		temp,TD_sbor
	dec		temp
	rcall	calc_vkl_daf
	sbis	PinB,Call_3
	rjmp	minus_vkl_daf
;====================================
zapis_TD_sbor:							; запись в память
	ldi		adres_data,31				; адрес еепром 31
	lds		data,TD_sbor				; запись  температуры включения воды в еепром по 7 адресу	
	call	write_eprom
	call	read_eprom
	sts		TD_sbor,data				; чтение  температуры включения воды по 8 адресу
	ret
;====================================
calc_vkl_daf:
	sts		TD_sbor,temp
	call	calk
	sts		indik_2,r0
	call	div						; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz			
	sts		indik_1,r0
	call	text_nastr_daf				; индикация настраиваемой температуры на включение воды
	call	Delay_05sec
	ret


;**************************************************************************************************
; Программа переключателя ручная автоматическая регуировка напряжения
;**************************************************************************************************
nastr_kol_U_0:
	call	Delay_025sec
	call	text_kontr_U				; в вехней строке - текст - контроль U
	rcall	vibor_ruchn_avtomat

	sbis	PinB,Call_1
	rjmp	nastr_kol_U_0				; крутимся
;**************************************************************************************************
	rcall	clr_tim
nastr_kol_U:
	call	Delay_2sec

	sbis	PinB,Call_1
	rjmp	nastr_contr_U_0				; ПРОЦЕДУРА НАСТРОЙКИ  ; напряжение стабилизаци на тэне при дистилляции
	sbis	PinB,Call_2
	rjmp	nastroika_d					; в - следующее меню
	sbis	PinB,Call_3
	rjmp	nastroika_T_daf0			; в предыдущее меню

	lds		temp,timer2
	cpi		temp,8
	brlo	nastr_kol_U
	ret
;**************************************************************************************************
				; Процедура переключателя ручное автоматическое
;**************************************************************************************************
nastr_contr_U_0:
	rcall	vibor_ruchn_avtomat			; индикация данных 
	rcall	pauza_pusto
	sbis	PinB,Call_1
	rjmp	nastr_contr_U_0				; крутимся с миганием

nastr_contr_Ur:
	rcall	vibor_ruchn_avtomat			; индикация данных 
	rcall	pauza_pusto

	sbis	PinB,Call_1
	rjmp	nastr_kol_U_0				; выход из настройки
	sbis	PinB,Call_2
	rcall	plys_contrU					; кнопками + или - производим настройки
	sbis	PinB,Call_3
	rcall	minus_contrU

	rjmp	nastr_contr_Ur
;=================================
plys_contrU:
	clr		temp
	sts		count_U,temp
	call	text_ruchn					; текст  ручное управление
	call	Delay_1sec
	sbis	PinB,Call_2
	rjmp	minus_contrU
	sbis	PinB,Call_3
	rjmp	minus_contrU
	rjmp	zapis_contrU
;==================================
minus_contrU:
	ser		temp
	sts		count_U,temp
	call	text_avtomat				; текст автоматическое управление
	call	Delay_1sec
	sbis	PinB,Call_2
	rjmp	plys_contrU
	sbis	PinB,Call_3
	rjmp	plys_contrU
;==================================
zapis_contrU:							; запись в память
	ldi		adres_data,32			 	; адрес еепром 32
	lds		data,count_U				; данные минут в еепром
	call	write_eprom
	call	read_eprom
	sts		count_U,data
	ret




;**************************************************************************************************
;**************************************************************************************************


;====================================
vibor_ruchn_avtomat:
	lds		temp,count_U
	tst		temp
	brne	nastr_contr_Ur0
	call	text_ruchn					; ручное управление
	rjmp	ruchoe
nastr_contr_Ur0:
	call	text_avtomat				; автоматическое управление
ruchoe:
	ret
;==================================
migaem_P_shim:
	call	text_SHIM_pause				; индикация данных 
	rcall	pauza_pusto
	ret
;==================================
migaem_imp_shim:
	call	text_SHIM_impuls			; индикация данных 
	rcall	pauza_pusto
	ret
;==================================
plys_tim_vkl:
	mov		temp,cnt1
	cpi		temp,25
	brsh	no_plys
	inc		temp
no_plys:
	mov		cnt1,temp
	call	text_SHIM_pause				; Высвечивается пауза отбора (настраиваемая в секундах)
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_tim_vkl
	ret
;==================================
minus_tim_vkl:
	mov		temp,cnt1
	cpi		temp,3
	brlo	no_minus
	dec		temp
no_minus:
	mov		cnt1,temp
	call	text_SHIM_pause				; Высвечивается пауза отбора (настраиваемая в секундах)
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_tim_vkl
	ret
;==================================

pauza_pusto:	
	call	Delay_05sec
	call	text_pusto				; текст пусто
	call	Delay_05sec				
	ret
;**************************************************************************************************
plys_tim_sbrosa:
	lds		yh,dalay_h					; пишим исходный дэлэй
	lds		yl,dalay_l
	ldi		Xl,low(64700)				; пишим секундную паузу - это максимум настройки
	ldi		XH,high(64700)
	cp		yl,Xl						; сравниваем младший байт
	cpc		yh,Xh						; сравниваем старший байт
	brsh	plys_tim_sbrosa1			; если больше или равно секунде - больше не увеличиваем
	subi	yl,low(-780)				; плюс 780 к старшему байту
	sbci	yh,high(-780)				; плюс 780 к младшему байту
plys_tim_sbrosa1:
	sts		dalay_h,yh					; сохраняемся
	sts		dalay_l,yl
	call	text_SHIM_impuls			; Высвечивается импульс  сброса (настраиваемая в миллисекундах)
	call	Delay_05sec
	sbis	PinB,Call_2
	rjmp	plys_tim_sbrosa
	ret
;**************************************************************************************************
minus_tim_sbrosa:
	lds		yh,dalay_h					; пишим исходный дэлэй
	lds		yl,dalay_l
	ldi		Xl,low(1565)					; это минимум настройки
	ldi		XH,high(1565)
	cp		yl,Xl						; сравниваем младший байт
	cpc		yh,Xh						; сравниваем старший байт
	brlo	minus_tim_sbrosa1						; больше не уменьшаем
	subi	yl,low(780)					; вычесть старший байт
	sbci	yh,high(780)				; вычесть младший байт
minus_tim_sbrosa1:
	sts		dalay_h,yh
	sts		dalay_l,yl
	call	text_SHIM_impuls			; Высвечивается импульс  сброса (настраиваемый в миллисекундах)
	call	Delay_05sec
	sbis	PinB,Call_3
	rjmp	minus_tim_sbrosa
	ret
;**************************************************************************************************
clr_tim:
 	clr		temp
	sts		timer2,temp
	ret
;**************************************************************************************************



out_data:

	ldi 	data_uart,0x44		;D
	call 	uart_snt
	ldi 	data_uart,0x41		;A
	call 	uart_snt
	ldi 	data_uart,0x54		;T
	call 	uart_snt
	ldi 	data_uart,0x41		;A
	call 	uart_snt
;===========================
; РЕЖИМ РАБОТЫ СИСТЕМЫ,
	lds		data_uart,rejim_rab			; режим работы 0 - дистил, 1 - ректиф, 2 - пиво, 3 - автоклав,
	call 	uart_snt		;1			
;===========================

; Температура в КУБЕ,
	lds 	data_uart,T1_0		;T1_0
	call 	uart_snt		;2
	lds 	data_uart,T1_1		;T1_1
	call 	uart_snt		;3
	lds 	data_uart,T1_2		;T1_2
	call 	uart_snt		;4
	lds 	data_uart,T1_3		;T1_3
	call 	uart_snt		;5
;===========================
; Температура в ЦАРГЕ,
	lds 	data_uart,T2_0		;T2_0
	call 	uart_snt		;6
	lds 	data_uart,T2_1		;T2_1
	call 	uart_snt		;7
	lds 	data_uart,T2_2		;T2_2
	call 	uart_snt		;8
	lds 	data_uart,T2_3		;T2_3
	call 	uart_snt		;9
;===========================
; Температура в ДЕФЛЕГМАТОРЕ,
	lds 	data_uart,T3_0		;T3_0
	call 	uart_snt		;10
	lds 	data_uart,T3_1		;T3_1
	call 	uart_snt		;11
	lds 	data_uart,T3_2		;T3_2
	call 	uart_snt		;12
	lds 	data_uart,T3_3		;T3_3
	call 	uart_snt		;13

;===========================
; НАПРЯЖЕНИЕ НА ТЭНЕ
	lds 	data_uart,napryj_kontr
	call 	uart_snt		;14
;===========================
;В зависимости от режима работы 0 - дистил, 1 - ректиф, 2 - пиво, 3 - автоклав,
	lds		temp,rejim_rab	
	lds		data_uart,TS_sbor_d			; температура нагрева ДИСТИЛЛЯЦИИ
	cpi		temp,0	
	breq	peredacha_T_stb
	lds		data_uart,TS_sbor_r			; температура нагрева РЕКТИФИКАЦИИ
	cpi		temp,1
	breq	peredacha_T_stb

	lds		temp,num_programs
	lds		data_uart,TS_sbor_NZ		; температура нагрева ЗАТИРАНИЯ
	cpi		temp,16
	brne	peredacha_T_stb
	lds		data_uart,TS_sbor_NV		; температура нагрева ВАРЕНИЯ
peredacha_T_stb:
	call 	uart_snt		;15
;===========================
; НОМЕР ПРОГРАММЫ
	lds		data_uart,num_programs
	call 	uart_snt		;16
;===========================
; НАПРЯЖЕНИЕ СТАБИЛИЗАЦИИ
	lds		data_uart,regul_Ud
	lds		temp,rejim_rab
	cpi		temp,0
	breq	rec_U_stsb					; 0 - передача U стб  ДИСТИЛЛЯЦИИ
	lds		data_uart,regul_Ur
	cpi		temp,1
	breq	rec_U_stsb					; 1 - передача U стб РЕКТИФИКАЦИИ

	cpi		temp,2
	breq	rec_U_stsb_piva				; 2 - передача одного из трех U стб ПИВА
	lds		data_uart,regul_U_A
rec_U_stsb:
	rjmp	peredacha_U					; 3 - передача  U стб АВТОКЛАВА

rec_U_stsb_piva:

	lds		temp,rejim_stb

	lds		data_uart,regul_U_R				; напряжение стабилизации РАЗГОННОЕ при пивоварении
	cpi		temp,1
	breq	peredacha_U

	lds		data_uart,regul_U_S				; напряжение стабилизации затирки при пивоварении
	cpi		temp,2
	breq	peredacha_U

	lds		data_uart,regul_U_V				; напряжение стабилизации варки при пивоварении

peredacha_U:
	call 	uart_snt		;17
;===========================
; ТЕМПЕРАТУРА ОКОНЧАНИЯ ДИСТИЛЛЯЦИИ
	lds 	data_uart,T_ok_d_h			; T окончания дистилляции h
	call 	uart_snt		;18
	lds 	data_uart,T_ok_d_l			; T окончания дистилляции l
	call 	uart_snt		;19

;===========================
; ПЕРЕДАЧА ВРЕМЕНИ ТАЙМЕРОВ
	lds 	data_uart,hours				; t окончания стабилизации часы, отбор голов, пауза доения
 	call 	uart_snt		;20
	lds 	data_uart,minutes			; t окончания стабилизации минут
	call 	uart_snt		;21
	lds 	data_uart,seconds			; t окончания стабилизации секунд
	call 	uart_snt		;22
;===========================
; ТЕМПЕРАТУРА ОКОНЧАНИЯ РЕКТИФИКАЦИИ И ОТБОРА ХВОСТОВ
	lds 	data_uart,T4_1				;T4_1 ,T окончания тела или хвостов l
	call 	uart_snt		;23
	lds 	data_uart,T4_2				;T4_2 ,T окончания тела или хвостов 2
	call 	uart_snt		;24
	lds 	data_uart,T4_3				;T4_3 ,T окончания тела или хвостов 3
	call 	uart_snt		;25
 ;===========================
; ПЕРЕДАЧА РЕАЛЬНОГО ПРОРАБОТАННОГО ВРЕМЕНИ 
 	lds		data_uart,hours_R			; реально проработанное время часы,
 	call 	uart_snt		;26
	lds		data_uart,minutes_R			; реально проработанное время минуты
	call 	uart_snt		;27
;===========================
; КОЛИЧЕСТВО ПАУЗ ПРИ РЕКТИФИКАЦИИ ( ДОЕНИИ)
	lds 	data_uart,count_ascii		; количество пауз
 	call 	uart_snt		;28
	lds 	data_uart,count_ascii2
	call 	uart_snt		;29
;===========================
; ДАННЫЕ ТЕМПЕРАТУР НАГРЕВА
	lds 	data_uart,TN_2				;TN_2
	call 	uart_snt		;30
	lds 	data_uart,TN_1				;TN_1
	call 	uart_snt		;31
;===========================
; ДАННЫЕ ТЕМПЕРАТУР В РЕЦЕПТАХ
	mov 	data_uart,AdT1				;AdT1
	call 	uart_snt		;32
;===========================
; НОМЕР ПОДПРОГРАММЫ
	lds 	data_uart,nomer				;nomer
	call 	uart_snt		;33
;===========================
; ВРЕМЯ ТАЙМЕРОВ В ПИВОВАРЕНИИ И АВТОКЛАВЕ
	lds 	data_uart,minutesA			; t окончания стабилизации минут
	call 	uart_snt		;34
	lds 	data_uart,secondsA			; t окончания стабилизации секунд
	call 	uart_snt		;35
	lds 	data_uart,Prichina			; причина аварии
	call 	uart_snt		;36
	call	crlf
;===========================
	ret




;========================================================================================================================	
								; проверка команды GSM
;========================================================================================================================
kontr_ring:
	lds		temp,zapusk					; автоматический сброс системы с пульта
	cpi		temp,0x53					;S
	brne	kontr_ring_0
	jmp		reset
kontr_ring_0:
	lds		temp,GSM_opoveshen			; смотрим разрешон ли GSM
	tst		temp
	brne	kontr_count					; Если 1 - GSM не разрешон.- уходим 

	cpi		ring_dtmf,125
	brne	kontr_count
	rcall	komands_dtmf00
kontr_count:
	ret


komands_dtmf00:		jmp		komands_dtmf0

 ;-*********************************************************************************************-
								; Программа сирены
;-*********************************************************************************************-
signal_sis1:
	lds		temp,alarms
	tst		temp
	brne	np_sign1

	sbis	PinB,Call_3
	rjmp 	np_sign1					; Кнопкой "-" - отключаем сирену

	rcall	pic_pic1
	rcall	Delay_1sec
	dec		count
	cpi		count,255
	brlo	signal_sis1
np_sign1: 
	ret
;==================================================================================================================
pic_pic1:
    ldi 	cnt3,160
ring_11:
    sbi 	PortA,signal
    rcall 	Delay_500mkc
	rcall 	Delay_500mkc
    cbi 	PortA,signal
    rcall 	Delay_500mkc
	rcall 	Delay_500mkc
    dec 	cnt3
    brne 	ring_11
    ldi 	cnt3,255
ring_21:
	sbi 	PortA,signal
    rcall 	Delay_500mkc
    cbi 	PortA,signal
    rcall 	Delay_500mkc
    dec 	cnt3
    brne 	ring_21
 	ret

;========================================================================================================================	
					; БЛОК деления
;========================================================================================================================
div:
	ldi divtm3,16						; divnt1:divnt2 - делимое, сюда же помещаем частное
	clr divtm2							; divsr1:divsr2 - делитель
	clr divtm1							; divtm1:divtm2, divtm3 - временные регистры
divl:
	rol	divnt2
	rol divnt1
	rol	divtm2
	rol	divtm1
	cp	divtm2,divsr2
	cpc	divtm1,divsr1
	brlo divs 
	sub	divtm2,divsr2
	sbc	divtm1,divsr1
divs:
	dec divtm3
	brne divl
	rol	divnt2
	rol divnt1
	com	divnt1
	com	divnt2
	ret	
;========================================================================================================================	
					; Подпрограмма для показа двоичного числа в нормальном виде	
;========================================================================================================================
;preobraz:								; 	
 ;   clr 	r31							; Очищаем нижний регистр Z
;	adiw	r30,low(cross_array * 2	)	; В верхний регистр Z пишим те символы, которые хотим увидить при формировании двоичного числа
;	lpm									; Загружает один байт, адресованный регистром Z, в регистр 0 (R0).
;	ret

preobraz:
    clr     ZH                  ; ZH = 0, ZL содержит цифру 0...9
    subi    ZL, low(-(cross_array * 2))
    sbci    ZH, high(-(cross_array * 2))
    lpm                         ; результат помещается в r0
    ret

;-*********************************************************************************************-
						; Массив знакогенератора		Данный массив выбирается в ручную по таблице
						; в зависимости от испльзуемого индикатора
;-*********************************************************************************************-
cross_array:   .db    $30,$31,$32,$33,$34,$35,$36,$37,$38,$39








;========================================================================================================================
						; БЛОК умножения
;========================================================================================================================
mult:
	ldi 	divtm3,16					; divnt1:divnt2 - первый множитель, сюда же помещаем произведение
	clr		divtm2						; divsr1:divsr2 - второй множитель
	clr		divtm1						; divtm1:divtm2, counter - временные регистры
multl:
	lsl		divtm2
	rol		divtm1
	lsl		divnt2
	rol 	divnt1
	brcc 	mults 
	add		divtm2,divsr2
	adc		divtm1,divsr1
mults:
	dec 	divtm3
	brne 	multl
	mov 	divnt1,divtm1
	mov 	divnt2,divtm2
	ret	
;========================================================================================================================
calk:
	clr		divnt1
	mov		divnt2,temp
	clr		divsr1						; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  				; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp					; В нижний регистр делителя помещаем число на которое делим
	rcall	div							; Включаем подпрограмму деления
	mov		r30,divtm2			
	rcall	preobraz
	ret
;========================================================================================================================	
						; Блок чтения ЕЕПРОМ по указанному адресу
;========================================================================================================================	
read_eprom:				
	sbic	EECR, EEWE					; Если EEWE не лог. 0, то
	rjmp	PC-1						; ждать дальше
	clr		temp						; Старший байт адреса чтения EEPROM - 
	out		EEARH,temp					; в регистр адреса
	out		EEARL,adres_data			; в регистр младшего адреса 
	sbi		EECR,EERE					; Установить разряд EERE – начать процесс чтения.
	in		data,EEDR					; Чтение байта данных
	ret
;========================================================================================================================	
						; Блок записи в ЕЕПРОМ по указанному адресу
;========================================================================================================================
write_eprom:							; запись  времени стабилизации
	sbic	EECR,EEWE					; Если EEWE не лог. 0, то
	rjmp	PC-1						; ждать дальше
	clr		temp						; Старший байт адреса чтения EEPROM - 
	out		EEARH,temp					; в регистр адреса
	out		EEARL,adres_data			; в регистр младшего адреса 
	out		EEDR,data					; Байт данных - в регистр данных 
	sbi		EECR,EEMWE					; Разряд EEMWE разрешает программирование
	sbi		EECR,EEWE					; Разряд EEWE установлен: начало программирования
	ret
;----------------------------------------------------------------------------------
;*****  ;- ИЗМЕРЕНИЕ НАПРЯЖЕНИЯ	****************************************************************************************
;----------------------------------------------------------------------------------
izmerenie_U:
	clr		Adw0
	clr		Adw1
	ldi		cnt0,Low(1024)
	ldi		cnt1,High(1024)  				; готовим АСП
	clr		MW0
	clr		MW1
	clr		MW2
	ldi		temp,0b01000000					; ножка асп - 0
	out		ADMUX,temp
ACP_preobrazovanie:							; формула ADC=Vin*1024/Vref
	ldi		temp,(1<<ADEN)|(1<<ADSC)|(0<<ADATE)|(0<<ADIF)|(0<<ADIE)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)				; 
;ADEN - разрешение работы АЦП
;ADSC - запуск преобразования  АЦП
;ADATE - автоматический перезапуск АЦП
;ADIF - флаг прерывания АЦП после преобразования становится 1
;ADIE - разрешение прерывания АЦП
;ADPS2 - ADPS0 -управление  предделителем АЦП
	out 	ADCSRA,temp
;======================================
izmerenie2:
	rcall	Delay_150mkc
	in		temp,ADCSRA
	sbrc 	temp,ADSC						; ждем пока он не станет 0
	rjmp 	izmerenie2
	in		Adw0,ADCL						; Забираем показания
	in		Adw1,ADCh
	clr		temp
	add		MW0,Adw0
	adc		MW1,Adw1
	adc		MW2,temp
	subi	Cnt0,1
	sbci	Cnt1,0
	brsh	ACP_preobrazovanie

	Lsr		MW2
	Ror		MW1
	Lsr		MW2
	Ror		MW1

	mov		divnt1,MW2
	mov		divnt2,MW1

; y=0.3842x+66.1208
	clr		divsr1
	ldi		temp,38
	mov 	divsr2,temp
	rcall	mult
	clr		divsr1
	ldi		temp,100
	mov 	divsr2,temp
	rcall	div
	mov		temp,divnt2
	subi	temp,-70
	mov		divnt2,temp
	sts		napryj_kontr,divnt2				; Сохраняем измеренное напряение для контроля.
	mov		temp,divnt2
	cpi		temp,75
	brsh	calk_u							; обнуляем напряжение, если менше 50 вольт 
	clr		divnt1
	clr		divnt2
calk_u:
	clr		divsr1							; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  					; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp						; В нижний регистр делителя помещаем число на которое делим
	rcall	div								; Включаем подпрограмму деления
	mov		r30,divtm2			
	rcall	preobraz
	sts		U1_3,r0
	rcall	div							; Включаем подпрограмму деления
	mov		r30,divtm2			
	rcall	preobraz			
	sts		U1_2,r0
	rcall	div							; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	rcall	preobraz			
	sts		U1_1,r0
	ret
;========================================================================================================================	
								; таймеры
;========================================================================================================================
Delay_3sec:
	ldi		Yl,low(3000)				; 1000 миллисекун
	ldi		YH,high(3000)
	rjmp	Delay_1_loop

Delay_2sec:
	ldi		Yl,low(2000)				; 1000 миллисекун
	ldi		YH,high(2000)
	rjmp	Delay_1_loop


Delay_1sec:

;	rcall	out_data

;	rcall	kontr_ring

	ldi		Yl,low(1000)				; 1000 миллисекун
	ldi		YH,high(1000)
	rjmp	Delay_1_loop
Delay_05sec:							; 500 миллисекун
	ldi		Yl,low(500)
	ldi		YH,high(500)
	rjmp	Delay_1_loop
Delay_025sec:							; 500 миллисекун
	ldi		Yl,low(250)
	ldi		YH,high(250)
	rjmp	Delay_1_loop
Delay_005sec:							; 50 миллисекунда 
	ldi		Yl,low(50)
	ldi		YH,high(50)
;-------------------------------------------------
Delay_1_loop:							; 1 миллисекунда 
	rcall	Delay_1000mkc
	sbiw	YL,1				
	brne	Delay_1_loop
	ret
;-------------------------------------------------
Delay_1000mkc:
	ldi		Xl,low(1000-4)
	ldi		XH,high(1000-4)
	rjmp	delay_1
Delay_500mkc:
	ldi		Xl,low(500-4)
	ldi		XH,high(500-4)
	rjmp	delay_1
Delay_150mkc:
	ldi		Xl,low(150-4)
	ldi		XH,high(150-4)
;-------------------------------------------------
delay_1:
	in		tmp,SREG
	push	tmp
delay_loop:
	sbiw	XL,1						; 2 такта
	brne	delay_loop					; 2 такта
	pop		tmp
	out		SREG,tmp
	ret									; Выходим из подпрограммы :4 такта + 3 такта (RCALL)
;-------------------------------------------------





;-*********************************************************************************************-
; команды для работы с датчиком DS1820
;-*********************************************************************************************-

.equ	CMD_SEARCH_ROM 		= 0xF0	; поиск адресов всех устройств по спецалгоритму
.equ	CMD_READ_ROM 		= 0x33		; считываение адреса единственного устройства
.equ	CMD_MATCH_ROM 		= 0x55	; активация конкретного устройства по его адресу
.equ	CMD_SKIP_ROM 		= 0xCC 	; обращение к единственному на шине устройству без указания его адреса
.equ	CMD_ALARM_SEARCH 	= 0xEC	; поиск устройств, у которых сработал ALARM (алгоритм поиска как у CMD_SERCH_ROM)
.equ	CMD_CONVERT_T 		= 0x44	; старт преобразования температуры
.equ	CMD_W_SCRATCHPAD 	= 0x4E	; запись во внутренний буфер (регистры)
.equ	CMD_R_SCRATCHPAD 	= 0xBE	; чтение внутреннего буфера (регистров)
.equ	CMD_C_SCRATCHPAD 	= 0x48	; сохранение регистров в EEPROM 
.equ	CMD_RECALL_EE 		= 0xB8	; заносит в буфер из EEPROM значение порога ALARM
.equ	CMD_READ_POWER 		= 0xB4	; определение, есть ли в шине устройства с паразитным питанием

;-*********************************************************************************************-
;Макросы датчика температуры
;-*********************************************************************************************-
.macro	PortA_Zero
	sbi		ddrA,dallas				; Включаем подтягивающий резистор
	cbi		portA,dallas			; Выстовляем на входе ключа 0
.endm								; Выходим из макроса (выполняется за 4 цикла)
; -===============
.macro PortA_One
	cbi		ddrA,dallas				; Выключаем подтягивающий резистор
	cbi		portA,dallas			; Выстовляем на входе ключа 0
.endm								; Выходим из макроса  (выполняется за 4 цикла)
; -===============
.macro PortA_Input					; ПРАВЕРКА ВЫХОДА КЛЮЧА НА 0 ИЛИ 1, взависимости от этого управляем флагом переноса
	cbi		ddrA,dallas				; Выключаем подтягивающий резистор
	sec								; Установить флаг переноса	
	sbis	pinA,dallas				; если 0
	clc								; тогда очистить флаг переноса
.endm
;-*********************************************************************************************-
;Поиск и чтение найденных датчиков температуры
;-*********************************************************************************************-

Read_T_all:

	rcall	OWClearROM_NO 			; Обнуляем буфер кода пзу
	rcall	OWFirst 				; ищем первое устройство на шине
	sbrs	search_flags,search_result ; если ошибка, то поиск прерываем
	rjmp	ret_ret_0
loop_T:

	rcall	Read_Temper				; измеряем температуру конкретного датчика
	rcall	calk_display			; Вывод на диспей

	rcall	OWNext 					; ищем следующее устройство. Буфер очищать нельзя!
	sbrs	search_flags,search_result ; если ошибка, то поиск прерываем
	rjmp	ret_ret
	rjmp	loop_T 





ret_ret_0:
	ldi		temp,10
	clr		divnt1
	mov		divnt2,temp
	rcall	ind_1
	ldi		temp,10
	clr		divnt1
	mov		divnt2,temp
	rcall	ind_2
	ldi		temp,10
	clr		divnt1
	mov		divnt2,temp
	rcall	ind_3
ret_ret:
	ldi		temp,1
	sts		n_displ,temp
	ret


;-*********************************************************************************************-
;Распределение показаний датчиков по своим дисплеям
;-*********************************************************************************************-
calk_display:
	lds		temp,n_displ
	cpi		temp,1
	breq	ind_1
	lds		temp,n_displ
	cpi		temp,2
	breq	ind_2
	lds		temp,n_displ
	cpi		temp,3
	breq	calk_display_0
	rjmp	ind_3
calk_display_0:
	ret

;----------------------------------------------
ind_1:;куб 
	sts		temper_hs,divnt1			; Сохраняем результат измерения для контроля температуры в кубе
	sts		temper_ls,divnt2
	clr		divsr1				; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  		; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp			; В нижний регистр делителя помещаем число на которое делим
	call	div					; Включаем подпрограмму деления
	mov		r30,divtm2			
	call	preobraz
	sts		T1_3,r0
	sts		T_contr_s,divnt2
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T1_2,r0
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T1_1,r0
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T1_0,r0
	ldi		temp,2
	sts		n_displ,temp

	ret

;----------------------------------------------
ind_2: ;дефлегматор

	clr		divsr1				; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  		; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp			; В нижний регистр делителя помещаем число на которое делим
	call	div					; Включаем подпрограмму деления
	mov		r30,divtm2			
	call	preobraz
	sts		T3_3,r0
	sts		T_contr_d,divnt2
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T3_2,r0
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T3_1,r0
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T3_0,r0
	ldi		temp,3
	sts		n_displ,temp
	ret


;----------------------------------------------
ind_3: ;царга


	sts		T_contr_o_h,divnt1			; Сохраняем результат измерения для контроля температуры в узле отбора
	sts		T_contr_o_l,divnt2
	clr		divsr1				; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  		; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp			; В нижний регистр делителя помещаем число на которое делим
	call	div					; Включаем подпрограмму деления
	mov		r30,divtm2			
	call	preobraz
	sts		T2_3,r0
	sts		T_contr_o,divnt2
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T2_2,r0
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T2_1,r0
	call	div					; Результат после первого деления на 10, опять делим на 10
	mov		r30,divtm2			
	call	preobraz
	sts		T2_0,r0
	;	Значение 4 сообщает Read_T_all,
    ; что три требуемых датчика уже прочитаны.
    ldi temp, 4
    sts n_displ, temp
    ret
	ret
;========================================================================================================================
; Чтение температуры со всех поключенных датчиков
;========================================================================================================================
Read_Temper:
	rcall	Read_DS				; Чтение температуры
	mov		temp,divnt1			; Переписываем данные старшего разряда показантй температуры
	cbr		temp,0b00001111		; Стереть старшие 4 бита
	ldi		divtm3,0b11110000	; Пишим число с которым будем сравнивать
	cpse	temp,divtm3			; Сравниваем, если в старшем разряде присутствует 1 след команду пропускаем
	rjmp	Temp_plus			; Нет, 1 отсутствует,идем считать положительную температуру 
	mov		divtm3,divnt1		; Да, 1 присутствует - температура отрицательная,пишим результаты во временные регистры 
	mov		temp,divnt2			; ,пишим результаты во временные регистры
	ser		xl					; Пишим число $FFFF (65535) , в пару регистров
 	ser		yl
    sub    	yl,temp 			; Вычесть младший байт
    sbc    	xl,divtm3 			; Вычесть старший байт с переносом
	mov 	divnt1,xl			; Переписываем остатки из временных регистров во множимое
	inc		yl
	mov 	divnt2,yl
;	ldi		temp,10
;	sts		digits+5,temp
	rjmp	Temp_minus
Temp_plus:
;	ldi		temp,12
;	sts		digits+5,temp		; знак минус 
Temp_minus:
	clr		divsr1				; 
	ldi		temp,25				; Умножаем показания на 5 
	mov		divsr2,temp
	call	mult
	clr		divsr1				; 
	ldi		temp,4				; делим на 8
	mov		divsr2,temp
	call	div					; ПОЛУЧИЛИ РЕЗУЛЬТАТ ТЕМПЕРАТУРЫ С ДЕСЯТОЙ ДОЛЕЙ
	clr		divsr1				; Обнуляем верхний регистр делителя т.к. число делителя меньше FF
	ldi		temp,10		  		; Делим результат на 10 и остаток помещаем в соответствующие регистры
	mov 	divsr2,temp			; В нижний регистр делителя помещаем число на которое делим
	call	div					; Включаем подпрограмму деления
	ret

;========================================================================================================================
; Чтение температуры с конкретного датчика
;========================================================================================================================



Read_DS:
;**************** подготовка конкретного датчика к выдаче температуры ;****************
	rcall	OW_Reset						; Reset
	ldi 	temp,0x55						; (55) обращение к конкретному датчику
	rcall	Tr_Byte							; передача команды
	rcall	cod_DS							; Передаем код конкретного датчика	
	ldi		temp,0x44						;  (44) старт преобразования температуры
	rcall	Tr_Byte							; передача команды
;**************** чтение температуры конкретного датчика ;****************								
	rcall	OW_Reset						; Reset 
	ldi 	temp,0x55						; (55) обращение к конкретному датчику
	rcall 	Tr_Byte
	rcall	cod_DS							; Передаем код конкретного датчика
	ldi		temp,0xBE						;  (BE) чтение внутреннего буфера (регистров)
	rcall	Tr_Byte							; передача команды					
	rcall	Rx_Byte							; Read
	mov		divnt2,temp						; Записать в СОЗУ по адресу 61
	rcall	Rx_Byte							; Read
	mov		divnt1,temp						; Записать в СОЗУ по адресу 60
	ret










;**************** Передаем код конкретного датчика	****************
cod_DS:
	lds		temp,ROM_NO
	rcall 	Tr_Byte
	lds		temp,ROM_NO+1
	rcall 	Tr_Byte
	lds		temp,ROM_NO+2
	rcall 	Tr_Byte
	lds		temp,ROM_NO+3
	rcall 	Tr_Byte
	lds		temp,ROM_NO+4					; передаем код датчика, который будем считывать
	rcall 	Tr_Byte
	lds		temp,ROM_NO+5
	rcall 	Tr_Byte
	lds		temp,ROM_NO+6
	rcall 	Tr_Byte
	lds		temp,ROM_NO+7
	rcall 	Tr_Byte
	ret
;**************** сброс DS18B20 ****************
OW_Reset:
	PortA_Zero
	rcall	Delay_500mkcT
	PortA_One
	rcall	Delay_50mkcT
	PortA_Input
	rcall	Delay_500mkcT	
	ret

;**************** передача бита датчику ****************
Tr_Bit:
;	cli
	brcs	Tr_Bit0						; Если флаг переноса установлен, уходим на Tr_1
	PortA_Zero
	clz
	rcall	Delay_68mkcT					;	
	PortA_One
	clz
	rcall	Delay_5mkcT					;	
;	sei
	ret
;----------------------------------------------
Tr_Bit0:
;	cli
	PortA_Zero
	clz
	rcall	Delay_5mkcT					;	
	PortA_One
	clz
	rcall	Delay_68mkcT		
;	sei
	ret
;**************** передача байта датчику ****************

Tr_Byte:
	clc									; Очищаем флаг переноса
	PortA_One							; Обнуляем вход ключа
	ldi		divtm3,0x08					; Записываем число 8 в счетчик
Transmit_next:							; метка
	ror		temp							; Двигаем значение регистра в право через перенос!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	rcall	Tr_Bit						; Процедура ??????????
	rcall	Delay_68mkcT					; Задержка 68 мс
	clz									; Очищаем флаг нулевого значения
	dec		divtm3						; Уменьшаем счетчик на 1
	brne	Transmit_next				; Если не 0 повторяем еще раз 
	PortA_One							; Обнуляем вход ключа
	ret									; Выходим 






;**************** чтение бита с датчика ****************
Rx_Bit:
;	cli
	PortA_Zero							; Начало тайм-слота
	rcall Delay_5mkcT
	PortA_One							; Устанавливаем единицу, что бы ус-во могло передать инф.
	rcall Delay_5mkcT
	PortA_Input						; Считываем инф. на 15-16 мкс.
	rcall Delay_50mkcT					; окончание таймслота через 70 мкс.
;	sei
	ret	
;**************** чтение байта с датчика ****************
Rx_Byte:

	ldi		divtm3,0x08					;
Recieve_next:							;
	rcall	Rx_Bit
	ror		temp						; Двигаем значение регистра в право через перенос!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	dec		divtm3						;
	brne	Recieve_next				;

	ret






Delay_800mkcT:
	ldi		Xl,low(800-4)
	ldi		XH,high(800-4)
	rjmp	delay_1T
Delay_500mkcT:
	ldi		Xl,low(500-4)
	ldi		XH,high(500-4)
	rjmp	delay_1T
Delay_68mkcT:
	ldi		Xl,low(68-4)
	ldi		XH,high(68-4)
	rjmp	delay_1T
Delay_50mkcT:
	ldi		Xl,low(50-4)
	ldi		XH,high(50-4)
	rjmp	delay_1T
Delay_55mkcT:
	ldi		Xl,low(55-4)
	ldi		XH,high(55-4)
	rjmp	delay_1T
Delay_9mkcT:
	ldi		Xl,low(9-4)
	ldi		XH,high(9-4)
	rjmp	delay_1T
Delay_5mkcT:
	ldi		Xl,low(5-4)
	ldi		XH,high(5-4)
	rjmp	delay_1T

delay_1T:
	in		tmp,SREG
	push	tmp

delay_loopT:
	wdr	
	sbiw	XL,1						;  	:2 такта
	brne	delay_loopT					; 	:2 такта
	pop		tmp
	out		SREG,tmp
	ret									; Выходим из подпрограммы :4 такта + 3 такта (RCALL)






;***********************************************************************************
; Поиск устройств на шине 1-Wire
; Оригинал: Application Note 187. 1-Wire Search Algorithm by Dallas, С code
; портировано на ассемблер: StarXXX, http://hardisoft.ru (c) 2009
;***********************************************************************************
; Порядок использования:
;	1) Очистить ROM_NO вызовом подпрограммы OWClearROM_NO
;	2) Произвести первый поиск вызовом подпрограммы OWFirst
;	3) если флаг search_result в регистре search_flags = 1 тогда сохранить 
;		найденный код ПЗУ из ROM_NO, произвести следующий поиск вызовом 
;		подпрограммы OWNext и перейти к пункту 3
;
; Используемые регистры: temp, divtm3, r20 (search_flags)
;
; 
; Поиск использует внешние подпрограммы:
;
;	OWReset - Выполняет сброс линии 1-Wire, принимает от устройств импульс
;			присутствия PRESENCE. После вызова этой процедуры в флаге Т регистра 
;			SREG содержится бит присутствия: 1 - если на шине нет устройств, 
;			0 - если есть
;
;	OWWriteByte - Эта процедура отправляет 1 байт в линию 1-Wire. Отправляемый 
;			байт должен быть помещен в регистр temp
;	
;	OWReadBit - Эта процедура читает 1 бит из линии 1-Wire. Принятый бит 
;			помещается в флаг С регистра SREG
;
;	OWWriteBit - Эта процедура отправляет 1 бит в линию 1-Wire. Отправляемый 
;			бит должен быть помещен в флаг С регистра SREG
;
;***********************************************************************************
; Флаги
.equ		search_result		= 0
.equ		search_direction 	= 1
.equ		LastDeviceFlag		= 2

;------------------------------------------------------------------------------
; Поиск первого устройства на шине
;------------------------------------------------------------------------------
OWFirst:
    ; обнуление переменных
	clr		temp
	sts		LastDiscrepancy, temp
	sts		LastFamilyDiscrepancy, temp
	sts		stored_search_flags, temp
   	rcall 	OWNext
	ret
;------------------------------------------------------------------------------
; Поиск следующего устройства на шине
;------------------------------------------------------------------------------
OWNext:
	lds		search_flags,stored_search_flags	; Восстанавливаем флаги предыдущего поиска
   	clr 	temp
   	sts 	last_zero,temp						; last_zero = 0
   	sts 	rom_byte_number,temp				; rom_byte_number = 0
   	sts 	crc8, temp							; crc8 = 0
   	inc 	temp
   	sts 	id_bit_number,temp					; id_bit_number = 1
   	sts 	rom_byte_mask,temp					; rom_byte_mask = 1
	cbr		search_flags,1<<search_result		; очищаем бит в регистре
	sbrc	search_flags,LastDeviceFlag			; Это было последнее устройство?
	rjmp 	OWSItWasLastDevice					; Да - переходим на OWSItWasLastDevice
OWS_Reset:										; Сброс линии и проверка присутствия
	rcall 	OW_Reset							; сброс DS18B20
	brcc 	OWSResetOK
; Никого нет? Тогда выходим
	clr 	temp
	sts 	LastDiscrepancy,temp				; LastDiscrepancy = 0;
	sts 	LastFamilyDiscrepancy,temp			; LastFamilyDiscrepancy = 0;
	cbr		search_flags,1<<LastDeviceFlag		; LastDeviceFlag = FALSE;
	cbr		search_flags,1<<search_result		; return FALSE;
	rjmp	OWN_Return
OWSResetOK:
	ldi 	temp, 0xF0							; Посылаем команду поиска (0F)
	rcall 	Tr_Byte
OWS_do:											; Основной цикл поиска
	clr 	temp
	clr 	divtm3
	sbr		search_flags,1<<search_direction	; Сразу поставим search_direction=1, потом если что - сбросим
	rcall 	Rx_Bit								; читаем id_bit -> C
	rol 	temp									; из флага C в нулевой бит temp
	rcall 	Rx_Bit								; читаем cmp_id_bit -> C
	rol 	divtm3									; из флага C в нулевой бит divtm3
	tst 	temp
	breq 	OWS_do_1_0
	tst 	divtm3
	breq 	OWS_do_1_1
	rjmp 	OWS_do_break						; id_bit = 1 и cmp_id_bit = 1 - на линии нет устройств!
OWS_do_1_0:
	cbr		search_flags,1<<search_direction	; search_direction пока повторяет id_bit
OWS_do_1_1:										;  если id_bit не равен cmp_id_bit, тогда search_direction = id_bit
	cp 		temp,divtm3
	brne 	OWS_do_2
; Иначе - биты равны, тогда search_direction будет зависеть от id_bit_number и LastDiscrepancy
	sbr		search_flags,1<<search_direction	; установим пока search_direction = 1
	lds 	temp,id_bit_number					; загружаем для проверки id_bit_number и LastDiscrepancy
	lds		divtm3,LastDiscrepancy
	cp 		temp, divtm3							; сравниваем
	breq	BitsEqual_End						; id_bit_number = LastDiscrepancy, значит оставляем search_direction = 1
	brcc	OWS_do_BitsEqual_else				; id_bit_number > LastDiscrepancy, значит установим search_direction = 0
; иначе id_bit_number < LastDiscrepancy, а это значит, что search_direction будет равен
; значению текущего бита в ROM_NO

	rcall	Calc_ROM_NO							; Получаем указатель на ROM_NO[rom_byte_number]
	ld		temp, y								; Получили в temp ROM_NO[rom_byte_number]
	lds		divtm3,rom_byte_mask					; Делаем ROM_NO[rom_byte_number] AND rom_byte_mask
	and		temp,divtm3
	brne	BitsEqual_End						; если после AND результат не нулевой, то оставим search_direction = 1
	cbr		search_flags,1<<search_direction	; иначе переключим search_direction в 0
	rjmp 	BitsEqual_End
OWS_do_BitsEqual_else:							; id_bit_number = LastDiscrepancy, значит оставляем search_direction = 1
	cbr		search_flags,1<<search_direction
BitsEqual_End:
	sbrc	search_flags,search_direction		; если search_direction = 0,
	rjmp 	OWS_do_2
	lds 	temp, id_bit_number					; тогда last_zero = id_bit_number
	sts 	last_zero, temp
; проверка последнего различия в коде семейства.
	cpi 	temp,9								; Если last_zero < 9
	brcc 	OWS_do_2
	sts 	LastFamilyDiscrepancy,temp  		; тогда LastFamilyDiscrepancy = last_zero;
OWS_do_2:
	rcall	Calc_ROM_NO							; Получаем указатель на ROM_NO[rom_byte_number]
; Устанавливаем или сбрасываем бит в позиции rom_byte_mask байта rom_byte_number
; в зависимости от search_direction
	sbrs	search_flags,search_direction		;если search_direction = 1
	rjmp	OWS_do_2_1
; Тогда, устанавливаем бит в 1: ROM_NO[rom_byte_number] = ROM_NO[rom_byte_number] OR rom_byte_mask;
	ld 		temp,y								; Получили в temp ROM_NO[rom_byte_number]
	lds		divtm3,rom_byte_mask					; получили в divtm3 rom_byte_mask
	or 		temp, divtm3							; сделали ROM_NO[rom_byte_number] OR rom_byte_mask
	rjmp 	OWS_do_2_2
OWS_do_2_1:										
; иначе search_direction = 1
; Тогда сбрасываем бит в 0: ROM_NO[rom_byte_number] = ROM_NO[rom_byte_number] AND (rom_byte_mask XOR FF);
	lds		divtm3,rom_byte_mask					; получили в divtm3 rom_byte_mask
	ldi		temp,0xFF
	EOR		divtm3,temp							; инвертировали divtm3
	ld 		temp,y								; Получили в temp ROM_NO[rom_byte_number]
	AND		temp,divtm3							; сделали ROM_NO[rom_byte_number] AND (rom_byte_mask XOR FF)
OWS_do_2_2:
	ST 		y, temp								; записали назад в ROM_NO[rom_byte_number]
	sec											; отсылаем бит search_direction в шину, чтобы заткнуть те устройства, у которых этот бит не такой
	sbrs	search_flags,search_direction		
	clc
	rcall 	Tr_Bit							
	lds 	temp, id_bit_number					; id_bit_number++;
	inc 	temp
	sts 	id_bit_number, temp
	lds 	temp, rom_byte_mask					; Сдвигаем влево rom_byte_mask на 1 бит
	lsl 	temp
	sts 	rom_byte_mask, temp
	brne 	OWS_do_end							; если еще не все биты в текущем байте прошли - то бегом на следующую итерацию цикла поиска
; иначе добавляем CRC этого байта в общее CRC
	rcall	Calc_ROM_NO							; Получаем указатель на ROM_NO[rom_byte_number]
	ld		temp, y								; Получили в temp ROM_NO[rom_byte_number]
	rcall 	docrc8								; CRC готова
	lds 	temp, rom_byte_number				; rom_byte_number = rom_byte_number+1;
	inc 	temp
	sts 	rom_byte_number, temp
	ldi 	temp, 1								; Сбрасываем битовую маску в 1
	sts 	rom_byte_mask, temp
OWS_do_end:										; Крутим цикл пока rom_byte_number < 8
	lds 	temp, rom_byte_number
	cpi 	temp, 8
	brcc 	OWS_do_break
	rjmp 	OWS_do
; если поиск прошел успешно, тогда id_bit_number будет больше 64 и crc8 будет равна 0
OWS_do_break:
	lds 	temp,id_bit_number
	cpi 	temp,65
	brcc 	OWS_bo_break_0
	rjmp 	OWSItWasLastDevice					; id_bit_number < 65, ошибка!
OWS_bo_break_0:
	lds 	temp,crc8
	tst 	temp
	breq 	OWS_bo_break_00
	rjmp 	OWSItWasLastDevice					; crc8 не равно 0, ошибка!
OWS_bo_break_00:
; Поиск удался, установим флаги и переменные
	lds 	temp,last_zero						; LastDiscrepancy = last_zero;
	sts 	LastDiscrepancy,temp
	tst		temp									; если LastDiscrepancy = 0
	brne 	OWS_do_break_1
	sbr		search_flags,1<<LastDeviceFlag		; то это был последний девайс на линии, LastDeviceFlag = 1
OWS_do_break_1:
	lds		temp, LastFamilyDiscrepancy
	lds		divtm3, LastDiscrepancy
	cp		temp,divtm3								; если LastFamilyDiscrepancy == LastDiscrepancy
	brne	OWS_do_break_2
	clr 	temp
	sts		LastFamilyDiscrepancy,temp			; то LastFamilyDiscrepancy = 0
OWS_do_break_2:
	sbr		search_flags,1<<search_result		; search_result = 1, ура, все ОК!
	rjmp	OWN_Return
OWSItWasLastDevice:
	sbrc	search_flags,search_result			; если search_result = 0
	rjmp	OWN_Return
	lds		temp,ROM_NO
	tst 	temp
	brne 	OWN_Return
; Тогда сбрасываем флаги и переменные так, чтобы следующий вызов этой подпрограммы был равносилем вызову OWFirst
	cbr		search_flags,LastDeviceFlag		; LastDeviceFlag = 0
	clr 	temp
	sts 	LastDiscrepancy, temp				; LastDiscrepancy = 0	
	sts 	LastFamilyDiscrepancy,temp			; LastFamilyDiscrepancy = 0
	cbr		search_flags,1<<search_result		; search_result = 0
OWN_Return:
	sts		stored_search_flags,search_flags	; Сохраняем флаги для следующего поиска
	ret
;*********************************************************************		
; 	Вычисляем указатель на ROM_NO[rom_byte_number]
;*********************************************************************		
calc_ROM_NO:
	ldi		yh,high(ROM_NO)					; указатель на ROM_NO
	ldi		yl,low (ROM_NO)
	lds		temp,rom_byte_number				; прибавляем к нему rom_byte_number
	clr		divtm3
	add		yl,temp
	adc		yh,divtm3
	ret
;*********************************************************************		
;   Очистка буфера ROM_NO
;*********************************************************************		
OWClearROM_NO:
	ldi yh,high(ROM_NO)			; указатель на ROM_NO
	ldi yl,low (ROM_NO)
	ldi temp,8
	clr divtm3
OWCRN:
	st y+,divtm3
	dec temp
	brne OWCRN
	ret
;*********************************************************************		
;   выполняет подсчет CRC по алгоритму 1-Wire
; 	вход: temp - считанный байт
; 	выход: CRC - содержит подсчитанную сумму
; 	портит: регистр Z
; 	примечание: перед первым вызовом CRC необходимо обнулить
;*********************************************************************		
docrc8:
	lds		divtm3,CRC8
	eor		temp,divtm3
	
	ldi		ZH,high(CRCtable)
	ldi		ZL,low(CRCtable)
	clc
	rol		ZL
	rol		ZH
	add		ZL,temp
	ldi		divtm3,0
	adc		ZH,divtm3
	lpm		temp,z
	sts		CRC8,temp
	ret
;*********************************************************************		
; таблица сигнатур для быстрого расчета контрольной суммы CRC-8
;*********************************************************************		
CRCtable:

	.db		0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65
	.db 	157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220
	.db 	35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98
	.db 	190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255
	.db 	70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7
	.db 	219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154
	.db 	101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36
	.db 	248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185
	.db 	140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147,205
	.db 	17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80
	.db 	175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238
	.db 	50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115
	.db 	202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139
	.db 	87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22
	.db 	233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168
	.db 	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
;*********************************************************************		
; Переменные, необходимые для работы процедуры поиска
;*********************************************************************		
.dseg

stored_search_flags:	.db	0
id_bit_number: 			.db 0
rom_byte_number:		.db 0
rom_byte_mask:			.db 0
last_zero:				.db 0
LastDiscrepancy:		.db 0
LastFamilyDiscrepancy:	.db 0
crc8:					.db 0


ROM_NO:					.byte 8
n_displ:				.byte 1

.cseg








;-------------------------------------------------------------------------------------------------------------------------------------
;.INCLUDE "gsm.asm"
;-------------------------------------------------------------------------------------------------------------------------------------
;.INCLUDE "eeprom.asm"
;-------------------------------------------------------------------------------------------------------------------------------------



;=========================================================================================================================================
;.INCLUDE "distillyciy.asm"
;=========================================================================================================================================
;.INCLUDE "rektifikaciy.asm"
;=========================================================================================================================================
;.INCLUDE "text_inglish.asm"		
;========================================================================================================================
;.INCLUDE "meny_rekt_dist.asm"
;========================================================================================================================
;========================================================================================================================
;.INCLUDE "procedurs.asm"
;========================================================================================================================
;.INCLUDE "Ds18b20_all.asm"	
;========================================================================================================================







;.INCLUDE "nastr_receptov_z.asm"
;========================================================================================================================
;.INCLUDE "zatiranie.asm"	
;========================================================================================================================
;========================================================================================================================
;.INCLUDE "meny_avtoklav.asm"	
;========================================================================================================================
;.INCLUDE "avtoklav.asm"	
;========================================================================================================================
	

;.INCLUDE "baza.asm"




;.INCLUDE "baza_rus.asm"


















myso:.db						"   recept mysa    ",0,0

riba:.db						"   recept raba    ",0,0

ovoshi:.db						"   recept ovosi   ",0,0

nastroyka_r:.db 				"nastr recepta N",0				; НАСТРОЙКА РЕЦЕПТА

stop_zat:.db					"zatirka zakonchena",0,0

nagrev_do:.db					"nagrev do ",0,0

z_solov:.db 					" zasipte solod  ",0,0			; засыпте солод

zatirka:.db 					"zatirka ",0,0					; затирка

varka:.db 						"varka ",0,0					; варка

cuba:.db						" kuba",0

nagrev_:.db 					 "T norma ",0,0

pivovaren:.db 					"  pivovarenie   ",0,0

niomer_pr:.db 			     	"Prog-",0

temperatura:.db				 	"temperatura=",0,0

nastroykaT:.db					 " nastroyka T",0,0

nastroykaP:.db					 " nastroyka P",0,0

minut:.db 						 " minut ",0

pauza:.db 						 "pauza  ",0

avtoklav:.db 				 	"    AVTOKLAV     ",0


;========================================================================================================================
;========================================================================================================================

nomer_tlf:.db					 "vah nomer telef?",0,0

komand:.db						 "    komanda  ",0

zap_tlf:.db						 "zapishite telef ",0,0


;========================================================================================================================
;========================================================================================================================

d_roz:.db  						"datchik razliva ",0,0   ;датчик разлива 

d_gol:.db  						" datchik golov  ",0,0   ;датчик голов

zvuk:.db 						"      zvuk      ",0,0;    звук

vklychen:.db 					"   vklychen     ",0,0;    включен

otklychen:.db					"   otklychen    ",0,0;    отключен

t_golov1:.db 					"vremy otbora gol",0,0;    время отбора голов 1

t_stab:.db 						"vremy stabilizac",0,0;    время стабилизации

P_otb_gol:.db 					"nastr Pauza gol ",0,0

I_otb_gol:.db 					"nastr Impul gol ",0,0

P_otb_tel_1:.db 					"Pauza tela nom1 ",0,0

I_otb_tela_1:.db 					"Impuls tela nom1",0,0

P_otb_tel_2:.db 					"Pauza tela nom2 ",0,0

I_otb_tela_2:.db 					"Impuls tela nom2",0,0

P_otb_tel_3:.db 					"Pauza tela nom3 ",0,0

I_otb_tela_3:.db 					"Impuls tela nom3",0,0

otb_t:.db						 "otbor tela      ",0,0

otb_t1:.db						 "otbor tela 1    ",0,0

otb_t2:.db						 "otbor tela 2    ",0,0

otb_t3:.db						 "otbor tela 3    ",0,0

push_kn:.db 					"smena rej  + , -",0,0	

nom_rec:.db						"smena rec  + , -",0,0

txt_T_daf:.db 					"nastroyka T dafa",0,0	;     настройка температуры в дефлегматоре на рег U

voda:.db						 "  razlita voda  ",0,0	;     разлита вода 

paus_o:.db						 "Pause otbora N",0,0

sys_res:.db						 "systema reset   ",0,0

otpusmite_pusk:.db 				 "otpustite <PUSK>",0,0

stb:.db							 "  STABILIZACIY  ",0,0

distillyciy:.db 				 "  DISTILLYCIY   ",0,0

najmite_pusk:.db 				 " najmite <PUSK> ",0,0

Utana:.db 						 "U tana =   ",0

razgon_do:.db					 "razgon do       ",0,0

def:.db							 " defl  =",0,0

kub:.db							 " kuba =",0

car:.db							 " carga =",0,0

rektif:.db 						 "  REKTIFIKACIY  ",0,0

otbor_g1:.db 					 "  otbor golov   ",0,0

okonh:.db 						 "okonhaniy ",0,0

okonhe:.db 						 "okonhanie ",0,0

max:.db							 "max ",0,0

regul:.db						 "regulir ",0,0

t_contr:.db						 "t kontroly =",0,0

prirash:.db						 "prirashenie+",0,0

paus:.db						 "pauza SHM=",0,0

sbros:.db						 "sbros SHM =",0

otb_do:.db						 "otbor do =",0,0

napr1:.db						 "napryjenie stab ",0,0

napr3:.db						 "napryjenie razg ",0,0

napr4:.db						 "napryjenie varki",0,0

norma1:.db						 "norma",0

minus:.db						 "minus",0

plys:.db						 "plys ",0

peregr:.db						 "peregrev deflegm",0,0

otb_x:.db						 "otbor hvostov   ",0,0

rabot:.db						 "t rabota ",0

napr2:.db						 "U stabiliz =",0,0

stop:.db						 "  STOP  RABOTA  ",0,0

dly_zpuska:.db 					 "  dly  zapuska  ",0,0

razg_dist:.db 					"razgon distillyc",0,0	;     разгон дистилляции

razg_rekt:.db 					"razgon rektifik ",0,0	;     разгон ректификации

txt_vkl_vod:.db 				"vkl ohlajdeniy  ",0,0	;     вкл охлаждения

txt_alarm:.db 					"     ALARM      ",0,0	;     авария

okonh_d:.db 					"okonchanie distl",0,0	;     окончание дист

okonh_r:.db 					"okonchanie rekt ",0,0	;     окончание ректификации

okonh_t:.db 					"t okoncha= ",0			;     t окончан 

pust:.db 						"                ",0,0	;     пусто 

dlit_pauza:.db 					"dlitelnost pause",0,0	;     длительность паузы

ruchnoe:.db 					"    ruchnoe     ",0,0	;     ручное

avtomat:.db 					"avtomaticheskoe ",0,0	;     автоматическое

nastroyka:.db 					"   nastroyka    ",0,0	;     НАСТРОЙКА

col_p:.db 						"kolichestvo P",0		;     колич-во пауз

contr_Ur:.db 					"regulirovka   U ",0,0	;     регулировка U

t_control:.db 					"taym controly  ",0 	;     время контроля










