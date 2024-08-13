"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AccessTokenModelSchema = void 0;
const zod_1 = __importDefault(require("zod"));
exports.AccessTokenModelSchema = zod_1.default.object({
    name: zod_1.default.string(),
    uuid: zod_1.default.string().uuid(),
    email: zod_1.default.string().email(),
    expire: zod_1.default.string().datetime({ offset: true }),
    timestamp: zod_1.default.string().datetime({ offset: true }),
});
//# sourceMappingURL=token.js.map