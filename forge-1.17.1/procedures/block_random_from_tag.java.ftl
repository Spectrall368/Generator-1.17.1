<#include "mcelements.ftl">
(new Object() {
	public Block getRandomBlock(ResourceLocation name) {
		net.minecraft.tags.Tag<Block> _tag = BlockTags.getAllTags().getTagOrEmpty(name);
		return _tag.getValues().isEmpty() ? Blocks.AIR : _tag.getRandomElement(new Random());
}}.getRandomBlock(${toResourceLocation(input$tag)}))
