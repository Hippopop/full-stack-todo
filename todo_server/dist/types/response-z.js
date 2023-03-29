var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { z } from "zod";
export const ResponseWrapperSchema = (dataSchema) => {
    return z.object({
        status: z.number().int().gt(99).lt(600),
        msg: z.string(),
        error: z.object({}).passthrough().nullish(),
        data: dataSchema !== null && dataSchema !== void 0 ? dataSchema : z.object({}).nullish().default({}),
    }).strict();
};
export const wrapperFunction = (props) => (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const { schema, successMsg, errorMsg, buisnessLogic } = props;
    try {
        const data = yield buisnessLogic(req, res);
        const safeData = ResponseWrapperSchema(schema).safeParse({
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
        const safeData = ResponseWrapperSchema().safeParse({
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
});
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