import z from "zod";
import { UserSchema } from "../../../types/user/user-z";
import { AuthTokenSchema } from "../../../types/auth/token-z";

export const AuthResModel = z.object({
  user: UserSchema,
  token: AuthTokenSchema.required(),
}).required();

export type AuthResType = z.infer<typeof AuthResModel>;

