"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthTokenSchema = void 0;
const zod_1 = __importDefault(require("zod"));
exports.AuthTokenSchema = zod_1.default.object({
    token: zod_1.default.string(),
    refreshToken: zod_1.default.string(),
    expiresAt: zod_1.default.string().datetime({ offset: true }),
});
//# sourceMappingURL=token-z.js.map