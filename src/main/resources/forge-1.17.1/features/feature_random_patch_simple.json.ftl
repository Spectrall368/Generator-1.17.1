<#include "mcitems.ftl">
new RandomPatchConfiguration.GrassConfigurationBuilder(${mappedBlockToBlockStateProvider(input$block)}, SimpleBlockPlacer.INSTANCE)
.tries(${field$tries}).xspread(${field$xzSpread}).zspread(${field$xzSpread}).yspread(${field$ySpread}).build()
$
if(!(${input$condition})) return false;
$