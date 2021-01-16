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
-- ������ � ��� ��������� ������ ��������� �������. �� ����������� �� ��������� ��������� � ������, �� ����������� ������ ������ ����. ���� ����� ������ ������� �����, �� �� ������ ������. (Fernando Cavalli)
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
if imgui.Button(u8'                                               �������                                               ') then
function_window.v = not function_window.v
end
if function_window.v then
imgui.SetNextWindowPos(imgui.ImVec2(600, 465), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(1300, 760), imgui.Cond.FirstUseEver)
imgui.Begin(u8'FBI HELPER: ��/�� BSERVER', function_window)
imgui.Text(u8[[
											��������� ������ ����� ���������
����� 1. ���������� ����.
1.1 �� ���������� ����������� ����� ������� ��� ������� ������� ������������ ���� �/��� �� ���������� ������������������ ������� 
��� ���������� �������������� ��� ���������� ����� �������� ��������� �/��� ����������, �������������� ������������� 5-� ������� �������.
1.2 �� ���������� ����������� ����� ��������������� ���������� ��� ���������� ������������������ �������, �������������� ������������� 
5-� ������� �������, � ����� ����� � ������� 500$.

����� 2. ����������� ��������� �/��� ��������.
2.1 �� ����������� ��������� �� ���������� ��� �� ���������� ������������������ ������� �/��� �� ��������, �������������� �������������
6-� ������� �������.

����� 3. ������������ ��������.
3.1 �� ������� ����� ���������������� ��� �������� ������������� ��������, �������������� ������������� 2-� ������� �������.
3.2 �� ���� ���������������� ��� �������� ������������� ��������, �������������� ������������� 2-� ������� �������.
3.3 �� ����� ���������� ������������ ����, �������������� ������������� 1-�� ������� �������.
3.4 �� ����� ���������������� ����������, �������������� ������������� 2-� ������� �������.
]])
imgui.Text(u8[[
����� 4. ������������� ���������������� ����������.
4.1 �� ������� ����� ���. ���������, � �����, ���������� �������� �/��� ������������� � ������ �����, �������������� ������������� 2-�� ������� �������.
4.2 �� ������� ��� ������� ����� ���. ��������� �/��� ���� ������������� ������ ���. ��������, ������������ ������������� 4-�� ������� �������.

����� 5. ������.
5.1 �� ���� ��� ������� ���� ������ ������������ ����, �������������� ������������� 4-� ������� �������. (����������: ����. �������� ���)
5.2 �� ��������� ������ ����������� �����, ��� ������������� 5-� ������� �������, � ����� ����������� ��� �������� � ������ ������ ����������� �����������.
 (����������: ����. �������� ���)

����� 6. �������� ����������.
6.1 �� �������� ����������, �������������� �������� ��� ������ � �����-���� �����, �������������� ������������� 3-� ������� �������, � ����� �������������
�������� ������� � ������� 10.000$ �� ������ ���������� ��������.
]])
imgui.Text(u8[[
����� 7. ������.
7.1 �������� ������� � �������� ������ ��� �� � ������ ������, ������������ �������������� � ��� �� ���������������, ���������������, ������, ��� �� �������,
 ������� ������ � ������������� �������, ��� ���� ����������� ��� � ����� ������� ����� � �������. �������������� ������������� 2-� ������� �������. 
 ����������: ���������� ���, � ����� ���������� ��, ����������� �� ������� �������.
����������: ���� ������� �� ������� ���������� ����� ������ - ������������ ������ �����������.
7.2 �������� �� �������������� ������ ��� ��������� ����������. �������������� ������������� 2-� ������� �������.
7.2 �� �������� �������������, ��������������, �������������� �������, �� ���� �� �� ��������, �������������� ������������� 4-� ������� ������� � 
������������� �������� ������� � ������� 20.000$.
7.3 �� �������/�������/�������� ���������� �������� ������, �� �������� �������, � ����� �� �������� ������� �� �������� ��������� ������� �/��� 
���������� ������� ������, �������������� ������������� 5-� ������� �������.
7.4 �� ������������ ������ �/��� ��������, �� ���� �� �� ����������� ��������, �������������� ������������� 5-� ������� �������.
7.5 �� ���������� �������� ������ ��������� ���������, �������������� ������������� 6-� ������� ������� � ������� ���� ����� �������� � ����� 
������������� �������� ������� � ������� 50.000$ + ��������� � ׸���� ������ ���������.
7.6 �� ���������� �������� ������ ��������� ���������, ������� ���������� � ����-�������� ������� �����������, ����� ����������� ����������� � 
����������� ������ [5-� �������].. ����� ����, ������� ����������� ������������� �� ��������� ���������������.
]])
imgui.Text(u8[[
����� 8. ���������, ��������� � ����������, �����.
8.1 �� ������ ������ ��� ������ ����������, ���� �� ��������� �/��� ���. ��������, �� ��������� ��������, �� ����� �������������� ������������� 
6-� ������� �������, � ����� ������������� �������� ������� � ������� 50.000$ �� ������� ����������, ��� ����� ���� ��������.

����� 9. ������������.
9.1 �� ������������ ���������� ������������������ �������, ������������ ��� ����������, �������������� ������������� 3-� ������� �������.
9.2 �� ������������ ���������� ������������������ ������� ��� ���������� �� � ���������, � ��� �� ��� ���������� ����. ��������, ��������������
 ������������� 4-� ������� �������.
9.3 �� ������������ ��������� � ������� ���������� ������������������ �������, ������������ ��� ����������, �������������� ������������� 1-� ������� �������.
9.4 �� ����� �� ������� ������ ��� ��� ��� ��������������� �������, �������� �������� ������� ������������� �����, ����������� ������������� 1-� ������� �������.
9.5 �� ���������� ������� �������� ��������� (��������) �� ���������� ���, ���������� ������������� 3-� ������� �������.
]])
imgui.Text(u8[[
����� 10. �������������.
10.1. �� ������������� �� ���������� ������������������� �������� ����������, �������������� ������������� 3-� ������� �������.
10.2 �� ���������� ������������� �� ���������� �������� ������� ����, �������������� ������������� 2-� ������� �������. ������ ������� ���� 
����� ����� ���������/������������� �����������.
10.3 �� �������� ������������� �� ��������� ������ (������� ���� ��, ���, ���, ����������� ��, ���������), ������������� ������������� 6-� ������� �������.
10.4 ������������� � ����������� ����� �������� �������������(������������) ������� ����������, ���������� ������������� 2-� ������� �������.
10.5 ������������� � ������ ���. ���������� � ����� �/��� � �����������, ������������ 2-�� �������� ������� ����� ������������� �������� �������.
 (������ �� ��������� �� ����������� ��� ��� ����������.)
10.6 �� ������������� �� ���������� ����� ��� ��� ������������ ���������� �� ������������ ������ ���, �������������� ������������� 3-� ������� �������. (�����������)
]])
imgui.Text(u8[[
����� 11. ������������� ��������.
11.1 �� ����� ������������/�������� ������������� �������, �������������� ������������� 3-� ������� �������.
11.2 �� �������/�������/��������������� ������������� �������, �������������� ������������� 6-� ������� �������, � ��� �� ����������� � 
���������� ���������.
11.3 �� ������ � ������������� ������������� �������, ���������� ������������� 2-� ������� �������.
11.4 �� ������������ ����� ������������� ���������� �������������� ������������� 6-� ������� �������.
����� 12. ���������.
12.1 �� ������������/���������� �������, �������������� ������������� 6-� ������� �������, � ��� �� ������������ ������� ���� ����� ��������.
12.2 �� ���������� � ������� ��� ��� �������, �������������� ������������� 6-� ������� �������.
12.3 �� ��������������� ������ ���������� � ���������������� ����, �������������� ������������� 3-� ������� �������.
12.4 �� ������ � ���������� �������, �������������� ������������� 6-� �������
]])
imgui.Text(u8[[
����� 13. �����������.
13.1 �� ������������ ����������� ��� ����������� ���������, �������������� ������� ����, ��������������, �����������, 
�������������� ������������� 3-� ������� �������.
13.2 ������ ����� ����������� ��������������� �����������, �������������� ������������� 2-� ������� �������.
13.3 �� ���������� ��� ������� ����������, ���������� ������������� 3-� ������� �������.

����� 14. �������.
14.1 �� ���� ������������� ��������, ������� ��� ��������, ���������� ������������� 2-� ������� �������.
14.2 �� ����������� �������������������� ������� ����, ��������������� ������, ������������� 5-� ������� ������.
14.3 �� ������� � ������������������� ������� ����, ����������� � �������, ������������� 2-� ������� �������.
]])
imgui.Text(u8[[
����� 15. ���������.
15.1 �� ��������� � ������������ ����� ����� ���������� �������, ���������� ������������� ������� ������� �� ������, 
� ������� �� �����������.

����� 16. �������� �������.
16.1 �� �������� ������� ������������� �������������� ����� ��������� � ��������� ����, ���������� ������������� 2-� ������� 
������� � �������� �������� ������� ������������� �����.

17: ���������� �����������.
17.1: �������� ���������� �����������, � ����� ���������� ������������ ��� ����� ������������. 6-�� ������� �������.
17.2: ������� � ���������� �����������, ���������� ���������� ������ � ���������. 5-�� ������� �������.
17.3: ���������� ���������� ����������� � ���������� �������� ���������� ������. 4-�� ������� �������.

����� 18. �����������.
18.1 �� ����� ��� ����������� ���������� ������������������ �������, ���������� ������������� 3-� ������� �������.
]])
imgui.Text(u8[[
����� 19. �������� �������.
19.1 �� ������������� ��� ��������� ������������ ���������, ��������� �����, �������������� ������������� 3-� ������� �������.
19.2 �� ���������� ������������ ����������� � ���� ��������� �������, �������������� ������������� 3-� ������� �������.
19.3 �� ��������� ������ �� ���, �������������� ������������� 4-� ������� �������.
19.4 �� ������� �� ����� � ����� ��������� �������������� �������, ������������ ���������; ������������ � �������� ������������� ������� 
��� ����������� ������� ����, �������������� ������������� 4-� ������� �������.

����� 20. ���� �������� ������ ���������.
20.1 �� ���� �������� ������ ��������� ��������������, ���������, ������������ ��� ��������, ���������� ������������� 2-� ������� �������.

����� 21. ������ ������.
21.1 �� ������ ������ ���������� ������������ ���������� ���, �������������� ������������� 3-� ������� �������.
21.2 �� ������ ������ ���������� ������������ ���������� ��� ��� ���������� �� � ���������, �������������� ������������� 6-� ������� �������.

22. ��������������� ������.
22.1 �� ��������������� ������, ���������� ������������� 6-� ������� �������, ����������� ��������� � ����������� ������, � ��� �� ���������
 � ������ ������ ���������.
]])
imgui.Text(u8[[
23. ���������
23.1 ������ ��� ����� ����� ��������� ������� � ������ �� ��������� �������������. ����� ��������� ������������� ���������� 
������������������� ������, ���� �� ����� ������. (( ���������� - ��������� �� ������ ���. ����� ����� ������ ������ �� ���� ������,
 ����� ���� �������������� ��������, ��� ������� ����� ���������. ))

24. ����� ����������� ��������.
24.1 �� ����� ��� �� ������ ����������� ����� ��� ������������ ��������, ���������� ������������� 2-� ������� �������.
24.2 �� ����� ��� ��������� ������ ������������� �������� �� ���������� �����, ���������� ������������� 2-� ������� �������.

25. ������.
25.1 �� ������ � ������� ������������ ����, ���������� ������������� 1-� ������� �������.
25.2 �� ������ � ������� ���. ���������, ���������� ������������� 1-� ������� �������

]])
imgui.Text(u8[[
������ 26. ������������ ��������� � ������������ ������������ � �������������.
26.1 �� ���������� ����������� ����������, �������������� ������������� 3-� ������� �������.
26.2 �� ������������� �/��� ������������ ��������� ������������, �������������� ������������� 4-� ������� �������
26.3 �� ���������� ���������� ����������� ���������� �/��� ������������� ��������� ������������, ������� ����� ��������
 � ���������� ��������� ���������, �������������� ������������� 6 ������� �������, � ����� ������ "��" �� ������� ����

27. ���������� ����������� ������������������ �������.
27.1 � ������ ���� � �������� �����������, ������� ������� ��������� �� 1 �������.
27.3 � ������ �������� ���������� � ���� ���������, ������� ������� ����������� ��������� �� 2 ������� .

28. ������� � ������� ���. ����������.
28.1 �� ������� ���. ���������� ���������� ����� �������� 2-� ������� �������.
28.2 �� ������� ���. ����������, ���������� �������� 2-� ������� �������.
]])
imgui.Text(u8[[
29. ������� ������������.
29.1 �� ����������� ���������� ������ � ����� ������������ ������� ��������������� ������������� 1-� ������� �������.
29.2 �� ������� ��� ��������� �� �� ������� ������� �����������, ���������� ������� ������, ������ � �������� � ����,
 ���������� � ���������� ������������� ����� ������, ������������� 4-� ������� �������.
29.3 �� ������������ ������� ����������, ���� ��� �������� ������ �����������, ������������� 3-� ������� �������.
29.4 �� ������ �������������� ������� � ����� ����, ��������� ���������� ������������, ���������������� ��������� ��������. 
������� �������: ��������������� � ������������ � ������������ ��������������, ���������������� ��������� ������.

30. �������������� � �������������.
30.1 �� ������������� � ����� ������������ �������������� ������ ���������� 2-�� ������� �������.
30.2 �� ���������� �������������� �������� ������������ ��������� ������ ���������� 4-�� ������� ������� .
]])
imgui.Text(u8[[

����� �����

������ 31: ������������.
����� 1: ������������� �������� ����������� ������� ������, ����������� ��������� ������������, � ��������������� ��������� ��������.
����� 2: ������������� �������� ��� ����������� ������, ��������������� ��������� ��������, ��� � ������� ��� ����������.

������ 32: ������� ������������.
����� 1: ��������� ������������ �������� ����� ����, ������� ��������� ������������.
]])
imgui.Text(u8[[
������ 33: ��������� � ������������.
����� 1: ���������� ���� ��������� ������� ���� � ����� ��������� ������������ � ���������� ������������.
����� 2: ��� ����, ���������� � ������������ ����� ������ ���������������, � ������������� �� ������� ������� � ������������.
 ����������� ������������ ����� ���� ������������� ������� ����� �� ����������� � ���������� ������������.

������ 34: ���� ��������� �� ���������� ������������.
����� 1: ��������� ������ ��������� ��������: �����, ���������� ��� ������� � ��� �� ���������� ������������� �����, �������������� ������,
 ������� ������� �� ������������ ����, ��������� � ������ ������ ���������.

������ 35: ���������� ���������.
����� 1: ��� ��� ������������ ���� ��������� ��������� �� ���� ����������, �������������� ��������� ������, � ���������������� ����.
 ��� ����� ����� ��������� ��������� ���� ���������������� ������� ��� ������� ����������� ��������� ���������� �������������.
 ��� ����� ����� ��������� ��������� ���� ���������������� ������� ��� ������� ����������� ���������� �������������.
]])
imgui.Text(u8[[
����� 2: ����������� ���������������� ��������: �������������� ���������, �������� ���������� ���������, ������ � ��������� ������������,
 ��������� ����� ����.
����� 3: ����������� ���������������� ��������: ���������� ����� ������������ ��������, ���������� ������������ � ������� ������ ��� ��
 ���������������� �������, ������� ����������� ������������, ���������� ������������ � ��������� ����������� � �������������� ��������,
 ���������� ������������ � ��������� �������������� ���������.
����� 4: ��������� ��������� � ���� ������� ����� ��� ����� �����, ���� ����������� �������������� �� ������������, ������� �������� ��
 ����� ��������� ����������� ��� ����������� � ��������. ���������� ������� ���� ��������� ����������� �� ������� ���.
����� 5: ������������, ����������� ����������� ��������������� ����������� ��� ��������������� �������������� ������������ �� ���������
 � �������� �������. ����������� � ��������� (����������) ����������� ��������� �������:
1. ��� ��������� ����� �� ������ ������. (1.1, 2.1, 5.1, 5.2, 7.5, 8.1, 11.1, 11.2, 11.4, 12.1, 12.2, 12.4, 14.2, 19.1, 19.2, 19.3, 19.4,
 20.1, 22.1, 26.1, 26.2, 26.3, 29.2, 29.4 )
2. ��� ������������ ��������� ������� ������ ��. ������: �������, ����������� ������� � ���������� ������� �� �������� �������� ����������
 ���������� �������, ��������� �������� �� �����������, �������� ����������.
 9.1 + 9.5 + 14.3 + 18.1 = ����������� (����������) � ���������� ���������.
]])
imgui.Text(u8[[





]])

