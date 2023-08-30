<#if !data.flyingMob && !data.waterMob>
<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new OpenDoorGoal(this, true)<@conditionCode field$condition/>);
this.getNavigation().getNodeEvaluator().setCanOpenDoors(true);
</#if>
