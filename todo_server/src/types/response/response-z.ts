import z from "zod";
import { NextFunction, Request, Response } from "express";
import { SimpleErrorSchema } from "./errors/error-z";
import { User } from "../user/user-z";

export const ResponseWrapperSchema = <T extends z.ZodTypeAny>(dataSchema?: T) =>
  z
    .object({
      status: z.number().int().gt(99).lt(600),
      msg: z.string(),
      error: z.array(SimpleErrorSchema).nullish(),
      data: dataSchema ?? z.object({}).nullish(),
    })
    .strict();

export type BuisnessCallback<T> = (
  req: Request,
  res: Response,
  next?: NextFunction,
  user?: User
) => Promise<T>;

export type WrapperProps<T> = {
  authenticate?: boolean;
  successCode: number;
  schema: z.Schema<T>;
  successMsg: string;
  errorMsg: string;
  buisnessLogic: BuisnessCallback<T>;
};
