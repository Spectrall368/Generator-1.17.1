(${input$entity} instanceof ServerPlayer _plr && _plr.level instanceof ServerLevel && _plr.getAdvancements()
        .getOrStartProgress(_plr.server.getAdvancements().getAdvancement(new ResourceLocation("${generator.map(field$achievement, "achievements")}"))).isDone())
