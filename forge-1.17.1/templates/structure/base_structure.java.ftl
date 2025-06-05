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

public class BaseStructure extends StructureFeature<StructureConfiguration> {
    public BaseStructure() {
        super(StructureConfiguration.CODEC);
    }

    @Override
    public GenerationStep.Decoration step() {
        return null;
    }

    @Override
    public StructureFeature.StructureStartFactory<StructureConfiguration> getStartFactory() {
        return (feature, chunkPos, n, seed) -> {
           return new BaseStructure.FeatureStart(this, chunkPos, n, seed);
        };
    }

    public static class FeatureStart extends NoiseAffectingStructureStart<StructureConfiguration> {
        private final BaseStructure feature;

        public FeatureStart(BaseStructure feature, ChunkPos chunkPos, int n, long seed) {
            super(feature, chunkPos, n, seed);
            this.feature = feature;
        }

        @Override
        public void generatePieces(RegistryAccess registryAccess, ChunkGenerator chunkGenerator, StructureManager structureManager, ChunkPos chunkPos, Biome biome, StructureConfiguration config, LevelHeightAccessor levelHeightAccessor) {
            BlockPos blockpos = chunkPos.getMiddleBlockPosition(0);

            if (!config.projectStartToHeightmap().isEmpty()) {
                int topLandY = chunkGenerator.getFirstFreeHeight(blockpos.getX(), blockpos.getZ(), config.projectStartToHeightmap().get(), levelHeightAccessor);
                blockpos = blockpos.atY(topLandY + config.startHeight().sample(new Random(), new WorldGenerationContext(chunkGenerator, levelHeightAccessor)));
            } else {
                blockpos = blockpos.atY(config.startHeight().sample(new Random(), new WorldGenerationContext(chunkGenerator, levelHeightAccessor)));
            }

            Pools.bootstrap();
            JigsawConfiguration jigsawConfig = new JigsawConfiguration(config.startPool(), config.maxDepth());
            JigsawPlacement.addPieces(registryAccess, jigsawConfig, PoolElementStructurePiece::new, chunkGenerator, structureManager, blockpos, this, this.random, false, false, levelHeightAccessor);
        }
    }
}