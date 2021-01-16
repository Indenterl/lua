require "lib.moonloader"
require "lib.sampfuncs"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8 
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local key = require 'vkeys'
local sampev = require 'lib.samp.events'

script_name("TSIDE SYSTEM")
script_author("Fernando Cavalli - Vladimir Vinogradov - Mikhail Shcherbakov")
script_description('Press Ctrl + R to reload all lua scripts. Also can be used to load new added scripts')
if script_properties then
	script_properties('work-in-pause', 'forced-reloading-only')
end
require "lib.moonloader"
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- Лазить в код разрешено только создателю скрипта. Не покушайтесь на изменения отыгровок и команд, не присуждайте данный скрипт себе. Жить чужим трудом конечно легче, но не всегда хорошо. (Fernando Cavalli)
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
local one_win = imgui.ImBool(false)

function apply_custom_style()
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		style.WindowRounding = 2.0
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
		style.ChildWindowRounding = 2.0
		style.FrameRounding = 2.0
		style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
		style.ScrollbarSize = 13.0
		style.ScrollbarRounding = 0
		style.GrabMinSize = 8.0
		style.GrabRounding = 1.0
		colors[clr.Text]            		= ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]        	= ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]           		= ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]       	= ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]            		= ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]           		= colors[clr.PopupBg]
		colors[clr.Border]            		= ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]        	= ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg]            		= ImVec4(0.16, 0.29, 0.48, 0.54)
		colors[clr.FrameBgHovered]      	= ImVec4(0.26, 0.59, 0.98, 0.40)
		colors[clr.FrameBgActive]       	= ImVec4(0.26, 0.59, 0.98, 0.67)
		colors[clr.TitleBg]            		= ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]       	= ImVec4(0.16, 0.29, 0.48, 1.00)
		colors[clr.TitleBgCollapsed]   		= ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.MenuBarBg]           	= ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]        		= ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]       	= ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]	= ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive] 	= ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CheckMark]           	= ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.SliderGrab]         		= ImVec4(0.24, 0.52, 0.88, 1.00)
		colors[clr.SliderGrabActive]    	= ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.Button]            		= ImVec4(0.26, 0.59, 0.98, 0.40)
		colors[clr.ButtonHovered]       	= ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.ButtonActive]        	= ImVec4(0.06, 0.53, 0.98, 1.00)
		colors[clr.Header]            		= ImVec4(0.26, 0.59, 0.98, 0.31)
		colors[clr.HeaderHovered]       	= ImVec4(0.26, 0.59, 0.98, 0.80)
		colors[clr.HeaderActive]        	= ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.Separator]           	= colors[clr.Border]
		colors[clr.SeparatorHovered]    	= ImVec4(0.26, 0.59, 0.98, 0.78)
		colors[clr.SeparatorActive]     	= ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.ResizeGrip]          	= ImVec4(0.26, 0.59, 0.98, 0.25)
		colors[clr.ResizeGripHovered]   	= ImVec4(0.26, 0.59, 0.98, 0.67)
		colors[clr.ResizeGripActive]    	= ImVec4(0.26, 0.59, 0.98, 0.95)
		colors[clr.CloseButton]        		= ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]  	= ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]   	= ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]           	= ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]    	= ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]       	= ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]	= ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.TextSelectedBg]      	= ImVec4(0.26, 0.59, 0.98, 0.35)
		colors[clr.ModalWindowDarkening]	= ImVec4(0.80, 0.80, 0.80, 0.35)

	end

	apply_custom_style()

local main_window_state = imgui.ImBool(false)
local car_window = imgui.ImBool(false)
local function_window = imgui.ImBool(false)
local test_text_buffer = imgui.ImBuffer(256)

