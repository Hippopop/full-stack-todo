import z from "zod";
import { NextFunction, Request, Response } from "express";

export const ResponseWrapperSchema = <T extends z.ZodTypeAny>(dataSchema?: T) =>
  z.object({
      status: z.number().int().gt(99).lt(600),
      msg: z.string(),
      error: z.array(SimpleErrorSchema).nullish(),
      data: dataSchema ?? z.object({}).nullish(),
    })
    .strict();

export type BuisnessCallback<T> = (
  req: Request,
  res: Response,
  next?: NextFunction
) => Promise<T>;

export type WrapperProps<T> = {
  schema: z.Schema<T>;
  successMsg: string;
  errorMsg: string;
  buisnessLogic: BuisnessCallback<T>;
};

export const SimpleErrorSchema = z.object({
  code: z.array(z.string().or(z.number())),
  description: z.string(),
});

export type SimpleError = z.infer<typeof SimpleErrorSchema>;
