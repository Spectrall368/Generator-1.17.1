<#include "mcitems.ftl">
new RandomPatchConfiguration.GrassConfigurationBuilder(${mappedBlockToBlockStateProvider(input$block)}, BlockPlacerType.SIMPLE_BLOCK_PLACER)
.tries(${field$tries}).xspread(${field$xzSpread}).zspread(${field$xzSpread}).yspread(${field$ySpread}).build()