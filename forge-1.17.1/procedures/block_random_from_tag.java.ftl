<#include "mcelements.ftl">
(new Object() {
	public Block getRandomBlock(ResourceLocation name) {
		ITag<Block> _tag = BlockTags.getAllTags().getTagOrEmpty(name);
		return _tag.getAllElements().isEmpty() ? Blocks.AIR : _tag.getRandomElement(new Random());
}}.getRandomBlock(${toResourceLocation(input$tag)}))