imgui.Text(u8[[

										���������������� ������ ����� ���������


������ �� ���������������� ��������������� � ���������������� ����������� ���, ������������ ������������ ��������� �� ����������� 
� ���������������� ���������������, � ����� ��������������� ����� ������, �������� ���� ���������������� �������������� 
(������� ����� ���� �������� �� ������������ ������), ������, ��������������� ����, ������� ����������� � ���������������� 
��������������� � ������� ���������� ������� �� ���������������� �����.?


����� 1. �������������� � ��������� �������.
1.1. ��������� ������ (( �� 20 HP )) ��� �������������� ��������, ��� ������� ����������� ��� �������� ����������, ������ ����. ����� 10.000$

]])
imgui.Text(u8[[
����� 2. ������������ ��������������.
2.1 ������� � ������������ �����. ����� 2.000$.
2.2 ������������ �������� � ������������ �����. ����� 2.000$.

����� 3. ��������������, ��������� � ��������������.
3.1 ������ �������. ����� - ��������� ����������� � ������������� �������.
3.2 ������������� ������������������� ������������ ��� ��������������� �����������, ����� 100.000$ � �������� ����������� �����������/����������.
3.3 �������������� ���������������/�������/������������� �������� � ����������������� ��� ��������������� ��������. 
�������� ����� � ������� 100.000$.
3.3 �������������� ����������� ������������� ������������ ���� ��� �� ������������� �����������. ����� � ������� ����������� ������.
3.4 ��������� ��������. ����� - 2.000$.

]])
imgui.Text(u8[[
����� 4. �������� ��������������.
4.1 �� ������ �� �������� ��������� ��� ������� �������.�����:15.000$.
4.2 ����������� ���������� ��������� ��������. �����: 50.000$

����� 5. ���������������� �������������� � ������� ��������� ��������.
5.1 �������� �� ���������� ��� ��������������� �������. ����� 2000$
5.2 ���������� � �������� �������� � ���������� �� ����������. ����� 3000$
5.3 ���������� ����������� �����������. [������ ��� �� ��������� � ���� �������������� �������������, ����������� 
������� �� ������������ ��������] ����� 2.500$.
5.4 ���������� ����������� ���������, ����������� � ����������� ��������� - ����� 2000$, � ����� ������� ���� �� ���������� �����������.
5.5 ������� ��������������, ��������� ���� ��� �� ������. ����� 1500$.
5.6 ���� � �������������� �������� ������. ����� 2.000$

]])
imgui.Text(u8[[
5.7 �������� ���������� �� ��������� ������ ��������, �� ����������� ���������������� ���������� � ������������� ��������. 
����� � 2000$. � ������ ���������� ��������� ������� ������� ������������� �������������.
5.8 �������� �� ������� � ���������. ����� 2.000$. � ������ ���������� ��������� ������� ������� ������������� �������������.
5.9 �������� ���������� ����� ��������������� �����. ����� 2.000$.
5.10 �������� ���������� � ������������ �����. ����� 1.000$. ����������: �� ����������� ������� �������� � �������, �����, 
�������, ����������� ������. ����� ������������ ������ ����� �������� �������� �����, ���� �� ��� ���� ������� ��� �������.
5.11 ���� ��� ���������� ������� �������� �������� � ������ ����� ����� (c 21:00 �� 6:00). ����� 2.000$.
5.12 ����� �������� ������ ������������� ��������, �������� ������������. ����� 2000$.

]])
imgui.Text(u8[[
5.13 ��������� ������ ������� ���������� ����������. (���������� ����� ��� ������� ������� � ������ 3.1 ����� 3 ���). 
����� 2.000$, � ������ ������ ������ ������������ �������� ������� ������� ������������� �������������.
5.14 ������������� ��������� ������� �� �� ����������. (������ ��������� c������ ��������� ������ ��� �������������� 
��� ��� ����������� �������� ������� ��������). ����� 2.000$.

����� 6. �����������(-��) �����/��������� � ������������ �����/�����������
6.1 ����������� ��������� � ������������ �����. ����� 1.000$.
6.2 ����������� ����� � ������� ����������, �����������. ����� 2.000$

]])
imgui.Text(u8[[
����� 7. �������������� � ��������� ��������������� �������
7.1 ���������� � �����������. (������ ��� �������������� ���������� � ������ ��������. ������ ��������� �� ����.) 
��� ������������� �����������: ����� � ������� 50.000$. ( � ���� ����� ���������) ��� ���: ������� ���������� 
�������� �������, ������� ������� ����������. ������ �������������, ��� ��������� ����������: ����� � ������� 30.000$.
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
		sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}������ TS Helper {CC0000}National Security{FFFFFF} ������� �������, ��������� �����������.', 0xffffff)
		sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}����� ������� ������� Fernando Cavalli. ������ � ������������� - "/ts".', 0xffffff)
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
		sampRegisterChatCommand("��", ��)
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
		sampRegisterChatCommand("��������", ��������)
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
		sampRegisterChatCommand("������", ������)
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
		sampRegisterChatCommand("��1", ��1)
		sampRegisterChatCommand("ts", ts)
 while true do
	wait(0)

		if isKeyJustPressed(key.VK_F2) then
		lua_thread.create(function ()
sampSendChat("���� ���������� �� ����� ������, ��� ������ ��������!")
wait(800)
sampSendChat("���� �� ������, ����� �� �����. ĸ������� - ����.")
end)
end
		if isKeyJustPressed(key.VK_F3) then
		lua_thread.create(function ()
sampSendChat("/m �������� ������������� ��������, ���������� ������������...")
wait(800)
sampSendChat("/m ...���������� � ������� � ��������� ���������, ���� �������� �� ����.")
wait(800)
sampSendChat("/m � ������ ������������ ����� ����������� ������� ���� �� ���������.")
wait(100)
sampAddChatMessage('{4c4f45}[TS Helper] {FF0000}ALT+P{FFFFFF} - ��������� ������ � ����������.{FF0000}CTRL+P{FFFFFF} - ��������� ����� �� ����������.', 0xffffff)
end)
end
		if isKeyJustPressed(key.VK_F4) then
		local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
		if valid and doesCharExist(ped) then
		local result, id = sampGetPlayerIdByCharHandle(ped)
		if result then
		lua_thread.create(function ()
		sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ����������.")
		wait(100)
		sampSendChat("/su " .. id .. " 6 2.1 ��")
		wait(1000)
		sampSendChat("/do ���������� �������� � ����������� ������.")
		wait(1200)
		sampSendChat("/f ������ ��������� ���������, �� ������ ��� ������ �����. ��� 1.")
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
		sampSendChat("/r ������ ��������� ������������ �� ��� ���.")
wait(800)
sampSendChat("/f ������ ��������� ������������ �� ��� ���. ")
wait(800)
sampSendChat("/su " .. id .. " 2 ���")
end)
end
if isKeyJustPressed(key.VK_F12) then
lua_thread.create(function ()
sampSendChat("/s �������� ������������� ��������, ���������� ������������...")
wait(1000)
sampSendChat("/s ...���������� � ������� � ��������� ���������, ���� �������� �� ����.")
wait(2000)
sampSendChat("/s � ������ ������������ ����� ����������� ������� ���� �� ���������.")
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
sampSendChat("/do � ������ ������� ���� �����.")
wait(500)
sampSendChat("/me ����������� � ������ ����, ������� �����, ����� ������� � �� ����.")
wait(500)
sampSendChat("/mask")
wait(500)
sampSendChat("/do ����� �� ����.")
wait(500)
sampSendChat("/reset")
end)		
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_R) then
		lua_thread.create(function ()
sampSendChat("/do � ������ ������� ���� ����� � ��������������.")
wait(500)
sampSendChat("/me ����������� � ������ ����, ������� ����� � ������� ������� � ����.")
wait(500)
sampSendChat("/healme")
wait(500)
sampSendChat("/do �������� �������.")
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
sampSendChat("/me ������� ������ �� ������� �������� � ����������� ���������� ���")
wait(1000)
sampSendChat("/me ���������� ������ ��������, ��������� �� �� ����������.")
wait(1000)
sampSendChat("/me ������ ��� � ����� � ���� ������ ������������ ���� �������������.")
wait(1000)
sampSendChat("/me ��������� ������������ ���������� ������� � ���")
wait(1000)
sampSendChat("/me �������� ������ � ����������� ������� � ������������ �������.")
wait(1000)
sampSendChat("/do ������ ������ ������ ����� �� ������������ �������.")
wait(1000)
sampSendChat("/try ��������� ��� ������ ����������� ������������ �������")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_6) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/hack ')
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_7) then
sampSendChat("/fbi")
sampSendChat("/me ����� ��������� �� ������������ ����� �����.") 
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_8) then
sampSendChat("/jaildoor")
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_9) then
sampSendChat("/open")
sampSendChat("/me ������ ����� ���������� �� ������� ����, ����� ����� �� ������.") 
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_0) then
sampSetChatInputEnabled(true)
sampSetChatInputText('/ud FC | FBI | National Secutiry | ������� �����')
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_M) then
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("TS")
wait(500)
sampSendChat("/do ����� � ����� ������ ��������� ��������� ������� � �������������.")
wait(500)
sampSendChat("/su " .. id .. " 2 ���", main_color)
end) 
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_G) then
lua_thread.create(function ()
sampSendChat("/m ��������, ���������� �������� � �������...")
wait(800)
sampSendChat("/m ������ ������ ���������� ������������ �������, �� �� ������� �����.")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_G) then
lua_thread.create(function ()
sampSendChat("/m �������� ����������, ���������� ���������� �������������!")
wait(800)
sampSendChat("/m ������������ ���� ������������� ��� ������ ������ ������������ �������.")
end)
end
if isKeyDown(key.VK_MENU) and isKeyJustPressed(key.VK_P) then
lua_thread.create(function ()
sampSendChat("/m �� �������� �� ������ ������������� ��������...")
wait(500)
sampSendChat("/m ... ��������� ��������� � ��������� ����� �� ����")
wait(500)
sampSendChat("/m ... ���� ������ �������� � � �� ���� �� �������.")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_P) then
lua_thread.create(function ()
sampSendChat("/m �������� �������� � ��������������� ������...")
wait(500)
sampSendChat("/m ... ��������� � ������ ������ ���������� � ������� �� ���� ����...")
wait(500)
sampSendChat("/m ... ���� ������ �������� � � �� ���� �� �������.")
end)
end
if isKeyDown(key.VK_CONTROL) and isKeyJustPressed(key.VK_M) then
		local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ���� ����� �������������� �����.")
