import z from "zod";
import { UserSchema } from "../../../types/user/user-z";
import { AuthTokenSchema } from "../../../types/auth/token-z";
import { AuthSchema } from "../../../types/auth/auth-z";

export const AuthResModel = z.object({
  user: UserSchema.merge(AuthSchema.pick({ phone: true })),
  token: AuthTokenSchema.required(),
}).required();

export type AuthResType = z.infer<typeof AuthResModel>;

