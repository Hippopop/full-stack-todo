/* export declare type State = "active" | "finished";

export declare type Priority = "low" | "medium" | "high";

declare interface TODO {
    id: number,
    title: string,
    description?: string,
    state: State,
    priority: Priority,
}
declare function createTodo(id: number, title: string, description: string, state: State, priority: Priority): TODO;

export { TODO, State, Priority }; */

/* import { z } from "zod";

const StateEnum = ["active", "completed"] as const;
const PriorityEnum = ["low", "medium", "high"] as const;

declare const TODOSchema = z.object({
    id: z.number().nullish(),
    title: z.string(),
    description: z.string().nullish(),
    state: z.enum(StateEnum),
    priority: z.enum(PriorityEnum),
});

declare type TODO = z.infer<typeof TODOSchema>;

export { TODOSchema, TODO }; */

// ** Still not sure, How to use a `.d.ts` file. It keeps giving me some `MODULE ERROR`s. **
