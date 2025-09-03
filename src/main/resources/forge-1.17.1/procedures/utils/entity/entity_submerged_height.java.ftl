private static double getEntitySubmergedHeight(Entity entity) {
	for (net.minecraft.tags.Tag<Fluid> fluidType : FluidTags.getStaticTags()) {
		if (entity.level.getFluidState(entity.blockPosition()).is(fluidType))
			return entity.getFluidHeight(fluidType);
	}
	return 0;
}