<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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
package ${package}.world.structures;

public class ${JavaModName}StructureBase extends StructureFeature<StructureConfiguration> {
    private final String startPool;

    public ${JavaModName}StructureBase(String startPool) {
        super(StructureConfiguration.CODEC);
        this.startPool = startPool;
    }

    @Override
    public GenerationStep.Decoration step() {
        return null;
    }

    public Set<ResourceLocation> getBiomes() {
        return null;
    }

    public Set<ResourceKey<Level>> getDimensions() {
        return null;
    }

    public StructureFeatureConfiguration getStructureFeatureConfiguration() {
        return null;
    }

    public boolean isSurroundedByLand() {
        return false;
    }

    public ConfiguredStructureFeature<?, ?> configuredFeature() {
        return null;
    }

    @Override
    public WeightedRandomList<MobSpawnSettings.SpawnerData> getSpecialEnemies() {
        return null;
    }

    @Override
    public WeightedRandomList<MobSpawnSettings.SpawnerData> getSpecialAnimals() {
        return null;
    }

    @Override
    public WeightedRandomList<MobSpawnSettings.SpawnerData> getSpecialUndergroundWaterAnimals() {
        return null;
    }

    @Override
    public StructureFeature.StructureStartFactory<StructureConfiguration> getStartFactory() {
        return (feature, chunkPos, n, seed) -> {
           return new FeatureStart(this, chunkPos, n, seed, startPool);
        };
    }

    protected static class FeatureStart extends NoiseAffectingStructureStart<StructureConfiguration> {
        private final String startPool;

        public FeatureStart(${JavaModName}StructureBase feature, ChunkPos chunkPos, int n, long seed, String startPool) {
            super(feature, chunkPos, n, seed);
            this.startPool = startPool;
        }

        @Override
        public void generatePieces(RegistryAccess registryAccess, ChunkGenerator chunkGenerator, StructureManager structureManager, ChunkPos chunkPos, Biome biome, StructureConfiguration config, LevelHeightAccessor levelHeightAccessor) {
            int topLandY = config.startHeight().sample(random, new WorldGenerationContext(chunkGenerator, levelHeightAccessor));
            BlockPos blockpos = new BlockPos(chunkPos.getMinBlockX(), topLandY, chunkPos.getMinBlockZ());

            JigsawConfiguration jigsawConfig = new JigsawConfiguration(() -> registryAccess.registryOrThrow(Registry.TEMPLATE_POOL_REGISTRY).get(new ResourceLocation("${modid}:" + startPool)), config.maxDepth());

            Pools.bootstrap();

            JigsawPlacement.PieceFactory factory = PoolElementStructurePiece::new;

            if (config.projectStartToHeightmap().isPresent()) {
                Rotation rotation = Rotation.getRandom(random);
                StructurePoolElement element = jigsawConfig.startPool().get().getRandomTemplate(random);
                BoundingBox box = factory.create(structureManager, element, blockpos, element.getGroundLevelDelta(), rotation, element.getBoundingBox(structureManager, blockpos, rotation)).getBoundingBox();
                int i = (box.maxX() + box.minX()) / 2;
                int j = (box.maxZ() + box.minZ()) / 2;
                blockpos = blockpos.atY(blockpos.getY() + chunkGenerator.getFirstFreeHeight(i, j, config.projectStartToHeightmap().get(), levelHeightAccessor));
            }

            JigsawPlacement.addPieces(registryAccess, jigsawConfig, factory, chunkGenerator, structureManager, blockpos, this, this.random, false, false, levelHeightAccessor);
        }
    }
}