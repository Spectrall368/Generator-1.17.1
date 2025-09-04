$
{ boolean scan_env_adv = false;
for(int i = 0; i < ${field$maxSteps} && !scan_env_adv && ${input$searchCondition}; i++) {
  origin = origin.<#if generator.map(field$direction, "directions") == "Direction.DOWN">below<#else>above</#if>();
  if(${input$condition})
    scan_env_adv = true;
}
if(!scan_env_adv)
  return false; }
$