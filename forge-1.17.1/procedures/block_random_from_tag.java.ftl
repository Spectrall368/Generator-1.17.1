<#include "mcelements.ftl">
(ForgeRegistries.BLOCKS.tags().getTag(BlockTags.getAllTags().getTagOrEmpty(${toResourceLocation(input$tag)})).getRandomElement(new Random()).orElseGet(() -> Blocks.AIR))
