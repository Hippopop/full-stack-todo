"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const multer_1 = __importDefault(require("multer"));
const node_fs_1 = __importDefault(require("node:fs"));
function imageDestinationDefiner(req) {
    const basePath = "uploads/";
    let path;
    switch (req.path) {
        case "/register":
            path = `${basePath}profile-pics/`;
            break;
    }
    return path;
}
//NOTE: So far unused, bcz of the [Render] disk issue! 
const storage = multer_1.default.diskStorage({
    destination: (req, file, callback) => {
        let path = "";
        let error = null;
        if (imageDestinationDefiner(req)) {
            path = imageDestinationDefiner(req);
            if (!node_fs_1.default.existsSync(path)) {
                node_fs_1.default.mkdirSync(path, { recursive: true });
            }
        }
        else {
            error = Error("Unknown file was submitted!");
        }
        callback(error, path);
    },
    filename: (req, file, callback) => {
        let error = null;
        const name = file.mimetype.split("/");
        const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
        callback(error, `${name[0]}_${uniqueSuffix}.${name[1]}`);
    },
});
const multerConfig = (0, multer_1.default)({
    // NOTE: Using memory storage. Bcz, [Render] doesn't provide a disk storage, for free instances!
    storage: multer_1.default.memoryStorage(),
    preservePath: true,
    fileFilter: (req, file, callback) => {
        let error = null;
        // Decision.
        if (!file.mimetype.startsWith("image")) {
            console.log(`Found wrong mimetype : ${file.mimetype}`);
            error = new Error("Invalid file/mime type! (@multerConfig)");
        }
        // Final Output.
        if (error) {
            callback(error);
        }
        else {
            callback(error, true);
        }
    },
});
exports.default = multerConfig;
//# sourceMappingURL=multer_config.js.map