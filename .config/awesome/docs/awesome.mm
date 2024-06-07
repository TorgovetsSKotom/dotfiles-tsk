<map version="freeplane 1.11.5">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="awesome" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1704977047999" STYLE="oval">
<font SIZE="18"/>
<hook NAME="MapStyle">
    <properties edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" associatedTemplateLocation="template:/standard-1.6.mm" fit_to_viewport="false"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ID="ID_271890427" ICON_SIZE="12 pt" COLOR="#000000" STYLE="fork">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="200" DASH="" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_271890427" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
<richcontent TYPE="DETAILS" CONTENT-TYPE="plain/auto"/>
<richcontent TYPE="NOTE" CONTENT-TYPE="plain/auto"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.selection" BACKGROUND_COLOR="#afd3f7" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#afd3f7"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important" ID="ID_67550811">
<icon BUILTIN="yes"/>
<arrowlink COLOR="#003399" TRANSPARENCY="255" DESTINATION="ID_67550811"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10 pt" SHAPE_VERTICAL_MARGIN="10 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="12" RULE="ON_BRANCH_CREATION"/>
<node TEXT="bindings" POSITION="bottom_or_right" ID="ID_293921417" CREATED="1704976562077" MODIFIED="1704976566673">
<edge COLOR="#007c7c"/>
<node TEXT="mouse" POSITION="bottom_or_right" ID="ID_1639406481" CREATED="1704978134876" MODIFIED="1704978331644">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="keyboard" POSITION="bottom_or_right" ID="ID_1279951748" CREATED="1704978137957" MODIFIED="1704979121308">
<icon BUILTIN="button_ok"/>
<icon BUILTIN="pencil"/>
<node TEXT="В примере и" ID="ID_359988913" CREATED="1704978644986" MODIFIED="1704978652494"/>
<node TEXT="Использован собственный конфиг" ID="ID_1371431492" CREATED="1704979107473" MODIFIED="1704979116523"/>
</node>
</node>
<node TEXT="signals" POSITION="bottom_or_right" ID="ID_672741369" CREATED="1704976400302" MODIFIED="1704976541854">
<edge COLOR="#00007c"/>
<node TEXT="error" POSITION="bottom_or_right" ID="ID_1567522946" CREATED="1704976242210" MODIFIED="1704977037322">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="corners" ID="ID_976146649" CREATED="1704977018977" MODIFIED="1704977056379">
<icon BUILTIN="help"/>
</node>
<node TEXT="brightness" ID="ID_1421505047" CREATED="1704977102693" MODIFIED="1704977121891">
<icon BUILTIN="help"/>
<icon BUILTIN="pencil"/>
<icon BUILTIN="button_cancel"/>
</node>
</node>
<node TEXT="config" POSITION="bottom_or_right" ID="ID_1100335585" CREATED="1704983944954" MODIFIED="1704983951161">
<edge COLOR="#7c7c00"/>
<node TEXT="signals" ID="ID_1703613697" CREATED="1704984480236" MODIFIED="1704986346622">
<icon BUILTIN="button_ok"/>
<icon BUILTIN="help"/>
</node>
<node TEXT="menu" ID="ID_659903022" CREATED="1704984491266" MODIFIED="1704984493373">
<node TEXT="lock заменить" ID="ID_1351425219" CREATED="1704986125817" MODIFIED="1704986131425"/>
</node>
<node TEXT="gaps" ID="ID_166206329" CREATED="1704984493904" MODIFIED="1704984836453">
<icon BUILTIN="pencil"/>
<icon BUILTIN="help"/>
</node>
<node TEXT="layout" POSITION="bottom_or_right" ID="ID_1203790686" CREATED="1704976237933" MODIFIED="1704984633919">
<icon BUILTIN="button_ok"/>
<icon BUILTIN="pencil"/>
</node>
</node>
<node TEXT="rules" POSITION="bottom_or_right" ID="ID_299055017" CREATED="1704976545980" MODIFIED="1704987001881">
<icon BUILTIN="button_ok"/>
<edge COLOR="#007c00"/>
</node>
<node TEXT="ui" POSITION="bottom_or_right" ID="ID_6536553" CREATED="1704976550272" MODIFIED="1704976551138">
<edge COLOR="#7c007c"/>
<node TEXT="bar" POSITION="bottom_or_right" ID="ID_181693432" CREATED="1704976350240" MODIFIED="1704976560541"/>
<node TEXT="notifications" POSITION="bottom_or_right" ID="ID_1248079332" CREATED="1704987199051" MODIFIED="1704987437400">
<icon BUILTIN="help"/>
<icon BUILTIN="button_cancel"/>
</node>
<node TEXT="powermenu" POSITION="bottom_or_right" ID="ID_1001910759" CREATED="1704987205980" MODIFIED="1704987546361">
<icon BUILTIN="help"/>
</node>
<node TEXT="popups.mic" POSITION="bottom_or_right" ID="ID_1782776721" CREATED="1704987210371" MODIFIED="1704987575605">
<icon BUILTIN="help"/>
<icon BUILTIN="button_cancel"/>
<node TEXT="статус микрофона" ID="ID_1971738809" CREATED="1704987565786" MODIFIED="1704987572568"/>
</node>
</node>
<node TEXT="1 окно" POSITION="top_or_left" ID="ID_1713049084" CREATED="1705260042245" MODIFIED="1705260048822">
<edge COLOR="#ff0000"/>
<node TEXT="kitty + console app" ID="ID_172820741" CREATED="1705260049253" MODIFIED="1705260056962">
<node TEXT="ncmpp" ID="ID_1132087204" CREATED="1705260057542" MODIFIED="1705260062657"/>
<node TEXT="прога для заметок/сниппетов" ID="ID_533654693" CREATED="1705260063319" MODIFIED="1705260073091"/>
<node TEXT="h-m-m" ID="ID_1238305459" CREATED="1705260073504" MODIFIED="1705260086011">
<node TEXT="минд карты с читабельным форматом для заметок" ID="ID_919403492" CREATED="1705260113645" MODIFIED="1705260135000"/>
<node TEXT="И можно на виндовс" ID="ID_1511192037" CREATED="1705260537804" MODIFIED="1705260544535"/>
</node>
<node TEXT="Для задач" ID="ID_1100447699" CREATED="1705260087129" MODIFIED="1705260096765">
<node TEXT="plantuml + mind?" ID="ID_1076608142" CREATED="1705260098306" MODIFIED="1705260110350"/>
</node>
<node TEXT="rss" ID="ID_1246815739" CREATED="1705260151049" MODIFIED="1705260154035"/>
<node TEXT="parsers" ID="ID_1517196851" CREATED="1705260158378" MODIFIED="1705260161571"/>
</node>
<node TEXT="scratchpads" ID="ID_389762405" CREATED="1705260470605" MODIFIED="1705260476159">
<node TEXT="+ rule instance" ID="ID_764873838" CREATED="1705260479838" MODIFIED="1705260516516"/>
</node>
<node TEXT="wibar" ID="ID_1044996979" CREATED="1705261316165" MODIFIED="1705261320217"/>
</node>
</node>
</map>