function imgui.OnDrawFrame()
if one_win.v then
local sw, sh = getScreenResolution()
imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(400, 245), imgui.Cond.FirstUseEver)
imgui.Begin(u8'FBI HELPER', one_win, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
if imgui.Button(u8'                                               Кодексы                                               ') then
function_window.v = not function_window.v
end
if function_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1300, 760), imgui.Cond.FirstUseEver)
imgui.Begin(u8'FBI HELPER: УК/АК BSERVER', function_window)
imgui.Text(u8[[
						ы					Уголовный кодекс Синей Федерации
Глава 1. Физический вред.
1.1 За причинение физического вреда средней или сильной тяжести гражданскому лицу и/или на сотруднику правоохранительных органов 
без применения способствующих для причинения вреда здоровью предметов и/или материалов, подозреваемому присваивается 5-я степень розыска.
1.2 За причинение физического вреда автотранспортом гражданину или сотруднику правоохранительных органов, подозреваемому присваивается 
5-я степень розыска, а также штраф в размере 500$.

Глава 2. Вооруженное нападение и/или убийство.
2.1 За вооруженное нападение на гражданина или на сотрудника правоохранительных органов и/или их убийство, подозреваемому присваивается
6-я степень розыска.

Глава 3. Транспортные средства.
3.1 За попытку угона государственного или частного транспортного средства, подозреваемому присваивается 2-я степень розыска.
3.2 За угон государственного или частного транспортного средства, подозреваемому присваивается 2-я степень розыска.
3.3 За порчу автомобиля гражданского лица, подозреваемому присваивается 1-ая степень розыска.
3.4 За порчу государственного автомобиля, подозреваемому присваивается 2-я степень розыска.
]])
imgui.Text(u8[[
Глава 4. Использование государственного снаряжения.
4.1 За ношение формы гос. служащего, её кражу, незаконное хранение и/или использование в личных целях, подозреваемому присваивается 2-ая степень розыска.
4.2 За продажу или покупку формы гос. служащего и/или иных отличительных знаков гос. служащих, задержанному присваивается 4-ая степень розыска.

Глава 5. Взятка.
5.1 За дачу или попытку дачи взятки должностному лицу, подозреваемому присваивается 4-я степень розыска. (Исключение: спец. операция ФБР)
5.2 За получение взятки должностным лицом, ему присваивается 5-я степень розыска, а также последующее его внесение в Черный Список собственной организации.
 (Исключение: спец. операция ФБР)

Глава 6. Подделка документов.
6.1 За подделку документов, удостоверяющих личность или работу в какой-либо сфере, подозреваемому присваивается 3-я степень розыска, а также накладывается
штрафная санкция в размере 10.000$ за каждый поддельный документ.
]])
imgui.Text(u8[[
Глава 7. Оружие.
7.1 Открытое ношение в пределах города или же в людных местах, прицеливание огнестрельного а так же пневматического, травматического, оружия, или же объекта,
 который схожий с огнестрельным оружием, без цели самообороны или с целью вызвать страх и истерию. Подозреваемому присваивается 2-я степень розыска. 
 Исключение: сотрудники МВД, а также сотрудники МО, находящиеся на военном объекте.
Примечание: Если человек по первому требованию убрал оружие - преступность деяния устраняется.
7.2 Выстрелы из огнестрельного оружия без очевидной надобности. Подозреваемому присваивается 2-я степень розыска.
7.2 За владение огнестрельным, травматическим, пневматическим оружием, не имея на то лицензии, подозреваемому присваивается 4-я степень розыска и 
накладывается штрафная санкция в размере 20.000$.
7.3 За продажу/покупку/хранение нелегально добытого оружия, за владение таковым, а также за владения оружием со стертыми номерными знаками и/или 
измененным нарезом ствола, подозреваемому присваивается 5-я степень розыска.
7.4 За изготовление оружия и/или патронов, не имея на то специальной лицензии, подозреваемому присваивается 5-я степень розыска.
7.5 За незаконное хранение оружия массового поражения, подозреваемому присваивается 6-я степень розыска и изъятие всех видов лицензий а также 
накладывается штрафная санкция в размере 50.000$ + занесение в Чёрный Список Федерации.
7.6 За незаконное хранение оружия массового поражения, которое базируется в штаб-квартире частной организации, глава организации объявляется в 
федеральный розыск [5-я степень].. Кроме того, частная организация опечатывается до судебного разбирательства.
]])
imgui.Text(u8[[
Глава 8. Похищение, удержание в заложниках, пытка.
8.1 За взятие одного или группы заложников, будь то гражданин и/или гос. служащий, за похищение человека, за пытки подозреваемому присваивается 
6-я степень розыска, а также накладывается штрафная санкция в размере 50.000$ за каждого гражданина, чьи права были нарушены.

Глава 9. Неподчинение.
9.1 За неподчинение сотруднику правоохранительных органов, находящемуся при исполнении, подозреваемому присваивается 3-я степень розыска.
9.2 За неподчинению сотруднику правоохранительных органов при обстановке ЧС в Федерации, а так же при проведении спец. операции, подозреваемому
 присваивается 4-я степень розыска.
9.3 За неадекватное поведение в сторону сотрудника правоохранительных органов, находящемуся при исполнении, подозреваемому присваивается 1-я степень розыска.
9.4 За отказ от выплаты штрафа или при его несвоевременной выплате, выданная штрафная санкция увеличивается втрое, нарушившему присваивается 1-я степень розыска.
9.5 За намеренную попытку избежать наказания (скрыться) от сотрудника МВД, нарушителю присваивается 3-я степень розыска.
]])
imgui.Text(u8[[
Глава 10. Проникновение.
10.1. За проникновение на охраняемую правоохранительными органами территорию, подозреваемому присваивается 3-я степень розыска.
10.2 За незаконное проникновение на территорию закрытой военной базы, подозреваемому присваивается 2-я степень розыска. Охрана военной базы 
имеет право устранить/ликвидировать преступника.
10.3 За массовое проникновение на секретный объект (Военная база СВ, ВВС, ВМФ, Лаборатория СВ, Авианосец), подозреваемым присваивается 6-я степень розыска.
10.4 Проникновение и последующий отказ покинуть собственность(недвижимость) другого гражданина, нарушителю присваивается 2-я степень розыска.
10.5 Проникновение в здания гос. учреждений в маске и/или с вооружением, наказывается 2-ой степенью розыска также накладывается штрафная санкция.
 (Статья не действует на сотрудников МВД при исполнении.)
10.6 За проникновение на территорию офиса ФБР без специального разрешения от действующего агента ФБР, подозреваемому присваивается 3-я степень розыска. (Иллюстрация)
]])
imgui.Text(u8[[
Глава 11. Наркотические вещества.
11.1 За любое употребление/хранение наркотических веществ, подозреваемому присваивается 3-я степень розыска.
11.2 За продажу/покупку/распространение наркотических веществ, подозреваемому присваивается 6-я степень розыска, а так же отстранение с 
занимаемой должности.
11.3 За призыв к использованию наркотических веществ, нарушителю присваивается 2-я степень розыска.
11.4 За производство любых наркотических препаратов подозреваемому присваивается 6-я степень розыска.
Глава 12. Терроризм.
12.1 За планирование/исполнение теракта, подозреваемому присваивается 6-я степень розыска, а так же производится изъятие всех видов лицензий.
12.2 За подозрение в теракте или его попытке, подозреваемому присваивается 6-я степень розыска.
12.3 За распространение ложной информации о террористическом акте, подозреваемому присваивается 3-я степень розыска.
12.4 За помощь в исполнении теракта, подозреваемому присваивается 6-я степень
]])
imgui.Text(u8[[
Глава 13. Хулиганство.
13.1 За значительное повреждение или уничтожение имущества, принадлежащего другому лицу, муниципалитету, государству, 
подозреваемому присваивается 3-я степень розыска.
13.2 Ложный вызов сотрудников государственных организаций, подозреваемому присваивается 2-я степень розыска.
13.3 За ограбление или попытку ограбления, нарушителю присваивается 3-я степень розыска.

Глава 14. Митинги.
14.1 За срыв согласованных собраний, шествий или митингов, нарушителю присваивается 2-я степень розыска.
14.2 За организацию несанкционированного митинга лицу, организовавшему митинг, присваивается 5-я степень розыск.
14.3 За участие в несанкционированном митинге лицу, участвующем в митинге, присваивается 2-я степень розыска.
]])
imgui.Text(u8[[
Глава 15. Соучастие.
15.1 За соучастие в преступлении любой главы Уголовного Кодекса, гражданину присваивается степень розыска по статье, 
в которой он соучаствует.

Глава 16. Неуплата налогов.
16.1 За неуплату налогов установленных правительством синей федерации в указанный срок, нарушителю присваивается 2-я степень 
розыска и выданная штрафная санкция увеличивается втрое.

17: Преступная организация.
17.1: Создание преступной организации, с целью совершения преступления или серии преступлений. 6-ая степень розыска.
17.2: Участие в преступной организации, совершение преступных деяний в соучастии. 5-ая степень розыска.
17.3: Содействие преступной организации в совершении уголовно наказуемых деяний. 4-ая степень розыска.

Глава 18. Оскорбление.
18.1 За любой вид оскорбления сотрудника правоохранительных органов, нарушителю присваивается 3-я степень розыска.
]])
imgui.Text(u8[[
Глава 19. Судебная система.
19.1 За игнорирование или нарушение официального документа, изданного судом, подозреваемому присваивается 3-я степень розыска.
19.2 За умышленное неисполнение вступившего в силу судебного решения, подозреваемому присваивается 3-я степень розыска.
19.3 За повторную неявку на суд, подозреваемому присваивается 4-я степень розыска.
19.4 За влияние на судью с целью вынесения неправомерного решения, лоббирования интересов; сознательное и циничное неповиновение устному 
или письменному решению суда, подозреваемому присваивается 4-я степень розыска.

Глава 20. Дача заведомо ложных показаний.
20.1 За дачу заведомо ложных показаний подозреваемого, свидетеля, потерпевшего или понятого, нарушителю присваивается 2-я степень розыска.

Глава 21. Помеха работе.
21.1 За помеху работе сотруднику министерства внутренних дел, подозреваемому присваивается 3-я степень розыска.
21.2 За помеху работе сотруднику министерства внутренних дел при обстановке ЧС в Федерации, подозреваемому присваивается 6-я степень розыска.

22. Государственная измена.
22.1 За государственную измену, гражданину присваивается 6-я степень розыска, пожизненное наказание в федеральной тюрьме, а так же занесение
 в Черный Список Федерации.
]])
imgui.Text(u8[[
23. Следствие
23.1 Агенты ФБР имеют право объявлять граждан в розыск до выяснения обстоятельств. После выяснения обстоятельств необходимо 
переквалифицировать деяние, либо же снять розыск. (( Исключение - нападение на агента ФБР. Агент может выдать розыск по этой статье,
 после чего нейтрализовать человека, при наличии факта нападения. ))

24. Пункт Таможенного Контроля.
24.1 За отказ или же проезд таможенного поста без предъявления паспорта, гражданину присваивается 2-я степень розыска.
24.2 За отказ или уклонение обыска транспортного средства на таможенном посте, гражданину присваивается 2-я степень розыска.

25. Угрозы.
25.1 За угрозы в сторону гражданского лица, гражданину присваивается 1-я степень розыска.
25.2 За угрозы в сторону гос. служащего, гражданину присваивается 1-я степень розыска

]])
imgui.Text(u8[[
Статья 26. Преступление связанные с должностными полномочиями и обязанностями.
26.1 За превышение должностных полномочий, подозреваемому присваивается 3-а степень розыска.
26.2 За игнорирование и/или невыполнение служебных обязанностей, подозреваемому присваивается 4-а степень розыска
26.3 За чрезмерное превышение должностных полномочий и/или игнорирование служебных обязанностей, которые могли привести
 к глобальной опасности Федерации, подозреваемому присваивается 6 степень розыска, а также статус "ЧС" по решению суда

27. Содействие сотрудникам правоохранительных органов.
27.1 В случае явки с повинной преступника, уровень розыска снижается на 1 единицу.
27.3 В случае оказания содействия в ходе следствия, уровень розыска преступника снижается на 2 единицы .

28. Продажа и покупка гос. информация.
28.1 За продажу гос. информации сотруднику мэрии выдается 2-а степень розыска.
28.2 За покупку гос. информации, гражданину выдается 2-а степень розыска.
]])
imgui.Text(u8[[
29. Военные преступления.
29.1 За Самовольное оставление службы в рядах Министерства Обороны военнослужащему присваивается 1-я степень розыска.
29.2 За продажу или перевозку не на военные объекты гражданином, проходящим военную службу, оружия и патронов к нему,
 полученных в результате осуществления такой службы, присваивается 4-я степень розыска.
29.3 За невыполнение приказа начальника, если оно повлекло тяжкие последствия, присваивается 3-я степень розыска.
29.4 За отдачу неправомерного приказа в любом виде, повлекшее совершение преступления, предусмотренного настоящим Кодексом. 
УРОВЕНЬ РОЗЫСКА: квалифицируется в соответствии с совершенными преступлениями, предусмотренными настоящей Частью.

30. Домогательство и преследование.
30.1 За преследование с целью сексуального домогательства влечет присвоение 2-ой степени розыска.
30.2 За совершение насильственных действий сексуального характера влечет присвоение 4-ой степени розыска .
]])
imgui.Text(u8[[

ОБЩАЯ ЧАСТЬ

СТАТЬЯ 31: Преступление.
ЧАСТЬ 1: Преступлением является общественно опасное деяние, совершенное субъектом преступления, и предусмотренное Уголовным Кодексом.
ЧАСТЬ 2: Преступлением является как законченное деяние, предусмотренное Уголовным Кодексом, так и попытка его совершения.

СТАТЬЯ 32: Субъект преступления.
ЧАСТЬ 1: Субъектом преступления является любое лицо, которое совершает преступление.
]])
imgui.Text(u8[[
СТАТЬЯ 33: Соучастие в преступлении.
ЧАСТЬ 1: Соучастием есть умышленое участие двух и более субъектов преступления в совершении преступления.
ЧАСТЬ 2: Все лица, причастные к преступлению несут равную ответственность, в независимости от степени участия в преступлении.
 Организатор преступления может быть дополнительно осужден судом за организацию и подготовку преступления.

СТАТЬЯ 34: Виды наказаний за совершение преступлений.
ЧАСТЬ 1: Основными видами наказаний являются: штраф, содержание под стражей в КПЗ на протяжении определенного срока, исправительные работы,
 лишение свободы на определенный срок, занесение в черный список федерации.

СТАТЬЯ 35: Назначение наказания.
ЧАСТЬ 1: Суд при рассмотрении дела назначает наказание на свое усмотрение, руководствуясь санкциями статей, и обстоятельствами дела.
 Суд имеет право назначить наказание ниже предусмотренного законом при условии присутствия множества смягчающих обстоятельств.
 Суд имеет право назначить наказание выше предусмотренного законом при условии присутствия отягчающих обстоятельств.
]])
imgui.Text(u8[[
ЧАСТЬ 2: Смягчающими обстоятельствами являются: чистосердечное признание, активное содействие следствию, помощь в раскрытии преступления,
 признание своей вины.
ЧАСТЬ 3: Отягчающими обстоятельствами являются: совершение лицом преступления повторно, совершение преступления в составе группы лиц по
 предварительному сговору, тяжелые последствия преступления, совершение преступления с особенной жестокостью и исключительным цинизмом,
 совершение преступления в состоянии наркотического опьянения.
ЧАСТЬ 4: Назначить наказание в виде лишении жизни суд имеет право, имея неоспоримые доказательства на преступления, которые повлекли за
 собой фатальные последствия для государства и общества. Исполнение данного вида наказаний возлагается на агентов ФБР.
ЧАСТЬ 5: Преступления, совершённые работниками государственных организаций или военнослужащими сопровождаются отстранением от должности
 в судебном порядке. Отстранение с должности (увольнение) происходить следующим образом:
1. При нарушении одной из тяжких статей. (1.1, 2.1, 5.1, 5.2, 7.5, 8.1, 11.1, 11.2, 11.4, 12.1, 12.2, 12.4, 14.2, 19.1, 19.2, 19.3, 19.4,
 20.1, 22.1, 26.1, 26.2, 26.3, 29.2, 29.4 )
2. При совокупности нарушения четырех статей УК. Пример: человек, принимавший участие в незаконном митинге не выполнил законное требование
 сотрудника полиции, попытался скрыться от сотрудников, оскорбил сотрудника.
 9.1 + 9.5 + 14.3 + 18.1 = отстранение (увольнение) с занимаемой должности.
]])
imgui.Text(u8[[





]])

