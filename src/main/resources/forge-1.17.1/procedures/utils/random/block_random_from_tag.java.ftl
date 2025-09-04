private static Block getRandomBlock(ResourceLocation name) {
    net.minecraft.tags.Tag<Block> tag = BlockTags.getAllTags().getTag(name);
    return tag.getValues().isEmpty() ? Blocks.AIR : tag.getRandomElement(new Random());
}