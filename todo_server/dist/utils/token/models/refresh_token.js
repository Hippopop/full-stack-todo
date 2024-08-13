"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RefreshTokenSchema = void 0;
const zod_1 = __importDefault(require("zod"));
exports.RefreshTokenSchema = zod_1.default.object({
    token: zod_1.default.string(),
    sha256: zod_1.default.string(),
    uuid: zod_1.default.string().uuid(),
    email: zod_1.default.string().email(),
    expire: zod_1.default.string().datetime({ offset: true }),
    timestamp: zod_1.default.string().datetime({ offset: true }),
});
//# sourceMappingURL=refresh_token.js.map