wait(500)
sampSendChat("/me ����� ����� � ������ � ������������� ����� �������� ������.")
wait(500)
sampSendChat("/clear " .. id .. "", main_color)
wait(500)
sampSendChat("/do ����� �������������.")
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
sampShowDialog(6405, "{FFFFFF}������ ������ {4c4f45}�TS Helper�", "{ffffff}| /geg - �������� �������� � ���, ��� �� ���������\n| /fn [�����] - ��� ��������� � ����� ���\n| /rn [�����] - ��� ��������� � ����� ���\n| /nar - ������ ���������\n| /pt - ������ �������\n| /ud [��������]-[�����������]-[�����(�� �������)]-[���������] - ����� �������������\n(���������� �������� ��� ���� ������ ��������������)\n| /incar [id] - �������� �������� �� ����������\n| /inmoto [id] - ������� �������� � ���������\n| /mon  - ������������ ���� ��� ������\n| /moff  - �������������� ���� ������\n| /ton - ��������� ����������\n| /ot - �������� ������� � ������������\n| /cs  (/changeskin) - �������� ���� �����\n| /css [id] (/changeskin) - �������� �������� �����\n| /fo (/follow) - ������ ������������ ����� �����������\n| /foff (/follow) - ��������� ������������ �����\n| /ja (/jaildoor) - ������� ������ � ������\n| /cam - �������� �� ������\n| /������ - ��������� ���������\n| /pol - ��������� ����������� ���������\n| /palec - �������� ����������������� ���������\n| /otvet - ����� ��������� � ���������\n| /alp - ����������� ������������� ����������\n| /alpt (������) - ���������� �� ������\n| /alpf (��������) - ���������� ��������� �������\n| /alps - ������ ������������� ����������\n| /bomba - ������������� �����\n| /bt (������) - ������� ����������� �������\n| /bf1 (��������) - ��������� �������\n| /bf2 (�������� x2) - ��������� ������� �����\n| /bf3 (�������� x3) - ����� ����� � ������� � �������\n{800000}����������! {FFFFFF}��������� �������� �� ���� ����������� ��������, ����� /changeskin\n{4c4f45}�������������! {FFFFFF}������ ����������� ��������� ����� ���������� ��� �� ���������\n ��� ����� ���������� ������ � ����� ������� �sp� (������: /susp [id][��.�������][�������]", "�������")
wait(200)
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}C����� �������������� ������ - /cmd2. ������ ������������� ������ - /cmd3.', 0xffffff)
end)
end

