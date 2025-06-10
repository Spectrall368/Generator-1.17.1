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
package ${package}.world.features.ores;
<#assign cond = false>
<#if data.restrictionBiomes?has_content>
	<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
		<#if restrictionBiome?contains(":is_")>
			<#assign cond = true>
			 <#break>
		</#if>
		<#break>
	</#list>
</#if>
<#if data.maxGenerateHeight gt 256>
	<#assign maxGenerateHeight = 256>
<#elseif data.maxGenerateHeight lt 0>
	<#assign maxGenerateHeight = 0>
<#else>
	<#assign maxGenerateHeight = data.maxGenerateHeight>
</#if>
<#if data.minGenerateHeight gt 256>
	<#assign minGenerateHeight = 256>
<#elseif data.minGenerateHeight lt 0>
	<#assign minGenerateHeight = 0>
<#else>
	<#assign minGenerateHeight = data.minGenerateHeight>
</#if>


public class ${name}Feature extends OreFeature {
	public static final ${name}Feature FEATURE = new ${name}Feature().setRegistryName("${modid}:${registryname}");
	public static final ConfiguredFeature<OreConfiguration, ?> CONFIGURED_FEATURE = FEATURE.configured(new OreConfiguration(${name}FeatureRuleTest.INSTANCE, ${JavaModName}Blocks.${data.getModElement().getRegistryNameUpper()}.get().defaultBlockState(), ${data.frequencyOnChunk}))
				.count(${data.frequencyPerChunks}).squared()
				.range(new RangeDecoratorConfiguration(<#if data.generationShape == "UNIFORM">UniformHeight<#else>TrapezoidHeight</#if>.of(VerticalAnchor.absolute(${data.minGenerateHeight}), VerticalAnchor.absolute(${data.maxGenerateHeight}))));

	public static ConfiguredFeature<?, ?> configuredFeature() {
		return CONFIGURED_FEATURE;
	}

	public static final Set<ResourceLocation> GENERATE_BIOMES =
	<#if data.restrictionBiomes?has_content && !cond>
	Set.of(
		<#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
			new ResourceLocation("${restrictionBiome?replace("#", "")}")<#sep>,
		</#list>
	);
	<#else>
	null;
	</#if>

    <#if data.restrictionBiomes?has_content && cond>
	private final Set<ResourceKey<Level>> generate_dimensions = Set.of(
	    <#list w.filterBrokenReferences(data.restrictionBiomes) as restrictionBiome>
			<#if restrictionBiome == "#minecraft:is_overworld">
				Level.OVERWORLD
			<#elseif restrictionBiome == "#minecraft:is_nether">
				Level.NETHER
			<#elseif restrictionBiome == "#minecraft:is_end">
				Level.END
			<#else>
			    ResourceKey.create(Registry.DIMENSION_REGISTRY, new ResourceLocation("${modid}:${restrictionBiome?keep_after("is_")}"))
			</#if><#sep>,
		</#list>
	);
	</#if>

	public ${name}Feature() {
		super(OreConfiguration.CODEC);
	}

	@Override public boolean place(FeaturePlaceContext<OreConfiguration> context) {
		WorldGenLevel world = context.level();
		<#if data.restrictionBiomes?has_content && cond>
		if (!generate_dimensions.contains(world.getLevel().dimension()))
			return false;
        </#if>

		return super.place(context);
	}

	@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD) private static class ${name}FeatureRuleTest extends RuleTest {
		static final ${name}FeatureRuleTest INSTANCE = new ${name}FeatureRuleTest();

		private static final Codec<${name}FeatureRuleTest> CODEC = Codec.unit(() -> INSTANCE);
		private static final RuleTestType<${name}FeatureRuleTest> CUSTOM_MATCH = () -> CODEC;

		@SubscribeEvent public static void init(FMLCommonSetupEvent event) {
			Registry.register(Registry.RULE_TEST, new ResourceLocation("${modid}:${registryname}_match"), CUSTOM_MATCH);
		}

		public boolean test(BlockState blockstate, Random random) {
		    return ${containsAnyOfBlocks(data.blocksToReplace "blockstate")};
		}

		protected RuleTestType<?> getType() {
			return CUSTOM_MATCH;
		}
	}
}
<#-- @formatter:on -->