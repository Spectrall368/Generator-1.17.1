<#if input$blockSet?starts_with("/*@Tag*/")> <#-- The holder set is a tag -->
    ${input$blockSet?remove_beginning("/*@Tag*/")}
<#else> <#-- The holder set is a list of blocks -->
    Set.of(${input$blockSet})
</#if>
.contains(world.getBlockState(origin<#if (field$x != "0")||(field$y != "0")||(field$z != "0")>.offset(${field$x}, ${field$y}, ${field$z})</#if>).getBlock())