function unc() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do ��������� �� ����� ��������. � ������ ������� ���� ����� �������.")
wait(800)
sampSendChat("/me ����� ������ � ������ ������ ����, ������� �������...")
wait(800)
sampSendChat("/me ...������� ���� ��������� �������� �������� ����������, ����� �������� �������...")
wait(800)
sampSendChat("/me ...� �������� �������� ����������, ��������� ������� ��������� ��� �� ������� �������.")
wait(800)
sampSendChat("/uncuff " .. id .. "", main_color)
wait(800)
sampSendChat("/do ��������� ������, ����� ���� ��������� ������������� � ����� �� �����.")
end) 
end

function cmd2()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}������ ������ {4c4f45}�TS Helper�", "{ffffff}| /hh [����������� �����] - ��������� ����� � ����������� ����������� ��������\n| /pp - ������� �������� ����� � ��\n| /so [���������] - ������������ ����������� ��� � ������ ���������\n| /sos  - ��������� ������ �� ������ ���������\n| /�������� - ��������� ��� ������ � ������� 5 ������\n| /mayak - ���������� ����� ��� ����. �������� ���� � ������� 150 ������\n| /strelba ( ���������� ����������� � �������� � ������ ������) - ����� ������ �� ���������\n��������, � �������� �� �������� � �������� � ������ �� ����� ���\n| /rasp - ���������� �������� ���/���\n| /prov - ��������� ����������� � ����������� ��������\n| /mo - ��������� ������ �� ���������� ������� ������������ �������\n| /krik - ��������\n| /meg - ���������� ���������� �����������\n| /megsp - ���������� ���������� ���������� �� ��������������� ������\n| /givedrugs [id] - ���������� �������� ���������\n| /unc  - ����� � ���� ��������� ��������\n| /rhelp  - ������� ������������ �� ����� ���\n| /fhelp  - ������� ������������ �� ����� ���\n| /soz - ������� ��� � �����\n| /epk(1-3) - ������ �������������� ������\n| /case - ��������� ����� � ���� � ���������� ��������\n| /caseact - ������������ ����� � ����� � ��������\n| /report - ������� �������� ������ �������\n| /dor - �������� ������ � /m\n| /pr - ���������� ������������� � /m\n| /pk - �������� ���������� � /m\n| /lec - ������ ������, �������� �� ����� ���\n| /vi - ����� �� ��������� ����������\n| /za - ����� � �������� ����������.\n| /op - �������������� ����� ����������\n| /cl - ������������� ����� ����������       /hexit - ��������� TS Helper.", "�������")
end)
end

function spec()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}����������� ������� {4c4f45}�TS Helper�", "{ffffff}| /mayak - ���������� ����� ��� ����. �������� ���� � ������� 150 ������\n| /order - ������� ��� ��������� ���� � �������\n| /�������� - �������������� ������ � ���� � �������.", "�������")
end)
end

function cmd3()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}������� � �� ���������� {4c4f45}�TS Helper�", "{ffffff}F2 - ��������\nF3 - �������\n���+F4 - /strelba\nF9 - /find\nF10 - /pg [id] - ������ ��� ������\nF11 - /rhelp+/fhelp\nF12 - ������� ��� ���������������� ����������\nALT+1 - /su\nALT+2 - /cuff\nALT+3 - /putpl\nALT+4 - /arrest\nALT+5 - /search\nALT+6 - /ticket\nALT+7 - /takelic\nALT+8 - /setmark\nALT+9 - /wanted\nALT+0 - /lock 1\nCTRL+1 - /clear\nCTRL+2 - /uncuff\nCTRL+3 - /eject\nCTRL+4 - /hold\nCTRL+5 - /mo\nCTRL+6 - /hack\nCTRL+7 - /fbi\nCTRL+8 - /jaildoor\nCTRL+9 - /open\nCTRL+0 - /ud\nALT+M - /mon\nCTRL+M - /moff\nALT+H - �������� ������\nCTRL+H - ���������� �������������\nALT+P - ��������� ������ � ����������\nCTRL+P ��������� ����� �� ����������", "�������")
end)
end

function epk1()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}����� ������ ����� ���/��/�� ��������!', 0xffffff)
end)
end

function epk2()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}����� ������ ����� ���/��/��  ��������!', 0xffffff)
end)
end

function epk3()
lua_thread.create(function ()
sampAddChatMessage('{4c4f45}[TS Helper] {FFFFFF}����� ������ ����� ���/��/��  ��������!', 0xffffff)
end)
end


function dor()
lua_thread.create(function ()
sampSendChat("/m ��������, ���������� �������� � �������...")
wait(800)
sampSendChat("/m ������ ������ ���������� ������������ �������, �� �� ������� �����.")
end)
end

function ts()
one_win.v = not one_win.v
end

function pr()
lua_thread.create(function ()
sampSendChat("/m �������� ����������, ���������� ���������� �������������!")
wait(800)
sampSendChat("/m ������������ ���� ������������� ��� ������ ������ ������������ �������.")
end)
end

function hexit()
lua_thread.create(function ()
sampAddChatMessage('{800000}[Tside System] {FFFFFF}������ TS Helper ��������.', 0xffffff)
file:close ()
end)
end

function pk()
lua_thread.create(function ()
sampSendChat("/m �������� �������� � ��������������� ������...")
wait(500)
sampSendChat("/m ... ��������� � ������ ������ ���������� � ������� �� ���� ����...")
wait(500)
sampSendChat("/m ... ���� ������ �������� � � �� ���� �� �������.")
end)
end

function pn()
lua_thread.create(function ()
sampSendChat("/m �� �������� �� ������ ������������� ��������...")
wait(500)
sampSendChat("/m ... ��������� ��������� � ��������� ����� �� ����")
wait(500)
sampSendChat("/m ... ���� ������ �������� � � �� ���� �� �������.")
end)
end

function rhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/r ������ ��������� ������������ �� ��� ���. ��������, ��������� ������������.")
wait(100)
sampSendChat("/su " .. id .. " 2 ���")
end)
end

function case()
lua_thread.create(function ()
sampSendChat("/do � ������ ������������� �������� ����� ��� �����.")
wait(1000)
sampSendChat("/me ���� ���� � ���������� ��������, ����� ���� ������ ���")
wait(1000)
sampSendChat("/me ������� ����� �� ���� � ������� ��� ����� �����.")
wait(1000)
sampSendChat("/do ����� �������������� ���������� ������������ �������� �� ������ ������.")
wait(1000)
sampSendChat("/me ���������� � ������������ �����, ������ ���� � ������� ��� ����� �� ������.")
wait(1000)
sampSendChat("/do ����� ����� � ������ ������� ����.")
end)
end

