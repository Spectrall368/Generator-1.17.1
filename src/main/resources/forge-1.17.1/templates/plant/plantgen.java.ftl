<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
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
<#include "../procedures.java.ftl">
<#include "../mcitems.ftl">
package ${package}.world.features.plants;
<#assign cond = false>
<#if data.restrictionBiomes?has_content>
	<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
	    <#assign biomeName = fixNamespace(restrictionBiome)>
        <#if biomeName == "#minecraft:is_overworld" || biomeName == "#minecraft:is_nether" || biomeName == "#minecraft:is_end">
			<#assign cond = true>
			 <#break>
		</#if>
	</#list>
</#if>

public class ${name}Feature extends <#if data.plantType == "normal" && data.generationType == "Flower">DefaultFlower<#else>RandomPatch</#if>Feature {
    private static ${name}Feature INSTANCE = null;
  	private static ConfiguredFeature<?, ?> CONFIGURED_FEATURE = null;

	public ${name}Feature() {
		super(RandomPatchConfiguration.CODEC);
	}

	public static Feature<?> feature() {
		INSTANCE = new ${name}Feature();
		CONFIGURED_FEATURE = INSTANCE.configured(
            new RandomPatchConfiguration.GrassConfigurationBuilder(new SimpleStateProvider(${JavaModName}Blocks.${REGISTRYNAME}.get().defaultBlockState()),
        	<#if data.plantType == "double">DoublePlantPlacer.INSTANCE
            <#elseif data.plantType == "normal">SimpleBlockPlacer.INSTANCE
            <#else>new ColumnPlacer(BiasedToBottomInt.of(2, 4))</#if>)
            <#if data.plantType == "growapable">.xspread(4).yspread(0).zspread(4).noProjection()</#if>
            <#if data.plantType == "double" && data.generationType == "Flower">.noProjection()</#if>
       		.tries(${data.patchSize}).build())
            .count(${data.frequencyOnChunks})
        	<#if data.generationType == "Flower" || data.plantType == "growapable">
        	.rarity(32)</#if>
        	.squared()
       		.decorated(Features.Decorators.
       		<#if data.generateAtAnyHeight>
                FULL_RANGE
        	<#else>
                HEIGHTMAP<#if !(data.generationType == "Grass" || data.plantType == "growapable")>_WORLD_SURFACE</#if>
            </#if>);

        Registry.register(BuiltinRegistries.CONFIGURED_FEATURE, new ResourceLocation("${modid}:${registryname}"), CONFIGURED_FEATURE);
		return INSTANCE;
	}

	public static ConfiguredFeature<?, ?> configuredFeature() {
		return CONFIGURED_FEATURE;
	}

	public static final Set<ResourceLocation> GENERATE_BIOMES =
	<#if data.restrictionBiomes?has_content && !cond>
	Set.of(
		<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
		    <#assign expandedBiomes = expandBiomeTag(restrictionBiome)>
		    <#list expandedBiomes as expandedBiome>
			new ResourceLocation("${expandedBiome}")<#sep>,
		    </#list><#sep>,
        </#list>
	);
	<#else>
	null;
	</#if>

	<#if data.restrictionBiomes?has_content && cond>
	private final Set<ResourceKey<Level>> generate_dimensions = Set.of(
			<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
	        <#assign biomeName = fixNamespace(restrictionBiome)>
			<#if biomeName == "#minecraft:is_overworld">
				Level.OVERWORLD
			<#elseif biomeName == "#minecraft:is_nether">
				Level.NETHER
			<#else>
				Level.END
			</#if><#sep>,
		</#list>
	);

	@Override public boolean place(FeaturePlaceContext<RandomPatchConfiguration> context) {
		WorldGenLevel world = context.level();
		if (!generate_dimensions.contains(world.getLevel().dimension()))
			return false;

		return super.place(context);
	}
	</#if>
}
<#-- @formatter:on -->
<#function expandBiomeTag biomeTag>
    <#local result = []>

    <#if biomeTag?contains("#")>
        <#local biomeName = fixNamespace(biomeTag)>
        <#local tagKey = "BIOMES:" + biomeName?substring(1)>

        <#local tagFound = false>
        <#list w.getWorkspace().getTagElements()?keys as tagElement>
            <#if tagElement.toString().replace("mod:", modid + ":") == tagKey>
                <#local tagFound = true>
                <#local biomeValues = w.getWorkspace().getTagElements().get(tagElement)>
                <#list biomeValues as biomeValue>
                    <#if biomeValue?starts_with("#")>
                        <#local expandedSubValues = expandBiomeTag(biomeValue?replace("mod:", modid + ":"))>
                        <#list expandedSubValues as expandedSubValue>
                            <#local result = result + [expandedSubValue]>
                        </#list>
                    <#else>
                        <#local result = result + [generator.map(biomeValue, "biomes")]>
                    </#if>
                </#list>
                <#break>
            </#if>
        </#list>

        <#if !tagFound>
            <#local result = result + [biomeName?substring(1)]>
        </#if>
    <#else>
        <#local result = result + [biomeTag]>
    </#if>

    <#return result>
</#function>
<#function fixNamespace input>
    <#assign noHash = input?starts_with("#")?then(input?substring(1), input)/>

    <#if noHash?contains(":")>
        <#return input>
    <#else>
        <#assign result = "minecraft:" + noHash />
        <#return input?starts_with("#")?then("#" + result, result)/>
    </#if>
</#function>