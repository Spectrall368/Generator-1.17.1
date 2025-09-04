<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
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
<#include "../mcitems.ftl">
package ${package}.world.biome;

import net.minecraftforge.common.BiomeManager;

public class ${name}Biome {

	private static final ConfiguredSurfaceBuilder<?> SURFACE_BUILDER = SurfaceBuilder.DEFAULT.configured(new SurfaceBuilderBaseConfiguration(
            ${mappedBlockToBlockStateCode(data.groundBlock)},
            ${mappedBlockToBlockStateCode(data.undergroundBlock)},
            ${mappedBlockToBlockStateCode(data.getUnderwaterBlock())}));

    public static Biome createBiome() {
            BiomeSpecialEffects effects = new BiomeSpecialEffects.Builder()
                .fogColor(${data.fogColor?has_content?then(data.fogColor.getRGB(), 12638463)})
                .waterColor(${data.waterColor?has_content?then(data.waterColor.getRGB(), 4159204)})
                .waterFogColor(${data.waterFogColor?has_content?then(data.waterFogColor.getRGB(), 329011)})
                .skyColor(${data.airColor?has_content?then(data.airColor.getRGB(), 7972607)})
                .foliageColorOverride(${data.foliageColor?has_content?then(data.foliageColor.getRGB(), 10387789)})
                .grassColorOverride(${data.grassColor?has_content?then(data.grassColor.getRGB(), 9470285)})
                <#if data.ambientSound?has_content && data.ambientSound.getMappedValue()?has_content>
                    .ambientLoopSound(ForgeRegistries.SOUND_EVENTS.getValue(new ResourceLocation("${data.ambientSound}")))
                </#if>
                <#if data.moodSound?has_content && data.moodSound.getMappedValue()?has_content>
                    .ambientMoodSound(new AmbientMoodSettings(ForgeRegistries.SOUND_EVENTS.getValue(new ResourceLocation("${data.moodSound}")), ${data.moodSoundDelay}, 8, 2))
                </#if>
                <#if data.additionsSound?has_content && data.additionsSound.getMappedValue()?has_content>
                    .ambientAdditionsSound(new AmbientAdditionsSettings(ForgeRegistries.SOUND_EVENTS.getValue(new ResourceLocation("${data.additionsSound}")), 0.0111D))
                </#if>
                <#if data.music?has_content && data.music.getMappedValue()?has_content>
                    .backgroundMusic(new Music(ForgeRegistries.SOUND_EVENTS.getValue(new ResourceLocation("${data.music}")), 12000, 24000, true))
                </#if>
                <#if data.spawnParticles>
                    .ambientParticle(new AmbientParticleSettings(${data.particleToSpawn}, ${data.particlesProbability / 100}f))
                </#if>
                .build();

        BiomeGenerationSettings.Builder biomeGenerationSettings = new BiomeGenerationSettings.Builder().surfaceBuilder(SURFACE_BUILDER);

        <#if data.spawnStronghold>
            biomeGenerationSettings.addStructureStart(StructureFeatures.STRONGHOLD);
        </#if>

        <#if data.spawnMineshaft>
            biomeGenerationSettings.addStructureStart(StructureFeatures.MINESHAFT);
        </#if>

        <#if data.spawnMineshaftMesa>
            biomeGenerationSettings.addStructureStart(StructureFeatures.MINESHAFT_MESA);
        </#if>

        <#if data.spawnPillagerOutpost>
            biomeGenerationSettings.addStructureStart(StructureFeatures.PILLAGER_OUTPOST);
        </#if>

        <#if data.villageType != "none">
            biomeGenerationSettings.addStructureStart(StructureFeatures.VILLAGE_${data.villageType?upper_case});
        </#if>

        <#if data.spawnWoodlandMansion>
            biomeGenerationSettings.addStructureStart(StructureFeatures.WOODLAND_MANSION);
        </#if>

        <#if data.spawnJungleTemple>
            biomeGenerationSettings.addStructureStart(StructureFeatures.JUNGLE_TEMPLE);
        </#if>

        <#if data.spawnDesertPyramid>
            biomeGenerationSettings.addStructureStart(StructureFeatures.DESERT_PYRAMID);
        </#if>

        <#if data.spawnSwampHut>
            biomeGenerationSettings.addStructureStart(StructureFeatures.SWAMP_HUT);
        </#if>

        <#if data.spawnIgloo>
            biomeGenerationSettings.addStructureStart(StructureFeatures.IGLOO);
        </#if>

        <#if data.spawnOceanMonument>
            biomeGenerationSettings.addStructureStart(StructureFeatures.OCEAN_MONUMENT);
        </#if>

        <#if data.spawnShipwreck>
            biomeGenerationSettings.addStructureStart(StructureFeatures.SHIPWRECK);
        </#if>

        <#if data.spawnShipwreckBeached>
            biomeGenerationSettings.addStructureStart(StructureFeatures.SHIPWRECH_BEACHED);
        </#if>

        <#if data.spawnBuriedTreasure>
            biomeGenerationSettings.addStructureStart(StructureFeatures.BURIED_TREASURE);
        </#if>

        <#if data.oceanRuinType != "NONE">
            biomeGenerationSettings.addStructureStart(StructureFeatures.OCEAN_RUIN_${data.oceanRuinType});
        </#if>

        <#if data.spawnNetherBridge>
            biomeGenerationSettings.addStructureStart(StructureFeatures.NETHER_BRIDGE);
        </#if>

        <#if data.spawnNetherFossil>
            biomeGenerationSettings.addStructureStart(StructureFeatures.NETHER_FOSSIL);
        </#if>

        <#if data.spawnBastionRemnant>
            biomeGenerationSettings.addStructureStart(StructureFeatures.BASTION_REMNANT);
        </#if>

        <#if data.spawnEndCity>
            biomeGenerationSettings.addStructureStart(StructureFeatures.END_CITY);
        </#if>

        <#if data.spawnRuinedPortal != "NONE">
          <#if data.spawnRuinedPortal == "STANDARD">
            biomeGenerationSettings.addStructureStart(StructureFeatures.RUINED_PORTAL_STANDARD);
          <#else>
            biomeGenerationSettings.addStructureStart(StructureFeatures.RUINED_PORTAL_${data.spawnRuinedPortal});
          </#if>
        </#if>

        <#if (data.treesPerChunk > 0)>
        	<#assign ct = data.treeType == data.TREES_CUSTOM>

        	<#if data.vanillaTreeType == "Big trees">
        	biomeGenerationSettings.addFeature(GenerationStep.Decoration.VEGETAL_DECORATION,
				Feature.TREE.configured((new TreeConfiguration.TreeConfigurationBuilder(
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.JUNGLE_LOG.defaultBlockState()")}),
                    new MegaJungleTrunkPlacer(${ct?then([data.minHeight, 32]?min, 10)}, 2, 19),
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.JUNGLE_LEAVES.defaultBlockState()")}),
                    new SimpleStateProvider(Blocks.OAK_SAPLING.defaultBlockState()),
                    new MegaJungleFoliagePlacer(ConstantInt.of(2), ConstantInt.of(0), 2),
                    new TwoLayersFeatureSize(1, 1, 2)))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>
            	.build())
            	.decorated(Features.Decorators.HEIGHTMAP_SQUARE)
            	.decorated(FeatureDecorator.COUNT_EXTRA.configured(new FrequencyWithExtraChanceDecoratorConfiguration(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Savanna trees">
        	biomeGenerationSettings.addFeature(GenerationStep.Decoration.VEGETAL_DECORATION,
                Feature.TREE.configured((new TreeConfiguration.TreeConfigurationBuilder(
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.ACACIA_LOG.defaultBlockState()")}),
                    new ForkingTrunkPlacer(${ct?then([data.minHeight, 32]?min, 5)}, 2, 2),
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.ACACIA_LEAVES.defaultBlockState()")}),
                    new SimpleStateProvider(Blocks.ACACIA_SAPLING.defaultBlockState()),
                    new AcaciaFoliagePlacer(ConstantInt.of(2), ConstantInt.of(0)),
                    new TwoLayersFeatureSize(1, 0, 2)))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>
            	.build())
            	.decorated(Features.Decorators.HEIGHTMAP_SQUARE)
            	.decorated(FeatureDecorator.COUNT_EXTRA.configured(new FrequencyWithExtraChanceDecoratorConfiguration(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Mega pine trees">
        	biomeGenerationSettings.addFeature(GenerationStep.Decoration.VEGETAL_DECORATION,
				Feature.TREE.configured((new TreeConfiguration.TreeConfigurationBuilder(
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.SPRUCE_LOG.defaultBlockState()")}),
                    new GiantTrunkPlacer(${ct?then([data.minHeight, 32]?min, 13)}, 2, 14),
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.SPRUCE_LEAVES.defaultBlockState()")}),
                    new SimpleStateProvider(Blocks.SPRUCE_SAPLING.defaultBlockState()),
                    new MegaPineFoliagePlacer(ConstantInt.of(0), ConstantInt.of(0), UniformInt.of(3, 4)),
                    new TwoLayersFeatureSize(1, 1, 2)))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    </#if>
            	.build())
            	.decorated(Features.Decorators.HEIGHTMAP_SQUARE)
            	.decorated(FeatureDecorator.COUNT_EXTRA.configured(new FrequencyWithExtraChanceDecoratorConfiguration(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Mega spruce trees">
        	biomeGenerationSettings.addFeature(GenerationStep.Decoration.VEGETAL_DECORATION,
				Feature.TREE.configured((new TreeConfiguration.TreeConfigurationBuilder(
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.SPRUCE_LOG.defaultBlockState()")}),
                    new GiantTrunkPlacer(${ct?then([data.minHeight, 32]?min, 13)}, 2, 14),
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.SPRUCE_LEAVES.defaultBlockState()")}),
                    new SimpleStateProvider(Blocks.SPRUCE_SAPLING.defaultBlockState()),
                    new MegaPineFoliagePlacer(ConstantInt.of(0), ConstantInt.of(0), UniformInt.of(13, 4)),
                    new TwoLayersFeatureSize(1, 1, 2)))
                    .decorators(ImmutableList.of(new AlterGroundDecorator(new SimpleStateProvider(Blocks.PODZOL.defaultBlockState()))))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    </#if>
            	.build())
            	.decorated(Features.Decorators.HEIGHTMAP_SQUARE)
            	.decorated(FeatureDecorator.COUNT_EXTRA.configured(new FrequencyWithExtraChanceDecoratorConfiguration(${data.treesPerChunk}, 0.1F, 1))));
        	<#elseif data.vanillaTreeType == "Birch trees">
        	biomeGenerationSettings.addFeature(GenerationStep.Decoration.VEGETAL_DECORATION,
				Feature.TREE.configured((new TreeConfiguration.TreeConfigurationBuilder(
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.BIRCH_LOG.defaultBlockState()")}),
                    new StraightTrunkPlacer(${ct?then([data.minHeight, 32]?min, 5)}, 2, 0),
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.BIRCH_LEAVES.defaultBlockState()")}),
                    new SimpleStateProvider(Blocks.BIRCH_SAPLING.defaultBlockState()),
                    new BlobFoliagePlacer(ConstantInt.of(2), ConstantInt.of(0), 3),
                    new TwoLayersFeatureSize(1, 0, 1)))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>
            	.build())
            	.decorated(Features.Decorators.HEIGHTMAP_SQUARE)
            	.decorated(FeatureDecorator.COUNT_EXTRA.configured(new FrequencyWithExtraChanceDecoratorConfiguration(${data.treesPerChunk}, 0.1F, 1))));
        	<#else>
        	biomeGenerationSettings.addFeature(GenerationStep.Decoration.VEGETAL_DECORATION,
				Feature.TREE.configured((new TreeConfiguration.TreeConfigurationBuilder(
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.OAK_LOG.defaultBlockState()")}),
                    new StraightTrunkPlacer(${ct?then([data.minHeight, 32]?min, 4)}, 2, 0),
                    new SimpleStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.OAK_LEAVES.defaultBlockState()")}),
                    new SimpleStateProvider(Blocks.OAK_SAPLING.defaultBlockState()),
                    new BlobFoliagePlacer(ConstantInt.of(2), ConstantInt.of(0), 3),
                    new TwoLayersFeatureSize(1, 0, 1)))
                    <#if data.hasVines() || data.hasFruits()>
                    	<@vinesAndFruits/>
                    <#else>
                    	.ignoreVines()
                    </#if>
            	.build())
            	.decorated(Features.Decorators.HEIGHTMAP_SQUARE)
            	.decorated(FeatureDecorator.COUNT_EXTRA.configured(new FrequencyWithExtraChanceDecoratorConfiguration(${data.treesPerChunk}, 0.1F, 1))));
        	</#if>
        </#if>

        <#list data.defaultFeatures as defaultFeature>
        	<#assign mfeat = generator.map(defaultFeature, "defaultfeatures")>
        	<#if mfeat != "null">
            BiomeDefaultFeatures.add${mfeat}(biomeGenerationSettings);
        	</#if>
        </#list>

        MobSpawnSettings.Builder mobSpawnInfo = new MobSpawnSettings.Builder().setPlayerCanSpawn();
        <#list data.spawnEntries as spawnEntry>
		<#assign entity = spawnEntry.entity.getMappedValue(1)!"null">
		<#if entity != "null">
		mobSpawnInfo.addSpawn(${generator.map(spawnEntry.spawnType, "mobspawntypes")},
			new MobSpawnSettings.SpawnerData(${entity}, ${spawnEntry.weight}, ${spawnEntry.minGroup}, ${spawnEntry.maxGroup}));
		</#if>
        </#list>

        return new Biome.BiomeBuilder()
            .precipitation(Biome.Precipitation.<#if (data.rainingPossibility > 0)><#if (data.temperature > 0.15)>RAIN<#else>SNOW</#if><#else>NONE</#if>)
            .biomeCategory(Biome.BiomeCategory.NONE)
            .depth(${data.baseHeight}f)
            .scale(${data.heightVariation}f)
            .temperature(${data.temperature}f)
            .downfall(${data.rainingPossibility}f)
            .specialEffects(effects)
            .mobSpawnSettings(mobSpawnInfo.build())
            .generationSettings(biomeGenerationSettings.build())
            .build();
    }

    <#if data.spawnBiome>
    public static void init() {
            BiomeManager.addBiome(
				BiomeManager.BiomeType.
				<#if (data.temperature < -0.25)>
					ICY
				<#elseif (data.temperature > -0.25) && (data.temperature <= 0.15)>
					COOL
				<#elseif (data.temperature > 0.15) && (data.temperature <= 1.0)>
					WARM
				<#elseif (data.temperature > 1.0)>
					DESERT
				</#if>,
				new BiomeManager.BiomeEntry(ResourceKey.create(Registry.BIOME_REGISTRY, BuiltinRegistries.BIOME.getKey(${JavaModName}Biomes.${REGISTRYNAME}.get())), ${data.biomeWeight})
			);
    }
    </#if>
}
<#macro vinesAndFruits>
.decorators(ImmutableList.of(
	<#if data.hasVines()>
		${name}LeaveDecorator.INSTANCE,
		${name}TrunkDecorator.INSTANCE
	</#if>

	<#if data.hasFruits()>
	    <#if data.hasVines()>,</#if>
        ${name}FruitDecorator.INSTANCE
	</#if>
))
</#macro>
<#-- @formatter:on -->