<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2022, Pylo, opensource contributors
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 #
 # Additional permission for code generator templates (*.ftl files)
 #
 # As a special exception, you may create a larger work that contains part or
 # all of the MCreator code generator templates (*.ftl files) and distribute
 # that work under terms of your choice, so long as that work isn't itself a
 # template for code generation. Alternatively, if you modify or redistribute
 # the template itself, you may (at your option) remove this special exception,
 # which will cause the template and the resulting code generator output files
 # to be licensed under the GNU General Public License without this special
 # exception.
-->

<#-- @formatter:off -->
<#include "procedures.java.ftl">
<#include "mcitems.ftl">

package ${package}.world.features;

<#assign configuration = generator.map(featuretype, "features", 1)>

<#compress>
public class ${name}Feature extends ${generator.map(featuretype, "features")} {
	public static final ${name}Feature FEATURE = (${name}Feature) new ${name}Feature().setRegistryName("${modid}:${registryname}");
	public static final ConfiguredFeature<?, ?> CONFIGURED_FEATURE = FEATURE
				.configured(new ${configurationcode}(${JavaModName}Blocks.${data.getModElement().getRegistryNameUpper()}.defaultBlockState()));
    				List.of(${placementcode?remove_ending(",")}));

	public static final Set<ResourceLocation> GENERATE_BIOMES =
	<#if data.restrictionBiomes?has_content>
	Set.of(
		<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
		new ResourceLocation("${restrictionBiome}")<#if restrictionBiome?has_next>,</#if>
		</#list>
	);
	<#else>
	null;
	</#if>

	public ${name}Feature() {
		super(${configuration}.CODEC);
	}

	<#if data.restrictionDimensions?has_content>
 	<#if data.hasGenerationConditions()>
	public boolean place(FeaturePlaceContext<${configuration}> context) {
		WorldGenLevel world = context.level();
  		<#if data.restrictionDimensions?has_content>
		ResourceKey<Level> dimensionType = world.getLevel().dimension();
  		</#if>
		boolean dimensionCriteria = false;
  		<#list data.restrictionDimensions as dimension>
			<#if dimension == "Surface">
				if(dimensionType == Level.OVERWORLD)
					dimensionCriteria = true;
			<#elseif dimension =="Nether">
				if(dimensionType == Level.NETHER)
					dimensionCriteria = true;
			<#elseif dimension =="End">
				if(dimensionType == Level.END)
					dimensionCriteria = true;
			<#else>
				if(dimensionType == ResourceKey.create(Registry.DIMENSION_REGISTRY,
						new ResourceLocation("${generator.getResourceLocationForModElement(dimension.toString().replace("CUSTOM:", ""))}")))
					dimensionCriteria = true;
			</#if>
		</#list>
	</#if>

		if(!dimensionCriteria)
			return false;

		<#if hasProcedure(data.generateCondition)>
		int x = context.origin().getX();
		int y = context.origin().getY();
		int z = context.origin().getZ();
		if (!<@procedureOBJToConditionCode data.generateCondition/>)
			return false;
		</#if>

		return super.place(context);
	}
	</#if>
}</#compress>
