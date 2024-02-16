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

// UPDATE: So basically, a `d.ts` file works as a type definition file.
// For example if you have a `.js` file. That you want to use with your `.ts` files.
// you can create a `d.ts` file to define the types for that file.
/* 
This is a type definition. That you can put in a `d.ts` file.
export default interface ExampleType {
  name: string;
  age: number;
} 

export type FileType = "A-File" | "B-File" | "C-File";
*/

