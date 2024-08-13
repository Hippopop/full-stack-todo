"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.LoginSchema = void 0;
const zod_1 = __importDefault(require("zod"));
exports.LoginSchema = zod_1.default.object({
    email: zod_1.default.string().email("Please provide a valid email."),
    password: zod_1.default.string().min(8, "Password must be at least 8 characters long."),
});
//# sourceMappingURL=login-z.js.map