imgui.Text(u8[[

										Административный кодекс Синей Федерации


Кодекс об административных правонарушениях — кодифицированный нормативный акт, регулирующий общественные отношения по привлечению 
к административной ответственности, а также устанавливающий общие начала, перечень всех административных правонарушений 
(который может быть дополнен на региональном уровне), органы, рассматривающие дела, порядок привлечения к административной 
ответственности и порядок исполнения решений по административным делам.?


Глава 1. Правонарушения в отношении граждан.
1.1. Нанесение побоев (( до 20 HP )) или насильственные действия, без сильных последствий для здоровья гражданина, помимо боли. Штраф 10.000$

]])
imgui.Text(u8[[
Глава 2. Общественные правонарушения.
2.1 Курение в общественном месте. Штраф 2.000$.
2.2 Употребление алкоголя в общественном месте. Штраф 2.000$.

Глава 3. Правонарушения, связанные с собственностью.
3.1 Мелкое хищение. Штраф - стоимость украденного в десятикратном размере.
3.2 Осуществление предпринимательской деятельности без государственной регистрации, штраф 100.000$ и закрытие организации предприятия/учреждения.
3.3 Сотрудничество государственных/частный/лицензируемых структур с предпринимателями без государственной лицензии. 
Выдается штраф в размере 100.000$.
3.3 Незначительное повреждение собственности гражданского лица или же собственности государства. Штраф в размере причинённого ущерба.
3.4 Нанесение граффити. Штраф - 2.000$.

]])
imgui.Text(u8[[
Глава 4. Судебные правонарушения.
4.1 За неявку на судебное заседание без весомой причины.Штраф:15.000$.
4.2 Оскорбление участников судебного процесса. Штраф: 50.000$

Глава 5. Административные правонарушения в области дорожного движения.
5.1 Движение на автомобиле без регистрационных номеров. Штраф 2000$
5.2 Отсутствие у водителя паспорта и документов на автомобиль. Штраф 3000$
5.3 Управление неисправным автомобилем. [Черный дым из двигателя и иные функциональные неисправности, оказывающие 
влияние на безопасность движения] Штраф 2.500$.
5.4 Управление транспортом водителем, находящимся в алкогольном опьянении - штраф 2000$, а также изъятие прав на управление автомобилем.
5.5 Опасное маневрирование, создающее риск ДТП на дороге. Штраф 1500$.
5.6 Езда с игнорированием дорожных знаков. Штраф 2.000$

]])
imgui.Text(u8[[
5.7 Движение автомобиля по встречной полосе движения, за исключением государственного транспорта в проблесковыми маячками. 
Штраф – 2000$. В случае повторения нарушения следует лишение водительского удостоверения.
5.8 Движение по газонам и тротуарам. Штраф 2.000$. В случае повторения нарушения следует лишение водительского удостоверения.
5.9 Движение автомобиля вдоль железнодорожных путей. Штраф 2.000$.
5.10 Парковка автомобиля в неположенном месте. Штраф 1.000$. Примечание: не положенными местами являются – тротуар, газон, 
ступени, придорожная насыпь. Также неположенным местом будет являться проезжая часть, если на ней есть тротуар или обочина.
5.11 Езда без включенных внешних световых приборов в темное время суток (c 21:00 до 6:00). Штраф 2.000$.
5.12 Отказ уступить дорогу транспортному средству, имеющему преимущество. Штраф 2000$.

]])
imgui.Text(u8[[
5.13 Нарушение правил посадки воздушного транспорта. (Подходящие места для посадки указаны в пункте 3.1 главы 3 ПДД). 
Штраф 2.000$, в случае отказа убрать транспортное средство следует лишение водительского удостоверения.
5.14 Использование звукового сигнала не по назначению. (Подача звукового cигнала разрешена только для предотвращения 
ДТП или привлечения внимания другого водителя). Штраф 2.000$.

Глава 6. Нецензурная(-ые) брань/выражения в общественном месте/оскорбления
6.1 Нецензурные выражения в общественном месте. Штраф 1.000$.
6.2 Нецензурная брань в сторону гражданина, оскорбления. Штраф 2.000$

]])
imgui.Text(u8[[
Глава 7. Правонарушения в отношении государственных законов
7.1 Неуважение к конституции. (ошибки при редактировании объявлений и подачи новостей. Замена Федерации на штат.) 
Для руководителей организаций: штраф в размере 50.000$. ( В Фонд Синей Федерации) Для СМИ: выговор сотруднику 
старшего состава, который повысил нарушителя. Лидеру подразделения, где находится нарушитель: штраф в размере 30.000$.
]])
imgui.Text(u8[[


]])
imgui.Text(u8[[


]])
imgui.Text(u8[[


]])
imgui.Text(u8[[


]])
imgui.Text(u8[[


]])
imgui.Text(u8[[


]])
imgui.Text(u8[[

]])
imgui.Text(u8[[

]])
imgui.Text(u8[[

]])

imgui.End()
end
end
imgui.End()
end


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
		while not isSampAvailable() do wait(100) end
		sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}Скрипт TS Helper {CC0000}National Security{FFFFFF} успешно запущен, приятного пользования.', 0xffffff)
		sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}Автор данного скрипта Fernando Cavalli. Помощь в использовании - "/ts".', 0xffffff)
		sampRegisterChatCommand("cmd1", cmd1)
		sampRegisterChatCommand("cmd3", cmd3)
		sampRegisterChatCommand("geg", geg)
		sampRegisterChatCommand("casesvet", casesvet)
		sampRegisterChatCommand("svet", svet)
		sampRegisterChatCommand("lec", lec)
		sampRegisterChatCommand("lecac", lecac)
		sampRegisterChatCommand("lecns", lecns)
		sampRegisterChatCommand("leckso", leckso)
		sampRegisterChatCommand("lecgnk", lecgnk)
		sampRegisterChatCommand("su", su)
		sampRegisterChatCommand("op", op)
		sampRegisterChatCommand("cl", cl)
		sampRegisterChatCommand("pg", pg)
		sampRegisterChatCommand("уд", уд)
		sampRegisterChatCommand("pn", pn)
		sampRegisterChatCommand("susp", susp)
		sampRegisterChatCommand("fn", fn)
		sampRegisterChatCommand("rn", rn)
		sampRegisterChatCommand("cuff", cuff)
		sampRegisterChatCommand("cuffsp", cuffsp)
		sampRegisterChatCommand("uncuff", uncuff)
		sampRegisterChatCommand("uncuffsp", uncuffsp)
		sampRegisterChatCommand("putpl", putpl)
		sampRegisterChatCommand("putplsp", putplsp)
		sampRegisterChatCommand("eject", eject)
		sampRegisterChatCommand("ejectsp", ejectsp)
		sampRegisterChatCommand("arrest", arrest)
		sampRegisterChatCommand("arrestsp", arrestsp)
		sampRegisterChatCommand("clear", clear)
		sampRegisterChatCommand("clearsp", clearsp)
		sampRegisterChatCommand("hold", hold)
		sampRegisterChatCommand("holdsp", holdsp)
		sampRegisterChatCommand("search", search)
		sampRegisterChatCommand("searchsp", searchsp)
		sampRegisterChatCommand("so", so)
		sampRegisterChatCommand("test", test)
		sampRegisterChatCommand("mayak", mayak)
		sampRegisterChatCommand("глушилка", глушилка)
		sampRegisterChatCommand("sos", sos)
		sampRegisterChatCommand("mo", mo)
		sampRegisterChatCommand("hexit", hexit)
		sampRegisterChatCommand("mon", mon)
		sampRegisterChatCommand("moff", moff)
		sampRegisterChatCommand("ticket", ticket)
		sampRegisterChatCommand("ticketsp", ticketsp)
		sampRegisterChatCommand("takelic", takelic)
		sampRegisterChatCommand("takelicsp", takelicsp)
		sampRegisterChatCommand("setmark", setmark)
		sampRegisterChatCommand("setmarksp", setmarksp)
		sampRegisterChatCommand("ud", ud)
		sampRegisterChatCommand("eat", eat)
		sampRegisterChatCommand("eatsp", eatsp)
		sampRegisterChatCommand("rang", rang)
		sampRegisterChatCommand("rangsp", rangsp)
		sampRegisterChatCommand("invite", invite)
		sampRegisterChatCommand("invitesp", invitesp)
		sampRegisterChatCommand("fbi", fbi)
		sampRegisterChatCommand("fbisp", fbisp)
		sampRegisterChatCommand("open", open)
		sampRegisterChatCommand("opensp", opensp)
		sampRegisterChatCommand("biz", biz)
		sampRegisterChatCommand("ton", ton)
		sampRegisterChatCommand("nar", nar)
		sampRegisterChatCommand("pt", pt)
		sampRegisterChatCommand("ot", ot)
		sampRegisterChatCommand("cs", cs)
		sampRegisterChatCommand("css", css)
		sampRegisterChatCommand("mask", mask)
		sampRegisterChatCommand("mayakk", mayakk)
		sampRegisterChatCommand("healme", healme)
		sampRegisterChatCommand("healmesp", healmesp)
		sampRegisterChatCommand("masksp", masksp)
		sampRegisterChatCommand("r", r)
		sampRegisterChatCommand("rsp", rsp)
		sampRegisterChatCommand("f", f)
		sampRegisterChatCommand("report", report)
		sampRegisterChatCommand("fsp", fsp)
		sampRegisterChatCommand("strelba", strelba)
		sampRegisterChatCommand("hack", hack)
		sampRegisterChatCommand("hacksp", hacksp)
		sampRegisterChatCommand("fo", fo)
		sampRegisterChatCommand("ja", ja)
		sampRegisterChatCommand("givedrugs", givedrugs)
		sampRegisterChatCommand("foff", foff)
		sampRegisterChatCommand("bomba", bomba)
		sampRegisterChatCommand("bt", bt)
		sampRegisterChatCommand("bf1", bf1)
		sampRegisterChatCommand("bf2", bf2)
		sampRegisterChatCommand("bf3", bf3)
		sampRegisterChatCommand("incar", incar)
		sampRegisterChatCommand("inmoto", inmoto)
		sampRegisterChatCommand("hh", hh)
		sampRegisterChatCommand("pp", pp)
		sampRegisterChatCommand("cam", cam)
		sampRegisterChatCommand("alp", alp)
		sampRegisterChatCommand("alpt", alpt)
		sampRegisterChatCommand("alpf", alpf)
		sampRegisterChatCommand("alps", alps)
		sampRegisterChatCommand("skip", skip)
		sampRegisterChatCommand("skipsp", skipsp)
		sampRegisterChatCommand("allow", allow)
		sampRegisterChatCommand("allowsp", allowsp)
		sampRegisterChatCommand("pol", pol)
		sampRegisterChatCommand("palec", palec)
		sampRegisterChatCommand("otvet", otvet)
		sampRegisterChatCommand("жертва", жертва)
		sampRegisterChatCommand("cmd2", cmd2)
		sampRegisterChatCommand("prov", prov)
		sampRegisterChatCommand("rasp", rasp)
		sampRegisterChatCommand("order", order)
		sampRegisterChatCommand("meg", meg)
		sampRegisterChatCommand("megsp", megsp)
		sampRegisterChatCommand("krik", krik)
		sampRegisterChatCommand("rhelp", rhelp)
		sampRegisterChatCommand("fhelp", fhelp)
		sampRegisterChatCommand("soz", soz)
		sampRegisterChatCommand("case", case)
		sampRegisterChatCommand("caseact", caseact)
		sampRegisterChatCommand("unc", unc)
		sampRegisterChatCommand("epk1", epk1)
		sampRegisterChatCommand("epk2", epk2)
		sampRegisterChatCommand("epk3", epk3)
		sampRegisterChatCommand("dor", dor)
		sampRegisterChatCommand("pr", pr)
		sampRegisterChatCommand("pk", pk)
		sampRegisterChatCommand("za", za)
		sampRegisterChatCommand("vi", vi)
		sampRegisterChatCommand("spec", spec)
		sampRegisterChatCommand("test", test)
		sampRegisterChatCommand("ук1", ук1)
		sampRegisterChatCommand("ts", ts)
 while true do
	wait(0)

		if isKeyJustPressed(key.VK_F2) then
		lua_thread.create(function ()
sampSendChat("Всем оставаться на своих местах, без лишних движений!")
wait(800)
sampSendChat("Руки за голову, лицом на землю. Дёрнетесь - убью.")
end)
end
		if isKeyJustPressed(key.VK_F3) then
		lua_thread.create(function ()
sampSendChat("/m Водитель транспортонго средства, немедленно остановитесь...")
wait(800)
sampSendChat("/m ...прижмитесь к обочине и заглушите двигатель, руки оставьте на руле.")
wait(800)
sampSendChat("/m В случае неподчинения будут предприняты суровые меры по остановке.")
wait(100)
sampAddChatMessage('{4c4f45}[TS Helper] {FF0000}ALT+P{FFFFFF} - приказать сидеть в автомобиле.{FF0000}CTRL+P{FFFFFF} - приказать выйти из автомобиля.', 0xffffff)
end)
end
		if isKeyJustPressed(key.VK_F4) then
		local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
		if valid and doesCharExist(ped) then
		local result, id = sampGetPlayerIdByCharHandle(ped)
		if result then
		lua_thread.create(function ()
		sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя.")
		wait(100)
		sampSendChat("/su " .. id .. " 6 2.1 УК")
		wait(1000)
		sampSendChat("/do Преступник объявлен в Федеральный розыск.")
		wait(1200)
		sampSendChat("/f Срочно требуется поддержка, по агенту был открыт огонь. Код 1.")
		end)
		end
		end
		end
		if isKeyJustPressed(key.VK_F9) then
		sampSendChat("/find")
		end
		if isKeyJustPressed(key.VK_F10) then
	sampSetChatInputEnabled(true)
