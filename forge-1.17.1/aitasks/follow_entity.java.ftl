<#include "aiconditions.java.ftl">
<#if !data.waterMob || data.flyingMob>
this.goalSelector.addGoal(${customBlockIndex+1}, new FollowMobGoal(this, ${field$speed}, (float) ${field$maxrange}, (float) ${field$followarea})<@conditionCode field$condition/>);
</#if>
