<#if !data.flyingMob && !data.waterMob>
<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new OpenDoorGoal(this, false)<@conditionCode field$condition/>);
this.getNavigation().getNodeEvaluator().setCanOpenDoors(true);
</#if>