sampSetChatInputText('/pg ')
end	
		if isKeyJustPressed(key.VK_F11) then
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
		lua_thread.create(function ()
		sampSendChat("/r Срочно требуется подкрепление на мой жук.")
wait(800)
sampSendChat("/f Срочно требуется подкрепление на мой жук. ")
wait(800)
sampSendChat("/su " .. id .. " 2 жук")
end)
end
if isKeyJustPressed(key.VK_F12) then
lua_thread.create(function ()
sampSendChat("/s Водитель транспортонго средства, немедленно остановитесь...")
wait(1000)
sampSendChat("/s ...прижмитесь к обочине и заглушите двигатель, руки оставьте на руле.")
wait(2000)
sampSendChat("/s В случае неподчинения будут предприняты суровые меры по остановке.")
end)
end
		if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_1) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/su ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_2) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/cuff ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_3) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/putpl ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_4) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/arrest ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_5) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/search ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_6) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/ticket ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_7) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/takelic ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_8) then
		lua_thread.create(function ()
sampSetChatInputEnabled(true)
sampSetChatInputText('/setmark ')
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_9) then
		lua_thread.create(function ()
sampSendChat("/wanted")
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_0) then
		lua_thread.create(function ()
sampSendChat("/lock 2")
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_T) then
		lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк маска.")
wait(500)
sampSendChat("/me потянувшись в карман брюк, вытащил маску, затем натянул её на лицо.")
wait(500)
sampSendChat("/mask")
wait(500)
sampSendChat("/do Маска на лице.")
wait(500)
sampSendChat("/reset")
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_R) then
		lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк шприц с обезбаливающим.")
wait(500)
sampSendChat("/me потянувшись в карман брюк, вытащил шприц и кольнул шприцом в рану.")
wait(500)
sampSendChat("/healme")
wait(500)
sampSendChat("/do Инъекция введена.")
end)		
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_1) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/clear ')
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_2) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/uncuff ')
end	
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_3) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/eject ')
end		
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_4) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/hold ')
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_5) then
lua_thread.create(function ()
sampSendChat("/me вытащил патрон из кармана человека и внимательно рассмотрел его")
wait(1000)
sampSendChat("/me рассмотрев патрон человека, обнаружил на нём маркировку.")
wait(1000)
sampSendChat("/me достал КПК и вошёл в базу данных Федерального Бюро Расследований.")
wait(1000)
sampSendChat("/me переписал обнаруженную маркировку патрона в КПК")
wait(1000)
sampSendChat("/me отправил запрос с маркировкой патрона в Министерство Обороны.")
wait(1000)
sampSendChat("/do Спустя минуту пришёл ответ от Министерства Обороны.")
wait(1000)
sampSendChat("/try обнаружил что патрон принадлежит Министерству Обороны")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_6) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/hack ')
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_7) then
sampSendChat("/fbi")
sampSendChat("/me провёл карточкой по электронному замку двери.") 
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_8) then
sampSendChat("/jaildoor")
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_9) then
sampSendChat("/open")
sampSendChat("/me достал пульт управления из кармана брюк, затем нажал на кнопку.") 
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_0) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/ud FC | FBI | National Secutiry | Старший агент')
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_M) then
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("TS")
wait(500)
sampSendChat("/do Жучок в часах агента определил голосовую команду и активировался.")
wait(500)
sampSendChat("/su " .. id .. " 2 жук", main_color)
end) 
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_G) then
lua_thread.create(function ()
sampSendChat("/m Водитель, немедленно прижмись к обочине...")
wait(800)
sampSendChat("/m Уступи дорогу автомобилю следственных органов, не то откроем огонь.")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_G) then
lua_thread.create(function ()
sampSendChat("/m Водитель автомобиля, немедленно прекратите преследование!")
wait(800)
sampSendChat("/m Неподчинение буду рассматривать как помеху работе следственных органов.")
end)
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_P) then
lua_thread.create(function ()
sampSendChat("/m Не выходите из своего транспортного средства...")
wait(500)
sampSendChat("/m ... заглушите двигатель и выбросите ключи из окна")
wait(500)
sampSendChat("/m ... одно лишнее движение и я за себя не ручаюсь.")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_P) then
lua_thread.create(function ()
sampSendChat("/m Медленно выходите с высокоподнятыми руками...")
wait(500)
sampSendChat("/m ... подойдите к капоту своего автомобиля и сложите на него руки...")
wait(500)
sampSendChat("/m ... одно лишнее движение и я за себя не ручаюсь.")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_M) then
		local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do В правом кармане брюк лежит активированный жучок.")
wait(500)
sampSendChat("/me залез рукой в карман и деактивировал жучок нажатием кнопки.")
wait(500)
sampSendChat("/clear " .. id .. "", main_color)
wait(500)
sampSendChat("/do Жучок деактивирован.")
end) 
end
if isKeyDown(17) and isKeyDown(82) then -- CTRL+R
		while isKeyDown(17) and isKeyDown(82) do wait(80) end
		reloadScripts()
	end
	imgui.Process = one_win.v
  end
 end


function cmd1()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Список команд {4c4f45}«TS Helper»", "{ffffff}| /geg - сообщить человеку о том, что он арестован\n| /fn [текст] - ООС сообщение в рацию МВД\n| /rn [текст] - ООС сообщение в рацию ФБР\n| /nar - изъять наркотики\n| /pt - изъять патроны\n| /ud [инициалы]-[организация]-[отдел(по желанию)]-[должность] - умное удостоверение\n(Необходимо записать все свои данные самостоятельно)\n| /incar [id] - вытащить человека из автомобиля\n| /inmoto [id] - скинуть человека с мотоцикла\n| /mon  - активировать свои два маячка\n| /moff  - деактивировать свои маячки\n| /ton - тонировка транспорта\n| /ot - отобрать отмычку у заключённого\n| /cs  (/changeskin) - поменять себе форму\n| /css [id] (/changeskin) - поменять человеку форму\n| /fo (/follow) - начать прослушивать рацию организаций\n| /foff (/follow) - перестать прослушивать рацию\n| /ja (/jaildoor) - открыть клетку в тюрьме\n| /cam - отыграть РП камеру\n| /жертва - развязать заложника\n| /pol - отыгровка подключения полиграфа\n| /palec - проверка работоспособности полиграфа\n| /otvet - снять показания с полиграфа\n| /alp - приготовить альпинистское снаряжение\n| /alpt (Удачно) - взобраться на здание\n| /alpf (Неудачно) - произвести повторный выстрел\n| /alps - убрать альпинистское снаряжение\n| /bomba - разминировать бомбу\n| /bt (Удачно) - сложить инструменты обратно\n| /bf1 (Неудачно) - повторить попытку\n| /bf2 (Неудачно x2) - повторить попытку снова\n| /bf3 (Неудачно x3) - взять бомбу и убежать в сторону\n{800000}ПРИМЕЧАНИЕ! {FFFFFF}Отыгровки работают на всех стандартных командах, кроме /changeskin\n{4c4f45}ДОПОЛНИТЕЛЬНО! {FFFFFF}Каждую стандартную отыгровку можно отправлять без РП отыгровок\n для этого необходимо писать в конце префикс «sp» (Пример: /susp [id][ур.розыска][причина]", "Закрыть")
wait(200)
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}Cписок дополнительных команд - /cmd2. Список забиндованных клавиш - /cmd3.', 0xffffff)
end)
end

function unc() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do Наручники на руках человека. В заднем кармане брюк лежит отмычка.")
wait(800)
sampSendChat("/me залез руками в задний карман брюк, вытащил отмычку...")
wait(800)
sampSendChat("/me ...методом тыка обнаружил замочную скважину наручников, затем просунул отмычку...")
wait(800)
sampSendChat("/me ...в замочную скважину наручников, провернул отмычку несколько раз по часовой стрелке.")
wait(800)
sampSendChat("/uncuff " .. id .. "", main_color)
wait(800)
sampSendChat("/do Произошёл щелчок, после чего наручники расстягнулись и упали на землю.")
end) 
end

function cmd2()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Список команд {4c4f45}«TS Helper»", "{ffffff}| /hh [отклоняемый номер] - отклонить вызов с последующим отключением телефона\n| /pp - принять входящий вызов с рп\n| /so [местность] - предупредить сотрудников МВД о угрозе похищения\n| /sos  - активация жучков на случай похищения\n| /глушилка - отключает все маячки в радиусе 5 метров\n| /mayak - активирует жучки для спец. операций всем в радиусе 150 метров\n| /strelba ( необходимо прицелиться в человека и нажать кнопку) - выдаёт розыск за нападение\nчеловеку, в которого Вы целитесь с запросом о помощи на волну МВД\n| /rasp - расписание проверок ГНК/КСО\n| /prov - уведомить организацию о предстоящей проверке\n| /mo - отправить запрос на маркировку патрона Министерству Обороны\n| /krik - кричалка\n| /meg - требование остановить автомобииль\n| /megsp - требование остановить автомобиль на немаркированной машине\n| /givedrugs [id] - подбросить человеку наркотики\n| /unc  - снять с себя наручники отмычкой\n| /rhelp  - вызвать подкрепление на волну ФБР\n| /fhelp  - вызвать подкрепление на волну МВД\n| /soz - созвать МВД к офису\n| /epk(1-3) - Единый Процессуальный Кодекс\n| /case - подложить жучок в кейс с настоящими деньгами\n| /caseact - активировать жучок в кейсе с деньгами\n| /report - быстрое открытие панели репорта\n| /dor - уступите дорогу в /m\n| /pr - прекратите преследование в /m\n| /pk - покиньте автомобиль в /m\n| /lec - список лекций, читаемых на волну МВД\n| /vi - выйти из закрытого автомобиля\n| /za - сесть в закрытый автомобиль.\n| /op - разблокировать двери транспорта\n| /cl - заблокировать двери транспорта       /hexit - отключить TS Helper.", "Закрыть")
end)
end

