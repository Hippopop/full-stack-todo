"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserSchema = void 0;
const zod_1 = __importDefault(require("zod"));
exports.UserSchema = zod_1.default.object({
    uid: zod_1.default.number(),
    photo: zod_1.default.string().optional().nullable(),
    uuid: zod_1.default.string().uuid("Invalid UUID!"),
    birthdate: zod_1.default.string().datetime().optional().nullable(),
    email: zod_1.default.string().email("Please provide a valid email."),
    name: zod_1.default.string().min(3, "Username must be at least 3 characters long.").optional().nullable(),
});
//# sourceMappingURL=user-z.js.map