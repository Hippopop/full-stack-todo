import { z } from "zod";
const StateEnum = ["active", "completed"];
const PriorityEnum = ["low", "medium", "high"];
export const TODOSchema = z.object({
    id: z.number().nullish(),
    title: z.string(),
    description: z.string().nullish(),
    state: z.enum(StateEnum),
    priority: z.enum(PriorityEnum),
});
//# sourceMappingURL=todo-z.js.map