function spec()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Специальные команды {4c4f45}«TS Helper»", "{ffffff}| /mayak - активирует жучки для спец. операций всем в радиусе 150 метров\n| /order - пустить под следствие всех в радиусе\n| /глушилка - деактивировать маячки у всех в радиусе.", "Закрыть")
end)
end

function cmd3()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Клавиши и их назначения {4c4f45}«TS Helper»", "{ffffff}F2 - кричалка\nF3 - мегафон\nПКМ+F4 - /strelba\nF9 - /find\nF10 - /pg [id] - розыск при погоне\nF11 - /rhelp+/fhelp\nF12 - мегафон для немаркированного автомобиля\nALT+1 - /su\nALT+2 - /cuff\nALT+3 - /putpl\nALT+4 - /arrest\nALT+5 - /search\nALT+6 - /ticket\nALT+7 - /takelic\nALT+8 - /setmark\nALT+9 - /wanted\nALT+0 - /lock 1\nCTRL+1 - /clear\nCTRL+2 - /uncuff\nCTRL+3 - /eject\nCTRL+4 - /hold\nCTRL+5 - /mo\nCTRL+6 - /hack\nCTRL+7 - /fbi\nCTRL+8 - /jaildoor\nCTRL+9 - /open\nCTRL+0 - /ud\nALT+M - /mon\nCTRL+M - /moff\nALT+H - уступите дорогу\nCTRL+H - прекратите преследование\nALT+P - приказать сидеть в автомобиле\nCTRL+P приказать выйти из автомобиля", "Закрыть")
end)
end

function epk1()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}Агент обязан знать ЕПК/УК/АК наизусть!', 0xffffff)
end)
end

function epk2()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}Агент обязан знать ЕПК/УК/АК  наизусть!', 0xffffff)
end)
end

function epk3()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}Агент обязан знать ЕПК/УК/АК  наизусть!', 0xffffff)
end)
end


function dor()
lua_thread.create(function ()
sampSendChat("/m Водитель, немедленно прижмись к обочине...")
wait(800)
sampSendChat("/m Уступи дорогу автомобилю следственных органов, не то откроем огонь.")
end)
end

function ts()
one_win.v = not one_win.v
end

function pr()
lua_thread.create(function ()
sampSendChat("/m Водитель автомобиля, немедленно прекратите преследование!")
wait(800)
sampSendChat("/m Неподчинение буду рассматривать как помеху работе следственных органов.")
end)
end

function hexit()
lua_thread.create(function ()
sampAddChatMessage('{800000}[Tside System] {FFFFFF}Скрипт TS Helper отключён.', 0xffffff)
file:close ()
end)
end

function pk()
lua_thread.create(function ()
sampSendChat("/m Медленно выходите с высокоподнятыми руками...")
wait(500)
sampSendChat("/m ... подойдите к капоту своего автомобиля и сложите на него руки...")
wait(500)
sampSendChat("/m ... одно лишнее движение и я за себя не ручаюсь.")
end)
end

function pn()
lua_thread.create(function ()
sampSendChat("/m Не выходите из своего транспортного средства...")
wait(500)
sampSendChat("/m ... заглушите двигатель и выбросите ключи из окна")
wait(500)
sampSendChat("/m ... одно лишнее движение и я за себя не ручаюсь.")
end)
end

function rhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/r Срочно требуется подкрепление на мой жук. Повторяю, требуется подкрепление.")
wait(100)
sampSendChat("/su " .. id .. " 2 жук")
end)
end

function case()
lua_thread.create(function ()
sampSendChat("/do В салоне транспортного средства лежат два кейса.")
wait(1000)
sampSendChat("/me взял кейс с настоящими деньгами, после чего открыл его")
wait(1000)
sampSendChat("/me вытащил жучок из брюк и засунул его между купюр.")
wait(1000)
sampSendChat("/do Жучок дистанционного управления активируется нажатием на кнопку пульта.")
wait(1000)
sampSendChat("/me убедившись в незаметности жучка, закрыл кейс и положил его рядом со вторым.")
wait(1000)
sampSendChat("/do Пульт лежит в правом кармане брюк.")
end)
end

function caseact()
lua_thread.create(function ()
sampSendChat("/do Пульт лежит в правом кармане брюк.")
wait(500)
sampSendChat("/me сунув руку в правый карман брюк, нажал на кнопку активации жучка.")
wait(500)
sampSendChat("/try убедился в том, что жучок в кейсе активирован")
end)
end

function fhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/f Срочно требуется подкрепление на мой жук. Повторяю, требуется подкрепление.")
wait(100)
sampSendChat("/su " .. id .. " 2 жук")
end)
end

function soz()
lua_thread.create(function ()
sampSendChat("/f Старший состав ПД и SWAT строй у офиса ФБР!")
wait(100)
sampSendChat("/f Старший состав ПД и SWAT строй у офиса ФБР!")
end)
end

function rasp()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}Расписание проверок ГНК/КСО {4c4f45}«TS Helper»", "{ffffff}| Понедельник - Министерство Внутренних Дел\n| Вторник - Министерство Обороны\n| Среда - Средства Массовой Информации\n| Четверг - Министерство Здравоохранения\n| Пятница - Правительство\n| Суббота - день перенесенных проверок\n| Воскресенье - день перенесенных проверок", "Закрыть")
end)
end

function meg()
lua_thread.create(function ()
sampSendChat("/m Водитель транспортонго средства, немедленно остановитесь...")
wait(800)
sampSendChat("/m ...прижмитесь к обочине и заглушите двигатель, руки оставьте на руле.")
wait(800)
sampSendChat("/m В случае неподчинения будут предприняты суровые меры по остановке.")
end)
end

function krik()
lua_thread.create(function ()
sampSendChat("Всем оставаться на своих местах, без лишних движений!")
wait(800)
sampSendChat("Руки за голову, лицом на землю. Дёрнетесь - убью.")
end)
end

function megsp()
lua_thread.create(function ()
sampSendChat("/s Водитель транспортонго средства, немедленно остановитесь...")
wait(1000)
sampSendChat("/s ...прижмитесь к обочине и заглушите двигатель, руки оставьте на руле.")
wait(2000)
sampSendChat("/s В случае неподчинения будут предприняты суровые меры по остановке.")
end)
end

function prov()
lua_thread.create(function ()
sampSendChat("Говорит сотрудник Федерального Бюро Расследований")
wait(800)
sampSendChat("Уведомляю Вас о предстоящей проверке на наличие запрещённых предметов")
wait(800)
sampSendChat("Будьте добры приготовиться и построить сотрудников.")
end)
end

function mo()
lua_thread.create(function ()
sampSendChat("/me вытащил патрон из кармана человека и внимательно рассмотрел его")
wait(1000)
sampSendChat("/me рассмотрев патрон человека, обнаружил на нём маркировку.")
wait(1000)
sampSendChat("/me достал КПК и вошёл в базу данных Федерального Бюро Расследований.")
wait(1000)
sampSendChat("/me переписал обнаруженную маркировку патрона в КПК")
wait(1000)
sampSendChat("/me отправил запрос с маркировкой патрона в Министерство Обороны.")
wait(1000)
sampSendChat("/do Спустя минуту пришёл ответ от Министерства Обороны.")
wait(1000)
sampSendChat("/try обнаружил что патрон принадлежит Министерству Обороны")
end)
end

function pol()
lua_thread.create(function ()
sampSendChat("/me включил полиграф")
wait(1200)
sampSendChat("/me разложил перед собой датчики")
wait(1200)
sampSendChat("/me прикрепил датчик грудного дыхания")
wait(1200)
sampSendChat("/me прикрепил датчик диафрагмального дыхания")
wait(1200)
sampSendChat("/me установил фотоплетизмаграмму на палец подозреваемого")
wait(1200)
sampSendChat("/me установил датчики двигательной активности")
wait(1200)
sampSendChat("/me установил датчик речевых реакций")
wait(1200)
sampSendChat("/me установил датчик кожно гальванической реакции")
wait(1200)
sampSendChat("/me проверил правильность подключения датчиков.")
wait(1200)
sampSendChat("/try убедился в правильности подключения датчиков")
end)
end

function alp()
lua_thread.create(function ()
sampSendChat("/do На плече сумка с альпинистским снаряжением.")
wait(800)
sampSendChat("/me снял сумку с плеча, после чего открыл её.")
wait(800)
sampSendChat("/do В сумке находятся пистолет и тросс с крюком.")
wait(800)
sampSendChat("/me закрепив тросс с крюком в пистолете, произвёл прицельный выстрел.")
wait(800)
sampSendChat("/try обнаружил что крюк зацепился за крышу")
end)
end

function alpt()
lua_thread.create(function ()
sampSendChat("/break 1")
wait(500)
sampSendChat("/me убедившись что крюк надёжно закреплён, полез наверх.")
end)
end

function healmesp()
lua_thread.create(function ()
sampSendChat("/healme")
end)
end

function masksp()
lua_thread.create(function ()
sampSendChat("/mask")
end)
end

function allow(arg)
lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк лежат ключи от автомобиля.")
wait(500)
sampSendChat("/me потянувшись в карман брюк, вытащил ключи, затем передал их человеку напротив.")
wait(500)
sampSendChat("/allow " .. arg .. "")
end)
end

function skip(arg)
lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк лежит пропуск.")
wait(800)
sampSendChat("/me потянувшись левой рукой в карман брюк, вытащил пропуск...")
wait(800)
sampSendChat("/me ...после чего заполнил его и передал человеку напротив.")
wait(800)
sampSendChat("/skip " .. arg .. "")
end)
end

function cam()
lua_thread.create(function ()
sampSendChat("/do В пуговицу рубашки встроена скрытая видеокамера.")
wait(500)
sampSendChat("/do Камера записывает звук и видео в хорошем качестве.")
end)
end

function alpf()
lua_thread.create(function ()
sampSendChat("/me обнаружив что крюк не закреплён, принялся проводить повторную сборку пистолета.")
wait(500)
sampSendChat("/me закрепив тросс с крюком в пистолете, произвёл прицельный выстрел.")
wait(500)
sampSendChat("/try обнаружил что крюк зацепился за крышу")
end)
end

function alps()
lua_thread.create(function ()
sampSendChat("/do Крюк прицеплен к поверхности.")
wait(800)
sampSendChat("/me отцепил крюк от поверхности, после чего принялся выполнять разборку пистолета.")
wait(800)
sampSendChat("/break 0")
wait(800)
sampSendChat("/me разобрав пистолет, сложил снаряжение в сумку и закрыл её")
wait(800)
sampSendChat("/me закинул сумку с альпинистским снаряжением на плечо.")
wait(800)
sampSendChat("/do На плече сумка с альпинистским снаряжением.")
end)
end

