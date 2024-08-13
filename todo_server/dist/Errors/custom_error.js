"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CustomErrorStructure = void 0;
class CustomErrorStructure extends Error {
    constructor(message) {
        super(message);
        Object.setPrototypeOf(this, CustomErrorStructure.prototype);
    }
}
exports.CustomErrorStructure = CustomErrorStructure;
//# sourceMappingURL=custom_error.js.map