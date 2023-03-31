"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.wrapperFunction = exports.ResponseWrapperSchema = void 0;
const zod_1 = require("zod");
const ResponseWrapperSchema = (dataSchema) => {
    return zod_1.z.object({
        status: zod_1.z.number().int().gt(99).lt(600),
        msg: zod_1.z.string(),
        error: zod_1.z.object({}).passthrough().nullish(),
        data: dataSchema ?? zod_1.z.object({}).nullish().default({}),
    }).strict();
};
exports.ResponseWrapperSchema = ResponseWrapperSchema;
const wrapperFunction = (props) => async (req, res, next) => {
    const { schema, successMsg, errorMsg, buisnessLogic } = props;
    try {
        const data = await buisnessLogic(req, res);
        const safeData = (0, exports.ResponseWrapperSchema)(schema).safeParse({
            status: 200,
            msg: successMsg,
            data: data,
        });
        if (safeData.success) {
            res.status(200).json(safeData.data);
        }
        else { }
    }
    catch (error) {
        console.log(error);
        const safeData = (0, exports.ResponseWrapperSchema)().safeParse({
            status: 500,
            msg: errorMsg,
            error: error,
        });
        console.log(safeData);
        if (safeData.success) {
            res.status(500).json(safeData.data);
        }
        else { }
    }
};
exports.wrapperFunction = wrapperFunction;
// ** QUICK GENERIC EXAMPLE!
// const makeGetEndpoint = <T>(schema: z.Schema<T>, callback: (req: Request<any, any, any, T>, res: Response) => void) => (req: Request, res: Response) => {
//     /* Handling will happen here! */
//     /* Call the actual function! */
//     callback(req as any, res);
// };
//
// const somethingHandler = makeGetEndpoint(
//     z.string(),
//     (req, res) => {
//         /* Out actual call! */
//     },
// );
//# sourceMappingURL=response-z.js.map