function bomba()
lua_thread.create(function ()
sampSendChat("/do На плече сумка с эмблемой «Набор сапёра».")
wait(1200)
sampSendChat("/me снял сумку с плеча и открыл её.")
wait(1200)
sampSendChat("/do В сумке лежат заморозка, щипцы и отвертка. Перед агентом бомба.")
wait(1200)
sampSendChat("/me взял бомбу в руки и внимательно осмотрел её.")
wait(1200)
sampSendChat("/do На бомбе таймер две минуты, механизм бомбы скрыт под крышкой...")
wait(1200)
sampSendChat("/do ...которая закреплена четремя винтами.")
wait(1200)
sampSendChat("/me потянулся к набору сапёра и вытащил от туда отвёртку")
wait(1200)
sampSendChat("/me открутил отвёрткой все четыре винта")
wait(1200)
sampSendChat("/do В руке агента четыре винта.")
wait(1200)
sampSendChat("/me положил винты рядом с набором сапёра")
wait(1200)
sampSendChat("/me потянулся к крышке бомбы, затем аккуратно снял её.")
wait(1200)
sampSendChat("/do Перед агентом три провода: красный, синий и зелёный.")
wait(1200)
sampSendChat("/me потянулся к набору сапёра и вытащил из него щипцы.")
wait(1200)
sampSendChat("/do Агент немного заволновался от груза ответственности на себе.")
wait(1200)
sampSendChat("/me определившись, потянулся щипцами к красному проводу и переразал его.")
wait(1200)
sampSendChat("/try обнаружил что таймер остановился.")
end)
end

function bt()
lua_thread.create(function ()
sampSendChat("/do Бомба успешно обезврежена.")
wait(1200)
sampSendChat("/me с улыбкой на лице убрал щипцы, отвёртку и винты в сумку.")
wait(1200)
sampSendChat("/do Инструменты в сумке с эмблемой «Набор сапёра».")
wait(1200)
sampSendChat("/me закрыл сумку и повесил её на плечо.")
wait(1200)
sampSendChat("/do На плече сумка с эмблемой «Набор сапёра».")
end)
end

function palec()
lua_thread.create(function ()
sampSendChat("/anim 16")
wait(500)
sampSendChat("/todo Показывая два пальца*сколько пальцев я показываю?")
end)
end

function otvet()
lua_thread.create(function ()
sampSendChat("/me снял показания с полиграфа.")
wait(500)
sampSendChat("/try распознал сигнал о верном утверждении")
end)
end

function bf1()
lua_thread.create(function ()
sampSendChat("/do Таймер на бомбем сократился в двое. До взрыва 1 минута.")
wait(1200)
sampSendChat("/me определившись, потянулся щипцами к синему проводу и переразал его.")
wait(1200)
sampSendChat("/try обнаружил что таймер остановился.")
end)
end

function жертва()
lua_thread.create(function ()
sampSendChat("/do В левом носке находится специальный нож.")
wait(500)
sampSendChat("/anim 14")
wait(500)
sampSendChat("/me переразав верёвки, освободил заложника, после чего убрал нож обратно в носок.")
wait(500)
sampSendChat("Скорее идём от сюда!")
end)
end

function bf2()
lua_thread.create(function ()
wait(300)
sampSendChat("/do Таймер на бомбем сократился в двое. До взрыва 30 секунд.")
wait(1200)
sampSendChat("/me потянулся к последнему зелёному проводу и переразал его.")
wait(1200)
sampSendChat("/try обнаружил что таймер остановился.")
end)
end

function bf3()
lua_thread.create(function ()
wait(300)
sampSendChat("/do Таймер достиг критической отметки в 5 секунд.")
wait(2000)
sampSendChat("/me хорошенько обдумав свои действия, взял бомбу и побежал в сторону.")
wait(5000)
sampSendChat("/do Произошёл взрыв. агента разорвало на кусочки.")
end)
end

function ton() 
local veh = storeCarCharIsInNoSave(PLAYER_PED)
lua_thread.create(function ()
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Двери заблокированы, не стоит выходить без соответствующих отыгровок.', 0xffffff)
sampSendChat("/do Стёкла транспортного средства затонированы.")
wait(800)
sampSendChat("/do Двери транспортного средства заблокированы.")
wait(800)
sampSendChat("/do Звукопропускаемость внутри транспортного средства минимальная.")
wait(800)
sampSendChat("/do Микроантенна на капоте транспортного средства записывает звук.")
wait(800)
sampSendChat("/do Микрофон на приборной панели передаёт звук снаружи.")
wait(1000)
sampSendChat("/do На транспортном средстве отсутствую опозновательные знаки и гос. номер.")
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Выйти из закрытого автомобиля - /vi , сесть - /za .', 0xffffff)
end) 
end

function hh(arg) 

lua_thread.create(function ()
sampSendChat("/me потянулся левой рукой в карман брюк, после чего достал из него телефон.")
wait(800)
sampSendChat("/h")
wait(800)
sampSendChat("/sms " .. arg .. " [Автоответчик] Абонент находится вне зоны действия сети")
wait(800)
sampSendChat("/sms " .. arg .. " [Автоответчик] Повторите попытку немного позже.")
wait(800)
sampSendChat("/sms " .. arg .. " [Автоответчик] The subscriber is out of coverage area.")
wait(800)
sampSendChat("/togphone")
wait(800)
sampSendChat("/me выключив телефон, убрал его обратно в карман брюк.")
end) 
end

function pp() 

lua_thread.create(function ()
sampSendChat("/me потянулся левой рукой в карман брюк, после чего достал из него телефон.")
wait(1000)
sampSendChat("/p")
wait(300)
sampSendChat("[Автоответчик] Все входящие на данный номер звонки прослушиваются и записываются.")
wait(800)
sampSendChat("*Звуковой сигнал*")
wait(800)
sampSendChat("Управление Национальной Безопасности на связи...")
end) 
end

function incar(arg) 

lua_thread.create(function ()
sampSendChat("/me со всего размаха ударил локтём по стеклу автомобиля.")
wait(800)
sampSendChat("/do Стекло разбилось в дребезги.")
wait(800)
sampSendChat("/me сунул руку в салон автомобиля, потянулся к ручке...")
wait(800)
sampSendChat("/me ... и дёрнул её, тем самым открыв дверь автомобиля")
wait(800)
sampSendChat("/me схватил человека за шкирку и вытащил из автомобиля.")
wait(800)
sampSendChat("/pull " .. arg .. "")
end) 
end

function inmoto(arg) 

lua_thread.create(function ()
sampSendChat("/me со всего размаха ударил локтём по торсу человека.")
wait(500)
sampSendChat("/pull " .. arg .. "")
wait(500)
sampSendChat("/do Человек слетел с мотоцикла.")
end) 
end

function fo() 

lua_thread.create(function ()
sampSendChat("/do На плече сумка с аппаратурой.")
wait(800)
sampSendChat("/me снял сумку с плеча, после чего открыл её и залез рукой")
wait(800)
sampSendChat("/me вытащил наушники и радиочастотный перехватчик.")
wait(800)
sampSendChat("/me надел наушники и принялся обнаруживать нужную радиоволну")
wait(800)
sampSendChat("/me обнаружил подходящую радиоволну и подключился к ней")
wait(800)
sampSendChat("/r *Отключение рации*")
wait(800)
sampSendChat("/r (( Агент находится на прослушке. Связь с агентом только по телефону. ))")
wait(800)
sampSendChat("/follow")
end) 
end

function givedrugs(arg) 

lua_thread.create(function ()
sampSendChat("/do В правом кармане брюк пакетик с наркотическими веществами.")
wait(800)
sampSendChat("/me потянулся в правый карман брюк и вытащил пакетик")
wait(800)
sampSendChat("/me задел плечом рядом стоящего человека")
wait(800)
sampSendChat("/try незаметно просунул пакетик в карман человека.")
wait(800)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Если выпало «Неудачно», скажите что этот "чайный" пакетик выпал у Вас.', 0xffffff)
wait(800)
sampSendChat("/give " .. arg .. "")
end) 
end

function foff() 

lua_thread.create(function ()
sampSendChat("/me отключился от волны, после чего снял наушники.")
wait(800)
sampSendChat("/follow")
wait(800)
sampSendChat("/r *Включение рации*")
end) 
end

function vi() 

lua_thread.create(function ()
sampSendChat("/me потянулся к приборной панели автомобиля, затем нажал кнопку и разблокировал автомобиль")
wait(1000)
sampSendChat("/me вышел из автомобиля, затем достал брелок из кармана брюк и зажал кнопку закрытия автомобиля.")
end) 
end

function za() 

lua_thread.create(function ()
sampSendChat("/me достал брелок из кармана брюк и зажал кнопку открытия автомобиля")
wait(500)
sampSendChat("/me сел в автомобиль, затем нажал кнопку блокировки дверей на приборной панели автомобиля.")
end) 
end

function op() 

lua_thread.create(function ()
sampSendChat("/me достал ключи из кармана брюк, затем нажатием кнопки на брелке разблокировал двери транспорта")
wait(500)
sampSendChat("/me убрал ключи обратно в карман брюк.")
end) 
end

function cl() 

lua_thread.create(function ()
sampSendChat("/me достал ключи из кармана брюк, затем нажатием кнопки на брелке заблокировал двери транспорта")
wait(1000)
sampSendChat("/me убрал ключи обратно в карман брюк.")
end) 
end

function nar() 

lua_thread.create(function ()
sampSendChat("/do У гражданина был найден пакетик с наркотическими веществами.")
wait(500)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Сейчас необходимо изъять наркотики вручную.', 0xffffff)
wait(300)
sampSendChat("/me потянулся в левый карман брюк, после чего вытащил из него пакетик для улик")
wait(800)
sampSendChat("/me вытащил пакетиик с наркотическими веществами из кармана гражданина...")
wait(800)
sampSendChat("/me ... затем открыл пакетик для улик и сложил в него пакетик с наркотиками.")
end) 
end

function mask() 

lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк маска.")
wait(500)
sampSendChat("/me потянувшись в карман брюк, вытащил маску, затем натянул её на лицо.")
wait(500)
sampSendChat("/mask")
wait(500)
sampSendChat("/do Маска на лице.")
wait(500)
sampSendChat("/reset")
end) 
end

function healme() 

lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк шприц с обезбаливающим.")
wait(500)
sampSendChat("/me потянувшись в карман брюк, вытащил шприц и кольнул шприцом в рану.")
wait(500)
sampSendChat("/healme")
wait(500)
sampSendChat("/do Инъекция введена.")
end) 
end

function pt() 

lua_thread.create(function ()
sampSendChat("/do У гражданина было найдено определённое количество патронов.")
wait(500)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Сейчас необходимо изъять патроны вручную.', 0xffffff)
wait(300)
sampSendChat("/me потянулся в левый карман брюк, после чего вытащил из него пакетик для улик")
wait(800)
sampSendChat("/me вытащил все патроны из кармана гражданина...")
wait(800)
sampSendChat("/me ... затем открыл пакетик для улик и сложил в него патроны.")
end) 
end

function ot() 