function caseact()
lua_thread.create(function ()
sampSendChat("/do ����� ����� � ������ ������� ����.")
wait(500)
sampSendChat("/me ����� ���� � ������ ������ ����, ����� �� ������ ��������� �����.")
wait(500)
sampSendChat("/try �������� � ���, ��� ����� � ����� �����������")
end)
end

function fhelp()
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/f ������ ��������� ������������ �� ��� ���. ��������, ��������� ������������.")
wait(100)
sampSendChat("/su " .. id .. " 2 ���")
end)
end

function soz()
lua_thread.create(function ()
sampSendChat("/f ������� ������ �� � SWAT ����� � ����� ���!")
wait(100)
sampSendChat("/f ������� ������ �� � SWAT ����� � ����� ���!")
end)
end

function rasp()
lua_thread.create(function ()
sampShowDialog(6405, "{FFFFFF}���������� �������� ���/��� {4c4f45}�TS Helper�", "{ffffff}| ����������� - ������������ ���������� ���\n| ������� - ������������ �������\n| ����� - �������� �������� ����������\n| ������� - ������������ ���������������\n| ������� - �������������\n| ������� - ���� ������������ ��������\n| ����������� - ���� ������������ ��������", "�������")
end)
end

function meg()
lua_thread.create(function ()
sampSendChat("/m �������� ������������� ��������, ���������� ������������...")
wait(800)
sampSendChat("/m ...���������� � ������� � ��������� ���������, ���� �������� �� ����.")
wait(800)
sampSendChat("/m � ������ ������������ ����� ����������� ������� ���� �� ���������.")
end)
end

function krik()
lua_thread.create(function ()
sampSendChat("���� ���������� �� ����� ������, ��� ������ ��������!")
wait(800)
sampSendChat("���� �� ������, ����� �� �����. ĸ������� - ����.")
end)
end

function megsp()
lua_thread.create(function ()
sampSendChat("/s �������� ������������� ��������, ���������� ������������...")
wait(1000)
sampSendChat("/s ...���������� � ������� � ��������� ���������, ���� �������� �� ����.")
wait(2000)
sampSendChat("/s � ������ ������������ ����� ����������� ������� ���� �� ���������.")
end)
end

function prov()
lua_thread.create(function ()
sampSendChat("������� ��������� ������������ ���� �������������")
wait(800)
sampSendChat("��������� ��� � ����������� �������� �� ������� ����������� ���������")
wait(800)
sampSendChat("������ ����� ������������� � ��������� �����������.")
end)
end

function mo()
lua_thread.create(function ()
sampSendChat("/me ������� ������ �� ������� �������� � ����������� ���������� ���")
wait(1000)
sampSendChat("/me ���������� ������ ��������, ��������� �� �� ����������.")
wait(1000)
sampSendChat("/me ������ ��� � ����� � ���� ������ ������������ ���� �������������.")
wait(1000)
sampSendChat("/me ��������� ������������ ���������� ������� � ���")
wait(1000)
sampSendChat("/me �������� ������ � ����������� ������� � ������������ �������.")
wait(1000)
sampSendChat("/do ������ ������ ������ ����� �� ������������ �������.")
wait(1000)
sampSendChat("/try ��������� ��� ������ ����������� ������������ �������")
end)
end

function pol()
lua_thread.create(function ()
sampSendChat("/me ������� ��������")
wait(1200)
sampSendChat("/me �������� ����� ����� �������")
wait(1200)
sampSendChat("/me ��������� ������ �������� �������")
wait(1200)
sampSendChat("/me ��������� ������ ��������������� �������")
wait(1200)
sampSendChat("/me ��������� ������������������ �� ����� ��������������")
wait(1200)
sampSendChat("/me ��������� ������� ������������ ����������")
wait(1200)
sampSendChat("/me ��������� ������ ������� �������")
wait(1200)
sampSendChat("/me ��������� ������ ����� �������������� �������")
wait(1200)
sampSendChat("/me �������� ������������ ����������� ��������.")
wait(1200)
sampSendChat("/try �������� � ������������ ����������� ��������")
end)
end

function alp()
lua_thread.create(function ()
sampSendChat("/do �� ����� ����� � ������������� �����������.")
wait(800)
sampSendChat("/me ���� ����� � �����, ����� ���� ������ �.")
wait(800)
sampSendChat("/do � ����� ��������� �������� � ����� � ������.")
wait(800)
sampSendChat("/me �������� ����� � ������ � ���������, ������� ���������� �������.")
wait(800)
sampSendChat("/try ��������� ��� ���� ��������� �� �����")
end)
end

function alpt()
lua_thread.create(function ()
sampSendChat("/break 1")
wait(500)
sampSendChat("/me ���������� ��� ���� ������ ��������, ����� ������.")
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
sampSendChat("/do � ������ ������� ���� ����� ����� �� ����������.")
wait(500)
sampSendChat("/me ����������� � ������ ����, ������� �����, ����� ������� �� �������� ��������.")
wait(500)
sampSendChat("/allow " .. arg .. "")
end)
end

function skip(arg)
lua_thread.create(function ()
sampSendChat("/do � ������ ������� ���� ����� �������.")
wait(800)
sampSendChat("/me ����������� ����� ����� � ������ ����, ������� �������...")
wait(800)
sampSendChat("/me ...����� ���� �������� ��� � ������� �������� ��������.")
wait(800)
sampSendChat("/skip " .. arg .. "")
end)
end

function cam()
lua_thread.create(function ()
sampSendChat("/do � �������� ������� �������� ������� �����������.")
wait(500)
sampSendChat("/do ������ ���������� ���� � ����� � ������� ��������.")
end)
end

function alpf()
lua_thread.create(function ()
sampSendChat("/me ��������� ��� ���� �� ��������, �������� ��������� ��������� ������ ���������.")
wait(500)
sampSendChat("/me �������� ����� � ������ � ���������, ������� ���������� �������.")
wait(500)
sampSendChat("/try ��������� ��� ���� ��������� �� �����")
end)
end

function alps()
lua_thread.create(function ()
sampSendChat("/do ���� ��������� � �����������.")
wait(800)
sampSendChat("/me ������� ���� �� �����������, ����� ���� �������� ��������� �������� ���������.")
wait(800)
sampSendChat("/break 0")
wait(800)
sampSendChat("/me �������� ��������, ������ ���������� � ����� � ������ �")
wait(800)
sampSendChat("/me ������� ����� � ������������� ����������� �� �����.")
wait(800)
sampSendChat("/do �� ����� ����� � ������������� �����������.")
end)
end

function bomba()
lua_thread.create(function ()
sampSendChat("/do �� ����� ����� � �������� ������ �����.")
wait(1200)
sampSendChat("/me ���� ����� � ����� � ������ �.")
wait(1200)
sampSendChat("/do � ����� ����� ���������, ����� � ��������. ����� ������� �����.")
wait(1200)
sampSendChat("/me ���� ����� � ���� � ����������� �������� �.")
wait(1200)
sampSendChat("/do �� ����� ������ ��� ������, �������� ����� ����� ��� �������...")
wait(1200)
sampSendChat("/do ...������� ���������� ������� �������.")
wait(1200)
sampSendChat("/me ��������� � ������ ����� � ������� �� ���� �������")
wait(1200)
sampSendChat("/me �������� �������� ��� ������ �����")
wait(1200)
sampSendChat("/do � ���� ������ ������ �����.")
wait(1200)
sampSendChat("/me ������� ����� ����� � ������� �����")
wait(1200)
sampSendChat("/me ��������� � ������ �����, ����� ��������� ���� �.")
wait(1200)
sampSendChat("/do ����� ������� ��� �������: �������, ����� � ������.")
wait(1200)
sampSendChat("/me ��������� � ������ ����� � ������� �� ���� �����.")
wait(1200)
sampSendChat("/do ����� ������� ������������ �� ����� ��������������� �� ����.")
wait(1200)
sampSendChat("/me �������������, ��������� ������� � �������� ������� � ��������� ���.")
wait(1200)
sampSendChat("/try ��������� ��� ������ �����������.")
end)
end

function bt()
lua_thread.create(function ()
sampSendChat("/do ����� ������� �����������.")
wait(1200)
sampSendChat("/me � ������� �� ���� ����� �����, ������� � ����� � �����.")
wait(1200)
sampSendChat("/do ����������� � ����� � �������� ������ �����.")
wait(1200)
sampSendChat("/me ������ ����� � ������� � �� �����.")
wait(1200)
sampSendChat("/do �� ����� ����� � �������� ������ �����.")
end)
end

function palec()
lua_thread.create(function ()
sampSendChat("/anim 16")
wait(500)
sampSendChat("/todo ��������� ��� ������*������� ������� � ���������?")
end)
end

function otvet()
lua_thread.create(function ()
sampSendChat("/me ���� ��������� � ���������.")
wait(500)
sampSendChat("/try ��������� ������ � ������ �����������")
end)
end

