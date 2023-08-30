<#include "mcelements.ftl">
(new Object() {
	public Item getRandomItem(ResourceLocation name) {
		net.minecraft.tags.Tag<Item> _tag = ItemTags.getAllTags().getTagOrEmpty(name);
		return _tag.getValues().isEmpty() ? Items.AIR : _tag.getRandomElement(new Random());
}}.getRandomItem(${toResourceLocation(input$tag)}))
