import z from "zod";
import { UserSchema } from "../../../types/user/user-z";
import { LoginSchema } from "../../../types/user/login-z";

export const RegisterUserSchema = LoginSchema.merge(
  UserSchema.omit({
    uid: true,
    uuid: true,
    photo: true, // BCZ of Multer [photo] get separated from the actual schema. Also it's a file that's unsupported by [ZOD].
  })
);

export type RegisterUserModel = z.infer<typeof RegisterUserSchema>;
