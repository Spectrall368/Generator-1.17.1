<#include "mcitems.ftl">
£if (!${mappedBlockToBlockStateCode(input$block)}.mayPlaceOn(world.getLevel().getBlockState(origin.below()), world.getLevel(), origin))
  return false;^