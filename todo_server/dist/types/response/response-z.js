"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ResponseWrapperSchema = void 0;
const zod_1 = __importDefault(require("zod"));
const error_z_1 = require("./errors/error-z");
const ResponseWrapperSchema = (dataSchema) => zod_1.default
    .object({
    status: zod_1.default.number().int().gt(99).lt(600),
    msg: zod_1.default.string(),
    error: zod_1.default.array(error_z_1.SimpleErrorSchema).nullish(),
    data: dataSchema ?? zod_1.default.object({}).nullish(),
})
    .strict();
exports.ResponseWrapperSchema = ResponseWrapperSchema;
//# sourceMappingURL=response-z.js.map