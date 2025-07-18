<#include "mcitems.ftl">
${mappedBlockToBlockStateCode(input$block)}.mayPlaceOn(world.getLevel().getBlockState(origin.below()), world.getLevel(), origin<#if (field$x != "0")||(field$y != "0")||(field$z != "0")>.offset(${field$x}, ${field$y}, ${field$z})</#if>)
