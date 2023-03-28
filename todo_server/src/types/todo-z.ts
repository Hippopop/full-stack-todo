import { z } from "zod";

const StateEnum = ["active", "completed"] as const;
const PriorityEnum = ["low", "medium", "high"] as const;

export const TODOSchema = z.object({
    id: z.number().nullish(),
    title: z.string(),
    description: z.string().nullish(),
    state: z.enum(StateEnum),
    priority: z.enum(PriorityEnum),
});

export type TODO = z.infer<typeof TODOSchema>;