lua_thread.create(function ()
sampSendChat("/do Отмычка в руках у заключённого.")
wait(500)
sampSendChat("/me резким движением руки выхватил отмычку из рук человека")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/todo Убрав отмычку в карман брюк*хорошая попытка, жаль неудачная.")
end) 
end

function biz() 
sampSendChat("/business")
end

function ja() 
sampSendChat("/jaildoor")
end

function fbi() 
sampSendChat("/fbi")
sampSendChat("/me провёл карточкой по электронному замку двери.") 
end

function open() 
sampSendChat("/open")
sampSendChat("/me достал пульт управления из кармана брюк, затем нажал на кнопку.") 
end

function rang(arg) 

lua_thread.create(function ()
sampSendChat("/do В левой руке новое удостоверение агента.")
wait(800)
sampSendChat("/me передал новое удостоверение агента человеку напротив")
wait(800)
sampSendChat("/rang " .. arg .. "", main_color)
end) 
end

function lec() 
sampShowDialog(0, "{0000FF}Лекции","{FFFFFF}| /lecgnk - лекция Управления по борьбе с наркотическими веществами\n| /leckso - лекция Криминально-Следственного Отдела\n| /lecns - лекция Управления Национальной Безопасности\n| /lecac - лекция академии ФБР", "Закрыть")
end

function lecac() 

lua_thread.create(function ()
sampSendChat("/f Товарищи, напоминаю Вам, что на портале Федерации открыты электронные...")
wait(300)
sampSendChat("/f Заявления на стажировку в Академию Федерального Бюро Расследований. ")
wait(300)
sampSendChat("/f Со всеми критериями и требованиями можно ознакомиться в разделе ФБР.")
end) 
end

function lecns() 

lua_thread.create(function ()
sampSendChat("/f Товарищи, если Вы увидете подозрительный автомобиль...")
wait(500)
sampSendChat("/f С людьми в масках, либо же услышите любую другую информацию связанную...")
wait(500)
sampSendChat("/f С терактом, экстремизмом или же похищением, немедленно сообщите...")
wait(500)
sampSendChat("/f Подробно все детали управлению Национальной Безопасности.")
end) 
end

function leckso() 

lua_thread.create(function ()
sampSendChat("/f В случае обнаружения нелегальных транспортировок оружия или патронов...")
wait(300)
sampSendChat("/f Или же обнаружите коррупцию в государственной организации")
wait(300)
sampSendChat("/f Немедленно обратитесь к Криминально-следственному отделу ФБР.")
end) 
end

function lecgnk() 

lua_thread.create(function ()
sampSendChat("/f В случае находки пакетиков с наркотическими веществами немедленно сообщите...")
wait(500)
sampSendChat("/f Агентству ФБР или же добровольно сдайте находку в пункт приёма, находящийся...")
wait(500)
sampSendChat("/f В холле офиса ФБР. В случае обнаружения скупщика или же продавца дури...")
wait(500)
sampSendChat("/f Немедленно передайте это дело Управлению по борьбе с наркотиками.")
end) 
end

function hack(arg) 

lua_thread.create(function ()
sampSendChat("/do В заднем кармане брюк отмычка.")
wait(800)
sampSendChat("/me потянулся в карман и вытащил отмычку, затем сунул её в замочную...")
wait(800)
sampSendChat("/me ...скважину и провернул её.")
wait(800)
sampSendChat("/hack " .. arg .. "", main_color)
end) 
end

function cs() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/changeskin " .. id .."")
wait(500)
sampSendChat("/do В руке пакет с формой сотрудников Федерального Бюро Расследований.")
wait(500)
sampSendChat("/me открыл пакет с формой, после чего вытащил новую форму и переоделся")
wait(500)
sampSendChat("/me сложил старую форму в пакет и закрыл его.")
end) 
end

function css(arg) 

lua_thread.create(function ()
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Подождите, агент должен взять пакет с формой.', 0xffffff)
sampSendChat("/changeskin " .. arg .."")
wait(500)
sampSendChat("/do В руке пакет с формой сотрудников Федерального Бюро Расследований.")
wait(500)
sampSendChat("/me передал пакет с формой человеку напротив.")
wait(500)
sampSendChat("/n /me взял пакет с формой")
end) 
end

function invite(arg) 

lua_thread.create(function ()
sampSendChat("/do В левой руке пакет с рацией и комплектом формы.")
wait(800)
sampSendChat("/me передал пакет человеку напротив")
wait(800)
sampSendChat("/invite " .. arg .. "", main_color)
wait(800)
sampSendChat("Добро пожаловать в Федеральное Бюро Расследований.")
end) 
end

function hacksp(arg)
lua_thread.create(function ()
sampSendChat("/hack " .. arg .. "")
end)
end

function ud(arg) 
lua_thread.create(function () 
sampSendChat("/do В заднем кармане брюк лежит удостоверение.")
wait(500)
sampSendChat("/me потянулся к заднему карману брюк и вытащил удостоверение")
wait(500)
sampSendChat("/anim 16")
wait(500)
sampSendChat("/me резким движением руки выставил удостоверение перед лицом человека.")
wait(500)
sampSendChat("/do На удостоверении единого типа указана информация о сотруднике.")
wait(1200)
sampSendChat("/do | ".. arg .. ".")
wait(1200)
sampSendChat("/do | §Удостоверение является действительным и подделке не подлежит§.")
end) 
end

function уд() 
lua_thread.create(function () 
sampSendChat("/do В заднем кармане брюк лежит удостоверение.")
wait(500)
sampSendChat("/me потянулся к заднему карману брюк и вытащил удостоверение")
wait(500)
sampSendChat("/anim 16")
wait(500)
sampSendChat("/me резким движением руки выставил удостоверение перед лицом человека.")
wait(500)
sampSendChat("/do На удостоверении единого типа указана информация о сотруднике.")
wait(1200)
sampSendChat("/do | Сотрудник: Fernando Cavalli.")
wait(1200)
sampSendChat("/do | Организация: Federal Bureau of Investigation.")
wait(1200)
sampSendChat("/do | Отдел: Управление по борьбе с наркотиками.")
wait(1200)
sampSendChat("/do | Должность сотрудника: Агент ГНК.")
wait(1200)
sampSendChat("/do | §Удостоверение является действительным и подделке не подлежит§.")
end) 
end

function geg() 

lua_thread.create(function () 
sampSendChat("Федеральное Бюро Расследований")
wait(800)
sampSendChat("/anim 16")
wait(800)
sampSendChat("/me предъявил значок сотрудника FBI №514873.")
wait(800)
sampSendChat("Вы находитесь в Федеральном розыске...")
wait(800)
sampSendChat("Советую не оказывать сопротивления.")
end) 
end

function su(arg) 

lua_thread.create(function ()
sampSendChat("/do В левом ухе гарнитура настроенная на волну FBI.")
wait(800)
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя.")
wait(800)
sampSendChat("/su " .. arg .. "", main_color)
wait(800)
sampSendChat("/do Преступник объявлен в Федеральный розыск.")
end) 
end

function fn(arg) 
sampSendChat("/f (( " .. arg .. " ))", main_color) 
end

function rn(arg) 
sampSendChat("/r (( " .. arg .. " ))", main_color) 
end

function f(arg) 

lua_thread.create(function () 
sampSendChat("/f  " .. arg .. "")
sampSendChat("/me потянувшись к гарнитуре правого уха, зажал кнопку и что-то сказал.")
end)
end

function r(arg) 

lua_thread.create(function () 
sampSendChat("/r  " .. arg .. "")
sampSendChat("/me потянувшись к гарнитуре левого уха, зажал кнопку и что-то сказал.")
end)
end

function clear(arg) 

lua_thread.create(function () 
sampSendChat("/me потянувшись в карман брюк, достал оттуда КПК")
wait(800)
sampSendChat("/me открыл базу данных Федерального Бюро Расследований")
wait(800)
sampSendChat("/me зашёл в раздел Уголовный розыск, обнаружил дело и закрыл его.")
wait(800)
sampSendChat("/clear " .. arg .. "", main_color)
wait(800)
sampSendChat("/do Дело №" .. arg .. " аннулировано из баз данных.")
end) 
end

function uncuff(arg) 

lua_thread.create(function () 
sampSendChat("/do Наручники застёгнуты на запястиях человека.")
wait(800)
sampSendChat("/me расстягнул наручники, после чего снял их и убрал в левый карман брюк.")
wait(800)
sampSendChat("/uncuff " .. arg .. "", main_color)
wait(800)
sampSendChat("/do Наручники лежат в левом кармане брюк.")
end) 
end

function report() 
lua_thread.create(function() 
sampSendChat("/mn") 
sampSendDialogResponse(27, 6, 5) 
sampSendDialogResponse(80, 1, 1) 
end) 
end

function cuff(arg) 

lua_thread.create(function () 
sampSendChat("/do В левом кармане брюк лежат наручники.")
wait(800)
sampSendChat("/me потянулся в левый карман, после чего резким движением руки вытащил наручники")
wait(800)
sampSendChat("/cuff " .. arg .. "", main_color)
wait(800)
sampSendChat("/me заломав руки человека, завёл их за спину и застягнул наручники.")
end) 
end

function sampev.onServerMessage(color, msg)
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()  
if msg:find("Вы {00b300}сняли одежду {3399FF}организации") then
sampSendChat("/do Перед агентом стоит домашний шкафчик с костюмами.")
wait(300)
sampSendChat("/me открыл шкафчик с костюмами, затем выбрал подходящий костюм и переоделся.")
end
if msg:find("Используйте {FFCD00}/mask {66CC00}для скрытия Вашего расположения на карте") then
sampSendChat("/me передал деньги кассиру для покупки некоторого количества масок.")
wait(800)
sampSendChat("/do Кассир взяв деньги из рук агента, передаёт пакет с масками.")
end
if msg:find("Вы купили набор аптечек. Введите {3399FF}/healme {66CC00}для их использования") then
sampSendChat("/me передал деньги кассиру для покупки некоторого количества аптечек.")
wait(800)
sampSendChat("/do Кассир взяв деньги из рук агента, передаёт пакет с аптечками.")
end
if msg:find("Используйте {6699FF}/eat {CECECE}чтобы поесть или {6699FF}/put {CECECE}чтобы положить поднос с едой") then
wait(500)  
sampSendChat("/eat")
end
if msg:find("Вы позвонили в службу точного времени") then
sampAddChatMessage('{4c4f45}[Диспетчер Анна] {FFFFFF}Время в Вашем городе: '..os.date('%H:%M:%S'), 0xffffff)
sampSendChat("/me посмотрел на часы марки «TS» с гравировкой «Лубянка».")
end
if msg:find("Прикрытие установлено") then
sampSendChat("/do Перед агентом стоит шкафчик с маскировочными костюмами.")
wait(700)
sampSendChat("/me открыл шкафчик с костюмами, затем выбрал подходящий костюм и переоделся.")
end
if msg:find("Вы взяли бронежилет") then
sampSendChat("/do Перед агентом стоит шкафчик c амуницией.")
wait(700)
sampSendChat("/me открыл шкафчик и взял всё необходимое.")
end
end)
end

