"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TODOSchema = void 0;
const zod_1 = require("zod");
const StateEnum = ["active", "completed"];
const PriorityEnum = ["low", "medium", "high"];
exports.TODOSchema = zod_1.z.object({
    id: zod_1.z.number().nullish(),
    title: zod_1.z.string(),
    description: zod_1.z.string().nullish(),
    state: zod_1.z.enum(StateEnum),
    priority: zod_1.z.enum(PriorityEnum),
});
//# sourceMappingURL=todo-z.js.map