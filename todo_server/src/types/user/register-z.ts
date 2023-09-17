import z from "zod";
import { UserSchema } from "./user-z";
import { LoginSchema } from "./login-z";

export const RegisterUserSchema = LoginSchema.merge(
  UserSchema.omit({
    uid: true,
    uuid: true,
  })
);

export type RegisterUserModel = z.infer<typeof RegisterUserSchema>;