function bf1()
lua_thread.create(function ()
sampSendChat("/do ������ �� ������ ���������� � ����. �� ������ 1 ������.")
wait(1200)
sampSendChat("/me �������������, ��������� ������� � ������ ������� � ��������� ���.")
wait(1200)
sampSendChat("/try ��������� ��� ������ �����������.")
end)
end

function ������()
lua_thread.create(function ()
sampSendChat("/do � ����� ����� ��������� ����������� ���.")
wait(500)
sampSendChat("/anim 14")
wait(500)
sampSendChat("/me ��������� ������, ��������� ���������, ����� ���� ����� ��� ������� � �����.")
wait(500)
sampSendChat("������ ��� �� ����!")
end)
end

function bf2()
lua_thread.create(function ()
wait(300)
sampSendChat("/do ������ �� ������ ���������� � ����. �� ������ 30 ������.")
wait(1200)
sampSendChat("/me ��������� � ���������� ������� ������� � ��������� ���.")
wait(1200)
sampSendChat("/try ��������� ��� ������ �����������.")
end)
end

function bf3()
lua_thread.create(function ()
wait(300)
sampSendChat("/do ������ ������ ����������� ������� � 5 ������.")
wait(2000)
sampSendChat("/me ���������� ������� ���� ��������, ���� ����� � ������� � �������.")
wait(5000)
sampSendChat("/do ��������� �����. ������ ��������� �� �������.")
end)
end

function ton() 
local veh = storeCarCharIsInNoSave(PLAYER_PED)
lua_thread.create(function ()
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}����� �������������, �� ����� �������� ��� ��������������� ���������.', 0xffffff)
sampSendChat("/do ����� ������������� �������� ������������.")
wait(800)
sampSendChat("/do ����� ������������� �������� �������������.")
wait(800)
sampSendChat("/do ������������������� ������ ������������� �������� �����������.")
wait(800)
sampSendChat("/do ������������ �� ������ ������������� �������� ���������� ����.")
wait(800)
sampSendChat("/do �������� �� ��������� ������ ������� ���� �������.")
wait(1000)
sampSendChat("/do �� ������������ �������� ���������� ��������������� ����� � ���. �����.")
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}����� �� ��������� ���������� - /vi , ����� - /za .', 0xffffff)
end) 
end

function hh(arg) 

lua_thread.create(function ()
sampSendChat("/me ��������� ����� ����� � ������ ����, ����� ���� ������ �� ���� �������.")
wait(800)
sampSendChat("/h")
wait(800)
sampSendChat("/sms " .. arg .. " [������������] ������� ��������� ��� ���� �������� ����")
wait(800)
sampSendChat("/sms " .. arg .. " [������������] ��������� ������� ������� �����.")
wait(800)
sampSendChat("/sms " .. arg .. " [������������] The subscriber is out of coverage area.")
wait(800)
sampSendChat("/togphone")
wait(800)
sampSendChat("/me �������� �������, ����� ��� ������� � ������ ����.")
end) 
end

function pp() 

lua_thread.create(function ()
sampSendChat("/me ��������� ����� ����� � ������ ����, ����� ���� ������ �� ���� �������.")
wait(1000)
sampSendChat("/p")
wait(300)
sampSendChat("[������������] ��� �������� �� ������ ����� ������ �������������� � ������������.")
wait(800)
sampSendChat("*�������� ������*")
wait(800)
sampSendChat("���������� ������������ ������������ �� �����...")
end) 
end

function incar(arg) 

lua_thread.create(function ()
sampSendChat("/me �� ����� ������� ������ ����� �� ������ ����������.")
wait(800)
sampSendChat("/do ������ ��������� � ��������.")
wait(800)
sampSendChat("/me ����� ���� � ����� ����������, ��������� � �����...")
wait(800)
sampSendChat("/me ... � ����� �, ��� ����� ������ ����� ����������")
wait(800)
sampSendChat("/me ������� �������� �� ������ � ������� �� ����������.")
wait(800)
sampSendChat("/pull " .. arg .. "")
end) 
end

function inmoto(arg) 

lua_thread.create(function ()
sampSendChat("/me �� ����� ������� ������ ����� �� ����� ��������.")
wait(500)
sampSendChat("/pull " .. arg .. "")
wait(500)
sampSendChat("/do ������� ������ � ���������.")
end) 
end

function fo() 

lua_thread.create(function ()
sampSendChat("/do �� ����� ����� � �����������.")
wait(800)
sampSendChat("/me ���� ����� � �����, ����� ���� ������ � � ����� �����")
wait(800)
sampSendChat("/me ������� �������� � �������������� �����������.")
wait(800)
sampSendChat("/me ����� �������� � �������� ������������ ������ ����������")
wait(800)
sampSendChat("/me ��������� ���������� ���������� � ����������� � ���")
wait(800)
sampSendChat("/r *���������� �����*")
wait(800)
sampSendChat("/r (( ����� ��������� �� ���������. ����� � ������� ������ �� ��������. ))")
wait(800)
sampSendChat("/follow")
end) 
end

function givedrugs(arg) 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ���� ������� � �������������� ����������.")
wait(800)
sampSendChat("/me ��������� � ������ ������ ���� � ������� �������")
wait(800)
sampSendChat("/me ����� ������ ����� �������� ��������")
wait(800)
sampSendChat("/try ��������� �������� ������� � ������ ��������.")
wait(800)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}���� ������ ���������, ������� ��� ���� "������" ������� ����� � ���.', 0xffffff)
wait(800)
sampSendChat("/give " .. arg .. "")
end) 
end

function foff() 

lua_thread.create(function ()
sampSendChat("/me ���������� �� �����, ����� ���� ���� ��������.")
wait(800)
sampSendChat("/follow")
wait(800)
sampSendChat("/r *��������� �����*")
end) 
end

function vi() 

lua_thread.create(function ()
sampSendChat("/me ��������� � ��������� ������ ����������, ����� ����� ������ � ������������� ����������")
wait(1000)
sampSendChat("/me ����� �� ����������, ����� ������ ������ �� ������� ���� � ����� ������ �������� ����������.")
end) 
end

function za() 

lua_thread.create(function ()
sampSendChat("/me ������ ������ �� ������� ���� � ����� ������ �������� ����������")
wait(500)
sampSendChat("/me ��� � ����������, ����� ����� ������ ���������� ������ �� ��������� ������ ����������.")
end) 
end

function op() 

lua_thread.create(function ()
sampSendChat("/me ������ ����� �� ������� ����, ����� �������� ������ �� ������ ������������� ����� ����������")
wait(500)
sampSendChat("/me ����� ����� ������� � ������ ����.")
end) 
end

function cl() 

lua_thread.create(function ()
sampSendChat("/me ������ ����� �� ������� ����, ����� �������� ������ �� ������ ������������ ����� ����������")
wait(1000)
sampSendChat("/me ����� ����� ������� � ������ ����.")
end) 
end

function nar() 

lua_thread.create(function ()
sampSendChat("/do � ���������� ��� ������ ������� � �������������� ����������.")
wait(500)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}������ ���������� ������ ��������� �������.', 0xffffff)
wait(300)
sampSendChat("/me ��������� � ����� ������ ����, ����� ���� ������� �� ���� ������� ��� ����")
wait(800)
sampSendChat("/me ������� �������� � �������������� ���������� �� ������� ����������...")
wait(800)
sampSendChat("/me ... ����� ������ ������� ��� ���� � ������ � ���� ������� � �����������.")
end) 
end

function mask() 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ���� �����.")
wait(500)
sampSendChat("/me ����������� � ������ ����, ������� �����, ����� ������� � �� ����.")
wait(500)
sampSendChat("/mask")
wait(500)
sampSendChat("/do ����� �� ����.")
wait(500)
sampSendChat("/reset")
end) 
end

function healme() 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ���� ����� � ��������������.")
wait(500)
sampSendChat("/me ����������� � ������ ����, ������� ����� � ������� ������� � ����.")
wait(500)
sampSendChat("/healme")
wait(500)
sampSendChat("/do �������� �������.")
end) 
end

function pt() 

lua_thread.create(function ()
sampSendChat("/do � ���������� ���� ������� ����������� ���������� ��������.")
wait(500)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}������ ���������� ������ ������� �������.', 0xffffff)
wait(300)
sampSendChat("/me ��������� � ����� ������ ����, ����� ���� ������� �� ���� ������� ��� ����")
wait(800)
sampSendChat("/me ������� ��� ������� �� ������� ����������...")
wait(800)
sampSendChat("/me ... ����� ������ ������� ��� ���� � ������ � ���� �������.")
end) 
end

function ot() 

