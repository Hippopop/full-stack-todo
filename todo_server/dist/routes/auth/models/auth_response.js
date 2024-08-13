"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthResModel = void 0;
const zod_1 = __importDefault(require("zod"));
const user_z_1 = require("../../../types/user/user-z");
const token_z_1 = require("../../../types/auth/token-z");
const auth_z_1 = require("../../../types/auth/auth-z");
exports.AuthResModel = zod_1.default.object({
    user: user_z_1.UserSchema.merge(auth_z_1.AuthSchema.pick({ phone: true })),
    token: token_z_1.AuthTokenSchema.required(),
}).required();
//# sourceMappingURL=auth_response.js.map