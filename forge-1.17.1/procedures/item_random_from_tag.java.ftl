<#include "mcelements.ftl">
(ForgeRegistries.ITEMS.tags().getTag(ItemTags.getAllTags().getTagOrEmpty(${toResourceLocation(input$tag)})).getRandomElement(new Random()).orElseGet(() -> Items.AIR))