lua_thread.create(function ()
sampSendChat("/do ������� � ����� � ������������.")
wait(500)
sampSendChat("/me ������ ��������� ���� �������� ������� �� ��� ��������")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/jaildoor")
wait(500)
sampSendChat("/todo ����� ������� � ������ ����*������� �������, ���� ���������.")
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
sampSendChat("/me ����� ��������� �� ������������ ����� �����.") 
end

function open() 
sampSendChat("/open")
sampSendChat("/me ������ ����� ���������� �� ������� ����, ����� ����� �� ������.") 
end

function rang(arg) 

lua_thread.create(function ()
sampSendChat("/do � ����� ���� ����� ������������� ������.")
wait(800)
sampSendChat("/me ������� ����� ������������� ������ �������� ��������")
wait(800)
sampSendChat("/rang " .. arg .. "", main_color)
end) 
end

function lec() 
sampShowDialog(0, "{0000FF}������","{FFFFFF}| /lecgnk - ������ ���������� �� ������ � �������������� ����������\n| /leckso - ������ �����������-������������� ������\n| /lecns - ������ ���������� ������������ ������������\n| /lecac - ������ �������� ���", "�������")
end

function lecac() 

lua_thread.create(function ()
sampSendChat("/f ��������, ��������� ���, ��� �� ������� ��������� ������� �����������...")
wait(300)
sampSendChat("/f ��������� �� ���������� � �������� ������������ ���� �������������. ")
wait(300)
sampSendChat("/f �� ����� ���������� � ������������ ����� ������������ � ������� ���.")
end) 
end

function lecns() 

lua_thread.create(function ()
sampSendChat("/f ��������, ���� �� ������� �������������� ����������...")
wait(500)
sampSendChat("/f � ������ � ������, ���� �� �������� ����� ������ ���������� ���������...")
wait(500)
sampSendChat("/f � ��������, ������������ ��� �� ����������, ���������� ��������...")
wait(500)
sampSendChat("/f �������� ��� ������ ���������� ������������ ������������.")
end) 
end

function leckso() 

lua_thread.create(function ()
sampSendChat("/f � ������ ����������� ����������� ��������������� ������ ��� ��������...")
wait(300)
sampSendChat("/f ��� �� ���������� ��������� � ��������������� �����������")
wait(300)
sampSendChat("/f ���������� ���������� � �����������-������������� ������ ���.")
end) 
end

function lecgnk() 

lua_thread.create(function ()
sampSendChat("/f � ������ ������� ��������� � �������������� ���������� ���������� ��������...")
wait(500)
sampSendChat("/f ��������� ��� ��� �� ����������� ������ ������� � ����� �����, �����������...")
wait(500)
sampSendChat("/f � ����� ����� ���. � ������ ����������� �������� ��� �� �������� ����...")
wait(500)
sampSendChat("/f ���������� ��������� ��� ���� ���������� �� ������ � �����������.")
end) 
end

function hack(arg) 

lua_thread.create(function ()
sampSendChat("/do � ������ ������� ���� �������.")
wait(800)
sampSendChat("/me ��������� � ������ � ������� �������, ����� ����� � � ��������...")
wait(800)
sampSendChat("/me ...�������� � ��������� �.")
wait(800)
sampSendChat("/hack " .. arg .. "", main_color)
end) 
end

function cs() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()
sampSendChat("/changeskin " .. id .."")
wait(500)
sampSendChat("/do � ���� ����� � ������ ����������� ������������ ���� �������������.")
wait(500)
sampSendChat("/me ������ ����� � ������, ����� ���� ������� ����� ����� � ����������")
wait(500)
sampSendChat("/me ������ ������ ����� � ����� � ������ ���.")
end) 
end

function css(arg) 

lua_thread.create(function ()
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}���������, ����� ������ ����� ����� � ������.', 0xffffff)
sampSendChat("/changeskin " .. arg .."")
wait(500)
sampSendChat("/do � ���� ����� � ������ ����������� ������������ ���� �������������.")
wait(500)
sampSendChat("/me ������� ����� � ������ �������� ��������.")
wait(500)
sampSendChat("/n /me ���� ����� � ������")
end) 
end

function invite(arg) 

lua_thread.create(function ()
sampSendChat("/do � ����� ���� ����� � ������ � ���������� �����.")
wait(800)
sampSendChat("/me ������� ����� �������� ��������")
wait(800)
sampSendChat("/invite " .. arg .. "", main_color)
wait(800)
sampSendChat("����� ���������� � ����������� ���� �������������.")
end) 
end

function hacksp(arg)
lua_thread.create(function ()
sampSendChat("/hack " .. arg .. "")
end)
end

function ud(arg) 
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ���� ����� �������������.")
wait(500)
sampSendChat("/me ��������� � ������� ������� ���� � ������� �������������")
wait(500)
sampSendChat("/anim 16")
wait(500)
sampSendChat("/me ������ ��������� ���� �������� ������������� ����� ����� ��������.")
wait(500)
sampSendChat("/do �� ������������� ������� ���� ������� ���������� � ����������.")
wait(1200)
sampSendChat("/do | ".. arg .. ".")
wait(1200)
sampSendChat("/do | �������������� �������� �������������� � �������� �� ��������.")
end) 
end

function ��() 
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ���� ����� �������������.")
wait(500)
sampSendChat("/me ��������� � ������� ������� ���� � ������� �������������")
wait(500)
sampSendChat("/anim 16")
wait(500)
sampSendChat("/me ������ ��������� ���� �������� ������������� ����� ����� ��������.")
wait(500)
sampSendChat("/do �� ������������� ������� ���� ������� ���������� � ����������.")
wait(1200)
sampSendChat("/do | ���������: Fernando Cavalli.")
wait(1200)
sampSendChat("/do | �����������: Federal Bureau of Investigation.")
wait(1200)
sampSendChat("/do | �����: ���������� �� ������ � �����������.")
wait(1200)
sampSendChat("/do | ��������� ����������: ����� ���.")
wait(1200)
sampSendChat("/do | �������������� �������� �������������� � �������� �� ��������.")
end) 
end

function geg() 

lua_thread.create(function () 
sampSendChat("����������� ���� �������������")
wait(800)
sampSendChat("/anim 16")
wait(800)
sampSendChat("/me ��������� ������ ���������� FBI �514873.")
wait(800)
sampSendChat("�� ���������� � ����������� �������...")
wait(800)
sampSendChat("������� �� ��������� �������������.")
end) 
end

function su(arg) 

lua_thread.create(function ()
sampSendChat("/do � ����� ��� ��������� ����������� �� ����� FBI.")
wait(800)
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ����������.")
wait(800)
sampSendChat("/su " .. arg .. "", main_color)
wait(800)
sampSendChat("/do ���������� �������� � ����������� ������.")
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
sampSendChat("/me ����������� � ��������� ������� ���, ����� ������ � ���-�� ������.")
end)
end

function r(arg) 

lua_thread.create(function () 
sampSendChat("/r  " .. arg .. "")
sampSendChat("/me ����������� � ��������� ������ ���, ����� ������ � ���-�� ������.")
end)
end

function clear(arg) 

lua_thread.create(function () 
sampSendChat("/me ����������� � ������ ����, ������ ������ ���")
wait(800)
sampSendChat("/me ������ ���� ������ ������������ ���� �������������")
wait(800)
sampSendChat("/me ����� � ������ ��������� ������, ��������� ���� � ������ ���.")
wait(800)
sampSendChat("/clear " .. arg .. "", main_color)
wait(800)
sampSendChat("/do ���� �" .. arg .. " ������������ �� ��� ������.")
end) 
end

function uncuff(arg) 

lua_thread.create(function () 
sampSendChat("/do ��������� ��������� �� ��������� ��������.")
wait(800)
sampSendChat("/me ���������� ���������, ����� ���� ���� �� � ����� � ����� ������ ����.")
wait(800)
sampSendChat("/uncuff " .. arg .. "", main_color)
wait(800)
sampSendChat("/do ��������� ����� � ����� ������� ����.")
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
sampSendChat("/do � ����� ������� ���� ����� ���������.")
wait(800)
sampSendChat("/me ��������� � ����� ������, ����� ���� ������ ��������� ���� ������� ���������")
wait(800)
sampSendChat("/cuff " .. arg .. "", main_color)
wait(800)
sampSendChat("/me ������� ���� ��������, ���� �� �� ����� � ��������� ���������.")
end) 
end

function sampev.onServerMessage(color, msg)
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function ()  
if msg:find("�� {00b300}����� ������ {3399FF}�����������") then
sampSendChat("/do ����� ������� ����� �������� ������� � ���������.")
wait(300)
sampSendChat("/me ������ ������� � ���������, ����� ������ ���������� ������ � ����������.")
end
if msg:find("����������� {FFCD00}/mask {66CC00}��� ������� ������ ������������ �� �����") then
sampSendChat("/me ������� ������ ������� ��� ������� ���������� ���������� �����.")
wait(800)
sampSendChat("/do ������ ���� ������ �� ��� ������, ������� ����� � �������.")
end
if msg:find("�� ������ ����� �������. ������� {3399FF}/healme {66CC00}��� �� �������������") then
sampSendChat("/me ������� ������ ������� ��� ������� ���������� ���������� �������.")
wait(800)
sampSendChat("/do ������ ���� ������ �� ��� ������, ������� ����� � ���������.")
end
if msg:find("����������� {6699FF}/eat {CECECE}����� ������ ��� {6699FF}/put {CECECE}����� �������� ������ � ����") then
wait(500)  
sampSendChat("/eat")
end
if msg:find("�� ��������� � ������ ������� �������") then
sampAddChatMessage('{4c4f45}[��������� ����] {FFFFFF}����� � ����� ������: '..os.date('%H:%M:%S'), 0xffffff)
sampSendChat("/me ��������� �� ���� ����� �TS� � ����������� ��������.")
end
if msg:find("��������� �����������") then
sampSendChat("/do ����� ������� ����� ������� � �������������� ���������.")
wait(700)
sampSendChat("/me ������ ������� � ���������, ����� ������ ���������� ������ � ����������.")
end
if msg:find("�� ����� ����������") then
sampSendChat("/do ����� ������� ����� ������� c ���������.")
wait(700)
sampSendChat("/me ������ ������� � ���� �� �����������.")
end
end)
end

