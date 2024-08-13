"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ZodErrorParser = exports.ResponseError = exports.SimpleErrorSchema = void 0;
const zod_1 = __importDefault(require("zod"));
const custom_error_1 = require("../../../errors/custom_error");
exports.SimpleErrorSchema = zod_1.default.object({
    codes: zod_1.default.string().or(zod_1.default.number()).or(zod_1.default.string().or(zod_1.default.number()).array()),
    description: zod_1.default.string(),
});
class ResponseError extends custom_error_1.CustomErrorStructure {
    status;
    code;
    constructor(status, message, code) {
        super(message);
        this.code = code;
        this.status = status;
        Object.setPrototypeOf(this, ResponseError.prototype);
    }
    serializeErrors() {
        return [
            {
                codes: this.code ?? `unknown(${this.status})`,
                description: this.message,
            },
        ];
    }
}
exports.ResponseError = ResponseError;
const ZodErrorParser = (error) => {
    if (error.isEmpty)
        return [];
    return error.issues.map((issue) => {
        return {
            codes: issue.path,
            description: issue.message,
        };
    });
};
exports.ZodErrorParser = ZodErrorParser;
//# sourceMappingURL=error-z.js.map