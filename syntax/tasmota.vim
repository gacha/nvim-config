""" Vim syntax file
""" Copyright 2023, 2024 N. Radtke
""" License: GPLv2

""" Language:             Tasmota Script
""" Maintainer:           Nils Radtke (nr) <vimsyn@success-in-software.com>
""" Last Change:          2023-06-19

""" TODO: args in parenthesis
"""       identifiers in parenthesis and with math ops
"""       prevent <> from being interpreted as HTML comments

" Prelude {{{1
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Keywords {{{1
syn keyword tsmKeyword IP SB UFILES
syn match tsmKeyword "\k\+="me=e-1
syn match tsmKeyword "\[\k\+\]"ms=s+1,me=e-1
syn match tsmKeyword "=\k\+"ms=s-1
syn match tsmKeyword "^#$"
syn match tsmFunction "^#\k\+.*$"

syn match tsmFunction "^[pt]:"
syn match tsmBraces "[{}\[\]]"
syn match tsmParens "[()]"

syn keyword tsmStatement spinm spin delay beep ceil floor round rad
syn keyword tsmStatement gpwl rnd gvr spi svars sensor print sendmail
syn keyword tsmStatement ws2812 round ceil floor ow f i dt ct wcs
syn keyword tsmStatement wfs wcf wc rap pwm fwp adc pl say slp gc nm
syn keyword tsmStatement tx tm sl ck bu chg pin power
syn keyword tsmRepeat for next break return
syn keyword tsmConditional switch case ends if then else endif and or
syn match tsmSpecial "dp\d\.\d"
syn match tsmSpecial "%\d\k\+%"
syn match tsmSpecial "s("me=e-1
syn match tsmSpecial "st("me=e-1
syn match tsmMathsOperator   "-\|=\|[:<>+\*^/\\]\|and\|or"
syn match tsmFunction "^\s\+=#\k\+"
syn match tsmFunction "^=#\k\+"
syn region tsmString start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
syn region tsmString start=+'+ skip=+\\\\\|\\'+ end=+'\|$+

" NumericVariables {{{1
syn keyword tsmSpecial upsecs uptime time sunrise sunset tper smlj pwr pc tbut sw bt pin pn pd sht gtmp ghum gprs mqttc mqttd npwr http wific wifid mqtts wifis tset heap pheap stack slen freq micros millis loglvl upd
syn keyword tsmSpecial chg tbut enrg sml pow med acos sqrt sin cos sf int mp mpt fo fw fr fc fd fwp fra fwa fwb frb cpf fa fs flx fsm fmd rfd frw frn fz fxt fxto fx fe ts1 ts2 ts3 ts4 tso s2t gjp asc hd hsvrgb hours
syn keyword tsmSpecial mins secs day wday month year eres epoch tinit Temperature Pressure Humidity Distance wtch wdclk wbut wm abs ia ir tper ctper iw so sc sr srb sw swb sra swa smw sa ttget acb cts hf af ains mux
syn keyword tsmSpecial cbs udp i2s tstamp

" SpecialVariables {{{1
syn keyword tsmSpecial tele SENSOR RESULT STATE Wifi RSSI VL53L0X backlog blinkcount blinktime buttondebounce buzzer devgroupname devgroupsend devgroupshare devgroupstatus fanspeed interlock ledmask
syn keyword tsmSpecial ledpower ledpower ledstate power0 power poweronstate pulsetime switchdebounce switchmode webbutton delay deepsleeptime devicename emulation friendlyname gpios gpio gpio i2cscan i2cdriver
syn keyword tsmSpecial loghost logport modules module mqttlog ntpserver otaurl pwmfrequency pwmrange reset restart savedata seriallog sleep state status syslog template time timestd timedst timezone tuyamcu upgrade
syn keyword tsmSpecial upload weblog ap cors hostname ipaddress password ping ssid webcolor webpassword webrefresh websend websensor webserver wificonfig wifipower buttonretain buttontopic fulltopic grouptopic
syn keyword tsmSpecial mqttclient mqttfingerprint mqtthost mqttpassword mqttport mqttretry mqttuser powerretain
syn match tsmSpecial "prefix[1-3]"
syn keyword tsmSpecial publish publish2 sensorretain statetext switchretain subscribe switchtopic teleperiod topic unsubscribe add calcres event mem mult rule ruletimer scale sub var latitude longitude timers timer
syn keyword tsmSpecial adcparam altitude ampres counter counterdebounce counterdebouncelow counterdebouncehigh countertype globalhum globaltemp humoffset humres pressres
syn match tsmSpecial "sensor[10\|13\|15\|18\|20\|27\|29\|34\|50\|52\|53\|54\|60\|68]"
syn keyword tsmSpecial speedunit tempres tempoffset voltres wattres weightres ampres currentcal currenthigh currentlow currentset energyres energyreset freqres frequencyset maxpower maxpowerhold maxpowerwindow
syn keyword tsmSpecial moduleaddress powercal powerdelta powerhigh powerlow powerset status tariff voltagecal voltagehigh voltagelow voltageset voltres wattres channel color ct dimmer dimmer dimmerrange fade
syn keyword tsmSpecial hsbcolor
syn match tsmSpecial "hsbcolor[1-3]"
syn keyword tsmSpecial led ledtable palette pixels rgbwwtable rotation scheme speed wakeup wakeupduration white width devgroupname devgroupsend devgroupshare devgroupstatus sendmail setoption0
syn match tsmSpecial "setoption[1\|3\|4\|8\|10\|11\|12\|13\|15\|16\|17\|18\|19\|20\|21\|24\|26\|28\|29\|30\|31\|32\|33\|34\|36\|37\|38\|39\|40\|41\|42\|43\|51\|52\|\|53\|54\|55\|56\|57\|58\|59\|60\|61\|62\|63\|64\|65\|66\|67\|68\|69\|71\|72\|73\|74\|75\|76\|77\|78\|79\|80\|81\|82\|83\|84\|85\|86\|87\|88\|89\|90\|91\|92\|93]"
syn keyword tsmSpecial baudrate sbaudrate serialconfig serialdelimiter serialsend sserialsend tuyasend rfcode rfhigh rfhost rfkey rflow rfraw rfsync rfsend irsend irhvac display displayaddress displaydimmer
syn keyword tsmSpecial displaymode displaymodel displayrefresh displaysize displayrotate displaytext displaycols displayrows displayfont displaywidth displayheight shutterbutton shuttercalibration
syn keyword tsmSpecial shuttercloseduration shutterclose shutterfrequency shutterenableendstoptime shutterinvert shutterinvertwebbuttons shutterlock shuttermotordelay shutteropenduration shutteropen shutterposition shutterrelay shuttersetclose shuttersetopen shuttersethalfway shutterstop
syn keyword tsmSpecial shutterstopclose shutterstopopen shutterstopposition shutterstoptoggle shuttertoggle zbbind zbconfig zbconfig zbforget zblight zbname zbpermitjoin zbping zbsend zbstatus zbunbind zbmodelid
syn keyword tsmSpecial zbprobe zbread zbreset zbrestore zbsave zbznpsend zbznpreceive hm10scan hm10period hm10baud hm10at hm10time hm10auto nrfpage nrfignore nrfscan nrfbeacon motormis motorspr motorrpm motormove
syn keyword tsmSpecial motorrotate motorturn mp3dac mp3device mp3eq mp3pause mp3play mp3reset mp3stop mp3track mp3volume thermostatmodeset climatemodeset controllermodeset tempfrostprotectset inputswitchset
syn keyword tsmSpecial inputswitchuse sensorinputset outputrelayset timeallowrampupset tempformatset tempmeasuredset temptargetset tempmeasuredgrdread stateemergencyset timemanualtoautoset propbandset timeresetset
syn keyword tsmSpecial timepiproportread timepiintegrread timepicycleset tempantiwindupresetset temphystset timemaxactionset timeminactionset timesenslostset timeminturnoffactionset temprupdeltinset temprupdeltoutset
syn keyword tsmSpecial timerampupmaxset timerampupcycleset temprampuppiaccerrset diagnosticmodeset domoticzidx domoticzkeyidx domoticzsensoridx domoticzswitchidx domoticzupdatetimer knxtx_cmnd knxtx_val knx_enabled
syn keyword tsmSpecial knx_enhanced knx_pa knx_ga knx_ga knx_cb knx_cb

" Numbers {{{1
syn match  tsmNumber          "\<\d\+\>"
syn match  tsmNumber          "\<\d\+\.\d*\>"
syn match  tsmNumber          "\<\d\+\.\d*\>"
syn match  tsmNumber          "\.\d\+\>"

" Keep this last or it will be shadowed
syn match tsmSection "^>\k\+$"

" Highlighting {{{1
hi def link tsmKeyword Keyword
hi def link tsmStatement Statement
hi def link tsmFunction Function
hi def link tsmBraces Function
hi def link tsmParens Function
hi def link tsmComment Comment
hi def link tsmRepeat Repeat
hi def link tsmConditional Conditional
hi def link tsmTodo Todo
hi def link tsmSpecial Special
hi def link tsmString String
hi def link tsmNumber Number
hi tsmSection ctermfg=lightGray guifg=#80a0ff term=bold cterm=bold gui=bold
hi tsmMathsOperator term=bold cterm=bold gui=bold

" Comments {{{1
syn keyword tsmTodo TODO FIXME XXX NOTE contained
syn match tsmComment "^;.*$" contains=tsmTodo
syn match tsmComment "^;.*$" contains=tsmTodo
syn match tsmComment "^\/\/.*"

" Postscript {{{1
let b:current_syntax = 'tasmota'

let &cpo = s:cpo_save
unlet s:cpo_save