function putpl(arg) 

lua_thread.create(function () 
sampSendChat("/me ��������� � ������� ����� ���������� � ������ �����")
wait(800)
sampSendChat("/me ������ �������� � ����������")
wait(800)
sampSendChat("/putpl " .. arg .. "", main_color)
wait(800)
sampSendChat("/me ��������� ����� �� ���������.")
end) 
end

function arrest(arg) 

lua_thread.create(function () 
sampSendChat("/me ��������� � �������� � ������ ���.")
wait(1200)
sampSendChat("/do � �������� ����� ��������� ���� ������������� ������� ���������.")
wait(1200)
sampSendChat("/me �������� ����, ����� ����� ���������� � ������� ���")
wait(1200)
sampSendChat("/me ������� ��������� �� ���� ������� � ������������ ������")
wait(1200)
sampSendChat("/me ��� ��� ������������� � ����, ����� ���� ������� ���� � �������.")
wait(1200)
sampSendChat("/arrest " .. arg .. "", main_color)
wait(1200)
sampSendChat("/do ��������� ���� �" .. arg .. " ���������� � �������.")
end) 
end

function mon() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("TS")
wait(500)
sampSendChat("/do ����� � ����� ������ ��������� ��������� ������� � �������������.")
wait(500)
sampSendChat("/su " .. id .. " 2 ���", main_color)
end) 
end

function mayak() 
lua_thread.create(function ()
sampAddChatMessage('{800000}[TS Helper] ��������!{FFFFFF} ������ ������� ������ ���� ���� � ������� 150 ������...', 0xffffff)
wait(500)
sampAddChatMessage('{800000}[TS Helper] {FFFFFF}���� �� ��������� ��� ����������� ����������, ��������� ������� /mayakk', 0xffffff)
end)
end

function mayakk() 
lua_thread.create(function () 
sampSendChat("/do � ������� ����� ����������� ���������� ������������ ������.")
wait(800)
sampSendChat("/me �������� ������ ����������� ����������.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 2 ��� ��� ����. ��������", main_color)
wait(1200)
end 
end
end)
end

function order() 
lua_thread.create(function () 
sampSendChat("/do � ����� ��� ��������� ����������� �� ����� FBI.")
wait(800)
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ �����������.")
wait(800)
for k, v in pairs(getAllChars()) do 
local result, id = sampGetPlayerIdByCharHandle(v) 
if result and doesCharExist(v) then 
sampSendChat("/su " .. id .. " 6 ���������", main_color)
wait(1200)
end 
end
end)
end

function ��������() 
lua_thread.create(function () 
sampSendChat("/do � ������� ����� ����������� ���������� ����������� ������.")
wait(800)
sampSendChat("/me �������� ������ ����������� ����������.")
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
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ����������.")
wait(100)
sampSendChat("/su " .. id .. " 6 2.1 ��")
wait(1000)
sampSendChat("/do ���������� �������� � ����������� ������.")
wait(1200)
sampSendChat("/f ������ ��������� ���������, �� ������ ��� ������ �����. ��� 1.")
end)
end
end
end

function pg(arg) 
lua_thread.create(function ()
sampSendChat("/me ����� ������ �� ���������, ������� ���������� ������ ����������.")
wait(100)
sampSendChat("/su " .. arg .. " 3 9.1 ��")
wait(500)
sampSendChat("/su " .. arg .. " 3 9.5 ��")
wait(1000)
sampSendChat("/do ���������� �������� � ����������� ������.")
wait(1200)
sampSendChat("/f ������ ��������� ���������, ���������� ����������.")
end)
end

function moff()  
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ���� ����� �������������� �����.")
wait(500)
sampSendChat("/me ����� ����� � ������ � ������������� ����� �������� ������.")
wait(500)
sampSendChat("/clear " .. id .. "", main_color)
wait(500)
sampSendChat("/do ����� �������������.")
end) 
end

function search(arg) 

lua_thread.create(function () 
sampSendChat("/do � ������ ������� ���� ��������� ��������.")
wait(1000)
sampSendChat("/me ������� �������� �� ������� ���� � ����� ��")
wait(1000)
sampSendChat("/anim 45")
wait(1000)
sampSendChat("/me ����������� � ����� ��������, �������� ������ ��������")
wait(1000)
sampSendChat("/me ����� ������ �� ����� � ��������� �������� ������� ������...")
wait(1000)
sampSendChat("/me ... �� ������� ������, ����� � ���� ������ ������ ����� � �����.")
wait(1000)
sampSendChat("/anim 14")
wait(1000)
sampSendChat("/me ����������� � ����� ��������, �������� �� ��� � �������� ����� ��������.")
wait(1000)
sampSendChat("/search " .. arg .. "", main_color)
wait(500)
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}������� ��� ������: /nar - ������ ���������, /pt - ������ �������.', 0xffffff)
end) 
end

function hold(arg) 

lua_thread.create(function () 
sampSendChat("/me ������� ���� �������� � ���� �� �� �����")
wait(800)
sampSendChat("/me ���� �����, ������ ����� ���� ��������.")
wait(800)
sampSendChat("/hold " .. arg .. "", main_color)
wait(800)
sampSendChat("�������� ����� � �� ������������...")
end) 
end

function eject(arg) 

lua_thread.create(function () 
sampSendChat("/me ��������� � ������� ����� ���������� � ������ �����")
wait(500)
sampSendChat("/me ����� �� ���������� � ������� �������� �� ����.")
wait(500)
sampSendChat("/eject " .. arg .. "", main_color)
wait(1000)
sampAddChatMessage('{800000}[TS Helper] {FFFFFF}���� �� �������� �������� � ����������, ������� ����� � ������ ��, ����� ������� ���������!', 0xffffff)
end) 
end

function ticket(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}��������� ��� �� ��������� �������, ������������� � ��� �� � ����� �����������.', 0xffffff)
sampSendChat("/do � ������� ���� ����� ������� ��� ������� � ���������.")
wait(1000)
sampSendChat("/me ��������� � ������ ���� � ������� ������� � ����������")
wait(1000)
sampSendChat("/me ��������� ����� �� ������ ������.")
wait(1000)
sampSendChat("/do ����� �� ������ ������ ��������.")
wait(1000)
sampSendChat("/me ������ ����� �� �������� � �������� ����� �������� ��������.")
wait(1000)
sampSendChat("/ticket " .. arg .. "", main_color)
wait(1000)
sampSendChat("/todo ������� ����� ��������*�����������.")
end) 
end

function takelic(arg) 

lua_thread.create(function () 
sampAddChatMessage('{800000}[��������� ����] {FFFFFF}��������� ��� �� ��������� �������, ������������� � ��� �� � ����� �����������.', 0xffffff)
sampSendChat("/me ������ ���, ����� ���� ������� ��� � ����� � ���� ������ FBI.")
wait(1000)
sampSendChat("/do ��� ������� ����������.")
wait(1000)
sampSendChat("/me ������������ �������������� � ������ ����.")
wait(1000)
sampSendChat("/takelic " .. arg .. "", main_color)
wait(1000)
sampSendChat("/do �������� ������������.")
end) 
end

function setmark(arg) 

lua_thread.create(function () 
sampSendChat("/me ������ ���, ����� ���� ����� � ������ ������������� � ������ ���������� ����.")
wait(500)
sampSendChat("/setmark " .. arg .. "", main_color)
wait(500)
sampSendChat("/do ��� ������� ����������.")
end) 
end

function so(arg) 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/f �������� ! �������� ���� �������� ����������...")
wait(1000)
sampSendChat("/f � ������ � ������. ��������� ������ ���������. ���������� �������������...")
wait(1000)
sampSendChat("/f � �������������� � ������� �� ����� ���� �������.")
wait(1000)
sampSendChat("/f ��������� ����� ����������� ����������: " .. arg .. ".", main_color)
wait(1000)
sampSendChat("/su " .. id .. " 2 ���", main_color)
end) 
end

function sos() 
local _, id = sampGetPlayerIdByCharHandle (PLAYER_PED)
lua_thread.create(function () 
sampSendChat("/do � ������ ������� ���� ����� ���������������� ����� �� ������ ���������.")
wait(1000)
sampSendChat("/me ����� ����� � ������ � ����������� ����� �������� ������.")
wait(1000)
sampSendChat("/su " .. id .. " 2 SOS", main_color)
wait(1000)
sampSendChat("/do ����� �����������.")
wait(1000)
sampSendChat("/f �������� ! �������� ��������, ������ ��������� ������!")
wait(1000)
sampSendChat("/su " .. id .. " 2 SOS", main_color)
wait(1000)
sampSendChat("/f ��������, ������ ����� ������, �������� ��������!")
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