private static Item getRandomItem(ResourceLocation name) {
    net.minecraft.tags.Tag<Item> tag = ItemTags.getAllTags().getTag(name);
    return tag.getValues().isEmpty() ? Items.AIR : tag.getRandomElement(new Random());
}