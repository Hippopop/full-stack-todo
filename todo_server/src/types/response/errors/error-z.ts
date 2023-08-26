import z, { ZodError, number } from "zod";
import { CustomErrorStructure } from "../../../Errors/custom_error";

export const SimpleErrorSchema = z.object({
  codes: z.string().or(z.number()).or(z.string().or(z.number()).array()), // TODO: Needs more justifying!
  description: z.string(),
});

export type SimpleError = z.infer<typeof SimpleErrorSchema>;

export class ResponseError extends CustomErrorStructure {
  status: number;
  code?: string | number | number[] | string[];

  constructor(
    status: number,
    message: string,
    code?: string | number | number[] | string[],
  ) {
    super(message);
    this.code = code;
    this.status = status;
    Object.setPrototypeOf(this, ResponseError.prototype);
  }

  serializeErrors(): SimpleError[] {
    return [
      {
        codes: this.code ?? "unknown",
        description: this.message,
      },
    ];
  }
}

export const ZodErrorParser = (error: ZodError): SimpleError[] => {
  if (error.isEmpty) return [];
  return error.issues.map((issue) => {
    return {
      codes: issue.path,
      description: issue.message,
    };
  });
};