function putpl(arg) 

lua_thread.create(function () 
sampSendChat("/me потянулся к дверной ручке автомобиля и открыл дверь")
wait(800)
sampSendChat("/me усадил человека в автомобиль")
wait(800)
sampSendChat("/putpl " .. arg .. "", main_color)
wait(800)
sampSendChat("/me захлопнул дверь за человеком.")
end) 
end

function arrest(arg) 

lua_thread.create(function () 
sampSendChat("/me потянулся к бардачку и открыл его.")
wait(1200)
sampSendChat("/do В бардачке лежат Уголовные дела розыскиваемых граждан Федерации.")
wait(1200)
sampSendChat("/me перебрал дела, затем нашёл подходящее и вытащил его")
wait(1200)
sampSendChat("/me вытащил авторучку из брюк рубашки и приготовился писать")
wait(1200)
sampSendChat("/me ввёл все корректировки в дело, после чего передал дело в участок.")
wait(1200)
sampSendChat("/arrest " .. arg .. "", main_color)
wait(1200)
sampSendChat("/do Уголовное Дело №" .. arg .. " отправлено в участок.")
end) 
end

function mon() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("TS")
wait(500)
sampSendChat("/do Жучок в часах агента определил голосовую команду и активировался.")
wait(500)
sampSendChat("/su " .. id .. " 2 жук", main_color)
end) 
end

function mayak() 
lua_thread.create(function ()
sampAddChatMessage('{800000}[TS Helper] Внимание!{FFFFFF} Данная команда раздаёт жуки ВСЕМ в радиусе 150 метров...', 0xffffff)
wait(500)
sampAddChatMessage('{800000}[TS Helper] {FFFFFF}Если Вы понимаете всю серьёзность затеянного, пропишите команду /mayakk', 0xffffff)
end)
end

function mayakk() 
lua_thread.create(function () 
sampSendChat("/do В кармане лежит портативное устройство активирующее маячки.")
wait(800)
sampSendChat("/me нажатием кнопки активировал устройство.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 2 жук для спец. операции", main_color)
wait(1200)
end 
end
end)
end

function order() 
lua_thread.create(function () 
sampSendChat("/do В левом ухе гарнитура настроенная на волну FBI.")
wait(800)
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителей.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 6 следствие", main_color)
wait(1200)
end 
end
end)
end

function глушилка() 
lua_thread.create(function () 
sampSendChat("/do В кармане лежит портативное устройство заглушающее маячки.")
wait(800)
sampSendChat("/me нажатием кнопки активировал устройство.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/clear " .. id .. "", main_color)
wait(800)
end 
end
end)
end

function strelba() 
local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
if valid and doesCharExist(ped) then
local result, id = sampGetPlayerIdByCharHandle(ped)
if result then
lua_thread.create(function ()
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя.")
wait(100)
sampSendChat("/su " .. id .. " 6 2.1 УК")
wait(1000)
sampSendChat("/do Преступник объявлен в Федеральный розыск.")
wait(1200)
sampSendChat("/f Срочно требуется поддержка, по агенту был открыт огонь. Код 1.")
end)
end
end
end

function pg(arg) 
lua_thread.create(function ()
sampSendChat("/me зажав кнопку на гарнитуре, сообщил диспетчеру данные нарушителя.")
wait(100)
sampSendChat("/su " .. arg .. " 3 9.1 УК")
wait(500)
sampSendChat("/su " .. arg .. " 3 9.5 УК")
wait(1000)
sampSendChat("/do Преступник объявлен в Федеральный розыск.")
wait(1200)
sampSendChat("/f Срочно требуется поддержка, преступник скрывается.")
end)
end

function moff()  
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do В правом кармане брюк лежит активированный жучок.")
wait(500)
sampSendChat("/me залез рукой в карман и деактивировал жучок нажатием кнопки.")
wait(500)
sampSendChat("/clear " .. id .. "", main_color)
wait(500)
sampSendChat("/do Жучок деактивирован.")
end) 
end

function search(arg) 

lua_thread.create(function () 
sampSendChat("/do В правом кармане брюк резиновые перчатки.")
wait(1000)
sampSendChat("/me вытащил перчатки из правого брюк и надел их")
wait(1000)
sampSendChat("/anim 45")
wait(1000)
sampSendChat("/me потянувшись к рукам человека, прощупал рукава человека")
wait(1000)
sampSendChat("/me провёл руками по торсу и тщательно проверил верхнюю одежду...")
wait(1000)
sampSendChat("/me ... на наличие жучков, камер и иных средст записи звука и видео.")
wait(1000)
sampSendChat("/anim 14")
wait(1000)
sampSendChat("/me потянувшись к ногам человека, похлопал по ним и прощупал носки человека.")
wait(1000)
sampSendChat("/search " .. arg .. "", main_color)
wait(500)
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Команды для обыска: /nar - изъять наркотики, /pt - изъять патроны.', 0xffffff)
end) 
end

function hold(arg) 

lua_thread.create(function () 
sampSendChat("/me заломал руки человека и завёл их за спину")
wait(800)
sampSendChat("/me повёл вперёд, крепко держа руки человека.")
wait(800)
sampSendChat("/hold " .. arg .. "", main_color)
wait(800)
sampSendChat("Проходим вперёд и не оглядываемся...")
end) 
end

function eject(arg) 

lua_thread.create(function () 
sampSendChat("/me потянулся к дверной ручке автомобиля и открыл дверь")
wait(500)
sampSendChat("/me вышел из автомобиля и вытащил человека из него.")
wait(500)
sampSendChat("/eject " .. arg .. "", main_color)
wait(1000)
sampAddChatMessage('{800000}[TS Helper] {FFFFFF}Если Вы вытащили человека в наручниках, следует снять и надеть их, иначе человек застрянет!', 0xffffff)
end) 
end

function ticket(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Напоминаю что Вы являетесь агентом, следовательно и ПДД не в вашей компитенции.', 0xffffff)
sampSendChat("/do В кармане брюк лежит блокнот для записей и авторучка.")
wait(1000)
sampSendChat("/me потянулся в карман брюк и вытащил блокнот с авторучкой")
wait(1000)
sampSendChat("/me заполняет бланк на выдачу штрафа.")
wait(1000)
sampSendChat("/do Бланк на выдачу штрафа заполнен.")
wait(1000)
sampSendChat("/me вырвал бланк из блокнота и протянул бланк человеку напротив.")
wait(1000)
sampSendChat("/ticket " .. arg .. "", main_color)
wait(1000)
sampSendChat("/todo Передав бланк человеку*Оплачивайте.")
end) 
end

function takelic(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[Диспетчер Анна] {FFFFFF}Напоминаю что Вы являетесь агентом, следовательно и ПДД не в вашей компитенции.', 0xffffff)
sampSendChat("/me достал КПК, после чего включил его и зашёл в базу данных FBI.")
wait(1000)
sampSendChat("/do КПК показал информацию.")
wait(1000)
sampSendChat("/me зафиксировал предупреждение в личном деле.")
wait(1000)
sampSendChat("/takelic " .. arg .. "", main_color)
wait(1000)
sampSendChat("/do Лицензия аннулирована.")
end) 
end

function setmark(arg) 

lua_thread.create(function () 
sampSendChat("/me достал КПК, после чего зашёл в список розыскиваемых и выбрал подходящее дело.")
wait(500)
sampSendChat("/setmark " .. arg .. "", main_color)
wait(500)
sampSendChat("/do КПК показал информацию.")
end) 
end

function so(arg) 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/f Внимание ! Объявлен план перехват автомобиля...")
wait(1000)
sampSendChat("/f с людьми в масках. Появилась угроза похищения. Немедленно отправляйтесь...")
wait(1000)
sampSendChat("/f в патрулирование в составе не менее двух человек.")
wait(1000)
sampSendChat("/f Последнее место обнаружения автомобиля: " .. arg .. ".", main_color)
wait(1000)
sampSendChat("/su " .. id .. " 2 жук", main_color)
end) 
end

function sos() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do В правом кармане брюк лежит неактивированный жучок на случай похищения.")
wait(1000)
sampSendChat("/me залез рукой в карман и активировал жучок нажатием кнопки.")
wait(1000)
sampSendChat("/su " .. id .. " 2 SOS", main_color)
wait(1000)
sampSendChat("/do Жучок активирован.")
wait(1000)
sampSendChat("/f Внимание ! Похищают человека, срочно требуется помощь!")
wait(1000)
sampSendChat("/su " .. id .. " 2 SOS", main_color)
wait(1000)
sampSendChat("/f Повторяю, срочно нужна помощь, человека похищают!")
end) 
end

function skipsp(arg)
lua_thread.create(function ()
sampSendChat("/skip " .. arg .. "")
end)
end

function susp(arg)
lua_thread.create(function ()
sampSendChat("/su " .. arg .. "")
end)
end

function clearsp(arg)
lua_thread.create(function ()
sampSendChat("/clear " .. arg .. "")
end)
end

function cuffsp(arg)
lua_thread.create(function ()
sampSendChat("/cuff " .. arg .. "")
end)
end

function uncuffsp(arg)
lua_thread.create(function ()
sampSendChat("/uncuff " .. arg .. "")
end)
end

function putplsp(arg)
lua_thread.create(function ()
sampSendChat("/putpl " .. arg .. "")
end)
end

function ejectsp(arg)
lua_thread.create(function ()
sampSendChat("/eject " .. arg .. "")
end)
end

function arrestsp(arg)
lua_thread.create(function ()
sampSendChat("/arrest " .. arg .. "")
end)
end

function holdsp(arg)
lua_thread.create(function ()
sampSendChat("/hold " .. arg .. "")
end)
end

function searchsp(arg)
lua_thread.create(function ()
sampSendChat("/search " .. arg .. "")
end)
end

function ticketsp(arg)
lua_thread.create(function ()
sampSendChat("/ticket " .. arg .. "")
end)
end

function takelicsp(arg)
lua_thread.create(function ()
sampSendChat("/takelic " .. arg .. "")
end)
end

function setmarksp(arg)
lua_thread.create(function ()
sampSendChat("/setmark " .. arg .. "")
end)
end

function allowsp(arg)
lua_thread.create(function ()
sampSendChat("/allow " .. arg .. "")
end)
end

function rangsp(arg)
lua_thread.create(function ()
sampSendChat("/rang " .. arg .. "")
end)
end

function invitesp(arg)
lua_thread.create(function ()
sampSendChat("/invite " .. arg .. "")
end)
end

function rsp(arg)
lua_thread.create(function ()
sampSendChat("/r " .. arg .. "")
end)
end

function fsp(arg)
lua_thread.create(function ()
sampSendChat("/f " .. arg .. "")
end)
end

function skipsp(arg)
lua_thread.create(function ()
sampSendChat("/skip " .. arg .. "")
end)
end

function fbisp(arg)
lua_thread.create(function ()
sampSendChat("/fbi " .. arg .. "")
end)
end
