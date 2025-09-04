<#include "mcitems.ftl">
$if (!${mappedBlockToBlock(input$block)}.canSurvive(world.getBlockState(origin.below()), world, origin))
  return false;$