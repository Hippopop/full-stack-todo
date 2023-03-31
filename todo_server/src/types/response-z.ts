import { z } from "zod";
import { NextFunction, Request, Response } from 'express';

export const ResponseWrapperSchema = <T extends z.ZodTypeAny>(dataSchema?: T) => {
    return z.object({
        status: z.number().int().gt(99).lt(600),
        msg: z.string(),
        error: z.object({}).passthrough().nullish(),
        data: dataSchema ?? z.object({}).nullish().default({}),
    }).strict();
};


export type BuisnessCallback<T> = (req: Request, res: Response, next?: NextFunction) => Promise<T>;
type WrapperProps<T> = {
    schema: z.Schema<T>,
    successMsg: string,
    errorMsg: string,
    buisnessLogic: BuisnessCallback<T>,
}

export const wrapperFunction = <T>(props: WrapperProps<T>) =>
    async (req: Request, res: Response, next: NextFunction) => {
        const { schema, successMsg, errorMsg, buisnessLogic } = props;
        try {
            const data = await buisnessLogic(req, res);
            const safeData = ResponseWrapperSchema(schema).safeParse({
                status: 200,
                msg: successMsg,
                data: data,
            });
            if (safeData.success) {
                res.status(200).json(safeData.data);
            } else { }
        } catch (error) {
            console.log(error);
            const safeData = ResponseWrapperSchema().safeParse({
                status: 500,
                msg: errorMsg,
                error: error,
            });
            console.log(safeData);
            
            if (safeData.success) {
                res.status(500).json(safeData.data);
            } else { }
        }
    };

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
